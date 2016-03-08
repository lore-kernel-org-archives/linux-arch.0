From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=
	<niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v5 9/9] ARM: dts: r8a7791: add iommus to dmac0 and dmac1
Date: Tue,  8 Mar 2016 03:42:54 +0100
Message-ID: <1457404974-1800-10-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1457404974-1800-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-4.sys.kth.se ([130.237.48.193]:38755 "EHLO
	smtp-4.sys.kth.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932369AbcCHCoV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Mar 2016 21:44:21 -0500
In-Reply-To: <1457404974-1800-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: vinod.koul@intel.com, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: robin.murphy@arm.com, laurent.pinchart@ideasonboard.com, geert+renesas@glider.be, linus.walleij@linaro.org, dan.j.williams@intel.com, arnd@arndb.de, linux-arch@vger.kernel.org, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>

A unconfirmed hardware bug prevents channel 0 and 15 to be used by the
DMAC together with the IPMMU. The DMAC driver will disable the channels
reducing the effective number of channels to 14 per DMAC.

Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatec=
h.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7791.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791=
=2Edtsi
index c6bee4a..341c460 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -283,6 +283,21 @@
 		power-domains =3D <&cpg_clocks>;
 		#dma-cells =3D <1>;
 		dma-channels =3D <15>;
+		iommus =3D <&ipmmu_ds 0>,
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
=20
 	dmac1: dma-controller@e6720000 {
@@ -314,6 +329,21 @@
 		power-domains =3D <&cpg_clocks>;
 		#dma-cells =3D <1>;
 		dma-channels =3D <15>;
+		iommus =3D <&ipmmu_ds 15>,
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
=20
 	audma0: dma-controller@ec700000 {
--=20
2.7.2
