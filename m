From: Enke Chen <enkechen@cisco.com>
Subject: Re: [PATCH] kernel/signal: Signal-based pre-coredump notification
Date: Mon, 15 Oct 2018 11:36:19 -0700
Message-ID: <c5a09a04-b4f2-876b-af83-30f7e527497e@cisco.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <CAG48ez2ZPhnxudqgU7nC2ORvLnS0Ja-qhLSE5WAY361jst7XNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAG48ez2ZPhnxudqgU7nC2ORvLnS0Ja-qhLSE5WAY361jst7XNw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jann Horn <jannh@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, deller@gmx.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, christian@brauner.io, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave.Martin@arm.com, mchehab+samsung@kernel.org, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@surriel.com>, "Kirill A . Shutemov" <kirill.sh>
List-Id: linux-arch.vger.kernel.org

Hi, Jann:

Thanks a lot for you detailed review. Please see my replied/comments inline.

On 10/13/18 11:27 AM, Jann Horn wrote:
> On Sat, Oct 13, 2018 at 2:33 AM Enke Chen <enkechen@cisco.com> wrote:
>> For simplicity and consistency, this patch provides an implementation
>> for signal-based fault notification prior to the coredump of a child
>> process. A new prctl command, PR_SET_PREDUMP_SIG, is defined that can
>> be used by an application to express its interest and to specify the
>> signal (SIGCHLD or SIGUSR1 or SIGUSR2) for such a notification. A new
>> signal code (si_code), CLD_PREDUMP, is also defined for SIGCHLD.
> 
> Your suggested API looks vaguely similar to PR_SET_PDEATHSIG, but with
> some important differences:
> 
>  - You don't reset the signal on setuid execution.
>  - You permit setting this not just on the current process, but also on others.
> 
> For both of these: Are these differences actually necessary, and if
> so, can you provide a specific rationale? From a security perspective,
> I would very much prefer it if this API had semantics closer to
> PR_SET_PDEATHSIG.

Regarding setting on others, I started with setting for self. But there is
a requirement for supporting the feature for a process manager written in
bash script. That's the reason for allowing the setting on others.

Given the feedback from you and others, I agree that it would be simpler and
more secure to remove the setting on others. We can submit a patch for bash
to support the setting natively.

Regarding the impact of "setuid", this property "PR_SET_PREDUMP_SIG" has to
do with the application/process whether the signal handler is set for receiving
such a notification.  If it is set, the "uid" should not matter.

> 
> [...]
>> diff --git a/kernel/signal.c b/kernel/signal.c
>> index 312b43e..eb4a483 100644
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -2337,6 +2337,44 @@ static int ptrace_signal(int signr, kernel_siginfo_t *info)
>>         return signr;
>>  }
>>
>> +/*
>> + * Let the parent, if so desired, know about the imminent death of a child
>> + * prior to its coredump.
>> + *
>> + * Locking logic is similar to do_notify_parent_cldstop().
>> + */
>> +static void do_notify_parent_predump(struct task_struct *tsk)
>> +{
>> +       struct sighand_struct *sighand;
>> +       struct task_struct *parent;
>> +       struct kernel_siginfo info;
>> +       unsigned long flags;
>> +       int sig;
>> +
>> +       parent = tsk->real_parent;
>> +       sig = parent->predump_signal;
>> +
>> +       /* Check again with "tasklist_lock" locked by the caller */
>> +       if (!valid_predump_signal(sig))
>> +               return;
>> +
>> +       clear_siginfo(&info);
>> +       info.si_signo = sig;
>> +       if (sig == SIGCHLD)
>> +               info.si_code = CLD_PREDUMP;
>> +
>> +       rcu_read_lock();
>> +       info.si_pid = task_pid_nr_ns(tsk, task_active_pid_ns(parent));
>> +       info.si_uid = from_kuid_munged(task_cred_xxx(parent, user_ns),
>> +                                      task_uid(tsk));
> 
> You're sending a signal from the current namespaces, but with IDs that
> have been mapped into the parent's namespaces? That looks wrong to me.

I am following the example "do_notify_parent_cldstop()" called in the same
routine "get_signal()". If there is a better way, sure I will use it.

> 
>> +       rcu_read_unlock();
>> +
>> +       sighand = parent->sighand;
>> +       spin_lock_irqsave(&sighand->siglock, flags);
>> +       __group_send_sig_info(sig, &info, parent);
>> +       spin_unlock_irqrestore(&sighand->siglock, flags);
>> +}
>> +
>>  bool get_signal(struct ksignal *ksig)
>>  {
>>         struct sighand_struct *sighand = current->sighand;
>> @@ -2497,6 +2535,19 @@ bool get_signal(struct ksignal *ksig)
>>                 current->flags |= PF_SIGNALED;
>>
>>                 if (sig_kernel_coredump(signr)) {
>> +                       /*
>> +                        * Notify the parent prior to the coredump if the
>> +                        * parent is interested in such a notificaiton.
>> +                        */
>> +                       int p_sig = current->real_parent->predump_signal;
> 
> current->real_parent is an __rcu member. I think if you run the sparse
> checker against this patch, it's going to complain. Are you allowed to
> access current->real_parent in this context?

Let me check, and get back to you on this one.

> 
>> +                       if (valid_predump_signal(p_sig)) {
>> +                               read_lock(&tasklist_lock);
>> +                               do_notify_parent_predump(current);
>> +                               read_unlock(&tasklist_lock);
>> +                               cond_resched();
>> +                       }
>> +
>>                         if (print_fatal_signals)
>>                                 print_fatal_signal(ksig->info.si_signo);
>>                         proc_coredump_connector(current);
>> diff --git a/kernel/sys.c b/kernel/sys.c
>> index 123bd73..43eb250d 100644
>> --- a/kernel/sys.c
>> +++ b/kernel/sys.c
>> @@ -2258,6 +2258,76 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struct *t, unsigned long which,
>>         return -EINVAL;
>>  }
>>
>> +static int prctl_get_predump_signal(struct task_struct *tsk, pid_t pid,
>> +                                   int __user *addr)
>> +{
>> +       struct task_struct *p;
>> +       int error;
>> +
>> +       /* For the current task, the common case */
>> +       if (pid == 0) {
>> +               put_user(tsk->predump_signal, addr);
>> +               return 0;
>> +       }
>> +
>> +       error = -ESRCH;
>> +       rcu_read_lock();
>> +       p = find_task_by_vpid(pid);
>> +       if (p) {
>> +               error = 0;
>> +               put_user(p->predump_signal, addr);
> 
> This is wrong. You can't call put_user() while you're in an RCU
> read-side critical section.
> 
> As below, I would like it if you could just get rid of this branch,
> and restrict this prctl to operating on the current process.

My bad. The code will be removed.

> 
>> +       }
>> +       rcu_read_unlock();
>> +       return error;
>> +}
>> +
>> +/*
>> + * Returns true if current's euid is same as p's uid or euid,
>> + * or has CAP_SYS_ADMIN.
>> + *
>> + * Called with rcu_read_lock, creds are safe.
>> + *
>> + * Adapted from set_one_prio_perm().
>> + */
>> +static bool set_predump_signal_perm(struct task_struct *p)
>> +{
>> +       const struct cred *cred = current_cred(), *pcred = __task_cred(p);
>> +
>> +       return uid_eq(pcred->uid, cred->euid) ||
>> +              uid_eq(pcred->euid, cred->euid) ||
>> +              capable(CAP_SYS_ADMIN);
>> +}
> 
> This permission check permits fiddling with other processes in
> scenarios where kill() wouldn't let you send signals (specifically, if
> you control the EUID of the target task). That worries me. Also,
> kill() is subject to LSM checks (see check_kill_permission()), but
> this interface isn't. I would really prefer it if you could amend this
> so that you can only operate on the current task, and get rid of this
> permission check.

It is gone.

> 
> [...]
>>  SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>>                 unsigned long, arg4, unsigned long, arg5)
>>  {
>> @@ -2476,6 +2546,13 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struct *t, unsigned long which,
>>                         return -EINVAL;
>>                 error = arch_prctl_spec_ctrl_set(me, arg2, arg3);
>>                 break;
>> +       case PR_SET_PREDUMP_SIG:
>> +               error = prctl_set_predump_signal(me, (pid_t)arg2, (int)arg3);
>> +               break;
>> +       case PR_GET_PREDUMP_SIG:
>> +               error = prctl_get_predump_signal(me, (pid_t)arg2,
>> +                                                (int __user *)arg3);
>> +               break;
> 
> New prctl() calls should check that the unused arguments are zero, in
> order to make it possible to safely add more flags in the future.

Will do.

Thanks again.  -- Enke
