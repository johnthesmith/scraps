# About Gap

**Gap** a tool for sharing formation about payments in the public space. **Gap**
minimizes or elliminates cross-border payments. The system builds on voluntary
exchange of the information about planed transactions. Any physical or a
representative of a legal entity can leave information about planned payments. Gap
stores this information and makes it available to other users upon request.

## How it works

Gap receives information from users about planned payments between different regions. Suppose Alice, who lives in the 
<span style="background-color:#ffcc00">Orangeland</span> region, provides services to Carlos, who lives in the <span 
style="background-color:#00ccff">Blueland</span> region. Carlos makes a cross-border payment.

```mermaid
graph RL
    subgraph Orangeland
        Alice
    end
    subgraph Blueland
        Carlos
    end

    Alice --> |Services| Carlos
    Carlos --> |$| Alice
```

At the same time, Dave from <span style="background-color:#00ccff">Blueland</span> is waiting for money from Bob from 
<span style="background-color:#ffcc00">Orangeland</span> for services.

```mermaid
 graph RL
    subgraph Orangeland
        Bob
    end
    subgraph Blueland
        Dave
    end

    Dave --> |Services| Bob
    Bob --> |$| Dave
```

Alice and Bob live in the same region but do not know each other. The same goes for
Carlos and Dave. To complete the transaction, the parties must make two cross-border
payments.

```mermaid
graph RL
    subgraph Orangeland
        Alice
        Bob
    end

    subgraph Blueland
        Carlos
        Dave
    end

    Alice --> |Services| Carlos --> |$| Alice
    Dave --> |Services| Bob --> |$| Dave
```

Gap invites the parties to meet and make settlements as follows:

```mermaid
graph RL
    subgraph Orangeland
        Alice
        Bob
    end

    subgraph Blueland
        Carlos
        Dave
    end

    Alice
    --> |Services| Carlos
    --> |$| Dave
    --> |Services| Bob
    --> |$| Alice
```

Thus, only services and goods pass through the border between <span style="background-color:#ffcc00">Orangeland</span> 
and <span style="background-color:#00ccff">Blueland</span>. Transactions carried out in the regions. The issue of 
transactions between the parties is at the discretion of the participants. Gap performs exclusively informational 
function and acquaints the parties.

## Search offers

To search for a pair trade, the user must provide the following information:

- The amount of the planned payment
- Payment currency
- Region of the payer
- Recipient's region

Gap will match paired trades if available. The user leaves contacts for transactions of interest. In case the search is
not gave results, the user can leave a request, which will be displayed to other participants.

## Offer

To apply, you will need all the data specified in the search, and the contact of the participant who left the
application. It is this contact that will be presented to other users on the next search. A deal is registered every
time a user leaves a contact.

Gap will start publishing a new offer immediately.

## Registration

Gap does not require registration. All credentials are based on a link that you can get in any **Copy** option. The loss
of the link is tantamount to the loss of information on your orders and transactions.

