Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:50437 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbeIXSLU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Sep 2018 14:11:20 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 24 Sep 2018 14:09:18 +0200
Message-ID: <87pnx32j2p.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [REVIEW][PATCH 0/4] signal/arm: siginfo cleanups
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@armlinux.org.uk>
Message-ID: <20180924120918.oXmJaafufC1U_dB_Uztas3wltNZsfVwweESxUk8GiBE@z>


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
