# Tax-Inclusive Pricing Demo Script

## 🎯 **Demo Overview**
Show tax-inclusive pricing working in both product creation and editing forms.

## 📋 **Demo Steps**

### **Step 1: Create Tax-Inclusive Product**
1. Go to: `https://gumroad.dev/products/new`
2. Fill in:
   - Name: `Tax Inclusive Demo Product`
   - Product Type: `Digital product`
   - Price: `12.00`
   - **Tax settings**: ✅ "Price includes tax" (should be checked by default)
3. Click "Next: Customize"
4. **Result**: Product created with tax-inclusive pricing

### **Step 2: Create Tax-Exclusive Product**
1. Go to: `https://gumroad.dev/products/new`
2. Fill in:
   - Name: `Tax Exclusive Demo Product`
   - Product Type: `Digital product`
   - Price: `12.00`
   - **Tax settings**: ❌ Uncheck "Price includes tax"
3. Click "Next: Customize"
4. **Result**: Product created with traditional tax-exclusive pricing

### **Step 3: Edit Existing Product**
1. Go to: `https://gumroad.dev/products`
2. Click on any existing product
3. Go to "Product" tab
4. Scroll to "Pricing" section
5. **See**: Tax-inclusive toggle available in editing form
6. **Toggle**: Switch between tax-inclusive and tax-exclusive
7. **Result**: Existing products can be updated

## 📊 **Expected Behavior**

### **Tax-Inclusive Product ($12.00)**
- Customer sees: **$12.00**
- At checkout: **$12.00 total** (no surprises)
- Tax included: ~$1.90 (depending on location)
- Net price: ~$10.10

### **Tax-Exclusive Product ($12.00)**
- Customer sees: **$12.00**
- At checkout: **$12.00 + $1.90 tax = $13.90 total**
- Traditional behavior

## 🔧 **Technical Verification**

Check browser network tab during product creation:
```json
{
  "link": {
    "name": "Tax Inclusive Demo Product",
    "price_range": "12.00",
    "tax_inclusive": true  // ← This should be present
  }
}
```

## 🎥 **Recording Tips**
1. **Show both forms**: Creation and editing
2. **Toggle the checkbox**: Demonstrate the difference
3. **Highlight help text**: "When enabled, customers pay exactly the price shown"
4. **Show form submission**: Verify data is sent correctly

Ready to record! 📹
