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
    
    public partial class quantityStatu
    {
        public int statusID { get; set; }
        public Nullable<int> inventoryID { get; set; }
        public Nullable<int> onHand { get; set; }
        public Nullable<int> onOrder { get; set; }
        public Nullable<int> inTransit { get; set; }
    
        public virtual inventory inventory { get; set; }
    }
}
