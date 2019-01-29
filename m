Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727593AbfA2MYr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 29 Jan 2019 07:24:47 -0500
From: guoren@kernel.org
Subject: [PATCH 02/10] dt-bindings: csky,apb-intc: Add dh7k SOC support
Date: Tue, 29 Jan 2019 20:24:21 +0800
Message-ID: <1548764669-16656-2-git-send-email-guoren@kernel.org>
In-Reply-To: <1548764669-16656-1-git-send-email-guoren@kernel.org>
References: <1548764669-16656-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, robh+dt@kernel.org, marc.zyngier@arm.com
Cc: linux-kernel@vger.kernel.org, guoren@kernel.org, linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20190129122421.sGS281yPFXXqTar-_JzxTQtoESyXAUNU2MRva6Q-Zi4@z>

From: Guo Ren <ren_guo@c-sky.com>

Add C-SKY dh7k SOC description.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
index 44286dc..63bc9dc 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
@@ -23,6 +23,7 @@ intc node bindings definition
 		Definition: must be "csky,apb-intc"
 				    "csky,dual-apb-intc"
 				    "csky,gx6605s-intc"
+				    "csky,dh7k-intc"
 	- #interrupt-cells
 		Usage: required
 		Value type: <u32>
-- 
2.7.4
