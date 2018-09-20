Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:60110 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726994AbeITLVs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Sep 2018 07:21:48 -0400
From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V8 0/6] C-SKY(csky) Linux Kernel Port
Date: Thu, 20 Sep 2018 13:39:26 +0800
Message-ID: <cover.1537417413.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, robh@kernel.org, sfr@canb.auug.org.au
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, green.hu@gmail.com, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20180920053926.vE2G1vuIe7L2aUX4cmNfepEXGUF6Pft0cVjTv2NTXJ0@z>

Because I've sent to Stephen Roth with the linux-4.19-rc3 git-tree for
linux-next, I shouldn't rebase any more.
https://github.com/c-sky/csky-linux.git#linux-next

This patchset include mptimer and mpintc drivers and fixup:

 - Fixup smp IPI's problems found by Marc Zyngier
 - Add irq-csky-mpintc.c patch in this patchset
 - Add mptimer.c patch in this patchset 
 - Fixup dma_sync_for_cpu/device in dma-mapping.c

Guo Ren (6):
  csky/dma: bugfix dma_sync_for_cpu/device
  csky: remove irq_mapping from smp.c
  irqchip: add C-SKY SMP interrupt controller
  dt-bindings: interrupt-controller: C-SKY SMP intc
  clocksource: add C-SKY SMP timer
  dt-bindings: timer: C-SKY Multi-processor timer

 .../bindings/interrupt-controller/csky,mpintc.txt  |  40 +++++
 .../devicetree/bindings/timer/csky,mptimer.txt     |  46 +++++
 arch/csky/include/asm/smp.h                        |   4 +-
 arch/csky/kernel/smp.c                             |  27 ++-
 arch/csky/mm/dma-mapping.c                         |   5 +-
 drivers/clocksource/Kconfig                        |   8 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/csky_mptimer.c                 | 178 +++++++++++++++++++
 drivers/irqchip/Kconfig                            |   8 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-csky-mpintc.c                  | 195 +++++++++++++++++++++
 include/linux/cpuhotplug.h                         |   1 +
 12 files changed, 503 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
 create mode 100644 Documentation/devicetree/bindings/timer/csky,mptimer.txt
 create mode 100644 drivers/clocksource/csky_mptimer.c
 create mode 100644 drivers/irqchip/irq-csky-mpintc.c

-- 
2.7.4
