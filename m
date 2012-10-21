From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: new execve/kernel_thread design
Date: Sun, 21 Oct 2012 11:35:25 +0100
Message-ID: <1350815725.2449.1.camel@dabdike.int.hansenpartnership.com>
References: <20121019155554.GL2616@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:34427 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752273Ab2JUKfb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 21 Oct 2012 06:35:31 -0400
In-Reply-To: <20121019155554.GL2616@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-arch@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>

On Fri, 2012-10-19 at 16:55 +0100, Al Viro wrote:
> [Sorry; forgot about that typo in Cc...  Repost to linux-arch alone]
> 
> On Tue, Oct 16, 2012 at 11:35:08PM +0100, Al Viro wrote:
> > 	1.  Basic rules for process lifetime.
> > Except for the initial process (init_task, eventual idle thread on the boot
> > CPU) all processes are created by do_fork().  There are three classes of
> > those: kernel threads, userland processes and idle threads to be.  There are
> > few low-level operations involved:
> > 	* a kernel thread can spawn a new kernel thread; the primitive
> > doing that is kernel_thread().
> > 	* a userland process can spawn a new userland process; that's
> > done by sys_fork()/sys_vfork()/sys_clone()/sys_clone2().
> > 	* a kernel thread can become a userland process.  The primitive
> > is kernel_execve().
> > 	* a kernel thread can spawn a future idle thread; that's done
> > by fork_idle().  Result is *not* scheduled until the secondary CPU gets
> > initialized and its state is heavily overwritten in process.
> 
> Minor correction: while the first two cases go through do_fork() to
> copy_process() to copy_thread(), fork_idle() calls copy_process() directly.
> 
> > 	4. What is done?
> > I've done the conversions for almost all architectures, but quite a few
> > are completely untested.
> > 
> > I'm fairly sure about alpha, x86 and um.  Tested and I understand the
> > architecture well enough.  arm, mips and c6x had been tested by architecture
> > maintainers.  This stuff also works.  alpha, arm, x86 and um are fully
> > converted in mainline by now.
> 
> arm64 fixed and tested by maintainer, put in no-rebase mode.
> 
> sparc corrected to avoid branching beyond what ba,pt allows, ACKed by Davem
> in that form.  In no-rebase mode.
> 
> m68k tested and ACKed on coldfire; I think that along with aranym testing
> here that is enough.  In no-rebase mode.
> 
> Surprisingly enough, ia64 one seems to work on actual hardware; I have sent
> Tony an incremental patch cleaning copy_thread() up, waiting for results of
> testing that on SMP box.
> 
> Even more surprisingly, unicore32 variant turned out to contain only one
> obvious typo.  Fixed and tested by maintainer of unicore32 tree and actually
> applied there, I've pulled his branch at that point.
> 
> microblaze: some fixes from Michal folded, still breakage with kernel_execve()
> side of things.
> 
> Since there had been no signs of life from hexagon folks, I'd done (absolutely
> blind and untested) tentative patches; see #arch-hexagon.  Same situation
> as with most of the embedded architectures - i.e. take with a cartload of salt,
> that pair of patches is intended to be a possible starting point for producing
> something working.
> 
> At that point we have the following situation:
> alpha                   done
> arm                     done
> arm64                   done
> avr32                   untested
> blackfin                untested
> c6x                     done
> cris                    untested
> frv                     untested, maintainer going to test
> h8300                   untested
> hexagon                 untested
> ia64                    apparently works, needs the final ACK from Tony.
> m32r                    untested
> m68k                    done
> microblaze              partially tested, maintainer hunting breakage down
> mips                    done
> mn10300                 untested
> openrisc                maintainers said to have partially working variant
> parisc                  should work, needs testing and ACK

Tested and works on top of 3.7-rc2 ... you can add my ACK.

James


> powerpc                 should work, needs testing and ACK
> s390                    should work, needs testing and ACK
> score                   untested
> sh                      untested, maintainers planned reviewing and
> testing
> sparc                   done
> tile                    maintainers writing that one
> um                      done
> unicore32               done
> x86                     done
> xtensa                  maintainers writing that one
> 
> One more thing: AFAICS, just about everything has something along the
> lines
> of
>         if (!usp)
>                 usp = <current userland sp>
>         do_fork(flags, usp, ....)
> in their sys_clone().  How about taking that into copy_thread()?
> After
> all, the logics there is
>         copy all the state, including userland stack pointer to child
>         override userland stack pointer with what the caller passed to
> copy_thread()
> often enough with "... and if we are about to override it with
> something
> different, do the following extra work".  Turning that into
>         copy all the state, including userland stack pointer to child
>         if (usp) {
>                 override the userland stack pointer for child and
> maybe do
>                 some extra work
>         }
> would seem to be a fairly natural thing.  Does anybody see problems
> with
> doing that on their architecture?  Note that with that fork() becomes
> simply
> #ifndef CONFIG_MMU
>         return -EINVAL;
> #else
>         return do_fork(SIGCHLD, 0, current_pt_regs(), 0, NULL, NULL);
> #endif
> and similar for vfork().  And these can definitely drop the
> Cthulhu-awful
> kludges for obtaining pt_regs (OK, on everything that doesn't do
> kernel_thread() via syscall-from-kernel, but by now only xtensa is
> still
> doing that).  In some cases we need to do a bit of work before that
> (gather callee-saved registers so that the child could get them as on
> alpha,
> mips, m68k, openrisc, parisc, ppc and x86, flush userland register
> windows
> on sparc and get psr/wim values on sparc32), but a lot more
> architectures
> lose the asm wrappers for those and the rest can get rid of assorted
> ugliness involved in getting that struct pt_regs *.
> 
> BTW, alpha seems to be doing an absolutely pointless work on the way
> out of
> sys_fork() et.al. - saving callee-saved registers is needed, all
> right,
> but why bother restoring all of them on the way out in the parent?
> All
> we need is rp; that's ~0.3Kb of useless reads from memory on each
> fork()...
> 
> The same goes for m68k; there the amount of traffic is less, but
> still, what
> the hell for?  Child needs callee-saved registers restored (and
> usually will
> have that done by switch_to()), but the parent needs only to make sure
> they
> are saved and available for copy_thread() to bring them to child
> (incidentally,
> copying registers is needed only when they are not embedded into
> task_struct.
> At least um is doing a memcpy() for no reason whatsoever; fix will be
> sent
> to rw shortly and ISTR seeing something similar on some of the other
> architectures).
> 
> Another cross-architecture thing: folks, watch out for what's being
> done with
> thread flags; I've just found a lovely bug on alpha where we have
> prctl(2)
> doing non-atomic modifications of those (as in ti->flags =
> (ti->flags&~x)|y;),
> which is obviously broken; TIF_SIGPENDING can be set asynchronously
> and even
> from an interrupt.  Fix for this one is going to Linus shortly (adding
> a separate field for thread-synchronous flags, taking obviously t-s
> ones
> there, including the UAC_... bunch set by that prctl()), but I don't
> think
> that I can audit that for all architectures efficiently; cursory look
> has
> found a braino on frv (fix being discussed with dhowells), but there
> may bloody
> well be more of that fun.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
