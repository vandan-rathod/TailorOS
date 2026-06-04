class CustomerAudit:

    def __init__(
        self,
        order_no,
        party_name,
        contact_no
    ):
        self.order_no = order_no
        self.party_name = party_name
        self.contact_no = contact_no

    def __str__(self):
        return (
            f"{self.party_name}"
            f" ({self.order_no})"
        )