From: guoren@kernel.org
Subject: [PATCH 09/10] dt-bindings: csky,apb-intc: Add vector irq mode
Date: Tue, 29 Jan 2019 20:24:28 +0800
Message-ID: <1548764669-16656-9-git-send-email-guoren@kernel.org>
References: <1548764669-16656-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548764669-16656-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de, robh+dt@kernel.org, marc.zyngier@arm.com
Cc: linux-kernel@vger.kernel.org, guoren@kernel.org, linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Add csky,support-vector-irq for irq-csky-apb-intc.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 .../devicetree/bindings/interrupt-controller/csky,apb-intc.txt         | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
index 63bc9dc..0f9fa88 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
@@ -37,6 +37,9 @@ intc node bindings definition
 	- csky,support-pulse-signal:
 		Usage: select
 		Description: to support pulse signal flag
+	- csky,support-vector-irq:
+		Usage: select
+		Description: to support vector irq mode
 
 Examples:
 ---------
-- 
2.7.4
