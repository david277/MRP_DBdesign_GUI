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
    
    public partial class vendorProduct
    {
        public int vendorID { get; set; }
        public int inventoryID { get; set; }
        public string productName { get; set; }
    
        public virtual inventory inventory { get; set; }
    }
}
