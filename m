Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9227EC433B4
	for <linux-arch@archiver.kernel.org>; Fri,  2 Apr 2021 09:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E93A60724
	for <linux-arch@archiver.kernel.org>; Fri,  2 Apr 2021 09:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbhDBJGd (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 2 Apr 2021 05:06:33 -0400
Received: from marcansoft.com ([212.63.210.85]:34342 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234404AbhDBJGd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 2 Apr 2021 05:06:33 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 8194042720;
        Fri,  2 Apr 2021 09:06:24 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/18] dt-bindings: timer: arm,arch_timer: Add interrupt-names support
Date:   Fri,  2 Apr 2021 18:05:29 +0900
Message-Id: <20210402090542.131194-6-marcan@marcan.st>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210402090542.131194-1-marcan@marcan.st>
References: <20210402090542.131194-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Not all platforms provide the same set of timers/interrupts, and Linux
only needs one (plus kvm/guest ones); some platforms are working around
this by using dummy fake interrupts. Implementing interrupt-names allows
the devicetree to specify an arbitrary set of available interrupts, so
the timer code can pick the right one.

This also adds the hyp-virt timer/interrupt, which was previously not
expressed in the fixed 4-interrupt form.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 .../bindings/timer/arm,arch_timer.yaml        | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml b/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
index 2c75105c1398..7f5e3af58255 100644
--- a/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
+++ b/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
@@ -34,11 +34,30 @@ properties:
               - arm,armv8-timer
 
   interrupts:
+    minItems: 1
+    maxItems: 5
     items:
       - description: secure timer irq
       - description: non-secure timer irq
       - description: virtual timer irq
       - description: hypervisor timer irq
+      - description: hypervisor virtual timer irq
+
+  interrupt-names:
+    oneOf:
+      - minItems: 2
+        items:
+          - const: phys
+          - const: virt
+          - const: hyp-phys
+          - const: hyp-virt
+      - minItems: 3
+        items:
+          - const: sec-phys
+          - const: phys
+          - const: virt
+          - const: hyp-phys
+          - const: hyp-virt
 
   clock-frequency:
     description: The frequency of the main counter, in Hz. Should be present
-- 
2.30.0

