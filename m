From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v7 0/3] clocksource/drivers/atcpit100: Add andestech atcpit100 timer
Date: Tue, 13 Feb 2018 17:13:16 +0800
Message-ID: <cover.1518505425.git.greentime@andestech.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, rdunlap@infradead.org, davem@davemloft.net, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com
Cc: green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

Hi, all:

ATCPIT100 is often used on the Andes architecture,
This timer provide 4 PIT channels. Each PIT channel is a
multi-function timer, can be configured as 32,16,8 bit timers
or PWM as well.

For system timer it will set channel 1 32-bit timer0 as clock
source and count downwards until underflow and restart again.

It also set channel 0 32-bit timer0 as clock event and count
downwards until condition match. It will generate an interrupt
for handling periodically.

Changes in v7:
 - Fix atcpit100_clkevt_next_event(), before set reload register,
   clock source timer shall disable. And re-enable it after the setting.
   Without this modification, the test case 'clock_nanosleep02' of ltp_20170929
   will fail.

Changes in v6:
 - To select TIMER_OF in drivers/clocksource/Kconfig instead of arch/nds32/Kconfig
 - Refine Kconfig
 - Update license format to SPDX-License-Identifier


Rick Chen (3):
  clocksource/drivers/atcpit100: Add andestech atcpit100 timer
  clocksource/drivers/atcpit100: VDSO support
  dt-bindings: timer: Add andestech atcpit100 timer binding doc

 .../bindings/timer/andestech,atcpit100-timer.txt   |  33 +++
 drivers/clocksource/Kconfig                        |   9 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/timer-atcpit100.c              | 266 +++++++++++++++++++++
 4 files changed, 309 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/andestech,atcpit100-timer.txt
 create mode 100644 drivers/clocksource/timer-atcpit100.c

-- 
2.16.1
