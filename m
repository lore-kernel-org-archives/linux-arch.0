Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g2t1383g.austin.hp.com ([15.217.136.92]:23423 "EHLO
	g2t1383g.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758036AbbGGWAH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jul 2015 18:00:07 -0400
Received: from g2t2352.austin.hp.com (g2t2352.austin.hp.com [15.217.128.51])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by g2t1383g.austin.hp.com (Postfix) with ESMTPS id CC48F492B
	for <linux-arch@vger.kernel.org>; Tue,  7 Jul 2015 22:00:06 +0000 (UTC)
Message-ID: <559C4BDF.3020605@hp.com>
Date: Tue, 07 Jul 2015 17:59:59 -0400
From: Waiman Long <waiman.long@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH 4/4] locking/qrwlock: Use direct MCS lock/unlock in slowpath
References: <1436197386-58635-1-git-send-email-Waiman.Long@hp.com> <1436197386-58635-5-git-send-email-Waiman.Long@hp.com> <20150707112449.GR3644@twins.programming.kicks-ass.net>
In-Reply-To: <20150707112449.GR3644@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>
Message-ID: <20150707215959.VbX93xcYw5EWB3sywU2hTQNWMNJOtl-TkPVJTdFgZ2w@z>

On 07/07/2015 07:24 AM, Peter Zijlstra wrote:
> On Mon, Jul 06, 2015 at 11:43:06AM -0400, Waiman Long wrote:
>> Lock waiting in the qrwlock uses the spinlock (qspinlock for x86)
>> as the waiting queue. This is slower than using MCS lock directly
>> because of the extra level of indirection causing more atomics to
>> be used as well as 2 waiting threads spinning on the lock cacheline
>> instead of only one.
> This needs a better explanation. Didn't we find with the qspinlock thing
> that the pending spinner improved performance on light loads?
>
> Taking it out seems counter intuitive, we could very much like these two
> the be the same.

Yes, for lightly loaded case, using raw_spin_lock should have an 
advantage. It is a different matter when the lock is highly contended. 
In this case, having the indirection in qspinlock will make it slower. I 
struggle myself as to whether to duplicate the locking code in qrwlock. 
So I send this patch out to test the water. I won't insist if you think 
this is not a good idea, but I do want to get the previous 2 patches in 
which should not be controversial.

Cheers,
Longman
