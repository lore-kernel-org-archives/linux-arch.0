From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v2] kernel/signal: Signal-based pre-coredump notification
Date: Wed, 24 Oct 2018 15:52:13 +0200
Message-ID: <20181024135212.GF30128@redhat.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <458c04d8-d189-4a26-729a-bb1d1d751534@cisco.com>
 <20181023092348.GA14340@redhat.com>
 <1e68a3ce-32cd-b058-3d1d-36455ceca848@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1e68a3ce-32cd-b058-3d1d-36455ceca848@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enke Chen <enkechen@cisco.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <christian@brauner.io>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Martin <Dave.Martin@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@s>
List-Id: linux-arch.vger.kernel.org

On 10/23, Enke Chen wrote:
>
> >> +	/*
> >> +	 * Send the pre-coredump signal to the parent if requested.
> >> +	 */
> >> +	read_lock(&tasklist_lock);
> >> +	notify = do_notify_parent_predump(current);
> >> +	read_unlock(&tasklist_lock);
> >> +	if (notify)
> >> +		cond_resched();
> >
> > Hmm. I do not understand why do we need cond_resched(). And even if we need it,
> > why we can't call it unconditionally?
>
> Remember the goal is to allow the parent (e.g., a process manager) to take early
> action. The "yield" before doing coredump will help.

I don't see how can it actually help...

cond_resched() is nop if CONFIG_PREEMPT or should_resched() == 0.

and the coredumping thread will certainly need to sleep/wait anyway.

> > And once again, SIGCHLD/SIGUSR do not queue, this means that PR_SET_PREDUMP_SIG
> > is pointless if you have 2 or more children.
>
> Hmm, could you point me to the code where SIGCHLD/SIGUSR is treated differently
> w.r.t. queuing?  That does not sound right to me.

see the legacy_queue() check. Any signal < SIGRTMIN do not queue. IOW, if SIGCHLD
is already pending, then next SIGCHLD is simply ignored.

Oleg.
