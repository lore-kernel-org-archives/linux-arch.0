From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] kernel/signal: Signal-based pre-coredump notification
Date: Mon, 15 Oct 2018 18:28:03 -0500
Message-ID: <87va62lri4.fsf@xmission.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com> (Enke Chen's
        message of "Fri, 12 Oct 2018 17:33:35 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Enke Chen <enkechen@cisco.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <christian@brauner.io>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Martin <Dave.Martin@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@surriel.com>, Kirill A. Shute
List-Id: linux-arch.vger.kernel.org

Enke Chen <enkechen@cisco.com> writes:

> For simplicity and consistency, this patch provides an implementation
> for signal-based fault notification prior to the coredump of a child
> process. A new prctl command, PR_SET_PREDUMP_SIG, is defined that can
> be used by an application to express its interest and to specify the
> signal (SIGCHLD or SIGUSR1 or SIGUSR2) for such a notification. A new
> signal code (si_code), CLD_PREDUMP, is also defined for SIGCHLD.
>
> Background:
>
> As the coredump of a process may take time, in certain time-sensitive
> applications it is necessary for a parent process (e.g., a process
> manager) to be notified of a child's imminent death before the coredump
> so that the parent process can act sooner, such as re-spawning an
> application process, or initiating a control-plane fail-over.

You talk about time senstive and then you talk about bash scripts.
I don't think your definition of time-sensitive and my definition match.

With that said I think the best solution would be to figure out how to
allow the coredump to run in parallel with the usual exit signal, and
exit code reaping of the process.

That would solve the problem for everyone, and would not introduce any
new complicated APIs.

Short of that having the prctl in the process that receives the signals
they you are doing is the right way to go.

You are however calling do_notify_parent_predump from the wrong
function, and frankly with the wrong locking.  There are multiple paths
to the do_coredump function so you really want this notification from
do_coredump.

But I still think it would be better to solve the root cause problem and
change the coredump logic to be able to run in parallel with the normal
exit notification and zombie reaping logic.  Then the problem you are
trying to solve goes away and everyone's code gets simpler.

Eric

> Currently there are two ways for a parent process to be notified of a
> child process's state change. One is to use the POSIX signal, and
> another is to use the kernel connector module. The specific events and
> actions are summarized as follows:
>
> Process Event    POSIX Signal                Connector-based
> ----------------------------------------------------------------------
> ptrace_attach()  do_notify_parent_cldstop()  proc_ptrace_connector()
>                  SIGCHLD / CLD_STOPPED
>
> ptrace_detach()  do_notify_parent_cldstop()  proc_ptrace_connector()
>                  SIGCHLD / CLD_CONTINUED
>
> pre_coredump/    N/A                         proc_coredump_connector()
> get_signal()
>
> post_coredump/   do_notify_parent()          proc_exit_connector()
> do_exit()        SIGCHLD / exit_signal
> ----------------------------------------------------------------------
>
> As shown in the table, the signal-based pre-coredump notification is not
> currently available. In some cases using a connector-based notification
> can be quite complicated (e.g., when a process manager is written in shell
> scripts and thus is subject to certain inherent limitations), and a
> signal-based notification would be simpler and better suited.
>
> Signed-off-by: Enke Chen <enkechen@cisco.com>
> ---
>  arch/x86/kernel/signal_compat.c    |  2 +-
>  include/linux/sched.h              |  4 ++
>  include/linux/signal.h             |  5 +++
>  include/uapi/asm-generic/siginfo.h |  3 +-
>  include/uapi/linux/prctl.h         |  4 ++
>  kernel/fork.c                      |  1 +
>  kernel/signal.c                    | 51 +++++++++++++++++++++++++
>  kernel/sys.c                       | 77 ++++++++++++++++++++++++++++++++++++++
>  8 files changed, 145 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
> index 9ccbf05..a3deba8 100644
> --- a/arch/x86/kernel/signal_compat.c
> +++ b/arch/x86/kernel/signal_compat.c
> @@ -30,7 +30,7 @@ static inline void signal_compat_build_tests(void)
>  	BUILD_BUG_ON(NSIGSEGV != 7);
>  	BUILD_BUG_ON(NSIGBUS  != 5);
>  	BUILD_BUG_ON(NSIGTRAP != 5);
> -	BUILD_BUG_ON(NSIGCHLD != 6);
> +	BUILD_BUG_ON(NSIGCHLD != 7);
>  	BUILD_BUG_ON(NSIGSYS  != 1);
>  
>  	/* This is part of the ABI and can never change in size: */
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 09026ea..cfb9645 100644
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
>  	/* JOBCTL_*, siglock protected: */
>  	unsigned long			jobctl;
>  
> diff --git a/include/linux/signal.h b/include/linux/signal.h
> index 706a499..7cb976d 100644
> --- a/include/linux/signal.h
> +++ b/include/linux/signal.h
> @@ -256,6 +256,11 @@ static inline int valid_signal(unsigned long sig)
>  	return sig <= _NSIG ? 1 : 0;
>  }
>  
> +static inline int valid_predump_signal(int sig)
> +{
> +	return (sig == SIGCHLD) || (sig == SIGUSR1) || (sig == SIGUSR2);
> +}
> +
>  struct timespec;
>  struct pt_regs;
>  enum pid_type;
> diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
> index cb3d6c2..1a47cef 100644
> --- a/include/uapi/asm-generic/siginfo.h
> +++ b/include/uapi/asm-generic/siginfo.h
> @@ -267,7 +267,8 @@ struct {				\
>  #define CLD_TRAPPED	4	/* traced child has trapped */
>  #define CLD_STOPPED	5	/* child has stopped */
>  #define CLD_CONTINUED	6	/* stopped child has continued */
> -#define NSIGCHLD	6
> +#define CLD_PREDUMP	7	/* child is about to dump core */
> +#define NSIGCHLD	7
>  
>  /*
>   * SIGPOLL (or any other signal without signal specific si_codes) si_codes
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index c0d7ea0..79f0a8a 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -219,4 +219,8 @@ struct prctl_mm_map {
>  # define PR_SPEC_DISABLE		(1UL << 2)
>  # define PR_SPEC_FORCE_DISABLE		(1UL << 3)
>  
> +/* Whether to receive signal prior to child's coredump */
> +#define PR_SET_PREDUMP_SIG	54
> +#define PR_GET_PREDUMP_SIG	55
> +
>  #endif /* _LINUX_PRCTL_H */
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 07cddff..c296c11 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1985,6 +1985,7 @@ static __latent_entropy struct task_struct *copy_process(
>  	p->dirty_paused_when = 0;
>  
>  	p->pdeath_signal = 0;
> +	p->predump_signal = 0;
>  	INIT_LIST_HEAD(&p->thread_group);
>  	p->task_works = NULL;
>  
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 312b43e..eb4a483 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2337,6 +2337,44 @@ static int ptrace_signal(int signr, kernel_siginfo_t *info)
>  	return signr;
>  }
>  
> +/*
> + * Let the parent, if so desired, know about the imminent death of a child
> + * prior to its coredump.
> + *
> + * Locking logic is similar to do_notify_parent_cldstop().
> + */
> +static void do_notify_parent_predump(struct task_struct *tsk)
> +{
> +	struct sighand_struct *sighand;
> +	struct task_struct *parent;
> +	struct kernel_siginfo info;
> +	unsigned long flags;
> +	int sig;
> +
> +	parent = tsk->real_parent;
> +	sig = parent->predump_signal;
> +
> +	/* Check again with "tasklist_lock" locked by the caller */
> +	if (!valid_predump_signal(sig))
> +		return;
> +
> +	clear_siginfo(&info);
> +	info.si_signo = sig;
> +	if (sig == SIGCHLD)
> +		info.si_code = CLD_PREDUMP;
> +
> +	rcu_read_lock();
> +	info.si_pid = task_pid_nr_ns(tsk, task_active_pid_ns(parent));
> +	info.si_uid = from_kuid_munged(task_cred_xxx(parent, user_ns),
> +				       task_uid(tsk));
> +	rcu_read_unlock();
> +
> +	sighand = parent->sighand;
> +	spin_lock_irqsave(&sighand->siglock, flags);
> +	__group_send_sig_info(sig, &info, parent);
> +	spin_unlock_irqrestore(&sighand->siglock, flags);
> +}
> +
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
> +			}
> +
>  			if (print_fatal_signals)
>  				print_fatal_signal(ksig->info.si_signo);
>  			proc_coredump_connector(current);
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 123bd73..43eb250d 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2258,6 +2258,76 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struct *t, unsigned long which,
>  	return -EINVAL;
>  }
>  
> +static int prctl_get_predump_signal(struct task_struct *tsk, pid_t pid,
> +				    int __user *addr)
> +{
> +	struct task_struct *p;
> +	int error;
> +
> +	/* For the current task, the common case */
> +	if (pid == 0) {
> +		put_user(tsk->predump_signal, addr);
> +		return 0;
> +	}
> +
> +	error = -ESRCH;
> +	rcu_read_lock();
> +	p = find_task_by_vpid(pid);
> +	if (p) {
> +		error = 0;
> +		put_user(p->predump_signal, addr);
> +	}
> +	rcu_read_unlock();
> +	return error;
> +}
> +
> +/*
> + * Returns true if current's euid is same as p's uid or euid,
> + * or has CAP_SYS_ADMIN.
> + *
> + * Called with rcu_read_lock, creds are safe.
> + *
> + * Adapted from set_one_prio_perm().
> + */
> +static bool set_predump_signal_perm(struct task_struct *p)
> +{
> +	const struct cred *cred = current_cred(), *pcred = __task_cred(p);
> +
> +	return uid_eq(pcred->uid, cred->euid) ||
> +	       uid_eq(pcred->euid, cred->euid) ||
> +	       capable(CAP_SYS_ADMIN);
> +}
> +
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
> +
>  SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  		unsigned long, arg4, unsigned long, arg5)
>  {
> @@ -2476,6 +2546,13 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struct *t, unsigned long which,
>  			return -EINVAL;
>  		error = arch_prctl_spec_ctrl_set(me, arg2, arg3);
>  		break;
> +	case PR_SET_PREDUMP_SIG:
> +		error = prctl_set_predump_signal(me, (pid_t)arg2, (int)arg3);
> +		break;
> +	case PR_GET_PREDUMP_SIG:
> +		error = prctl_get_predump_signal(me, (pid_t)arg2,
> +						 (int __user *)arg3);
> +		break;
>  	default:
>  		error = -EINVAL;
>  		break;
