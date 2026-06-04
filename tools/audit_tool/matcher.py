from pathlib import Path
from difflib import SequenceMatcher
import xlrd


class Matcher:

    def __init__(self, party_folder):
        self.party_folder = Path(party_folder)

    def similarity(self, a, b):
        return SequenceMatcher(
            None,
            a.lower(),
            b.lower()
        ).ratio()

    def get_mobile(self, file_path):
        wb = xlrd.open_workbook(str(file_path))
        sheet = wb.sheet_by_index(0)

        return sheet.cell_value(4, 6)

    def find_file(self, customer_name):

        results = []

        for file in self.party_folder.rglob("*.xls"):

            score = self.similarity(
                customer_name,
                file.stem
            )

            results.append(
                (score, file)
            )

        results.sort(reverse=True)

        top_matches = results[:10]

        print("\nBest Matches:\n")

        for i, (score, file) in enumerate(
            top_matches,
            start=1
        ):
            print(
                f"{i}. {file.name}    Score:{score:.2f}"
            )

        while True:

            user_input = input(
                "\nSelect File No. "
                "(0=Back, q=Exit): "
            ).strip().lower()

            if user_input == "q":
                return None

            if user_input == "0":
                return "back"

            choice = int(user_input)

            selected_score, selected_file = (
                top_matches[choice - 1]
            )

            mobile = self.get_mobile(
                selected_file
            )

            print("\nSelected File:")
            print(selected_file.name)

            print(f"Mobile: {mobile}")

            print("\n1. Use File")
            print("2. Select Another File")
            print("3. Back To Customer List")
            print("4. Exit")

            action = input(
                "\nChoice: "
            ).strip()

            if action == "1":
                return selected_file

            elif action == "2":
                continue
            
            elif action == "3":
                return "back"

            elif action == "4":
                return None