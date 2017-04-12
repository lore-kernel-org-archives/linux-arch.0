From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH v2 0/6] Signal frame expansion support
Date: Wed, 12 Apr 2017 17:56:53 +0100
Message-ID: <1492016239-19511-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47076 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752299AbdDLQ5h (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Apr 2017 12:57:37 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>

(Note: This is an arm64-specific series, but the concepts introduced may
be of interest to other arches -- see in particular patch 6.)

Blurb:

An architecture advertises the maximum possible signal frame size via
the MINSIGSTKSZ #define (mandated by POSIX).

However, CPU architecture extensions may increase the amount of space
required to store the interrupted context when a signal is delivered.


Eventually the amount of space needed in the signal frame may exceed
MINSIGSTKSZ -- whether and when this happens is largely a matter of
luck, depending on the initial guess for MINSIGSTKSZ and the evolution
of that particular CPU architecture.  Unfortunately MINSIGSTKSZ cannot
be changed without an ABI break, and POSIX provides no mechanism for
migration.

arm64 initially reserved 4KB of space in the signal frame for
extensions, of which about 0.5KB is allocated to the FP/SIMD registers
initially.

Depending on the vector length supported by the hardware, SVE requires
up to around 8KB of space to store the full SIMD register context, which
is too large to fit in the existing frame.

This series adds a mechanism for optionally enlarging the signal frame
(patches 4-5) and reporting the actual maximum signal frame size to
userspace (patch 6).  Patches 1-3 do some refactoring to support this
change by abstracting the way signal frame records are allocated onto
the user stack.

Full backwards compatibility is not possible -- there is no way to hide
the fact that the signal frame has grown -- so it is expected that
support for new architecture extensions that can cause the signal frame
to grow will be opt-in for userspace, in addition to using the extension
mechanism defined by this series.

[1] ARM Scalable Vector Extension
https://community.arm.com/groups/processors/blog/2016/08/22/technology-update-the-scalable-vector-extension-sve-for-the-armv8-a-architecture
https://developer.arm.com/docs/ddi0584/latest/arm-architecture-reference-manual-supplement-the-scalable-vector-extension-sve-for-armv8-a

Dave Martin (6):
  arm64: signal: Refactor sigcontext parsing in rt_sigreturn
  arm64: signal: factor frame layout and population into separate passes
  arm64: signal: factor out signal frame record allocation
  arm64: signal: Allocate extra sigcontext space as needed
  arm64: signal: Parse extra_context during sigreturn
  arm64: signal: Report signal frame size to userspace via auxv

 arch/arm64/include/asm/elf.h             |   5 +
 arch/arm64/include/asm/processor.h       |   3 +
 arch/arm64/include/uapi/asm/auxvec.h     |   3 +-
 arch/arm64/include/uapi/asm/sigcontext.h |  50 ++++
 arch/arm64/kernel/signal.c               | 389 ++++++++++++++++++++++++++++---
 5 files changed, 415 insertions(+), 35 deletions(-)

-- 
2.1.4
