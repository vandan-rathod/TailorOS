import pandas as pd
import openpyxl
from models import CustomerAudit
from matcher import Matcher
from fileeditor import FileEditor

class AuditManager:

    def __init__(self):
        try:
            self.df = pd.read_excel(
                "index.xlsx",
                sheet_name="Duplicates"
            )
            self.matcher=Matcher(r"F:\Party Detail")
            self.editor=FileEditor()
        except FileNotFoundError:
            print("connect the source")
            raise SystemExit(1)

    def get_duplicate_groups(self):

        duplicates=self.df[self.df.duplicated(subset=["ORDER NO"],keep=False)]

        return duplicates.groupby("ORDER NO")

    def process_customer(
        self,
        selected_row
    ):

        customer_name = str(
            selected_row["PARTY NAME"]
        ).strip()

        while True:
            selected_file=self.matcher.find_file(
                customer_name
            )

            if selected_file == "back":
                return

            if selected_file is None:
                raise SystemExit
        
            customer_id = self.editor.get_customer_id(
                selected_file
            )

        
            print(f"Customer ID: {customer_id}")

            while True:
                new_id=input(
                    "\nEnter New Customer ID: "
                ).strip()

                print("\n"+"="*40)
                print("CONFIRM CHANGES")
                print("="*40)

                print(
                    f"Customer Name : {customer_name}"
                )

                print(
                    f"Old ID        : {customer_id}"
                )

                print(
                    f"New ID        : {new_id}"
                )

                print(
                    f"File          : {selected_file.name}"
                )

                print("\n1. Confirm")
                print("2. Re-enter ID")
                print("3. Back To File Selection")
                print("4. Cancel")

                action = input(
                    "\nChoice: "
                )

                if action=="1":
                    break

                elif action=="2":
                    continue

                elif action=="3":
                    break

                elif action=="4":
                    return

                else:
                    print(
                        "\nInvalid Choice"
                    )

            if action=="3":
                continue

            break
        
        selected_file=self.editor.rename_file(
            selected_file,
            new_id
        )


        self.editor.update_customer_id(
            selected_file,
            new_id
        )

        self.editor.export_pdf(
            selected_file
        )
        
        self.update_duplicate_row(
            selected_row,
            new_id
        )

        print(
            "\nCustomer ID updated successfully"
        )
    
    def process_group(
        self,
        order_no,
        group
    ):

        while True:
            print("\n" + "=" * 50)
            print(f"ORDER NO : {order_no}")
            print("=" * 50)

            for i, (_, row) in enumerate(
                group.iterrows(),
                start=1
            ):
                print(
                    f"{i}. "
                    f"{row['PARTY NAME']}"
                )

            user_input = input(
                "\nSelect Customer (q=quit): "
            ).strip().lower()

            if user_input == "q":
                return None

            choice = int(user_input)

            selected_row = group.iloc[
                choice - 1
            ]

            print(
                f"\nSelected Customer:"
                f"{selected_row['PARTY NAME']}"
            )

            print("\n1. Process Customer")
            print("2. Delete Duplicate Entry")
            print("3. Re-select Customer")
            print("4. Skip Group")
            print("5. Exit")

            action = input(
                "\nChoice: "
            ).strip()

            if action == "1":
                return selected_row

            elif action == "2":
                self.delete_duplicate_row(
                    selected_row
                )
                print(
                    f"\n Row deleted successfully"
                )
                return "skip"

            elif action == "3":
                continue

            elif action == "4":
                return "skip"

            elif action == "5":
                return None
            else:
                print(
                    "\nInvalid Choice"
                )
    
    def process_all(self):

        groups = self.get_duplicate_groups()

        for order_no, group in groups:

            result = self.process_group(
                order_no,
                group
            )

            if result is None:
                print(
                    "Exiting Audit Tool..."
                )
                return
            
            if isinstance(result, str) and result == "skip":
                continue

            self.process_customer(
                result
            )

    def delete_duplicate_row(
            self,
            selected_row
    ):
        self.df=self.df.drop(
            selected_row.name
        )

        with pd.ExcelWriter(
            "index.xlsx",
            engine="openpyxl",
            mode="a",
            if_sheet_exists="replace"
        ) as writer:
            self.df.to_excel(
                writer,
                sheet_name="Duplicates",
                index=False
            )
        
        print(
            "\nRow Deleted Successfully"
        )

    def update_duplicate_row(
            self,
            selected_row,
            new_id
    ):
        self.df.loc[
            selected_row.name,
            "ORDER NO"
        ]=float(new_id)

        with pd.ExcelWriter(
            "index.xlsx",
            engine="openpyxl",
            mode="a",
            if_sheet_exists="replace"
        ) as writer:

            self.df.to_excel(
                writer,
                sheet_name="Duplicates",
                index=False
            )
audit = AuditManager()

audit.process_all()