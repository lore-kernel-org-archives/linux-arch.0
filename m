Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42808 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbfDDWYI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Apr 2019 18:24:08 -0400
Subject: Re: [PATCH tip/core/rcu 04/21] docs/memory-barriers.txt: Rewrite
 "KERNEL I/O BARRIER EFFECTS" section
References: <20190326234114.GA23843@linux.ibm.com>
 <20190326234133.24962-4-paulmck@linux.ibm.com>
 <20190402130346.GA14559@fuggles.cambridge.arm.com>
 <7c0b1afc-9308-e060-d1cc-7389a2330e97@gmail.com>
 <20190404164022.GB28932@fuggles.cambridge.arm.com>
From: Akira Yokosawa <akiyks@gmail.com>
Message-ID: <1a30f6ec-cbf9-7bb0-3b08-ab785156a144@gmail.com>
Date: Fri, 5 Apr 2019 07:23:59 +0900
MIME-Version: 1.0
In-Reply-To: <20190404164022.GB28932@fuggles.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Mikulas Patocka <mpatocka@redhat.com>
Message-ID: <20190404222359.xKdDJnI0N_wlhqlDsffDWERbysJOMMLjYlLuKvI0aIo@z>

On Thu, 4 Apr 2019 17:40:22 +0100, Will Deacon wrote:
> Hi Akira,
> 
> On Fri, Apr 05, 2019 at 12:58:36AM +0900, Akira Yokosawa wrote:
>> On Tue, 2 Apr 2019 14:03:46 +0100, Will Deacon wrote:
>>> On Tue, Mar 26, 2019 at 04:41:16PM -0700, Paul E. McKenney wrote:
>>>> From: Will Deacon <will.deacon@arm.com>
>>>>
>>>> The "KERNEL I/O BARRIER EFFECTS" section of memory-barriers.txt is vague,
>>>> x86-centric, out-of-date, incomplete and demonstrably incorrect in places.
>>>> This is largely because I/O ordering is a horrible can of worms, but also
>>>> because the document has stagnated as our understanding has evolved.
>>>>
>>>> Attempt to address some of that, by rewriting the section based on
>>>> recent(-ish) discussions with Arnd, BenH and others. Maybe one day we'll
>>>> find a way to formalise this stuff, but for now let's at least try to
>>>> make the English easier to understand.
>>>>
>>>> Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
>>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>> Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
>>>> Cc: Palmer Dabbelt <palmer@sifive.com>
>>>> Cc: Daniel Lustig <dlustig@nvidia.com>
>>>> Cc: David Howells <dhowells@redhat.com>
>>>> Cc: Alan Stern <stern@rowland.harvard.edu>
>>>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>>>> Cc: "Maciej W. Rozycki" <macro@linux-mips.org>
>>>> Cc: Mikulas Patocka <mpatocka@redhat.com>
>>>> Signed-off-by: Will Deacon <will.deacon@arm.com>
>>>> Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
>>>> ---
>>>>  Documentation/memory-barriers.txt | 115 ++++++++++++++++++------------
>>>>  1 file changed, 70 insertions(+), 45 deletions(-)
>>>
>>> If somebody could provide an Ack on this patch, I'd really appreciate it,
>>> please. Whilst the portable ordering guarantees that I've documented are
>>> fairly conservative, I do think that this change is a big improvement and
>>> gives you what you need if you're writing a portable device driver for a new
>>> piece of hardware. I'm tackling the removal of MMIOWB as a separate series.
>>>
>>> I think Paul now requires an Ack before he'll send a patch to mainline,
>>> hence the grovelling.
>>
>> I'm afraid I'm not that qualified to provide an Ack to this patch,
>> but please find a nit fix below.
> 
> Oh well, thanks for having a look anyway!
> 
>>>> + (*) insX(), outsX():
>>>> +
>>>> +     As above, the insX() and outX() accessors provide the same ordering
>>                                   outsX()
> 
> Thanks; I'll fix that.
> 
>>>> +     guarantees as readsX() and writesX() respectively when accessing a mapping
>>>> +     with the default I/O attributes.
>>>>  
>>>>   (*) ioreadX(), iowriteX()
>>>>  
>>>>       These will perform appropriately for the type of access they're actually
>>>>       doing, be it inX()/outX() or readX()/writeX().
>>>>  
>>>> +All of these accessors assume that the underlying peripheral is little-endian,
>>>> +and will therefore perform byte-swapping operations on big-endian architectures.
>>>> +
>>>> +Composing I/O ordering barriers with SMP ordering barriers and LOCK/UNLOCK
>>>> +operations is a dangerous sport which may require the use of mmiowb(). See the
>>>> +subsection "Acquires vs I/O accesses" for more information.
>>>>  
>>>>  ========================================
>>>>  ASSUMED MINIMUM EXECUTION ORDERING MODEL
>>>> -- 
>>>> 2.17.1
>>>>
>>
>> JFYI, there is another document Documentation/driver-api/device-io.rst,
>> which is somewhat related to this update. It looks like this one also needs
>> some update, as Jon commented in transforming to .rst format in commit
>> 8a8a602fdb83 ("docs: Convert the deviceio template to RST"):
>> <quote>
>>     Like the rest of our documentation, this one could use some work.  There's
>>     no mention of ioremap() and friends, no mention of io_read*() and friends.
>>     But we have nice documentation for all those folks writing new drivers that
>>     do port I/O :).
>> </quote>
>>
>> This commit was merged in v4.11 cycle. And there has been no update whatsoever
>> since. mmiowb() is lightly mentioned therein. IMHO, just updating
>> memory-barriers.txt would widen the gap of information.
>>
>> Thoughts?
> 
> I have a subsequent patch which kills mmiowb() entirely:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?h=for-next/mmiowb&id=3c1a2050c08fb8193777b60b49e60320254a156c
> 
> and that one does hit device-io.rst.

Ah, I see.
So can somebody else have a look at this patch and provide an Ack, please?

        Thanks, Akira

> 
> Will
> 
