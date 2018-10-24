From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v3] kernel/signal: Signal-based pre-coredump notification
Date: Wed, 24 Oct 2018 16:02:15 +0200
Message-ID: <20181024140214.GG30128@redhat.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <458c04d8-d189-4a26-729a-bb1d1d751534@cisco.com>
 <7741efa7-a3f8-62a1-ba52-613883164643@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7741efa7-a3f8-62a1-ba52-613883164643@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enke Chen <enkechen@cisco.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <christian@brauner.io>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Martin <Dave.Martin@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@s>
List-Id: linux-arch.vger.kernel.org

On 10/23, Enke Chen wrote:
>
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -590,6 +590,12 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>  	if (retval < 0)
>  		goto fail_creds;
>
> +	/*
> +	 * Send the pre-coredump signal to the parent if requested.
> +	 */
> +	do_notify_parent_predump();
> +	cond_resched();

I am still not sure cond_resched() makes any sense here...

> @@ -1553,6 +1553,9 @@ static int copy_signal(unsigned long clone_flags, struct task_struct *tsk)
>  	tty_audit_fork(sig);
>  	sched_autogroup_fork(sig);
>
> +	/* Clear the pre-coredump signal for the child */
> +	sig->predump_signal = 0;

No need, copy_signal() does zalloc().


> +void do_notify_parent_predump(void)
> +{
> +	struct sighand_struct *sighand;
> +	struct kernel_siginfo info;
> +	struct task_struct *parent;
> +	unsigned long flags;
> +	int sig;
> +
> +	read_lock(&tasklist_lock);
> +	parent = current->parent;
> +	sig = parent->signal->predump_signal;
> +	if (sig != 0) {
> +		clear_siginfo(&info);
> +		info.si_pid = task_tgid_vnr(current);
> +		info.si_signo = sig;
> +		if (sig == SIGCHLD)
> +			info.si_code = CLD_PREDUMP;
> +
> +		sighand = parent->sighand;
> +		spin_lock_irqsave(&sighand->siglock, flags);
> +		__group_send_sig_info(sig, &info, parent);
> +		spin_unlock_irqrestore(&sighand->siglock, flags);

You can just use do_send_sig_info() and remove sighand/flags/spin_lock_irqsave.

Perhaps the "likely" predump_signal==0 check at the start makes sense to avoid
read_lock(tasklist).

And I'd suggest to move it into coredump.c and make it static. It won't have
another user.

Oleg.
