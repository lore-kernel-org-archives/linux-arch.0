From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH-tip v2 0/2] locking/qrwlock: Improve qrwlock performance
Date: Thu, 09 Jul 2015 21:16:26 -0400
Message-ID: <559F1CEA.4060806@hp.com>
References: <1436459543-29126-1-git-send-email-Waiman.Long@hp.com> <1436479469.27924.19.camel@stgolabs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g2t2353.austin.hp.com ([15.217.128.52]:20433 "EHLO
	g2t2353.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbbGJBQa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2015 21:16:30 -0400
In-Reply-To: <1436479469.27924.19.camel@stgolabs.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>

On 07/09/2015 06:04 PM, Davidlohr Bueso wrote:
> On Thu, 2015-07-09 at 12:32 -0400, Waiman Long wrote:
>> With this patch series in place, we can start converting some spinlocks
>> back to rwlocks where it makes sense and the lock size increase isn't
>> a concern.
> Nice, have any users to convert? I can think of a few I've encountered,
> but there must be quite a few, specially those nasty global spinlocks
> where nobody cares about the size.
>
> o hugetlb reservation map lock: Updating hugepage ranges does a two step
> read/update for the reservation map. The first step could now be done
> concurrently if converted.
>
> o The infamous swap_lock; although I doubt any of the serious offenders
> (ie zswap callbacks) would benefit much for anything
> beyond /proc/meminfo and related.
>
> o async cookie sync wait_event, battery/ata bootup(?).
>
> etc. etc. Obviously the fairness factor is also something to consider.

Yes, I saw a couple of global spinlocks that can be converted to 
rwlocks. The read lock can be used for lookup, whereas the write lock is 
used for modification. Doing so will enable parallel lookups. As the 
qrwlock is almost fair compared with the old implementation, it removes 
a big roadblock for the conversion.

Cheers,
Longman
