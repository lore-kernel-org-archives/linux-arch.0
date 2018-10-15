From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] kernel/signal: Signal-based pre-coredump notification
Date: Mon, 15 Oct 2018 14:05:21 +0200
Message-ID: <20181015120521.GA10146@redhat.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enke Chen <enkechen@cisco.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <christian@brauner.io>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Martin <Dave.Martin@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Hocko <mhocko@kernel.org>, Rik
List-Id: linux-arch.vger.kernel.org

On 10/12, Enke Chen wrote:
>
> For simplicity and consistency, this patch provides an implementation
> for signal-based fault notification prior to the coredump of a child
> process. A new prctl command, PR_SET_PREDUMP_SIG, is defined that can
> be used by an application to express its interest and to specify the
> signal (SIGCHLD or SIGUSR1 or SIGUSR2) for such a notification. A new
> signal code (si_code), CLD_PREDUMP, is also defined for SIGCHLD.

To be honest, I can't say I like this new feature...

> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -696,6 +696,10 @@ struct task_struct {
>  	int				exit_signal;
>  	/* The signal sent when the parent dies: */
>  	int				pdeath_signal;
> +
> +	/* The signal sent prior to a child's coredump: */
> +	int				predump_signal;
> +

At least, I think predump_signal should live in signal_struct, not
task_struct.

(pdeath_signal too, but it is too late to change (fix) this awkward API).

> +static void do_notify_parent_predump(struct task_struct *tsk)
> +{
> +	struct sighand_struct *sighand;
> +	struct task_struct *parent;
> +	struct kernel_siginfo info;
> +	unsigned long flags;
> +	int sig;
> +
> +	parent = tsk->real_parent;

So, debuggere won't be notified, only real_parent...

> +	sig = parent->predump_signal;

probably ->predump_signal should be cleared on exec?

> +	/* Check again with tasklist_lock" locked by the caller */
> +	if (!valid_predump_signal(sig))
> +		return;

I don't understand why we need valid_predump_signal() at all.

>  bool get_signal(struct ksignal *ksig)
>  {
>  	struct sighand_struct *sighand = current->sighand;
> @@ -2497,6 +2535,19 @@ bool get_signal(struct ksignal *ksig)
>  		current->flags |= PF_SIGNALED;
>  
>  		if (sig_kernel_coredump(signr)) {
> +			/*
> +			 * Notify the parent prior to the coredump if the
> +			 * parent is interested in such a notificaiton.
> +			 */
> +			int p_sig = current->real_parent->predump_signal;
> +
> +			if (valid_predump_signal(p_sig)) {
> +				read_lock(&tasklist_lock);
> +				do_notify_parent_predump(current);
> +				read_unlock(&tasklist_lock);
> +				cond_resched();

perhaps this should be called by do_coredump() after coredump_wait() kills
all the sub-threads?

> +static int prctl_set_predump_signal(struct task_struct *tsk, pid_t pid, int sig)
> +{
> +	struct task_struct *p;
> +	int error;
> +
> +	/* 0 is valid for disabling the feature */
> +	if (sig && !valid_predump_signal(sig))
> +		return -EINVAL;
> +
> +	/* For the current task, the common case */
> +	if (pid == 0) {
> +		tsk->predump_signal = sig;
> +		return 0;
> +	}
> +
> +	error = -ESRCH;
> +	rcu_read_lock();
> +	p = find_task_by_vpid(pid);
> +	if (p) {
> +		if (!set_predump_signal_perm(p))
> +			error = -EPERM;
> +		else {
> +			error = 0;
> +			p->predump_signal = sig;
> +		}
> +	}
> +	rcu_read_unlock();
> +	return error;
> +}

Why? I mean, why do we really want to support the pid != 0 case?

Oleg.
