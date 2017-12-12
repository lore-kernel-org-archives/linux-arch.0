Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32867 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbdLLGMC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Dec 2017 01:12:02 -0500
From: Rick Chen <rickchen36@gmail.com>
Subject: [PATCH v5 0/3] Add andestech atcpit100 timer
Date: Tue, 12 Dec 2017 13:46:58 +0800
Message-ID: <1513057621-19084-1-git-send-email-rickchen36@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rickchen36@gmail.com, rick@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linus.walleij@linaro.org, daniel.lezcano@linaro.org, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, linux-serial@vger.kernel.org
Message-ID: <20171212054658.mgZfpO4DgCttvNGDnWjicfOhdfbWa_auPah4xE1W4wY@z>

Changelog v5:
 - Patch 1/3: Changes
 - Patch 2/3: New
 - Patch 3/3: Changes

[Patch 1/3] clocksource/drivers/atcpit100: Add andestech atcpit100 timer
 1 No need to split out the Makefile patch from the actual driver.
 	 Suggested by Arnd Bergmann
 2 Add of_clk.name = "PCLK" to be explicit on what we use.
   Suggested by Linus Walleij
 3 Remove the GENERIC_CLOCKEVENTS from Kconfig.
   Suggested by Daniel Lezcano
 4 Add depends on NDS32 || COMPILE_TEST in Kconfig
   Suggested by Greentime Hu

[Patch 2/3] clocksource/drivers/atcpit100: VDSO support
	 Why implemented in timer driver, please see details from
	 https://lkml.org/lkml/2017/12/8/362
	 [PATCH v3 17/33] nds32: VDSO support.
	 Suggested by Mark Rutland
	 Here Mark Rutlan suggested as below:
	 You should not add properties to arbitrary DT bindings to
	 handle a Linux implementation detail.
	 Please remove this DT code, and have the drivers for those
	 timer blocks export this information to your vdso code somehow.

[Patch 3/3] dt-bindings: timer: Add andestech atcpit100 timer binding doc
   Fix incorrect description about PCLK.
	 Suggested by Linus Walleij

Rick Chen (3):
  clocksource/drivers/atcpit100: Add andestech atcpit100 timer
  clocksource/drivers/atcpit100: VDSO support
  dt-bindings: timer: Add andestech atcpit100 timer binding doc

 .../bindings/timer/andestech,atcpit100-timer.txt   |  33 +++
 drivers/clocksource/Kconfig                        |   7 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/timer-atcpit100.c              | 270 +++++++++++++++++++++
 4 files changed, 311 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/andestech,atcpit100-timer.txt
 create mode 100644 drivers/clocksource/timer-atcpit100.c

-- 
2.7.4
