Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33721 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfG2Hwy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jul 2019 03:52:54 -0400
From: lantianyu1986@gmail.com
Subject: [PATCH 0/2] clocksource/Hyper-V: Add Hyper-V specific sched clock function
Date: Mon, 29 Jul 2019 15:52:41 +0800
Message-ID: <20190729075243.22745-1-Tianyu.Lan@microsoft.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org, daniel.lezcano@linaro.org, arnd@arndb.de, michael.h.kelley@microsoft.comashal@kernel.org
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>, linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190729075241.0E3I8AiPz07-mB5MIbUHlgeTMf23IGJKwYhGvydRmic@z>

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Hyper-V guests use the default native_sched_clock() in pv_ops.time.sched_clock
on x86.  But native_sched_clock() directly uses the raw TSC value, which
can be discontinuous in a Hyper-V VM.   Add the generic hv_setup_sched_clock()
to set the sched clock function appropriately.  On x86, this sets
pv_ops.time.sched_clock to read the Hyper-V reference TSC value that is
scaled and adjusted to be continuous.

Also move the Hyper-V reference TSC initialization much earlier in the boot
process so no discontinuity is observed when pv_ops.time.sched_clock
calculates its offset.  This earlier initialization requires that the Hyper-V TSC
page be allocated statically instead of with vmalloc(), so fixup the references
to the TSC page and the method of getting its physical address.

Tianyu Lan (2):
  clocksource/Hyper-v: Allocate Hyper-V tsc page statically
  clocksource/Hyper-V: Add Hyper-V specific sched clock function

 arch/x86/entry/vdso/vma.c          |  2 +-
 arch/x86/hyperv/hv_init.c          |  2 --
 arch/x86/kernel/cpu/mshyperv.c     |  8 ++++++++
 drivers/clocksource/hyperv_timer.c | 34 ++++++++++++++++------------------
 include/asm-generic/mshyperv.h     |  1 +
 5 files changed, 26 insertions(+), 21 deletions(-)

-- 
2.14.5
