Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bl2on0124.outbound.protection.outlook.com ([65.55.169.124]:53427
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753055AbcFOTJA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Jun 2016 15:09:00 -0400
Message-ID: <5761A7C0.6000709@hpe.com>
Date: Wed, 15 Jun 2016 15:08:48 -0400
From: Waiman Long <waiman.long@hpe.com>
MIME-Version: 1.0
Subject: Re: [RFC PATCH-tip v2 1/6] locking/osq: Make lock/unlock proper acquire/release
 barrier
References: <1465944489-43440-1-git-send-email-Waiman.Long@hpe.com> <1465944489-43440-2-git-send-email-Waiman.Long@hpe.com> <20160615165659.GC2094@linux-80c1.suse> <20160615171250.GO30921@twins.programming.kicks-ass.net>
In-Reply-To: <20160615171250.GO30921@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, Jason Low <jason.low2@hp.com>, Dave Chinner <david@fromorbit.com>, Scott J Norton <scott.norton@hpe.com>, Douglas Hatch <doug.hatch@hpe.com>
Message-ID: <20160615190848.MTdAaG7C5oLssI_j-rZbWktvYkdyjdK2tQqbRrZQ6ek@z>

On 06/15/2016 01:12 PM, Peter Zijlstra wrote:
> On Wed, Jun 15, 2016 at 09:56:59AM -0700, Davidlohr Bueso wrote:
>> On Tue, 14 Jun 2016, Waiman Long wrote:
>>> +++ b/kernel/locking/osq_lock.c
>>> @@ -115,7 +115,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>>> 	 * cmpxchg in an attempt to undo our queueing.
>>> 	 */
>>>
>>> -	while (!READ_ONCE(node->locked)) {
>>> +	while (!smp_load_acquire(&node->locked)) {
>> Hmm this being a polling path, that barrier can get pretty expensive and
>> last I checked it was unnecessary:
> I think he'll go rely on it later on.
>
> In any case, its fairly simple to cure, just add
> smp_acquire__after_ctrl_dep() at the end. If we bail because
> need_resched() we don't need the acquire I think.

Yes, I only need the acquire barrier when the locking is successful. 
Thanks for the suggestion. I will make the change accordingly.

Cheers,
Longman
