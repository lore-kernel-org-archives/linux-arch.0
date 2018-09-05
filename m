From: Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Date: Thu, 6 Sep 2018 00:04:14 +0900
Message-ID: <e8dbdd89-ff65-31ea-8d04-7e84b64a98b0@gmail.com>
References: <20180904081144.GA4137@andrea>
 <Pine.LNX.4.44L0.1809041503470.17060-100000@netrider.rowland.org>
 <20180905072151.GA3185@andrea>
 <50f0a7a7-0521-f833-34c3-132ce57dd777@gmail.com>
 <20180905150042.GA8820@andrea>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905150042.GA8820@andrea>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr
List-Id: linux-arch.vger.kernel.org

On 2018/09/06 0:00, Andrea Parri wrote:
> On Wed, Sep 05, 2018 at 11:33:08PM +0900, Akira Yokosawa wrote:
>> On 2018/09/05 09:21:51 +0200, Andrea Parri wrote:
>>> On Tue, Sep 04, 2018 at 03:09:49PM -0400, Alan Stern wrote:
>>>> On Tue, 4 Sep 2018, Andrea Parri wrote:
>>>>> Heh, your confusion might be the reflection of mine... ;-)  That was
>>>>> indeed a long and not conclusive discussion (meaning there're pending
>>>>> issues); and I cannot claim to find "arguments" such as:
>>>>>
>>>>>   "More than one kernel developer has expressed the opinion that
>>>>>    the LKMM should enforce ordering of writes by locking."
>>>>>
>>>>> particularly helpful (I do tend to be convinced by arguments rather
>>>>> than by opinions).  In fact, you can take the following as my only
>>>>> current "constructive argument" against the patch [1,2]:
>>>>>
>>>>>   THE COMMIT MESSAGE IS RIDICULOUS; PLEASE EXPAND ON IT, AND DO
>>>>>   SO BY LEVERAGING BOTH PROS AND CONS OF THE APPLIED CHANGES
>>>>
>>>> Do you have any concrete suggestions (i.e., some actual text) for 
>>>> improvements to the patch description?  Earlier in your message you 
>>>> mentioned that Will's comment:
>>>>
>>>> 	LKMM offers stronger guarantees that can portably be relied upon
>>>> 	in the codebase.
>>>>
>>>> would make a good addition.  Suitably edited, it could be added to the
>>>> description.  I can think of a few other things myself, but I'd like to 
>>>> hear your thoughts.  Anything else?
>>>
>>> Yes: I do sometimes have the impression that your "rules" for trimming
>>> text in emails/replies are too aggressive...
>>
>> Andrea, by saying "Yes:", do you mean you have something else to be added?
> 
> Indeed (examples in the trimmed text).

So, you mean just amending commit log does not work for you?

> 
> 
>> I don't think you do, but want to make sure.
>>
>> I'm a bit surprised to see all you wanted was the amendment of the
>> commit log...
> 
> Well, I said that it was my only current constructive argument...

This thread is getting quite hard for me to follow...

   Akira

> 
>   Andrea
> 
> 
>>
>>   Akira
>>
>>>
>>>   Andrea
>>>
>>>
>>>>
>>>> Alan
>>>>
>>
