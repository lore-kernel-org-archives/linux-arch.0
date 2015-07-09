Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49073 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753903AbbGIWEi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 9 Jul 2015 18:04:38 -0400
Message-ID: <1436479469.27924.19.camel@stgolabs.net>
Subject: Re: [PATCH-tip v2 0/2] locking/qrwlock: Improve qrwlock performance
From: Davidlohr Bueso <dave@stgolabs.net>
Date: Thu, 09 Jul 2015 15:04:29 -0700
In-Reply-To: <1436459543-29126-1-git-send-email-Waiman.Long@hp.com>
References: <1436459543-29126-1-git-send-email-Waiman.Long@hp.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <Waiman.Long@hp.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>
Message-ID: <20150709220429.cRqsgQZdkf1weFBATy2N1E27e52jydrNJ81zwN1F4mk@z>

On Thu, 2015-07-09 at 12:32 -0400, Waiman Long wrote:
> With this patch series in place, we can start converting some spinlocks
> back to rwlocks where it makes sense and the lock size increase isn't
> a concern.

Nice, have any users to convert? I can think of a few I've encountered,
but there must be quite a few, specially those nasty global spinlocks
where nobody cares about the size.

o hugetlb reservation map lock: Updating hugepage ranges does a two step
read/update for the reservation map. The first step could now be done
concurrently if converted.

o The infamous swap_lock; although I doubt any of the serious offenders
(ie zswap callbacks) would benefit much for anything
beyond /proc/meminfo and related.

o async cookie sync wait_event, battery/ata bootup(?).

etc. etc. Obviously the fairness factor is also something to consider.

Thanks,
Davidlohr 

