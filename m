Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:38922 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727761AbeIYFpk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Sep 2018 01:45:40 -0400
From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V5 19/30] dt-bindings: Add vendor prefix for csky
Date: Tue, 25 Sep 2018 07:39:22 +0800
Message-ID: <da5734d918db4e9159d07bda477f502d1243df10.1537789737.git.ren_guo@c-sky.com>
In-Reply-To: <a23b652c2ab55b129f729a57ec765550da1d2c16.1537789737.git.ren_guo@c-sky.com>
References: <a23b652c2ab55b129f729a57ec765550da1d2c16.1537789737.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1537789736.git.ren_guo@c-sky.com>
References: <cover.1537789736.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, green.hu@gmail.com, palmer@sifive.com, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20180924233922.S359GBMcJiEBlqdR3kC4tERDH1ce9NBWLVhsrkGUw3o@z>

Add csky vendor definition.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 2c3fc51..a728ee3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -84,6 +84,7 @@ cosmic	Cosmic Circuits
 crane	Crane Connectivity Solutions
 creative	Creative Technology Ltd
 crystalfontz	Crystalfontz America, Inc.
+csky	Hangzhou C-SKY Microsystems Co., Ltd
 cubietech	Cubietech, Ltd.
 cypress	Cypress Semiconductor Corporation
 cznic	CZ.NIC, z.s.p.o.
-- 
2.7.4
