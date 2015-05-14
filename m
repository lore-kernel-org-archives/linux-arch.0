From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH 0/4] arc: add AXS101 board support
Date: Thu, 14 May 2015 15:48:40 +0300
Message-ID: <1431607724-9142-1-git-send-email-abrodkin@synopsys.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:52021 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932420AbbENMs5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 14 May 2015 08:48:57 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, arc-linux-dev@synopsys.com, devicetree@vger.kernel.org, Vineet.Gupta1@synopsys.com, Alexey Brodkin <Alexey.Brodkin@synopsys.com>

AXS101 is a new generation of devlopment boards from Synopsys that houses
ASIC with ARC700 and lots of DesignWare peripherals:

 * DW APB UART
 * DW Mobile Storage (MMC/SD)
 * DW I2C
 * DW GMAC

More info about DesignWare ARC Software Development Platforms (SDP) is here:
http://www.synopsys.com/dw/ipdir.php?ds=arc-software-development-platform

More info about AXS101 in particular is here (it's required to enter contact
details to obtain the document):
http://www.synopsys.com/dw/doc.php/ds/cc/arc_axs101_sdp.pdf

Alexey Brodkin (2):
  ARC: [axs101] Add support for AXS101 SDP (software development
    platform)
  ARC: [axs101] STAR 9000799830: Fix SD cards support

Vineet Gupta (2):
  ARC: [axs101] support early 8250 uart
  ARC: [axs101] Tweak DDR port aperture mappings for performance

 Documentation/devicetree/bindings/arc/axs10x.txt |   7 +
 MAINTAINERS                                      |   7 +
 arch/arc/Kconfig                                 |   1 +
 arch/arc/Makefile                                |   1 +
 arch/arc/boot/dts/axc001.dtsi                    |  79 ++++++
 arch/arc/boot/dts/axs101.dts                     |  21 ++
 arch/arc/boot/dts/axs10x_mb.dtsi                 | 241 ++++++++++++++++++
 arch/arc/configs/axs101_defconfig                | 112 +++++++++
 arch/arc/kernel/devtree.c                        |   2 +
 arch/arc/plat-axs10x/Kconfig                     |  35 +++
 arch/arc/plat-axs10x/Makefile                    |   9 +
 arch/arc/plat-axs10x/axs10x.c                    | 298 +++++++++++++++++++++++
 12 files changed, 813 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arc/axs10x.txt
 create mode 100644 arch/arc/boot/dts/axc001.dtsi
 create mode 100644 arch/arc/boot/dts/axs101.dts
 create mode 100644 arch/arc/boot/dts/axs10x_mb.dtsi
 create mode 100644 arch/arc/configs/axs101_defconfig
 create mode 100644 arch/arc/plat-axs10x/Kconfig
 create mode 100644 arch/arc/plat-axs10x/Makefile
 create mode 100644 arch/arc/plat-axs10x/axs10x.c

-- 
2.1.0
