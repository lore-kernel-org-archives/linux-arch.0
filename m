From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH 0/5] arm64: signal: Signal frame expansion support
Date: Thu, 15 Jun 2017 15:03:37 +0100
Message-ID: <1497535442-11586-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751016AbdFOOEX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Jun 2017 10:04:23 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>

This series supersedes a prior RFC [1].

This series refactors the arm64 signal handling implementation in order
to make it easier to add support for new CPU architecture extensions,
which may require new records in the signal frame and may require the
signal frame to grow beyond its current size.

This series provides infrastructure that will be needed in order to
support the Scalable Vector Extension (SVE) [2] (patches to be posted
separately).

LTP testing is ongoing -- I will ping this series when I have results.


Changes since RFC v2:

 * The frame link record has been moved back to the end of the full
   signal frame, instead of fixing its position at the end of
   __reserved[], after Catalin raised concerns about the space otherwise
   wasted by putting the extended signal frame data after it.

   Previous versions of the series had this behaviour, but concerns were
   expressed by reviewers about the potential ABI impact.

   This change has been informally tested for ABI impacts using the
   libgcc unwinder (exercised by throwing exceptions from a signal
   handler with g++ -fnon-call-exceptions) and gdb backtracing, neither
   of which showed any problem.  Review of the libgcc and libunwind
   implementations and discussion with gdb developers suggest that no
   breakage is expected as a result of the change.

   (See patch 1 of this posting.)

 * Patches 4 (Allocate extra sigcontext space as needed) and 5 (Parse
   extra_context during sigreturn) of RFC v2 have been merged, since
   they are not fully bisectable and make more sense as a single patch.

 * Patch 6 (Report signal frame size to userspace via auxv) of RFC v2
   has been dropped from the series, because this creates ABI that we
   don't need yet, and can benefit from further discussion.  This patch
   will become relevant when merging support for SVE.

 * struct extra_context is explicitly padded up to a multiple of 16 bytes.
   This fixes a bug whereby a non-extra_context-aware unwinder would
   skip the wrong amount of data after extra_context and miss the
   terminator record.

   There is a de facto assumption that unwinders do not need to round
   _aarch64_ctx.size up to a multiple of 16 when stepping through the
   records in the signal frame, though this isn't documented anywhere.


Original blurb:

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


[1] [RFC PATCH v2 0/6] Signal frame expansion support
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-April/501163.html

[2] ARM Scalable Vector Extension
https://community.arm.com/groups/processors/blog/2016/08/22/technology-update-the-scalable-vector-extension-sve-for-the-armv8-a-architecture
https://developer.arm.com/docs/ddi0584/latest/arm-architecture-reference-manual-supplement-the-scalable-vector-extension-sve-for-armv8-a


Dave Martin (5):
  arm64: signal: split frame link record from sigcontext structure
  arm64: signal: Refactor sigcontext parsing in rt_sigreturn
  arm64: signal: factor frame layout and population into separate passes
  arm64: signal: factor out signal frame record allocation
  arm64: signal: Allow expansion of the signal frame

 arch/arm64/include/uapi/asm/sigcontext.h |  55 +++++
 arch/arm64/kernel/signal.c               | 408 ++++++++++++++++++++++++++++---
 2 files changed, 427 insertions(+), 36 deletions(-)

-- 
2.1.4
