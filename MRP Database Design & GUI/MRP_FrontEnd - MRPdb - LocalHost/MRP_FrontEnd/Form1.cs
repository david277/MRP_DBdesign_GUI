using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace MRP_FrontEnd
{
    public partial class Form1 : Form
    {

        // CLASS for Object Storage
        public class aInfo
        {
            public int i_id; // the ID (PK)
            public string returnVal; // String for Return Value Below
            public int is_id; // invoiceLineItems invoice sequence ID
            public string name;
            public int? qty;
            public decimal? totalPrice;
            public override string ToString() { return returnVal; } // Return Value
        }

        // -------------------------------------------------------------------------
        // FORM
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        // -------------------------------------------------------------------------
        // TEXTBOXES
        // Enter order ID
        private void textBox1_TextChanged(object sender, EventArgs e)
        {
            // dissable customer ID search.
            textBox2.Enabled = false;
        }

        // Enter customer ID
        private void textBox2_TextChanged(object sender, EventArgs e)
        {
            // dissable order ID search.
            textBox1.Enabled = false;
        }

        // Item Name
        private void textBox3_TextChanged(object sender, EventArgs e)
        {

        }

        // Change QUANTITY
        private void textBox4_TextChanged(object sender, EventArgs e)
        {

        }

        // -------------------------------------------------------------------------
        // LISTBOXES
        // Order List
        private void listBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            aInfo tRec = (aInfo)listBox1.SelectedItem;

            // if not null
            if (listBox1.SelectedItem != null)
            {
                if (listBox1.Items.Count > 0)
                {
                    // clear list box 2
                    listBox2.Items.Clear();

                    using (var context = new manufacturerEntities1())
                    {
                        // use VIEW
                        var query = from st in context.vInvoiceLineItemsAndInventories
                                    where st.invoiceID == tRec.i_id
                                    select st;

                        foreach (vInvoiceLineItemsAndInventory ivv in query)
                        {
                            aInfo tempB = new aInfo() { i_id = ivv.invoiceID, is_id = ivv.invoiceSequence, name = ivv.itemName, qty = ivv.quantityOfItem, returnVal = ivv.itemName + "\t Qty: " + ivv.quantityOfItem + "\t Unit Price: $" + ivv.invoiceLineItemPrice + "\t Status: " + ivv.orderStatus };
                            listBox2.Items.Add(tempB);
                        }
                    }
                }
                else
                {
                    using (var context = new manufacturerEntities1())
                    {
                        // use VIEW
                        var query = from st in context.vInvoiceLineItemsAndInventories
                                    where st.invoiceID == tRec.i_id
                                    select st;

                        foreach (vInvoiceLineItemsAndInventory ivv in query)
                        {
                            aInfo tempB = new aInfo() { i_id = ivv.invoiceID, is_id = ivv.invoiceSequence, name = ivv.itemName, qty = ivv.quantityOfItem, returnVal = ivv.itemName + "\t Qty: " + ivv.quantityOfItem + "\t Unit Price: $" + ivv.invoiceLineItemPrice + "\t Status: " + ivv.orderStatus };
                            listBox2.Items.Add(tempB);
                        }
                    }
                }
            }
        }
        
        // Order line item List
        private void listBox2_SelectedIndexChanged(object sender, EventArgs e)
        {
            // if not null
            if (listBox2.SelectedItem != null)
            {
                // get the selected item in this list box.
                aInfo t2Rec = (aInfo)listBox2.SelectedItem;
                // set the textbox according to what is selected in the list box.
                textBox3.Text = t2Rec.name;
                // get sequnce value for stored procedure.
                textBox4.Text = t2Rec.qty.ToString();
                // Dissable textbox quantity
                textBox4.Enabled = true;
            }
        }

        // -------------------------------------------------------------------------
        // BUTTONS
        // Search Order ID
        private void button1_Click(object sender, EventArgs e)
        {
            // make sure only ints are inputed
            int parsedValue;
            if (!int.TryParse(textBox1.Text, out parsedValue))
            {
                MessageBox.Show("This is a number only field");
                return;
            }

            // parse int
            string tb1 = textBox1.Text;
            int intVal = int.Parse(tb1);

            if (listBox1.Items.Count > 0)
            {
                // clear list box 1
                listBox1.Items.Clear();
                // clear list box 2
                listBox2.Items.Clear();

                // then display the new search order.
                using (var context = new manufacturerEntities1())
                {
                    var query = from st in context.invoices
                                where st.invoiceID == intVal
                                select st;

                    foreach (invoice iv in query)
                    {
                        aInfo tempA = new aInfo()
                        {
                            i_id = iv.invoiceID, totalPrice = iv.orderTotalPrice,
                            returnVal = "Invoice ID: " + iv.invoiceID +
                         "\t Customer ID: " + iv.customerID +
                         "\t Total Order Price: $" + iv.orderTotalPrice 
                        };
                        listBox1.Items.Add(tempA);

                    }

                }

            }
            else
            {
                using (var context = new manufacturerEntities1())
                {
                    var query = from st in context.invoices
                                where st.invoiceID == intVal
                                select st;

                    foreach (invoice iv in query)
                    {
                        aInfo tempA = new aInfo()
                        {
                            i_id = iv.invoiceID,
                            returnVal = "Invoice ID: " + iv.invoiceID +
                         "\t Customer ID: " + iv.customerID +
                         "\t Total Order Price: $" + iv.orderTotalPrice 
                        };
                        listBox1.Items.Add(tempA);
                    }
                }

            }
        }

        // Search Customer ID
        private void button2_Click(object sender, EventArgs e)
        {

            // make sure only ints are inputed
            int parsedValue;
            if (!int.TryParse(textBox2.Text, out parsedValue))
            {
                MessageBox.Show("This is a number only field");
                return;
            }

            // parse int
            string tb2 = textBox2.Text;
            int intVal2 = int.Parse(tb2);

            if (listBox1.Items.Count > 0)
            {
                // clear list box 1
                listBox1.Items.Clear();
                // clear list box 2
                listBox2.Items.Clear();

                // then display the new search order.
                using (var context = new manufacturerEntities1())
                {
                    var query = from st in context.invoices
                                where st.customerID == intVal2
                                select st;

                    foreach (invoice iv in query)
                    {
                        aInfo tempA = new aInfo()
                        {
                            i_id = iv.invoiceID,
                            returnVal = "Invoice ID: " + iv.invoiceID +
                         "\t Customer ID: " + iv.customerID +
                         "\t Total Order Price: $" + iv.orderTotalPrice 
                        };
                        listBox1.Items.Add(tempA);
                    }


                }
            }
            else
            {
                using (var context = new manufacturerEntities1())
                {
                    var query = from st in context.invoices
                                where st.customerID == intVal2
                                select st;

                    foreach (invoice iv in query)
                    {
                        aInfo tempA = new aInfo()
                        {
                            i_id = iv.invoiceID,
                            returnVal = "Invoice ID: " + iv.invoiceID +
                         "\t Customer ID: " + iv.customerID +
                         "\t Total Order Price: $" + iv.orderTotalPrice
                        };
                        listBox1.Items.Add(tempA);
                    }
                }
            }
        }

        // Update Button
        private void button3_Click(object sender, EventArgs e)
        {
            // make sure only ints are inputed
            int parsedValue;
            if (!int.TryParse(textBox4.Text, out parsedValue))
            {
                MessageBox.Show("This is a number only field");
                return;
            }

            // get the selected item in this list box.
            aInfo t3Rec = (aInfo)listBox2.SelectedItem;

            using (var context = new manufacturerEntities1())
            {
                // Update Quantity Stored Procedure
                var updtQty = context.updtQty(t3Rec.i_id, t3Rec.is_id, int.Parse(textBox4.Text));
                // Update Total Order Amount Stored Procedure
                var updtTotal = context.updtOrderTotal(t3Rec.i_id);
            }

            // refresh list box 2 items
            aInfo tRec = (aInfo)listBox1.SelectedItem;

            // if not null
            if (listBox1.SelectedItem != null)
            {
                if (listBox1.Items.Count > 0)
                {
                    // clear list box 2
                    listBox2.Items.Clear();

                    using (var context = new manufacturerEntities1())
                    {
                        // use VIEW
                        var query = from st in context.vInvoiceLineItemsAndInventories
                                    where st.invoiceID == tRec.i_id
                                    select st;

                        foreach (vInvoiceLineItemsAndInventory ivv in query)
                        {
                            aInfo tempB = new aInfo() { i_id = ivv.invoiceID, is_id = ivv.invoiceSequence, name = ivv.itemName, qty = ivv.quantityOfItem, returnVal = ivv.itemName + "\t Qty: " + ivv.quantityOfItem + "\t Unit Price: $" + ivv.invoiceLineItemPrice + "\t Status: " + ivv.orderStatus};
                            listBox2.Items.Add(tempB);
                        }
                    }
                }
                else
                {
                    using (var context = new manufacturerEntities1())
                    {
                        // use VIEW
                        var query = from st in context.vInvoiceLineItemsAndInventories
                                    where st.invoiceID == tRec.i_id
                                    select st;

                        foreach (vInvoiceLineItemsAndInventory ivv in query)
                        {
                            aInfo tempB = new aInfo() { i_id = ivv.invoiceID, is_id = ivv.invoiceSequence, name = ivv.itemName, qty = ivv.quantityOfItem, returnVal = ivv.itemName + "\t Qty: " + ivv.quantityOfItem + "\t Unit Price: $" + ivv.invoiceLineItemPrice + "\t Status: " + ivv.orderStatus };
                            listBox2.Items.Add(tempB);
                        }
                    }
                }
            }
            

            // wait till user select listbox again.
            textBox4.Enabled = false;
            //listBox1.Enabled = false;

            // then display the new search order.
            using (var context = new manufacturerEntities1())
            {
                var query = from st in context.invoices
                            where st.invoiceID == tRec.i_id
                            select st;

                foreach (invoice iv in query)
                {
                    aInfo tempA = new aInfo()
                    {
                        i_id = iv.invoiceID,
                        totalPrice = iv.orderTotalPrice,
                        returnVal = "Invoice ID: " + iv.invoiceID +
                     "\t Customer ID: " + iv.customerID +
                     "\t Total Order Price: $" + iv.orderTotalPrice
                    };
                    label12.Text = iv.orderTotalPrice.ToString();

                }
            }


        }

        // Clear Button
        private void button4_Click(object sender, EventArgs e)
        {
            // clear list box 1
            listBox1.Items.Clear();
            // clear list box 2
            listBox2.Items.Clear();
            // clear textbox 1
            textBox1.Text = String.Empty;
            // clear textbox 2
            textBox2.Text = String.Empty;
            // clear textbox 3
            textBox3.Text = String.Empty;
            // clear textbox 4
            textBox4.Text = String.Empty;

            // enable both ID search textbox
            textBox1.Enabled = true;
            textBox2.Enabled = true;

            // Set label to 0
            label12.Text = 0.ToString();
        }

        private void label6_Click(object sender, EventArgs e)
        {

        }
    }
}
