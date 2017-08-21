From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/2] arm64: mm: abort uaccess retries upon fatal signal
Date: Mon, 21 Aug 2017 14:42:03 +0100
Message-ID: <20170821134202.GA5418@leverpostej>
References: <1499782763-31418-1-git-send-email-mark.rutland@arm.com>
 <1499782763-31418-2-git-send-email-mark.rutland@arm.com>
 <20170711145849.GE13977@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170711145849.GE13977@arm.com>
Sender: stable-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, catalin.marinas@arm.com, james.morse@arm.com, labbott@redhat.com, linux@armlinux.org.uk, stable@vger.kernel.org, steve.capper@arm.com, viro@zeniv.linux.org.uk, peterz@infradead.org, luto@amacapital.net
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 11, 2017 at 03:58:49PM +0100, Will Deacon wrote:
> On Tue, Jul 11, 2017 at 03:19:22PM +0100, Mark Rutland wrote:
> > When there's a fatal signal pending, arm64's do_page_fault()
> > implementation returns 0. The intent is that we'll return to the
> > faulting userspace instruction, delivering the signal on the way.
> > 
> > However, if we take a fatal signal during fixing up a uaccess, this
> > results in a return to the faulting kernel instruction, which will be
> > instantly retried, resulting in the same fault being taken forever. As
> > the task never reaches userspace, the signal is not delivered, and the
> > task is left unkillable. While the task is stuck in this state, it can
> > inhibit the forward progress of the system.
> > 
> > To avoid this, we must ensure that when a fatal signal is pending, we
> > apply any necessary fixup for a faulting kernel instruction. Thus we
> > will return to an error path, and it is up to that code to make forward
> > progress towards delivering the fatal signal.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Reviewed-by: Steve Capper <steve.capper@arm.com>
> > Tested-by: Steve Capper <steve.capper@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: James Morse <james.morse@arm.com>
> > Cc: Laura Abbott <labbott@redhat.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  arch/arm64/mm/fault.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > index 37b95df..3952d5e 100644
> > --- a/arch/arm64/mm/fault.c
> > +++ b/arch/arm64/mm/fault.c
> > @@ -397,8 +397,11 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
> >  	 * signal first. We do not need to release the mmap_sem because it
> >  	 * would already be released in __lock_page_or_retry in mm/filemap.c.
> >  	 */
> > -	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current))
> > +	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current)) {
> > +		if (!user_mode(regs))
> > +			goto no_context;
> >  		return 0;
> > +	}
> 
> This will need rebasing at -rc1 (take a look at current HEAD).
> 
> Also, I think it introduces a weird corner case where we take a page fault
> when writing the signal frame to the user stack to deliver a SIGSEGV. If
> we end up with VM_FAULT_RETRY and somebody has sent a SIGKILL to the task,
> then we'll fail setup_sigframe and force an un-handleable SIGSEGV instead
> of SIGKILL.
> 
> The end result (task is killed) is the same, but the fatal signal is wrong.

That doesn't seem to be the case, testing on v4.13-rc5.

I used sigaltstack() to use the userfaultfd region as signal stack,
registerd a SIGSEGV handler, and dereferenced NULL. The task locks up,
but when killed with a SIGINT or SIGKILL, the exit status reflects that
signal, rather than the SIGSEGV.

If I move the SIGINT handler onto the userfaultfd-monitored stack, then
delivering SIGINT hangs, but can be killed with SIGKILL, and the exit
status reflects that SIGKILL.

As you say, it does look like we'd try to set up a deferred SIGSEGV for
the failed signal delivery.

I haven't yet figured out exactly how that works; I'll keep digging.

Thanks,
Mark.
