const updateWithToken = async (url, body) => {
    fetch( url, {
        method: "PUT",
        headers: {
            "Content-Type": "application/json",
            "Authorization": `Bearer ${localStorage.getItem("token")}`
        },
        body: JSON.stringify(body)
    })
            
}
 
export {updateWithToken};