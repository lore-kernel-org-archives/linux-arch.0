Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:57365 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729833AbeIRTWt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 Sep 2018 15:22:49 -0400
From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V7 0/2] irqchip: add C-SKY SMP interrupt controller
Date: Tue, 18 Sep 2018 21:49:29 +0800
Message-ID: <cover.1537276562.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, robh@kernel.org, sfr@canb.auug.org.au
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, green.hu@gmail.com, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20180918134929.Q-OCbEKmU1VWbigBQjjm3c7DpEhZjmF5XvkGHHQxb7Y@z>

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
