Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34465 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfBZPJV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Feb 2019 10:09:21 -0500
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
References: <20190225175517.GK4072@linux.ibm.com>
 <20190226093009.GS32477@hirez.programming.kicks-ass.net>
 <20190226104551.GF32534@hirez.programming.kicks-ass.net>
 <20190226112133.GG32534@hirez.programming.kicks-ass.net>
 <20190226112521.GH32534@hirez.programming.kicks-ass.net>
 <20190226113008.GI32534@hirez.programming.kicks-ass.net>
 <20190226113813.GA14753@zn.tnic>
 <20190226134906.GG32494@hirez.programming.kicks-ass.net>
 <20190226142845.GK4072@linux.ibm.com>
 <b8cdca74-6f7d-cfe3-636c-41a59b0d86da@gmail.com>
 <20190226150427.GM4072@linux.ibm.com>
From: Akira Yokosawa <akiyks@gmail.com>
Message-ID: <0d7275f1-4ed1-f13d-baab-27de8a061aa0@gmail.com>
Date: Wed, 27 Feb 2019 00:09:15 +0900
MIME-Version: 1.0
In-Reply-To: <20190226150427.GM4072@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Andrea Parri <andrea.parri@amarulasolutions.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Daniel Lustig <dlustig@nvidia.com>
Message-ID: <20190226150915.uvSDjtdqMlcsLDtTV-HePVGpa7uNbtvUAhK7j4FCBPY@z>

On Tue, 26 Feb 2019 07:04:27 -0800, Paul E. McKenney wrote:
> On Tue, Feb 26, 2019 at 11:56:57PM +0900, Akira Yokosawa wrote:
>> Hi Paul,
>>
>> On Tue, 26 Feb 2019 06:28:45 -0800, Paul E. McKenney wrote:
>>> On Tue, Feb 26, 2019 at 02:49:06PM +0100, Peter Zijlstra wrote:
>>>> On Tue, Feb 26, 2019 at 12:38:13PM +0100, Borislav Petkov wrote:
>>>>> On Tue, Feb 26, 2019 at 12:30:08PM +0100, Peter Zijlstra wrote:
>>>>>> When I used the argc variant, gcc-8 'works', but with s/argc/1/ it is
>>>>>> still broken.
>>>>>
>>>>> As requested on IRC:
>>>>
>>>> What I asked was if you could get your GCC developer friends to have a
>>>> look at this :-)
>>>
>>> Yes, this all is a bit on the insane side from a kernel viewpoint.
>>> But the paper you found does not impose this; it has instead been there
>>> for about 20 years, back before C and C++ admitted to the existence
>>> of concurrency.
>>
>> By "it", do you mean the concept of "pointer provenance"?
>>
>> I'm asking because the paper's header reads:
>>
>>         "ISO/IEC JTC1/SC22/WG14 N2311, 2018-11-09"
>>
>> Just wanted to make sure.
> 
> This paper introduces neither pointer provenance nor indeterminate-on-free,
> but rather proposes modification.  These things have been around for a
> few decades.

Got it!

        Thank, Akira
> 
> 							Thanx, Paul
> 
>>         Thanks, Akira
>>
>>>                  But of course compilers are getting more aggressive,
>>> and yes, some of the problems show up in single-threaded code.
>>>
>>> The usual response is "then cast the pointers to intptr_t!" but of
>>> course that breaks type checking.
>>>
>>> There is an effort to claw back the concurrency pieces, and I would
>>> be happy to run the resulting paper past you guys.
>>>
>>> I must confess to not being all that sympathetic to code that takes
>>> advantage of happenstance stack-frame layout.  Is there some reason
>>> we need that?
>>>
>>> 							Thanx, Paul
>>>
>>
> 
