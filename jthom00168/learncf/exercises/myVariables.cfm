
<cfoutput>
    <cfset todayDate=now()>
    #DateFormat(todayDate,"full")#<br/>

    <hr/>

    <cfset bookWithPrices=[
    {title:"Rumney", price: "35.00"},
    {title:"Rock Climbing in Thailand and Laos", price: "40.00"},
    {title:"Tough Schist", price: "27.96"},
    {title:"Rock Deluxe", price: "23.99"},
    {title:"Via Ferratas of the Italian Dolomites: Vol 1", price: "27.95"},
    {title:"Climbing Anchors", price: "24.95"},
    {title:"How to Rock Climb", price: "22.95"},
    {title:"Training For Climbing", price: "27.50"},
    {title:"Trekking Chamonix to Zermatt", price: "24.95"},
    {title:"The GR20 Corsica", price: "24.95"}
    ]>

    <cfset totalBookCost = 0>

    <cfloop array="#bookWithPrices#" index="book">
        <cfset totalBookCost=totalBookCost + book.price>
        #numberFormat(book.price,'$__.__')#  #book.title#   <br/>
    </cfloop>

    <hr/>
    Total cost of ten books: #numberFormat(totalBookCost,'$__.__')#<br/>

</cfoutput>