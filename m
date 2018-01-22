Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58174 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751004AbeAVMXh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Jan 2018 07:23:37 -0500
From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 0/2] arm64: Fix invalid si_codes for fault signals
Date: Mon, 22 Jan 2018 12:23:16 +0000
Message-ID: <1516623798-25001-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, linux-api@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Russell King <linux@armlinux.org.uk>
Message-ID: <20180122122316.Jag2AkFms-eoDvLam7OGOp3CNe4OhO3bHdIL6wCMEzo@z>

As reported by Eric Biederman, [1], [2], [3] etc., several architectures
are inappropriately setting si_code to 0 when signaling faults to
userspace, which will interpret this value as SI_USER leading to garbage
being read out of siginfo fields that the kernel doesn't initialise.

This seems not to be a huge problem in practice, since many affected
faults should only happen if the kernel or hardware is buggy or broken.
However, there are some cases that don't fall under this.

This RFC series proposes fixes to eliminate these si_code == 0 cases
from arm64.  Some of the changes may be controversial.

There are two main headlines here, which may be applicable to other
architectures:

 * addition of a new code FPE_UNKNOWN for undiagnosable floating-point
   exception traps;

 * delivering SIGKILL instead of SIGSEGV/BUS/TRAP etc. for "impossible"
   exceptions that are not feasible to recover from and likely indicate
   a kernel or system bug or failure.

In particular there is likely to be a fair amount of overlap between arm
and arm64 here, but due to the longer history and evolution of the arm
tree and 32-bit architecture I'm less confident in making correct
judgements for that case.  This series doesn't touch arm, for now.

This series has been build-tested only.

[1] [PATCH 00/11] siginfo fixes/cleanups esp SI_USER
https://marc.info/?l=linux-kernel&m=151571871109016&w=2

[2] [PATCH 08/11] signal/arm: Document conflicts with SI_USER and SIGFPE
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-January/553574.html

[3] [PATCH 07/11] signal/arm64: Document conflicts with SI_USER and SIGFPE, SIGTRAP, SIGBUS
lists.infradead.org/pipermail/linux-arm-kernel/2018-January/553573.html

Dave Martin (2):
  arm64: fpsimd: Fix bad si_code for undiagnosed SIGFPE
  arm64: signal: Ensure si_code is valid for all fault signals

 arch/arm64/include/asm/esr.h       |   9 +++
 arch/arm64/kernel/fpsimd.c         |  31 +++++-----
 arch/arm64/mm/fault.c              | 114 ++++++++++++++++++-------------------
 include/uapi/asm-generic/siginfo.h |   3 +-
 4 files changed, 85 insertions(+), 72 deletions(-)

-- 
2.1.4
