From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] tile: support GENERIC_KERNEL_THREAD and
 GENERIC_KERNEL_EXECVE
Date: Tue, 23 Oct 2012 19:41:22 +0100
Message-ID: <20121023184122.GZ2616@ZenIV.linux.org.uk>
References: <20121016223508.GR2616@ZenIV.linux.org.uk>
 <201210192041.q9JKf7jD003998@farm-0010.internal.tilera.com>
 <20121019213548.GR2616@ZenIV.linux.org.uk>
 <5082A1F1.3080303@tilera.com>
 <20121020153401.GT2616@ZenIV.linux.org.uk>
 <20121020171643.GU2616@ZenIV.linux.org.uk>
 <5086D432.4070008@tilera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:59778 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756708Ab2JWSlY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 23 Oct 2012 14:41:24 -0400
Content-Disposition: inline
In-Reply-To: <5086D432.4070008@tilera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@tilera.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>

On Tue, Oct 23, 2012 at 01:30:26PM -0400, Chris Metcalf wrote:

> I fetched the series from your arch-tile branch and built it, and it works
> fine.  It looks good from my inspection:
> 
> Acked-by: Chris Metcalf <cmetcalf@tilera.com>

Thanks; Acked-by applied, branch pushed and put into no-rebase mode.

BTW, something like detached Acked-by objects might be a good idea - i.e.
commit-like git object with amendment to commit message of a given ancestor.
The situation when ACKs come only after the commit has been pushed is quite
common.  Linus, what do you think about usefulness of such thing?  Ability
to append ACKed-by/Tested-by of an earlier commit to a branch instead of
git commit --amend + possibly some cherry-picks + force-push, that is.

> As you had suggested in an earlier email, I went ahead and eliminated the
> special pt_regs handling for sigaltstack, rt_sigreturn, and clone.  (Also a
> tilepro-specific syscall that was also using PTREG_SYSCALL.)  I'll send it
> separately and you can include it in your tree if you like.

OK by me...  Or just pull this arch-tile into a separate branch in your
tree, add commit on top of it and I'll pull that.

AFAICS, the current state is:
avr32                   untested
blackfin                untested
cris                    untested
frv                     untested, maintainer going to test
h8300                   untested
hexagon                 maintainer hunting the breakage down
m32r                    untested
microblaze              maintainer hunting the breakage down
mn10300                 untested
powerpc                 should work, needs testing and ACK
s390                    should work, needs testing and ACK
score                   untested
sh                      untested, maintainers planned reviewing and testing
xtensa                  maintainers writing that one
everything else		done

so we are more than halfway through on that one...  FWIW, here's what I want
to do next in that area:
	* consider taking the "if (!usp) usp = <parent's usp>" logics from
clone(2) to copy_thread().  Note that it allows to have fork and vfork
(where implemented) simply pass 0.  Per-architecture change, independent for
different architectures.
	* do generic sys_fork() and sys_vfork() variants, have the
architectures that want to use them do so.
	* consider making regs argument of copy_thread() unused.  The thing
is, we can tell whether we have userland process or kernel thread being
spawned just by looking at p->flags & PF_KTHREAD.  And on the "userland
process" side of things, it's often just as cheap (or cheaper) to use
current_pt_regs() instead of using the argument, especially on architectures
where 6-argument functions get the last args passed on stack.  Again,
independent for different architectures.
	* kill pt_regs argument of do_execve/compat_do_execve/do_execve_common/
search_binary_handler/->load_binary.  Depends on having everything switched
to generic kernel_execve/sys_execve; local to fs/* and on the last step
a couple of binfmt instances in arch (alpha ecoff, ia32 aout)
	* kill ifdefs by CONFIG_GENERIC_KERNEL_{THREAD,EXECVE} once everything
has those always true.
	* kill pt_regs argument of copy_thread() if all architectures can live
with that.  Same for copy_process() and do_fork().  A flagday change, obviously.
	* kill idle_regs() - it'll be unused by that point.
