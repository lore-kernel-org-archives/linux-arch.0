From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH 2/4] locking/qrwlock: Reduce reader/writer to reader lock
 transfer latency
Date: Tue, 07 Jul 2015 10:30:22 -0400
Message-ID: <559BE27E.6060901@hp.com>
References: <1436197386-58635-1-git-send-email-Waiman.Long@hp.com> <1436197386-58635-3-git-send-email-Waiman.Long@hp.com> <20150706182353.GC1607@arm.com> <559ADBCD.6020803@hp.com> <20150707091711.GA23879@arm.com> <20150707111731.GQ3644@twins.programming.kicks-ass.net> <20150707114918.GG23879@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54]:57779 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757275AbbGGOa2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jul 2015 10:30:28 -0400
In-Reply-To: <20150707114918.GG23879@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>

On 07/07/2015 07:49 AM, Will Deacon wrote:
> On Tue, Jul 07, 2015 at 12:17:31PM +0100, Peter Zijlstra wrote:
>> On Tue, Jul 07, 2015 at 10:17:11AM +0100, Will Deacon wrote:
>>>>> Thinking about it, can we kill _QW_WAITING altogether and set (cmpxchg
>>>>> from 0) wmode to _QW_LOCKED in the write_lock slowpath, polling (acquire)
>>>>> rmode until it hits zero?
>>>> No, this is how we make the lock fair so that an incoming streams of
>>>> later readers won't block a writer from getting the lock.
>>> But won't those readers effectively see that the lock is held for write
>>> (because we set wmode to _QW_LOCKED before the existing reader had drained)
>>> and therefore fall down the slow-path and get held up on the spinlock?
>> Yes, that's the entire point. Once there's a writer pending, new readers
>> should queue too.
> Agreed. My point was that we can achieve the same result without
> a separate _QW_WAITING flag afaict.
>
> Will
>

_QW_WAITING and _QW_LOCKED has different semantics and are necessary for 
the proper handshake between readers and writer. We set _QW_WAITING when 
readers own the lock and the writer is waiting for the readers to go 
away. The _QW_WAITING flag will force new readers to go to queuing while 
the writer is waiting. We set _QW_LOCKED when a writer own the lock and 
it can only be set atomically when no reader is present. Without the 
intermediate _QW_WAITING step, a continuous stream of incoming readers 
(which make the reader count never 0) could deny a writer from getting 
the lock indefinitely.

Cheers,
Longman
