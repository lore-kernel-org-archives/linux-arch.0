Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:48863 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728405AbeILT7D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Sep 2018 15:59:03 -0400
From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V4 27/27] dt-bindings: Add vendor prefix for csky
Date: Wed, 12 Sep 2018 22:52:09 +0800
Message-ID: <21c4e62bed6dcb4ff8ee860fb53de69a0adb1cce.1536758961.git.ren_guo@c-sky.com>
In-Reply-To: <93e8b592e429c156ad4d4ca5d85ef48fd0ab8b70.1536758961.git.ren_guo@c-sky.com>
References: <93e8b592e429c156ad4d4ca5d85ef48fd0ab8b70.1536758961.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1536758961.git.ren_guo@c-sky.com>
References: <cover.1536758961.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, devicetree@vger.kernel.org, andrea.parri@amarulasolutions.com, peterz@infradead.org
Cc: c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, ren_guo@c-sky.com, green.hu@gmail.com
Message-ID: <20180912145209.t0iYt-IzGs5UBP8Wl3G04R5QN3ratQj4C2NDkd4PlHU@z>

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 7cad066..335f9e0 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -81,6 +81,7 @@ cosmic	Cosmic Circuits
 crane	Crane Connectivity Solutions
 creative	Creative Technology Ltd
 crystalfontz	Crystalfontz America, Inc.
+csky	Hangzhou C-SKY Microsystems Co., Ltd
 cubietech	Cubietech, Ltd.
 cypress	Cypress Semiconductor Corporation
 cznic	CZ.NIC, z.s.p.o.
-- 
2.7.4
