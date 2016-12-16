Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:64363 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760229AbcLPK5G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Dec 2016 05:57:06 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 05/13] clk: pxa: fix gcc-4.4 build
Date: Fri, 16 Dec 2016 11:56:26 +0100
Message-ID: <20161216105634.235457-6-arnd@arndb.de>
In-Reply-To: <20161216105634.235457-1-arnd@arndb.de>
References: <20161216105634.235457-1-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, kernel-build-reports@lists.linaro.org, kvmarm@lists.cs.columbia.edu, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20161216105626.vhXTL5FmMbyUVEIO0ceWlkOi4QrinXPWzgadFk6hD-I@z>

With gcc-4.4 and earlier, the asm statement must not end in ':', or we
get this build error:

drivers/clk/pxa/clk-pxa.c: In function 'pxa2xx_core_turbo_switch':
drivers/clk/pxa/clk-pxa.c:152: error: expected string literal before ')' token

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/pxa/clk-pxa.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/pxa/clk-pxa.c b/drivers/clk/pxa/clk-pxa.c
index 74f64c3c4290..626ec5613bb1 100644
--- a/drivers/clk/pxa/clk-pxa.c
+++ b/drivers/clk/pxa/clk-pxa.c
@@ -148,8 +148,7 @@ void pxa2xx_core_turbo_switch(bool on)
 	"2:	b	1b\n"
 	"3:	nop\n"
 		: "=&r" (unused)
-		: "r" (clkcfg)
-		: );
+		: "r" (clkcfg));
 
 	local_irq_restore(flags);
 }
-- 
2.9.0

