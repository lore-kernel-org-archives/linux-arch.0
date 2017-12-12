From: Rick Chen <rickchen36-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v5 0/3] Add andestech atcpit100 timer
Date: Tue, 12 Dec 2017 13:46:58 +0800
Message-ID: <1513057621-19084-1-git-send-email-rickchen36@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: rickchen36-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rick-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
