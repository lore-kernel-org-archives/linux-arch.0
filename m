Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:57755 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729491AbeIRTVw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 Sep 2018 15:21:52 -0400
From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V7 0/2] clocksource: add gx6605s SOC system timer
Date: Tue, 18 Sep 2018 21:48:53 +0800
Message-ID: <cover.1537276815.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, robh@kernel.org, sfr@canb.auug.org.au
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, green.hu@gmail.com, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20180918134853.o2xhwD0_UloY01ehfI5tyEzPC4OS5mYhqc4EjnjioAY@z>

Guo Ren (2):
  clocksource: add gx6605s SOC system timer
  dt-bindings: timer: gx6605s SOC timer

 .../bindings/timer/csky,gx6605s-timer.txt          |  42 ++++++
 drivers/clocksource/Kconfig                        |   8 ++
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/timer-gx6605s.c                | 150 +++++++++++++++++++++
 4 files changed, 201 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
 create mode 100644 drivers/clocksource/timer-gx6605s.c

-- 
2.7.4
