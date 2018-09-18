From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V7 0/2] bugfix based on csky linux-next
Date: Tue, 18 Sep 2018 21:48:12 +0800
Message-ID: <cover.1537276837.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, robh@kernel.org, sfr@canb.auug.org.au
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, green.hu@gmail.com, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

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
