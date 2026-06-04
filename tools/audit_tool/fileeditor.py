import xlwings as xw
from pathlib import Path

class FileEditor:

    def rename_file(
            self,
            file_path,
            new_id
    ):
        file_path=Path(file_path)

        old_filename=file_path.name
        parts=file_path.stem.split()

        customer_name=" ".join(
            parts[:-1]
        )

        new_filename=(
            f"{customer_name} "
            f"{new_id}"
            f"{file_path.suffix}"
        )

        new_path=file_path.with_name(
            new_filename
        )

        file_path.rename(
            new_path
        )

        print(
            f"\nRenamed"
        )

        print(
            f"{old_filename}"
        )

        print(
            f"{new_filename}"
        )

        return new_path

    def get_customer_id(self, file_path):

        wb = xw.Book(
            str(file_path)
        )

        sheet = wb.sheets[0]

        customer_id=sheet["C5"].value

        wb.close()

        return customer_id
    
    def update_customer_id(
            self,file_path,new_id
    ):
        wb=xw.Book(str(file_path))
        sheet=wb.sheets[0]
        sheet["C5"].value=new_id
        wb.save()
        wb.close()


    def export_pdf(
            self,
            file_path
    ):
        pdf_folder=Path(r"E:\to print")

        wb=xw.Book(
            str(file_path)
        )

        sheet=wb.sheets[0]

        sheet.api.PageSetup.PrintArea = (
            "$A$1:$I$38"
        )

        customer_id=file_path.stem.split()[-1]

        pdf_path=pdf_folder/(
            f"{customer_id}.pdf"
        )

        sheet.api.ExportAsFixedFormat(
            0,
            str(pdf_path)
        )

        wb.close()

        print(
            f"\nPDF Exported:"
        )

        print(pdf_path)