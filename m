From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v5 1/2] kernel/signal: Signal-based pre-coredump
 notification
Date: Thu, 29 Nov 2018 11:55:24 +0000
Message-ID: <20181129115520.GO3505@e103592.cambridge.arm.com>
References: <458c04d8-d189-4a26-729a-bb1d1d751534@cisco.com>
 <7741efa7-a3f8-62a1-ba52-613883164643@cisco.com>
 <84460a77-a111-404e-4bad-88104a6e246e@cisco.com>
 <20181026082812.GA10581@redhat.com>
 <21f678a8-4001-df36-c26e-e96cf203b1b1@cisco.com>
 <20181029111804.GA24820@redhat.com>
 <0c197608-3b7e-ffd1-8943-801a60beb917@cisco.com>
 <80e96710-f424-9b39-72ee-9cc7cbe7a5f7@cisco.com>
 <20181128151911.GN3505@e103592.cambridge.arm.com>
 <ad461da7-f0a6-7912-3201-e440dc372f89@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ad461da7-f0a6-7912-3201-e440dc372f89@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enke Chen <enkechen@cisco.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <christian@brauner.io>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@sur>
List-Id: linux-arch.vger.kernel.org

On Thu, Nov 29, 2018 at 12:15:35AM +0000, Enke Chen wrote:
> Hi, Dave:
> 
> Thanks for your comments. You have indeed missed some of the prior reviews
> and discussions. But that is OK.
> 
> Please see my replies inline.
> 
> On 11/28/18 7:19 AM, Dave Martin wrote:
> > On Tue, Nov 27, 2018 at 10:54:41PM +0000, Enke Chen wrote:
> >> [Repost as a series, as suggested by Andrew Morton]
> >>
> >> For simplicity and consistency, this patch provides an implementation
> >> for signal-based fault notification prior to the coredump of a child
> >> process. A new prctl command, PR_SET_PREDUMP_SIG, is defined that can
> >> be used by an application to express its interest and to specify the
> >> signal for such a notification.
> >>
> >> Changes to prctl(2):
> >>
> >>    PR_SET_PREDUMP_SIG (since Linux 4.20.x)
> >>           Set the child pre-coredump signal of the calling process to
> >>           arg2 (either a signal value in the range 1..maxsig, or 0 to
> >>           clear). This is the signal that the calling process will get
> >>           prior to the coredump of a child process. This value is
> >>           cleared across execve(2), or for the child of a fork(2).
> >>
> >>    PR_GET_PREDUMP_SIG (since Linux 4.20.x)
> >>           Return the current value of the child pre-coredump signal,
> >>           in the location pointed to by (int *) arg2.
> >>
> >> Background:
> >>
> >> As the coredump of a process may take time, in certain time-sensitive
> >> applications it is necessary for a parent process (e.g., a process
> >> manager) to be notified of a child's imminent death before the coredump
> >> so that the parent process can act sooner, such as re-spawning an
> >> application process, or initiating a control-plane fail-over.
> >>
> >> One application is BFD. The early fault notification is a critical
> >> component for maintaining BFD sessions (with a timeout value of
> >> 50 msec or 100 msec) across a control-plane failure.
> >>
> >> Currently there are two ways for a parent process to be notified of a
> >> child process's state change. One is to use the POSIX signal, and
> >> another is to use the kernel connector module. The specific events and
> >> actions are summarized as follows:
> >>
> >> Process Event    POSIX Signal                Connector-based
> >> ----------------------------------------------------------------------
> >> ptrace_attach()  do_notify_parent_cldstop()  proc_ptrace_connector()
> >>                  SIGCHLD / CLD_STOPPED
> >>
> >> ptrace_detach()  do_notify_parent_cldstop()  proc_ptrace_connector()
> >>                  SIGCHLD / CLD_CONTINUED
> >>
> >> pre_coredump/    N/A                         proc_coredump_connector()
> >> get_signal()
> >>
> >> post_coredump/   do_notify_parent()          proc_exit_connector()
> >> do_exit()        SIGCHLD / exit_signal
> >> ----------------------------------------------------------------------
> >>
> >> As shown in the table, the signal-based pre-coredump notification is not
> >> currently available. In some cases using a connector-based notification
> >> can be quite complicated (e.g., when a process manager is written in shell
> >> scripts and thus is subject to certain inherent limitations), and a
> >> signal-based notification would be simpler and better suited.
> > 
> > Since this is a notification of a change of process status, would it be
> > more natural to send it through SIGCHLD?
> > 
> > As with other supplementary child status events, a flag could be added
> > for wait and sigaction.sa_flags to indicate whether the parent wants
> > this event to be reported or not.
> > 
> > Then a suitable CLD_XXX could be defined for this, and we could
> > piggyback on PR_{SET,GET}_PDEATHSIG rather than having to have something
> > new.
> > 
> 
> > (I hadn't been watching this thread closely, so apologies if this has
> > been discussed already.)
> 
> Indeed, I defined the signal code CLD_PREDUMP for SIGCHLD initially, but it
> was removed after discussion:
> 
> v3 --> v4:
> 
> Addressed review comments from Oleg Nesterov, and Eric W. Biederman,
> including:
> o remove the definition CLD_PREDUMP.
> ---
> 
> You can look at the discussions in the email thread, in particular several
> issues pointed out by Eric Biederman, and my reply to Eric.

Ah, right.

> There are two models 1:1 (one process manager with one child process), and 1:N
> (one process manager with many child processes). A legacy signal like SIGCHLD
> would not work in the 1:N model due to compression/loss of legacy signals. One
> need to use a RT signal in that case. 

SIGCHLD can be redirected to an RT signal via clone().  Are you saying
the signal is still not queued in that case?  I had assumed that things
like pthreads rely on this working.

However, one detail I had missed is that only child exits are reported
via the exit signal set by clone().  Other child status changes are
seem to be reported via SIGCHLD always.

Making your supervised processes into clone-children might interact
badly with pthreads if it uses wait(__WCLONE) internally.  I've not
looked into that.

> One more point in my reply:
> 
> When an application chooses a signal for pre-coredump notification, it is much
> simpler and robust for the signal to be dedicated for that purpose (in the parent)
> and not be mixed with other semantics. The "signo + pid" should be sufficient for
> the parent process in both 1:1 and 1:N models.

What if the signal queue overflows?  sigqueue() returns EAGAIN, but I
think that signals queued by the kernel would simply be lost.  This
probably won't happen in any non-pathological scenario, but the process
manager may just silently go wrong instead of failing cleanly when/if
this happens.

SIGCHLD + wait() is immune to this problem for other child status
notifications (albeit with higher overhead).

Unless I've missed something fundamental, signals simply aren't a
reliable data transport: if you need 100% reliability, you need to be
using another mechanism, either in combination with a signal, or by
itself.

> >>
> >> Signed-off-by: Enke Chen <enkechen@cisco.com>
> >> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> >> ---
> >> v4 -> v5:
> >> Addressed review comments from Oleg Nesterov:
> >> o use rcu_read_lock instead.
> >> o revert back to notify the real_parent.
> >>
> >>  fs/coredump.c                | 23 +++++++++++++++++++++++
> >>  fs/exec.c                    |  3 +++
> >>  include/linux/sched/signal.h |  3 +++
> >>  include/uapi/linux/prctl.h   |  4 ++++
> >>  kernel/sys.c                 | 13 +++++++++++++
> >>  5 files changed, 46 insertions(+)
> >>
> >> diff --git a/fs/coredump.c b/fs/coredump.c
> >> index e42e17e..740b1bb 100644
> >> --- a/fs/coredump.c
> >> +++ b/fs/coredump.c
> >> @@ -536,6 +536,24 @@ static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
> >>  	return err;
> >>  }
> >>  
> >> +/*
> >> + * While do_notify_parent() notifies the parent of a child's death post
> >> + * its coredump, this function lets the parent (if so desired) know about
> >> + * the imminent death of a child just prior to its coredump.
> >> + */
> >> +static void do_notify_parent_predump(void)
> >> +{
> >> +	struct task_struct *parent;
> >> +	int sig;
> >> +
> >> +	rcu_read_lock();
> >> +	parent = rcu_dereference(current->real_parent);
> >> +	sig = parent->signal->predump_signal;
> >> +	if (sig != 0)
> >> +		do_send_sig_info(sig, SEND_SIG_NOINFO, parent, PIDTYPE_TGID);
> > 
> > Doesn't this send si_code == SI_USER.  That seems wrong: the receiving
> > process wouldn't not be able to distinguish a real pre-coredump
> > notification from a bogus one sent by kill(2) et
> The receiving process (i.e., the process manager) knows the PID of all
> its child processes. Thus it can easily tell whether the signal is from
> a child or not.

But it can't tell whether the child sent the signal via kill(2) etc., or
whether the child started dumping core.

It's cleaner to be able to filter reliably on si_code, especially if the
process you're supervising isn't fully under your control.  For example,
even if the supervised process is considered trustworthy, it could still
be exploited by an attacker (or simply go wrong) in a way that causes
it do to a bogus kill().

(If you treat any incoming signal as anything more than a hint, failure
to check si_code is usually a bug in general.)

> > 
> > SEND_SIG_PRIV also looks wrong, because it assumes that the sender is
> > "the kernel" so there is no si_pid.
> 
> That is why SEND_SIG_NOINFO is chosen here for carrying the "pid". What
> matters to the parent process is the "signo + pid" for identifying the
> child process for the pre-coredump notification.

I think that si_code should at least be SI_KERNEL, but how that is
achieved doesn't really matter.

> > 
> > This may be another reason for building on top of SIGCHLD which already
> > has the required (but weird) "si_pid == affected process" semantics,
> > rather than si_pid indicating the sender.
> > 
> >> +	rcu_read_unlock();
> >> +}
> >> +
> >>  void do_coredump(const kernel_siginfo_t *siginfo)
> >>  {
> >>  	struct core_state core_state;
> >> @@ -590,6 +608,11 @@ void do_coredump(const kernel_siginfo_t *siginfo)
> >>  	if (retval < 0)
> >>  		goto fail_creds;
> >>  
> >> +	/*
> >> +	 * Send the pre-coredump signal to the parent if requested.
> >> +	 */
> >> +	do_notify_parent_predump();
> >> +
> >>  	old_cred = override_creds(cred);
> >>  
> >>  	ispipe = format_corename(&cn, &cprm);
> >> diff --git a/fs/exec.c b/fs/exec.c
> >> index fc281b7..7714da7 100644
> >> --- a/fs/exec.c
> >> +++ b/fs/exec.c
> >> @@ -1181,6 +1181,9 @@ static int de_thread(struct task_struct *tsk)
> >>  	/* we have changed execution domain */
> >>  	tsk->exit_signal = SIGCHLD;
> >>  
> >> +	/* Clear the pre-coredump signal before loading a new binary */
> >> +	sig->predump_signal = 0;
> >> +
> >>  #ifdef CONFIG_POSIX_TIMERS
> >>  	exit_itimers(sig);
> >>  	flush_itimer_signals();
> >> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> >> index 13789d1..728ef68 100644
> >> --- a/include/linux/sched/signal.h
> >> +++ b/include/linux/sched/signal.h
> >> @@ -112,6 +112,9 @@ struct signal_struct {
> >>  	int			group_stop_count;
> >>  	unsigned int		flags; /* see SIGNAL_* flags below */
> >>  
> >> +	/* The signal sent prior to a child's coredump */
> >> +	int			predump_signal;
> >> +
> >>  	/*
> >>  	 * PR_SET_CHILD_SUBREAPER marks a process, like a service
> >>  	 * manager, to re-parent orphan (double-forking) child processes
> >> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> >> index c0d7ea0..79f0a8a 100644
> >> --- a/include/uapi/linux/prctl.h
> >> +++ b/include/uapi/linux/prctl.h
> >> @@ -219,4 +219,8 @@ struct prctl_mm_map {
> >>  # define PR_SPEC_DISABLE		(1UL << 2)
> >>  # define PR_SPEC_FORCE_DISABLE		(1UL << 3)
> >>  
> >> +/* Whether to receive signal prior to child's coredump */
> >> +#define PR_SET_PREDUMP_SIG	54
> >> +#define PR_GET_PREDUMP_SIG	55
> >> +
> >>  #endif /* _LINUX_PRCTL_H */
> >> diff --git a/kernel/sys.c b/kernel/sys.c
> >> index 123bd73..39aa3b8 100644
> >> --- a/kernel/sys.c
> >> +++ b/kernel/sys.c
> >> @@ -2476,6 +2476,19 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struct *t, unsigned long which,
> >>  			return -EINVAL;
> >>  		error = arch_prctl_spec_ctrl_set(me, arg2, arg3);
> >>  		break;
> >> +	case PR_SET_PREDUMP_SIG:
> >> +		if (arg3 || arg4 || arg5)
> > 
> > glibc has
> > 
> > 	int prctl(int option, ...);
> > 
> > Some prctls() police extra arguments for zeros, but this means that
> > the userspace caller also has to supply pointless 0 arguments.
> > 
> > It's debatable which is the preferred approach.  Did you have any
> > particular rationale for your choice here?
> >
> 
> The initial version did not check the values of these unused arguments.
> But Jann Horn pointed out the new convention is to enforce the 0 values
> so I followed ...

Hmmm, I wasn't aware of this convention when I added PR_SVE_SET_VL etc.,
and there is no clear pattern in sys.c, and nobody commented at the
time.

Of course, it works either way.

Cheers
---Dave
