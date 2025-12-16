#### What are Gems?

Gems are customized versions of Gemini that help you tackle repetitive tasks or get deep expertise in new areas. When you chat with a Gem, Gemini will tailor responses to save time on repeat goals and guidelines in your Gemini web app and Gemini mobile app prompts.

#### What you'll learn

- Use Gems
- Creating custom Gems
- FAQ    
- References
    

# Use Gems

With Gems, you can create specific and repeatable instructions for Gemini to follow.

1. Go to [gemini.google.com](https://gemini.google.com/ "https://gemini.google.com/")    
2. On the left, click `Gems`.
3. You will see: `Premade by Google` and `My Gems`. Select Gem you like and start chatting with it as wi the regular chat

# Creating custom Gems

1. On the left, click `Gems`.
2. Click `+ New Gem`.
3. Setup the project.
    1. Create a good name — self explanatory
    2. Add description — to provide more details, what the purpose and how to use
    3. Set instructions / #system_prompt — you can click information circle to get tip from Google, also you can follow simple rule of thumb: Role → Task → Context → Format. 

       > There many other ways how to create `Structured Prompt`, you can use any. The main goal is to narrow down #LLM work (be as. specific as possible)
 
4. Click `Save` / `Update`.    

> After you `Save` / `Update` the project you can test it `Preview` tab.

# FAQ

## **1. How Data is Stored (Retention Policy)**

Google stores your data differently depending on your settings and whether human reviewers have accessed it.

- **Default Retention:** By default, Google stores your Gemini activity for **18 months**.
- **Auto-Delete Options:** You can change this setting to automatically delete data older than **3 months** or **36 months**.
- **"Off" State:** If you turn _Gemini Apps Activity_ **OFF**, your conversations are not saved to your history. However, Google still retains them for **72 hours** to maintain the service and process feedback before deleting them.
- **The "Human Review" Exception:** To improve the model, a small subset of conversations is reviewed by human annotators.    
    - **Anonymization:** These conversations are "disconnected" from your Google Account (your email/ID is stripped from them).
    - **Retention:** Because they are disconnected, these specific samples are retained for **up to 3 years**, even if you subsequently delete your activity history.
        

## **2. How to Manage & Delete Your Data**

You can access these controls via the Gemini interface or your Google Account settings.

**Via Browser:**
1. Go to [myactivity.google.com/product/gemini](https://myactivity.google.com/product/gemini "https://myactivity.google.com/product/gemini").    
2. **To delete manually:** Click the **Delete** drop-down button. You can select:  
    Your workspace account and its data is owned and controlled by your organization and your Workspace admin manages data retention policies for your Workspace account, including your conversation history with Gemini.

## 3. Does the history affect my results?

The answer depends on whether you are talking about the **current chat** or **past chats**.

#### **1. Within the Same Conversation (Yes)**

- **Context Window:** Inside a single chat thread, Gemini "remembers" everything you have said previously in that specific session (up to a certain limit).    
- **Impact:** This allows you to ask follow-up questions like _"Rewrite that shorter"_ or _"What did you mean by the first point?"_ without repeating yourself.
- **Tip:** If the model starts getting confused or hallucinating after a very long conversation, it is often best to start a fresh chat to clear this short-term context.

#### **2. Across Different Conversations (Generally No)**

- **Fresh Slate:** When you click **"New Chat,"** Gemini generally starts with a blank slate. It does not look at your chat from last week to inform the chat you are starting today.
- **Privacy Design:** This ensures that topics you discussed previously (e.g., planning a surprise party) do not accidentally bleed into a professional work query you make later.

#### **3. The "Training" Impact (Indirectly Yes)**

- **Global Improvement:** If you have **Gemini Apps Activity** turned on, your history is used to train and refine the model _globally_.
- **Result:** While your history might not directly change _your_ specific next answer in a new chat, your data helps the model learn how humans speak and reason, improving the tool for everyone (including you) over time.
    

# References

1. [![](https://support.google.com/favicon.png)Tips for creating custom Gems - Gemini Apps Help](https://support.google.com/gemini/answer/15235603?hl=en&ref_topic=15236104&sjid=6021284919375341064-EU#zippy=)
2. [![](https://www.google.com/favicon.ico)Welcome to My Activity](https://myactivity.google.com/product/gemini?pli=1)
3. [![](https://support.google.com/favicon.png)Manage & delete your Gemini Apps activity - Computer - Gemini Apps Help](https://support.google.com/gemini/answer/13278892)
4. [![](https://support.google.com/favicon.png)Gemini Apps Privacy Hub - Gemini Apps Help](https://support.google.com/gemini/answer/13594961)