From: Rabin Vincent <rabin@rab.in>
Subject: Re: [PATCH 1/2] arm64: mm: abort uaccess retries upon fatal signal
Date: Tue, 14 Nov 2017 07:46:25 +0100
Message-ID: <20171114064556.GA18291@lnxartpec.se.axis.com>
References: <1499782763-31418-1-git-send-email-mark.rutland@arm.com>
 <1499782763-31418-2-git-send-email-mark.rutland@arm.com>
 <20170711145849.GE13977@arm.com>
 <20170821134202.GA5418@leverpostej>
 <20170822094523.GA5439@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:51075 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbdKNGqe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Nov 2017 01:46:34 -0500
Content-Disposition: inline
In-Reply-To: <20170822094523.GA5439@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, catalin.marinas@arm.com, james.morse@arm.com, labbott@redhat.com, linux@armlinux.org.uk, stable@vger.kernel.org, steve.capper@arm.com, viro@zeniv.linux.org.uk, peterz@infradead.org, luto@amacapital.net

On Tue, Aug 22, 2017 at 10:45:24AM +0100, Will Deacon wrote:
> On Mon, Aug 21, 2017 at 02:42:03PM +0100, Mark Rutland wrote:
> > On Tue, Jul 11, 2017 at 03:58:49PM +0100, Will Deacon wrote:
> > > On Tue, Jul 11, 2017 at 03:19:22PM +0100, Mark Rutland wrote:
> > > > When there's a fatal signal pending, arm64's do_page_fault()
> > > > implementation returns 0. The intent is that we'll return to the
> > > > faulting userspace instruction, delivering the signal on the way.
> > > > 
> > > > However, if we take a fatal signal during fixing up a uaccess, this
> > > > results in a return to the faulting kernel instruction, which will be
> > > > instantly retried, resulting in the same fault being taken forever. As
> > > > the task never reaches userspace, the signal is not delivered, and the
> > > > task is left unkillable. While the task is stuck in this state, it can
> > > > inhibit the forward progress of the system.
> > > > 
> > > > To avoid this, we must ensure that when a fatal signal is pending, we
> > > > apply any necessary fixup for a faulting kernel instruction. Thus we
> > > > will return to an error path, and it is up to that code to make forward
> > > > progress towards delivering the fatal signal.
> > > > 
> > > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > > Reviewed-by: Steve Capper <steve.capper@arm.com>
> > > > Tested-by: Steve Capper <steve.capper@arm.com>
> > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > Cc: James Morse <james.morse@arm.com>
> > > > Cc: Laura Abbott <labbott@redhat.com>
> > > > Cc: Will Deacon <will.deacon@arm.com>
> > > > Cc: stable@vger.kernel.org
> > > > ---
> > > >  arch/arm64/mm/fault.c | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > > > index 37b95df..3952d5e 100644
> > > > --- a/arch/arm64/mm/fault.c
> > > > +++ b/arch/arm64/mm/fault.c
> > > > @@ -397,8 +397,11 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
> > > >  	 * signal first. We do not need to release the mmap_sem because it
> > > >  	 * would already be released in __lock_page_or_retry in mm/filemap.c.
> > > >  	 */
> > > > -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> > > > +	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current)) {
> > > > +		if (!user_mode(regs))
> > > > +			goto no_context;
> > > >  		return 0;
> > > > +	}
> > > 
> > > This will need rebasing at -rc1 (take a look at current HEAD).
> > > 
> > > Also, I think it introduces a weird corner case where we take a page fault
> > > when writing the signal frame to the user stack to deliver a SIGSEGV. If
> > > we end up with VM_FAULT_RETRY and somebody has sent a SIGKILL to the task,
> > > then we'll fail setup_sigframe and force an un-handleable SIGSEGV instead
> > > of SIGKILL.
> > > 
> > > The end result (task is killed) is the same, but the fatal signal is wrong.
> > 
> > That doesn't seem to be the case, testing on v4.13-rc5.
> > 
> > I used sigaltstack() to use the userfaultfd region as signal stack,
> > registerd a SIGSEGV handler, and dereferenced NULL. The task locks up,
> > but when killed with a SIGINT or SIGKILL, the exit status reflects that
> > signal, rather than the SIGSEGV.
> > 
> > If I move the SIGINT handler onto the userfaultfd-monitored stack, then
> > delivering SIGINT hangs, but can be killed with SIGKILL, and the exit
> > status reflects that SIGKILL.
> > 
> > As you say, it does look like we'd try to set up a deferred SIGSEGV for
> > the failed signal delivery.
> > 
> > I haven't yet figured out exactly how that works; I'll keep digging.
> 
> The SEGV makes it all the way into do_group_exit, but then signal_group_exit
> is set and the exit_code is overridden with SIGKILL at the last minute (see
> complete_signal).

Unfortunately, this last minute is too late for print-fatal-signals.
With print-fatal-signals enabled, this patch leads to misleading
"potentially unexpected fatal signal 11" warnings if a process is
SIGKILL'd at the right time.

I've seen it without userfaultfd, but it's easiest reproduced by
patching Mark's original test code [1] with the following patch and
simply running "pkill -WINCH foo; pkill -KILL foo".  This results in:

 foo: potentially unexpected fatal signal 11.
 CPU: 1 PID: 1793 Comm: foo Not tainted 4.9.58-devel #3
 task: b3534780 task.stack: b4b7c000
 PC is at 0x76effb60
 LR is at 0x4227f4
 pc : [<76effb60>]    lr : [<004227f4>]    psr: 600b0010
 sp : 7eaf7bb4  ip : 00000000  fp : 00000000
 r10: 00000001  r9 : 00000003  r8 : 76fcd000
 r7 : 0000001d  r6 : 76fd0cf0  r5 : 7eaf7c08  r4 : 00000000
 r3 : 00000000  r2 : 00000000  r1 : 7eaf7a88  r0 : fffffffc
 Flags: nZCv  IRQs on  FIQs on  Mode USER_32  ISA ARM  Segment user
 Control: 10c5387d  Table: 3357404a  DAC: 00000055
 CPU: 1 PID: 1793 Comm: foo Not tainted 4.9.58-devel #3
 [<801113f0>] (unwind_backtrace) from [<8010cfb0>] (show_stack+0x18/0x1c)
 [<8010cfb0>] (show_stack) from [<8039725c>] (dump_stack+0x84/0x98)
 [<8039725c>] (dump_stack) from [<8012f448>] (get_signal+0x384/0x684)
 [<8012f448>] (get_signal) from [<8010c2ec>] (do_signal+0xcc/0x470)
 [<8010c2ec>] (do_signal) from [<8010c868>] (do_work_pending+0xb8/0xc8)
 [<8010c868>] (do_work_pending) from [<801086d4>] (slow_work_pending+0xc/0x20)

This is ARM and I haven't tested ARM64, but the same problem even exists
on x86.

--- foo.c.orig	2017-11-13 23:45:47.802167284 +0100
+++ foo.c	2017-11-14 07:16:13.906363466 +0100
@@ -6,6 +6,11 @@
 #include <sys/syscall.h>
 #include <sys/vfs.h>
 #include <unistd.h>
+#include <signal.h>
+
+static void handler(int sig)
+{
+}
 
 int main(int argc, char *argv[])
 {
@@ -47,13 +52,17 @@
         if (ret < 0)
                 return errno;
 
+        sigaltstack(&(stack_t){.ss_sp = mem, .ss_size = pagesz}, NULL);
+        sigaction(SIGWINCH, &(struct sigaction){ .sa_handler = handler, .sa_flags = SA_ONSTACK, }, NULL);
+
         /*
          * Force an arbitrary uaccess to memory monitored by the userfaultfd.
          * This will block, but when a SIGKILL is sent, will consume all
          * available CPU time without being killed, and may inhibit forward
          * progress of the system.
          */
-        ret = fstatfs(0, (struct statfs *)mem);
+        // ret = fstatfs(0, (struct statfs *)mem);
+        pause();
 
         return 0;
 }

[1] https://lkml.kernel.org/r/1499782590-31366-1-git-send-email-mark.rutland@arm.com
