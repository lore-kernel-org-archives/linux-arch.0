Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:43180 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750920AbdALL1y (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Jan 2017 06:27:54 -0500
From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 00/10] arm64/sve: Add userspace vector length control API
Date: Thu, 12 Jan 2017 11:25:59 +0000
Message-ID: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Alan Hayward <alan.hayward@arm.com>, Christoffer Dall <christoffer.dall@linaro.org>, linux-arch@vger.kernel.org, libc-alpha@sourceware.org, Florian Weimer <fweimer@redhat.com>, Joseph Myers <joseph@codesourcery.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Torvald Riegel <triegel@redhat.com>, gdb@sourceware.org, Yao Qi <qiyaoltc@gmail.com>
Message-ID: <20170112112559.tBY3snQL12lGtS0o78AuGB2V6PX7pe1KVKqPYEhoY84@z>

This is an add-on series for the Scalable Vector Extension (SVE) core
patches [1], adding an interface to allow userspace tasks to control
what vector length they use for SVE instructions.

(For an architectural overview of SVE, and an explanation of what a
"vector length" is, see [2].)

The amount of SVE register state depends on the vector length, so using
large vector lengths with SVE can requre the userspace signal frame to
grow.  This leads to some ABI impacts in common with other arches that
may have to grow their signal frame.


In this series I do not dictate any particular policy for the SVE vector
length: the kernel provides a default, but userspace can set the vector
length as it likes, provided the hardware supports the chosen length.

For example, userspace may pick a length that the images being loaded
have been validated against or optimised for.


Overview
========

The API proposed here consists of prctl() calls to allow a task to
set/query its vector length and related control flags, and corresponding
ptrace extensions to allow a debugger to do the same for a traced task:

prctl():
 * PR_SVE_SET_VL
 * PR_SVE_GET_VL

ptrace() NT_ARM_SVE regset:
 * user_sve_header.flags & SVE_PT_VL_*
 * user_sve_header.vl

(I follow the existing convention of not including the arch name in
prctl names).

The context switch logic is also extended to set the correct vector
length when scheduling a task in, since the vector length may now differ
between tasks.


The expected users of this API are libc startup, dynamic linker and
runtime environment plumbing code.  I don't expect ordinary user code to
change its own vector length on-the-fly, partly because it is generally
The Wrong Thing To Do with respect to the SVE programming model, and
partly because of ABI subtleties which make it difficult to do this
correctly.


ABI Impact
==========

The current arm64 signal frame size is not sufficient to save all SVE
state for larger vector lengths.

This won't affect existing binary distros, since the signal frame is not
extended unless some SVE instructions are executed by the user task.

However, non-SVE code executing in the same processes as SVE-aware code
may start to see the kernel using more than MINSIGSTKSZ bytes of stack
to deliver a signal, which may lead to stack overruns.  Other ABI
breakages are also possible if we were to simply increase the
MINSIGSTKSZ #define.  SVE aware code will need to move to a new
mechanism to discover the signal frame size: perhaps a new prctl() (not
implemented in this series).

As a temporary workaround, I added a Kconfig option in [1] to clamp the
vector length to a safe maximum that hides this effect, but this was
only intended as a short-term kludge.

This series removes the Kconfig kludge and introduces a new runtime
mechanism:

# echo <vector length in bytes> >/proc/cpu/sve_default_vector_length

will now set the default vector length for newly-exec'd processes.  This
is initialised to the ABI-safe value 512 at boot (or the maximum value
supported by the hardware, if smaller).  Administrators / distro
maintainers / developers can set this to something different in boot
scripts if they are comfortable doing so, or to see what happens.

We _could_ increase the kernel default in the future when and if we are
satisfied that the change is sufficiently low-impact.


User tasks can always override the default via prctl(): the logic is
that non-SVE-aware code doesn't know how to change the vector length,
and so won't do that anyway.  SVE-aware code is presumed to understand
the consequences.

The vector length can be made inheritable (allowing implementation of
taskset-like tools, or running a testsuite with a particular vector
length) or not (for general-purpose processes; in which case the vector
length is reset to the default across exec).


[1] arm64: Scalable Vector Extension core support
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-November/470507.html

[2] Technology Update: The Scalable Vector Extension (SVE) for the ARMv8-A architecture
https://www.community.arm.com/processors/b/blog/posts/technology-update-the-scalable-vector-extension-sve-for-the-armv8-a-architecture

Note: The size of an SVE vector register (the "vector length") is
choosable per hardware implementation, and the ISA allows software to be
coded independently of the actual vector length in use.  The vector
length can also be selected explicitly by software within the limits
supported by the hardware -- this is expected to be useful in some
situations.  This series exposes this control to userspace.


Dave Martin (10):
  prctl: Add skeleton for PR_SVE_{SET,GET}_VL controls
  arm64/sve: Track vector length for each task
  arm64/sve: Set CPU vector length to match current task
  arm64/sve: Factor out clearing of tasks' SVE regs
  arm64/sve: Wire up vector length control prctl() calls
  arm64/sve: Disallow VL setting for individual threads by default
  arm64/sve: Add vector length inheritance control
  arm64/sve: ptrace: Wire up vector length control and reporting
  arm64/sve: Enable default vector length control via procfs
  Revert "arm64/sve: Limit vector length to 512 bits by default"

 arch/arm64/Kconfig                    |  35 ----
 arch/arm64/include/asm/fpsimd.h       |  25 ++-
 arch/arm64/include/asm/fpsimdmacros.h |   7 +-
 arch/arm64/include/asm/processor.h    |  12 ++
 arch/arm64/include/uapi/asm/ptrace.h  |   5 +
 arch/arm64/kernel/entry-fpsimd.S      |   2 +-
 arch/arm64/kernel/fpsimd.c            | 334 +++++++++++++++++++++++++++++++---
 arch/arm64/kernel/ptrace.c            |  27 +--
 arch/arm64/kernel/signal.c            |  15 +-
 arch/arm64/mm/proc.S                  |   5 -
 include/uapi/linux/prctl.h            |  10 +
 kernel/sys.c                          |  12 ++
 12 files changed, 407 insertions(+), 82 deletions(-)

-- 
2.1.4

