Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from condef-10.nifty.com ([202.248.20.75]:51543 "EHLO
        condef-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932309AbdEOL3N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 May 2017 07:29:13 -0400
Received: from conuserg-08.nifty.com ([10.126.8.71])by condef-10.nifty.com with ESMTP id v4FBIf8X001465
        for <linux-arch@vger.kernel.org>; Mon, 15 May 2017 20:18:41 +0900
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/5] ARM: dts: use #include "..." to include DT in the same directory
Date: Mon, 15 May 2017 20:14:45 +0900
Message-ID: <1494846888-18966-3-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1494846888-18966-1-git-send-email-yamada.masahiro@socionext.com>
References: <1494846888-18966-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: devicetree@vger.kernel.org
Cc: linux-arch <linux-arch@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Gaurav Minocha <gaurav.minocha.os@gmail.com>, Grant Likely <grant.likely@linaro.org>, Frank Rowand <frowand.list@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <yamada.masahiro@socionext.com>, Fabio Estevam <fabio.estevam@nxp.com>, Sascha Hauer <kernel@pengutronix.de>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawnguo@kernel.org>
Message-ID: <20170515111445.zK31zkjEAGjxmhWvFLEfKq10Qtik9tM4fXskmp0md6o@z>

Most of DT files in ARM use #include "..." to make pre-processor
include DT in the same directory, but we have 3 exceptional files
that use #include <...> for that.

They must be fixed to remove -I$(srctree)/arch/$(SRCARCH)/boot/dts
path from dtc_cpp_flags.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/imx6q-zii-rdu2.dts  | 4 ++--
 arch/arm/boot/dts/imx6qp-zii-rdu2.dts | 4 ++--
 arch/arm/boot/dts/versatile-pb.dts    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-zii-rdu2.dts b/arch/arm/boot/dts/imx6q-zii-rdu2.dts
index b2d3466..6be8a1e 100644
--- a/arch/arm/boot/dts/imx6q-zii-rdu2.dts
+++ b/arch/arm/boot/dts/imx6q-zii-rdu2.dts
@@ -41,8 +41,8 @@
 
 /dts-v1/;
 
-#include <imx6q.dtsi>
-#include <imx6qdl-zii-rdu2.dtsi>
+#include "imx6q.dtsi"
+#include "imx6qdl-zii-rdu2.dtsi"
 
 / {
 	model = "ZII RDU2 Board";
diff --git a/arch/arm/boot/dts/imx6qp-zii-rdu2.dts b/arch/arm/boot/dts/imx6qp-zii-rdu2.dts
index 882b3bd..547a766 100644
--- a/arch/arm/boot/dts/imx6qp-zii-rdu2.dts
+++ b/arch/arm/boot/dts/imx6qp-zii-rdu2.dts
@@ -41,8 +41,8 @@
 
 /dts-v1/;
 
-#include <imx6qp.dtsi>
-#include <imx6qdl-zii-rdu2.dtsi>
+#include "imx6qp.dtsi"
+#include "imx6qdl-zii-rdu2.dtsi"
 
 / {
 	model = "ZII RDU2+ Board";
diff --git a/arch/arm/boot/dts/versatile-pb.dts b/arch/arm/boot/dts/versatile-pb.dts
index 33a8eb2..06e2331 100644
--- a/arch/arm/boot/dts/versatile-pb.dts
+++ b/arch/arm/boot/dts/versatile-pb.dts
@@ -1,4 +1,4 @@
-#include <versatile-ab.dts>
+#include "versatile-ab.dts"
 
 / {
 	model = "ARM Versatile PB";
-- 
2.7.4
