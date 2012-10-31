From: James Hogan <james.hogan@imgtec.com>
Subject: [RFC PATCH v1 06/40] of/vendor-prefixes: add Imagination Technologies
Date: Wed, 31 Oct 2012 16:13:47 +0000
Message-ID: <1351700061-7203-7-git-send-email-james.hogan@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:49628 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935781Ab2JaQOu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Oct 2012 12:14:50 -0400
In-Reply-To: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: James Hogan <james.hogan@imgtec.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, devicetree-discuss@lists.ozlabs.org

The "powervr" prefix which is currently described as "Imagination
Technologies" isn't really appropriate for non-PowerVR hardware, so
change the description of "powervr" to "PowerVR (Imagination
Technologies Ltd.)", and add a separate "img" prefix for "Imagination
Technologies Ltd.".

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Rob Landley <rob@landley.net>
Cc: devicetree-discuss@lists.ozlabs.org
---
 .../devicetree/bindings/vendor-prefixes.txt        |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index db4d3af..5a94721b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -24,6 +24,7 @@ gef	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
 hp	Hewlett Packard
 ibm	International Business Machines (IBM)
 idt	Integrated Device Technologies, Inc.
+img	Imagination Technologies Ltd.
 intercontrol	Inter Control Group
 linux	Linux-specific binding
 marvell	Marvell Technology Group Ltd.
@@ -34,7 +35,7 @@ nintendo	Nintendo
 nvidia	NVIDIA
 nxp	NXP Semiconductors
 picochip	Picochip Ltd
-powervr	Imagination Technologies
+powervr	PowerVR (Imagination Technologies Ltd.)
 qcom	Qualcomm, Inc.
 ramtron	Ramtron International
 realtek Realtek Semiconductor Corp.
-- 
1.7.7.6
