From: Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH-tip v2 0/2] locking/qrwlock: Improve qrwlock performance
Date: Thu, 09 Jul 2015 15:04:29 -0700
Message-ID: <1436479469.27924.19.camel@stgolabs.net>
References: <1436459543-29126-1-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436459543-29126-1-git-send-email-Waiman.Long@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Waiman Long <Waiman.Long@hp.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>
List-Id: linux-arch.vger.kernel.org

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
