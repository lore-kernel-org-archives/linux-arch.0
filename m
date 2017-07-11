From: Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 0/2] Fatal signal handing within uaccess faults
Date: Tue, 11 Jul 2017 15:19:21 +0100
Message-ID: <1499782763-31418-1-git-send-email-mark.rutland@arm.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: catalin.marinas@arm.com, james.morse@arm.com, labbott@redhat.com, linux@armlinux.org.uk, mark.rutland@arm.com, stable@vger.kernel.org, steve.capper@arm.com, will.deacon@arm.com, viro@zeniv.linux.org.uk, peterz@infradead.org, luto@amacapital.net
List-Id: linux-arch.vger.kernel.org

[resending with LAKML's address corrected]

Hi,

Arch maintainer tl;dr: most arch fault code doesn't handle fatal signals
correctly, allowing unprivileged users to create an unkillable task which can
lock up the system. Please check whether your arch is affected.

AFAICT, most arches don't correctly handle a fatal signal interrupting a
uaccess fault. They attempt to bail out, returning to the faulting context
without bothering to handle the fault, but forget to apply the uaccess fixup.
Consequently, the uaccess gets replayed, and the same thing happens forver.

When this occurs, the relevant task never returns to userspace, never handles
the fatal signal, and is stuck in an unkillable (though interruptible and
preemptible) state. The task can inhibit forward progress of the rest of the
system, leading to RCU stalls and lockups.

It's possible for an unprivileged user to trigger this deliberately using the
userfaultfd syscall, as demonstrated by the test case at the end of this email
(note: requires CONFIG_USERFAULTFD to be selected). I am not sure if this is
the only way of triggering the issue.

I stumbled upon this while fuzzing arm64 with Syzkaller. I've verified that
both arm and arm64 have the issue, and by inspection is seems that the majority
of other architectures are affected.

It looks like this was fixed up for x86 in 2014 with commit:

  26178ec11ef3c6c8 ("x86: mm: consolidate VM_FAULT_RETRY handling")

... but most other architectures never received a similar fixup.

The duplication (and divergence) of this logic is unfortunate. It's largely
copy-paste code that could be consolidated under mm/.

Until we end up refactoring this, and so as to be sutiable for backporting,
this series fixes arm and arm64 in-place. I've not touched other architectures
as I don't have the relevant hardwre or arch knowledge.

Thanks,
Mark.

----
#include <errno.h>
#include <linux/userfaultfd.h>
#include <stdio.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/syscall.h>
#include <sys/vfs.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
	void *mem;
	long pagesz;
	int uffd, ret;
	struct uffdio_api api = {
		.api = UFFD_API
	};
	struct uffdio_register reg;
       
	pagesz = sysconf(_SC_PAGESIZE);
	if (pagesz < 0) {
		return errno;
	}

	mem = mmap(NULL, pagesz, PROT_READ | PROT_WRITE,
		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
	if (mem == MAP_FAILED)
		return errno;

	uffd = syscall(__NR_userfaultfd, 0);
	if (uffd < 0)
		return errno;

	ret = ioctl(uffd, UFFDIO_API, &api);
	if (ret < 0)
		return errno;

	reg = (struct uffdio_register) {
		.range = {
			.start = (unsigned long)mem,
			.len = pagesz
		},
		.mode = UFFDIO_REGISTER_MODE_MISSING
	};

	ret = ioctl(uffd, UFFDIO_REGISTER, &reg);
	if (ret < 0)
		return errno;

	/*
	 * Force an arbitrary uaccess to memory monitored by the userfaultfd.
	 * This will block, but when a SIGKILL is sent, will consume all
	 * available CPU time without being killed, and may inhibit forward
	 * progress of the system.
	 */
	ret = fstatfs(0, (struct statfs *)mem);

	return 0;
}
----

Mark Rutland (2):
  arm64: mm: abort uaccess retries upon fatal signal
  arm: mm: abort uaccess retries upon fatal signal

 arch/arm/mm/fault.c   | 5 ++++-
 arch/arm64/mm/fault.c | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

-- 
1.9.1
