//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace MRP_FrontEnd
{
    using System;
    using System.Collections.Generic;
    
    public partial class inventory
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public inventory()
        {
            this.invoiceLineItems = new HashSet<invoiceLineItem>();
            this.quantityStatus = new HashSet<quantityStatu>();
            this.safetyStocks = new HashSet<safetyStock>();
            this.vendorProducts = new HashSet<vendorProduct>();
        }
    
        public int inventoryID { get; set; }
        public Nullable<int> vendorID { get; set; }
        public string itemName { get; set; }
        public string itemDesc { get; set; }
        public string itemUnit { get; set; }
        public string itemType { get; set; }
        public string itemFCost { get; set; }
        public string itemVCost { get; set; }
        public string bestPrice { get; set; }
        public string manufacturer { get; set; }
        public string imageFile { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<invoiceLineItem> invoiceLineItems { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<quantityStatu> quantityStatus { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<safetyStock> safetyStocks { get; set; }
        public virtual Vendor Vendor { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<vendorProduct> vendorProducts { get; set; }
    }
}