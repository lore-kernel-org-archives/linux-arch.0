From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v2] kernel/signal: Signal-based pre-coredump notification
Date: Tue, 23 Oct 2018 11:23:48 +0200
Message-ID: <20181023092348.GA14340@redhat.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <458c04d8-d189-4a26-729a-bb1d1d751534@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <458c04d8-d189-4a26-729a-bb1d1d751534@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enke Chen <enkechen@cisco.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <christian@brauner.io>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Martin <Dave.Martin@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@s>
List-Id: linux-arch.vger.kernel.org

On 10/22, Enke Chen wrote:
>
> As the coredump of a process may take time, in certain time-sensitive
> applications it is necessary for a parent process (e.g., a process
> manager) to be notified of a child's imminent death before the coredump
> so that the parent process can act sooner, such as re-spawning an
> application process, or initiating a control-plane fail-over.

Personally I still do not like this feature, but I won't argue.

> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -546,6 +546,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>  	struct cred *cred;
>  	int retval = 0;
>  	int ispipe;
> +	bool notify;
>  	struct files_struct *displaced;
>  	/* require nonrelative corefile path and be extra careful */
>  	bool need_suid_safe = false;
> @@ -590,6 +591,15 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>  	if (retval < 0)
>  		goto fail_creds;
>
> +	/*
> +	 * Send the pre-coredump signal to the parent if requested.
> +	 */
> +	read_lock(&tasklist_lock);
> +	notify = do_notify_parent_predump(current);
> +	read_unlock(&tasklist_lock);
> +	if (notify)
> +		cond_resched();

Hmm. I do not understand why do we need cond_resched(). And even if we need it,
why we can't call it unconditionally?

I'd also suggest to move read_lock/unlock(tasklist) into do_notify_parent_predump()
and remove the "task_struct *tsk" argument, tsk is always current.

Yes, do_notify_parent() and do_notify_parent_cldstop() are called with tasklist_lock
held, but there are good reasons for that.


> +static inline int valid_predump_signal(int sig)
> +{
> +	return (sig == SIGCHLD) || (sig == SIGUSR1) || (sig == SIGUSR2);
> +}

I still do not understand why do we need to restrict predump_signal.

PR_SET_PREDUMP_SIG can only change the caller's ->predump_signal, so to me
even PR_SET_PREDUMP_SIG(SIGKILL) is fine.

And once again, SIGCHLD/SIGUSR do not queue, this means that PR_SET_PREDUMP_SIG
is pointless if you have 2 or more children.

> +bool do_notify_parent_predump(struct task_struct *tsk)
> +{
> +	struct sighand_struct *sighand;
> +	struct kernel_siginfo info;
> +	struct task_struct *parent;
> +	unsigned long flags;
> +	pid_t pid;
> +	int sig;
> +
> +	parent = tsk->parent;
> +	sighand = parent->sighand;
> +	pid = task_tgid_vnr(tsk);
> +
> +	spin_lock_irqsave(&sighand->siglock, flags);
> +	sig = parent->signal->predump_signal;
> +	if (!valid_predump_signal(sig)) {
> +		spin_unlock_irqrestore(&sighand->siglock, flags);
> +		return false;
> +	}

Why do we need to check parent->signal->predump_signal under ->siglock?
This complicates the code for no reason, afaics.

> +	clear_siginfo(&info);
> +	info.si_pid = pid;
> +	info.si_signo = sig;
> +	if (sig == SIGCHLD)
> +		info.si_code = CLD_PREDUMP;
> +
> +	__group_send_sig_info(sig, &info, parent);
> +	__wake_up_parent(tsk, parent);

Why __wake_up_parent() ?

do_notify_parent() does this to wake up the parent sleeping in do_wait(), to
report the event. But predump_signal has nothing to do with wait().

Now. This version sends the signal to ->parent, not ->real_parent. OK, but this
means that real_parent won't be notified if its child is traced.


> +	case PR_SET_PREDUMP_SIG:
> +		if (arg3 || arg4 || arg5)
> +			return -EINVAL;
> +
> +		/* 0 is valid for disabling the feature */
> +		if (arg2 && !valid_predump_signal((int)arg2))
> +			return -EINVAL;
> +		me->signal->predump_signal = (int)arg2;
> +		break;

Again, I do not understand why do we need valid_predump_signal(). But even
if we need it, I don't understand why should we check it twice. IOW, why
do_notify_parent_predump() can't simply check ->predump_signal != 0?

Whatever we do, PR_SET_PREDUMP_SIG should validate arg2 anyway. Who else can
change ->predump_signal  after that?

> +	case PR_GET_PREDUMP_SIG:
> +		if (arg3 || arg4 || arg5)
> +			return -EINVAL;
> +		error = put_user(me->signal->predump_signal,
> +				 (int __user *)arg2);

To me it would be better to simply return ->predump_signal, iow

		error = me->signal->predump_signal;
		break;

but I won't insist, this is subjective and cosmetic.

Oleg.
