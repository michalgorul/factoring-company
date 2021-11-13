// Import with ES6
import Regon from "regon-js";


const api = async () => {

    const TEST_API_KEY = "abcde12345abcde12345"
    const CD_PROJEKT_NIP = "7342867148"



// Create a client with a configuration object
    const client = new Regon({
        // key: TEST_API_KEY, // Required for non-sandbox mode. Your API key
        sandbox: true, // Optional. Enables sandbox mode. Off by default
    });


// // Without async-await
//     client.login().then(() => {
//         const results = client.search({nip: CD_PROJEKT_NIP});
//         console.log("Results", results);
//     })


// With async-await
    await client.login(); // Log in to obtain a new session ID

    const results = await client.search({
        nip: CD_PROJEKT_NIP,
    });

    await client.logout(); // Log out to remove the session ID

    console.log('Results', results);
}

export {api};