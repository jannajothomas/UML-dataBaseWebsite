<cfset people={
    firstName: "Dave",
    lastName: "Vuono",
    email: "dave.vuono@madeupdomain.com"
}>

<cfset publisher={
    name:"Vermont Rock Press",
    city:"Underhill",
    state:"VT",
    country: "USA"
}>

<cfset book={
    ISBN13:"9780985313807",
    title:"Tough Schist",
    year:"2012",
    isbn:"09853138",
    weight:"0.5",
    binding:"soft",
    pages:"212",
    language:"English",
    author: #people#,
    publisher: #publisher#
}>

<cfset roles={
    title: "Author"
}>


<cfdump var="#book#" label="book"><br/>
<cfdump var="#people#" label="people"><br/>
<cfdump var="#publisher#" label="publishers"><br/>
<cfdump var="#roles#" label="roles">


