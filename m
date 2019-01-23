Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46646 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfAWWg1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 Jan 2019 17:36:27 -0500
Subject: Re: [PATCH v2 1/4] locking/qspinlock: Handle > 4 slowpath nesting
 levels
References: <1548215351-18896-1-git-send-email-longman@redhat.com>
 <1548215351-18896-2-git-send-email-longman@redhat.com>
 <20190123093424.GE15019@brain-police>
 <63131030-bd24-34bf-10dc-b5e7c7c177be@redhat.com>
 <20190123204038.GL13777@hirez.programming.kicks-ass.net>
From: Waiman Long <longman@redhat.com>
Message-ID: <0229798a-f5c8-4c90-3ae6-f25a969989a3@redhat.com>
Date: Wed, 23 Jan 2019 17:36:22 -0500
MIME-Version: 1.0
In-Reply-To: <20190123204038.GL13777@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>, James Morse <james.morse@arm.com>, SRINIVAS <srinivas.eeda@oracle.com>
Message-ID: <20190123223622.A2Uqz4YP1NMZmUDG7wmWz5XObBDz6DndoiE-IRA8H_I@z>

On 01/23/2019 03:40 PM, Peter Zijlstra wrote:
> On Wed, Jan 23, 2019 at 03:11:19PM -0500, Waiman Long wrote:
>> On 01/23/2019 04:34 AM, Will Deacon wrote:
>>> On Tue, Jan 22, 2019 at 10:49:08PM -0500, Waiman Long wrote:
>>>> @@ -412,6 +412,21 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>>>>  	idx = node->count++;
>>>>  	tail = encode_tail(smp_processor_id(), idx);
>>>> +	if (unlikely(idx >= MAX_NODES)) {
>>>> +		while (!queued_spin_trylock(lock))
>>>> +			cpu_relax();
>>>> +		goto release;
>>>> +	}
>> So the additional code checks the idx value and branch to the end of the
>> function when the condition is true. There isn't too much overhead here.
> So something horrible we could do (and I'm not at all advocating we do
> this), is invert node->count. That is, start at 3 and decrement and
> detect sign flips.
>
> That avoids the additional compare. It would require we change the
> structure layout though, otherwise we keep hitting that second line by
> default, which would suck.

The cost of the additional compare will not be noticeable if the branch
prediction logic is working properly. Inverting the loop logic, however,
will be a much bigger change and it may not guarantee it will be faster
anyway. So I don't think we should down go this route :-)

Cheers,
Longman
