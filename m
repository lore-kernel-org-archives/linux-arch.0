From: Andrii Nakryiko <andriin@fb.com>
Subject: Re: Some -serious- BPF-related litmus tests
Date: Fri, 22 May 2020 12:38:21 -0700
Message-ID: <006e2bc6-7516-1584-3d8c-e253211c157e@fb.com>
References: <20200522003850.GA32698@paulmck-ThinkPad-P72>
 <20200522094407.GK325280@hirez.programming.kicks-ass.net>
 <20200522143201.GB32434@rowland.harvard.edu>
 <20200522174352.GJ2869@paulmck-ThinkPad-P72>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33876 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730894AbgEVTjD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 May 2020 15:39:03 -0400
In-Reply-To: <20200522174352.GJ2869@paulmck-ThinkPad-P72>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulmck@kernel.org, Alan Stern <stern@rowland.harvard.edu>
Cc: Peter Zijlstra <peterz@infradead.org>, parri.andrea@gmail.com, will@kernel.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>

On 5/22/20 10:43 AM, Paul E. McKenney wrote:
> On Fri, May 22, 2020 at 10:32:01AM -0400, Alan Stern wrote:
>> On Fri, May 22, 2020 at 11:44:07AM +0200, Peter Zijlstra wrote:
>>> On Thu, May 21, 2020 at 05:38:50PM -0700, Paul E. McKenney wrote:
>>>> Hello!
>>>>
>>>> Just wanted to call your attention to some pretty cool and pretty serious
>>>> litmus tests that Andrii did as part of his BPF ring-buffer work:
>>>>
>>>> https://lore.kernel.org/bpf/20200517195727.279322-3-andriin@fb.com/
>>>>
>>>> Thoughts?
>>>
>>> I find:
>>>
>>> 	smp_wmb()
>>> 	smp_store_release()
>>>
>>> a _very_ weird construct. What is that supposed to even do?
>>
>> Indeed, it looks like one or the other of those is redundant (depending
>> on the context).
> 
> Probably.  Peter instead asked what it was supposed to even do.  ;-)

I agree, I think smp_wmb() is redundant here. Can't remember why I 
thought that it's necessary, this algorithm went through a bunch of 
iterations, starting as completely lockless, also using 
READ_ONCE/WRITE_ONCE at some point, and settling on 
smp_read_acquire/smp_store_release, eventually. Maybe there was some 
reason, but might be that I was just over-cautious. See reply on patch 
thread as well ([0]).

   [0] 
https://lore.kernel.org/bpf/CAEf4Bza26AbRMtWcoD5+TFhnmnU6p5YJ8zO+SoAJCDtp1jVhcQ@mail.gmail.com/


> 
>> Also, what use is a spinlock that is accessed in only one thread?
> 
> Multiple writers synchronize via the spinlock in this case.  I am
> guessing that his larger 16-hour test contended this spinlock.

Yes, spinlock is for coordinating multiple producers. 2p1c cases 
(bounded and unbounded) rely on this already. 1p1c cases are sort of 
subsets (but very fast to verify) checking only consumer/producer 
interaction.

> 
>> Finally, I doubt that these tests belong under tools/memory-model.
>> Shouldn't they go under the new Documentation/ directory for litmus
>> tests?  And shouldn't the patch update a README file?
> 
> Agreed, and I responded to that effect to his original patch:
> 
> https://lore.kernel.org/bpf/20200522003433.GG2869@paulmck-ThinkPad-P72/

Yep, makes sense, I'll will move.

> 
> 							Thanx, Paul
> 
