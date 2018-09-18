Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:59063 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729656AbeIRTVU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 Sep 2018 15:21:20 -0400
From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V7 0/2] bugfix based on csky linux-next
Date: Tue, 18 Sep 2018 21:48:12 +0800
Message-ID: <cover.1537276837.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, robh@kernel.org, sfr@canb.auug.org.au
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, green.hu@gmail.com, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20180918134812.NUDWfSxtdzCGtTIzXOSbeDrmPf9XJ8JTV5NIQLqPO-8@z>

Because I've sent to Stephen Roth with the linux-4.19-rc3 git-tree for
linux-next, I shouldn't rebase any more.

 - Fixup smp.c irq mapping problem found by Marc Zyngier
 - Fixup dma_sync_for_cpu/device in dma-mapping.c

Guo Ren (2):
  csky/dma: bugfix dma_sync_for_cpu/device
  csky: remove irq_mapping from smp.c.

 arch/csky/include/asm/smp.h |  4 ++++
 arch/csky/kernel/smp.c      | 18 +++++++++++++-----
 arch/csky/mm/dma-mapping.c  |  5 +++--
 3 files changed, 20 insertions(+), 7 deletions(-)

-- 
2.7.4
