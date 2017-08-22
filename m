From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/2] Fatal signal handing within uaccess faults
Date: Tue, 22 Aug 2017 11:25:28 +0100
Message-ID: <20170822102527.GA14671@leverpostej>
References: <1499782590-31366-1-git-send-email-mark.rutland@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41500 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932352AbdHVK0p (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 22 Aug 2017 06:26:45 -0400
Content-Disposition: inline
In-Reply-To: <1499782590-31366-1-git-send-email-mark.rutland@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kerne@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: catalin.marinas@arm.com, james.morse@arm.com, labbott@redhat.com, linux@armlinux.org.uk, stable@vger.kernel.org, steve.capper@arm.com, will.deacon@arm.com, viro@zeniv.linux.org.uk, peterz@infradead.org, luto@amacapital.net

On Tue, Jul 11, 2017 at 03:16:28PM +0100, Mark Rutland wrote:
> Hi,
> 
> Arch maintainer tl;dr: most arch fault code doesn't handle fatal signals
> correctly, allowing unprivileged users to create an unkillable task which can
> lock up the system. Please check whether your arch is affected.

From a glance at v4.13-rc5, I believe this affects:

	alpha, cris, hexagon, ia64, m68k, metag, microblaze, mips,
	mn10300, nios2, openrisc, parisc, sparc (32-bit), tile,
	unicore32, xtensa

... I'm not sure about:

	arc, s390, sparc (64-bit)

... and I think that the following are ok:

	powerpc, sh, x86

Thanks,
Mark.

> AFAICT, most arches don't correctly handle a fatal signal interrupting a
> uaccess fault. They attempt to bail out, returning to the faulting context
> without bothering to handle the fault, but forget to apply the uaccess fixup.
> Consequently, the uaccess gets replayed, and the same thing happens forver.
> 
> When this occurs, the relevant task never returns to userspace, never handles
> the fatal signal, and is stuck in an unkillable (though interruptible and
> preemptible) state. The task can inhibit forward progress of the rest of the
> system, leading to RCU stalls and lockups.
> 
> It's possible for an unprivileged user to trigger this deliberately using the
> userfaultfd syscall, as demonstrated by the test case at the end of this email
> (note: requires CONFIG_USERFAULTFD to be selected). I am not sure if this is
> the only way of triggering the issue.
> 
> I stumbled upon this while fuzzing arm64 with Syzkaller. I've verified that
> both arm and arm64 have the issue, and by inspection is seems that the majority
> of other architectures are affected.
> 
> It looks like this was fixed up for x86 in 2014 with commit:
> 
>   26178ec11ef3c6c8 ("x86: mm: consolidate VM_FAULT_RETRY handling")
> 
> ... but most other architectures never received a similar fixup.
> 
> The duplication (and divergence) of this logic is unfortunate. It's largely
> copy-paste code that could be consolidated under mm/.
> 
> Until we end up refactoring this, and so as to be sutiable for backporting,
> this series fixes arm and arm64 in-place. I've not touched other architectures
> as I don't have the relevant hardwre or arch knowledge.
> 
> Thanks,
> Mark.
> 
> ----
> #include <errno.h>
> #include <linux/userfaultfd.h>
> #include <stdio.h>
> #include <sys/ioctl.h>
> #include <sys/mman.h>
> #include <sys/syscall.h>
> #include <sys/vfs.h>
> #include <unistd.h>
> 
> int main(int argc, char *argv[])
> {
> 	void *mem;
> 	long pagesz;
> 	int uffd, ret;
> 	struct uffdio_api api = {
> 		.api = UFFD_API
> 	};
> 	struct uffdio_register reg;
>        
> 	pagesz = sysconf(_SC_PAGESIZE);
> 	if (pagesz < 0) {
> 		return errno;
> 	}
> 
> 	mem = mmap(NULL, pagesz, PROT_READ | PROT_WRITE,
> 		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> 	if (mem == MAP_FAILED)
> 		return errno;
> 
> 	uffd = syscall(__NR_userfaultfd, 0);
> 	if (uffd < 0)
> 		return errno;
> 
> 	ret = ioctl(uffd, UFFDIO_API, &api);
> 	if (ret < 0)
> 		return errno;
> 
> 	reg = (struct uffdio_register) {
> 		.range = {
> 			.start = (unsigned long)mem,
> 			.len = pagesz
> 		},
> 		.mode = UFFDIO_REGISTER_MODE_MISSING
> 	};
> 
> 	ret = ioctl(uffd, UFFDIO_REGISTER, &reg);
> 	if (ret < 0)
> 		return errno;
> 
> 	/*
> 	 * Force an arbitrary uaccess to memory monitored by the userfaultfd.
> 	 * This will block, but when a SIGKILL is sent, will consume all
> 	 * available CPU time without being killed, and may inhibit forward
> 	 * progress of the system.
> 	 */
> 	ret = fstatfs(0, (struct statfs *)mem);
> 
> 	return 0;
> }
> ----
> 
> Mark Rutland (2):
>   arm64: mm: abort uaccess retries upon fatal signal
>   arm: mm: abort uaccess retries upon fatal signal
> 
>  arch/arm/mm/fault.c   | 5 ++++-
>  arch/arm64/mm/fault.c | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> -- 
> 1.9.1
> 
