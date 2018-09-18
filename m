Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:58097 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729491AbeIRTWe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 Sep 2018 15:22:34 -0400
From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V7 0/2] irqchip: add C-SKY APB bus interrupt controller
Date: Tue, 18 Sep 2018 21:49:38 +0800
Message-ID: <cover.1537276735.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, robh@kernel.org, sfr@canb.auug.org.au
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, green.hu@gmail.com, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20180918134938.6TkV4Fyv_21F58qlvt294i3k5y4j2sFsR6dlgyFjSes@z>

Guo Ren (2):
  irqchip: add C-SKY APB bus interrupt controller
  dt-bindings: interrupt-controller: C-SKY APB intc

 .../interrupt-controller/csky,apb-intc.txt         |  70 ++++++
 drivers/irqchip/Kconfig                            |   8 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-csky-apb-intc.c                | 260 +++++++++++++++++++++
 4 files changed, 339 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
 create mode 100644 drivers/irqchip/irq-csky-apb-intc.c

-- 
2.7.4
