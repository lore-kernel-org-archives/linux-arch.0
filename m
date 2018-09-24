From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [REVIEW][PATCH 0/4] signal/arm: siginfo cleanups
Date: Mon, 24 Sep 2018 14:09:18 +0200
Message-ID: <87pnx32j2p.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@armlinux.org.uk>
List-Id: linux-arch.vger.kernel.org


This is the latest and hopefully round of siginfo cleanups for arm.
This replaces the use of siginal sending functions that take siginfo
with siginfo sending functions that take the values that go in siginfo
and this is harder to get wrong, and frequently results in cleaner code.

I don't think I have made made any mistakes in this coversion but if
people can look the code over and see if they can spot anything I would
appreciate it.

Eric W. Biederman (4):
      signal/arm: Push siginfo generation into arm_notify_die
      signal/arm: Use force_sig_fault where appropriate
      signal/arm: Use send_sig_fault where appropriate
      signal/arm/kvm: Use send_sig_mceerr

 arch/arm/include/asm/bug.h    |  4 +--
 arch/arm/kernel/ptrace.c      | 11 ++------
 arch/arm/kernel/swp_emulate.c | 16 +++++------
 arch/arm/kernel/traps.c       | 63 ++++++++++++-------------------------------
 arch/arm/mm/alignment.c       | 10 +------
 arch/arm/mm/fault.c           | 28 ++++---------------
 arch/arm/vfp/vfpmodule.c      | 11 +++-----
 virt/kvm/arm/mmu.c            | 14 +++-------
 8 files changed, 41 insertions(+), 116 deletions(-)

Eric
