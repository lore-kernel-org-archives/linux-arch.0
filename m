Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from condef-05.nifty.com ([202.248.20.70]:18980 "EHLO
        condef-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932309AbdEOL1g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 May 2017 07:27:36 -0400
Received: from conuserg-08.nifty.com ([10.126.8.71])by condef-05.nifty.com with ESMTP id v4FBJY8X013803
        for <linux-arch@vger.kernel.org>; Mon, 15 May 2017 20:19:34 +0900
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 0/5] devicetree: cleanup and improve DT cross-arch reference
Date: Mon, 15 May 2017 20:14:43 +0900
Message-ID: <1494846888-18966-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: devicetree@vger.kernel.org
Cc: linux-arch <linux-arch@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Gaurav Minocha <gaurav.minocha.os@gmail.com>, Grant Likely <grant.likely@linaro.org>, Frank Rowand <frowand.list@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <yamada.masahiro@socionext.com>, Fabio Estevam <fabio.estevam@nxp.com>, Sascha Hauer <kernel@pengutronix.de>, linux-kbuild@vger.kernel.org, Michal Marek <mmarek@suse.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, Shawn Guo <shawnguo@kernel.org>
Message-ID: <20170515111443.Tq8HFwwtKyiIwUB70Bq63v6i-fc2JFcT4xRK-MMadWw@z>

This series depends on Olof's
"devicetree: Move include prefixes from arch to separate directory"
https://patchwork.kernel.org/patch/9724995/

1/5: clean-up of unused include path
2/5: Fixup of last three DT files in ARM (needed for 4/5)
3/5: Fixup of last three DT files in PowerPC (needed for 4/5)
4/5: Remove arch/$(SRCARCH)/boot/dts include path
5/5: Make DT cross-arch reference available for /include/ directive


Masahiro Yamada (5):
  of: remove drivers/of/testcase-data from include search path for CPP
  ARM: dts: use #include "..." to include DT in the same directory
  powerpc: dts: use #include "..." to include DT in the same directory
  of: remove arch/$(SRCARCH)/boot/dts from include search path for CPP
  of: add scripts/dtc/include-prefixes to search path for both CPP and
    DTC

 arch/arm/boot/dts/imx6q-zii-rdu2.dts  | 4 ++--
 arch/arm/boot/dts/imx6qp-zii-rdu2.dts | 4 ++--
 arch/arm/boot/dts/versatile-pb.dts    | 2 +-
 arch/powerpc/boot/dts/ac14xx.dts      | 2 +-
 arch/powerpc/boot/dts/mpc5121ads.dts  | 2 +-
 arch/powerpc/boot/dts/pdm360ng.dts    | 2 +-
 scripts/Makefile.lib                  | 8 ++++----
 7 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.7.4
