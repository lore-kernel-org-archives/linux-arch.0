From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V7 0/2] irqchip: add C-SKY SMP interrupt controller
Date: Tue, 18 Sep 2018 21:49:29 +0800
Message-ID: <cover.1537276562.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, robh@kernel.org, sfr@canb.auug.org.au
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, green.hu@gmail.com, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

Guo Ren (2):
  irqchip: add C-SKY SMP interrupt controller
  dt-bindings: interrupt-controller: C-SKY SMP intc

 .../bindings/interrupt-controller/csky,mpintc.txt  |  40 +++++
 drivers/irqchip/Kconfig                            |  16 ++
 drivers/irqchip/Makefile                           |   2 +
 drivers/irqchip/irq-csky-mpintc.c                  | 196 +++++++++++++++++++++
 4 files changed, 254 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
 create mode 100644 drivers/irqchip/irq-csky-mpintc.c

-- 
2.7.4
