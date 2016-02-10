Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-3.sys.kth.se ([130.237.48.192]:33533 "EHLO
	smtp-3.sys.kth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754764AbcBJBFj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Feb 2016 20:05:39 -0500
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
	<niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v3 7/8] ARM: dts: r8a7790: add iommus to dmac0 and dmac1
Date: Wed, 10 Feb 2016 01:57:57 +0100
Message-ID: <1455065878-11906-8-git-send-email-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <1455065878-11906-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1455065878-11906-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: robin.murphy@arm.com, vinod.koul@intel.com, laurent.pinchart@ideasonboard.com, geert+renesas@glider.be, linus.walleij@linaro.org, dan.j.williams@intel.com, arnd@arndb.de, linux-arch@vger.kernel.org, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Message-ID: <20160210005757.qm5njwIS-LsW_-w02S3X1qPaqTn1e-SMv0LWfiFvm9E@z>

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 arch/arm/boot/dts/r8a7790.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 7dfd393..048bbf8 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -294,6 +294,21 @@
 		power-domains = <&cpg_clocks>;
 		#dma-cells = <1>;
 		dma-channels = <15>;
+		iommus = <&ipmmu_ds 0>,
+			 <&ipmmu_ds 1>,
+			 <&ipmmu_ds 2>,
+			 <&ipmmu_ds 3>,
+			 <&ipmmu_ds 4>,
+			 <&ipmmu_ds 5>,
+			 <&ipmmu_ds 6>,
+			 <&ipmmu_ds 7>,
+			 <&ipmmu_ds 8>,
+			 <&ipmmu_ds 9>,
+			 <&ipmmu_ds 10>,
+			 <&ipmmu_ds 11>,
+			 <&ipmmu_ds 12>,
+			 <&ipmmu_ds 13>,
+			 <&ipmmu_ds 14>;
 	};
 
 	dmac1: dma-controller@e6720000 {
@@ -325,6 +340,21 @@
 		power-domains = <&cpg_clocks>;
 		#dma-cells = <1>;
 		dma-channels = <15>;
+		iommus = <&ipmmu_ds 15>,
+			 <&ipmmu_ds 16>,
+			 <&ipmmu_ds 17>,
+			 <&ipmmu_ds 18>,
+			 <&ipmmu_ds 19>,
+			 <&ipmmu_ds 20>,
+			 <&ipmmu_ds 21>,
+			 <&ipmmu_ds 22>,
+			 <&ipmmu_ds 23>,
+			 <&ipmmu_ds 24>,
+			 <&ipmmu_ds 25>,
+			 <&ipmmu_ds 26>,
+			 <&ipmmu_ds 27>,
+			 <&ipmmu_ds 28>,
+			 <&ipmmu_ds 29>;
 	};
 
 	audma0: dma-controller@ec700000 {
-- 
2.7.1

