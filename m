Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:37499 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728341AbeJaLDP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 31 Oct 2018 07:03:15 -0400
From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V13 0/2] C-SKY(csky) Timer Driver
Date: Wed, 31 Oct 2018 10:06:46 +0800
Message-Id: <cover.1540947083.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: daniel.lezcano@linaro.org, tglx@linutronix.de
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>

Hi Daniel & Thomas,

I sent you "PATCH V13" a few days ago, but no-reply:
https://lkml.org/lkml/2018/10/29/608
Now I send again.

Although csky subsystem has been merged into linux-4.20, but there is no
timer drivers for csky. A lot of boards need these timer drivers.

Please help merge them into linux-4.20, wait for you reply.

Thx
 Guo Ren

Changelog:
 - Move changelog to end of patch.
 - Remove the set_irq_createmapping call back in csky-mp-intc.c.
 - Convert the cpumask to an interrupt-controller specific representation
   in driver's code, and not the SMP code's, and also modify the related
   codes in csky kernel patchset.
 - Add COMPILE_TEST for csky_mp_timer.
 - Fixup smp boot error, cpuhp_setup_state must after timer_of_init()
   for csky_mp_timer.

Guo Ren (2):
  clocksource: add C-SKY SMP timer
  clocksource: add gx6605s SOC system timer

 drivers/clocksource/Kconfig         |  18 ++++
 drivers/clocksource/Makefile        |   2 +
 drivers/clocksource/timer-gx6605s.c | 154 ++++++++++++++++++++++++++++++++
 drivers/clocksource/timer-mp-csky.c | 173 ++++++++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h          |   1 +
 5 files changed, 348 insertions(+)
 create mode 100644 drivers/clocksource/timer-gx6605s.c
 create mode 100644 drivers/clocksource/timer-mp-csky.c

-- 
2.7.4
