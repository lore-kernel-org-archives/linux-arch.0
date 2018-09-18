From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V7 0/2] clocksource: add C-SKY SMP timer
Date: Tue, 18 Sep 2018 21:48:34 +0800
Message-ID: <cover.1537276791.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, robh@kernel.org, sfr@canb.auug.org.au
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, green.hu@gmail.com, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

Guo Ren (2):
  clocksource: add C-SKY SMP timer
  dt-bindings: timer: C-SKY Multi-processor timer

 .../devicetree/bindings/timer/csky,mptimer.txt     |  46 ++++++
 drivers/clocksource/Kconfig                        |   8 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/csky_mptimer.c                 | 178 +++++++++++++++++++++
 4 files changed, 233 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/csky,mptimer.txt
 create mode 100644 drivers/clocksource/csky_mptimer.c

-- 
2.7.4
