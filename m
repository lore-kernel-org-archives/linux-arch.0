Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34865 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751511AbdFFXBZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jun 2017 19:01:25 -0400
Received: by mail-pg0-f66.google.com with SMTP id f127so14152214pgc.2
        for <linux-arch@vger.kernel.org>; Tue, 06 Jun 2017 16:01:25 -0700 (PDT)
From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 03/17] base: fix order of OF initialization
Date: Tue,  6 Jun 2017 15:59:53 -0700
Message-ID: <20170606230007.19101-4-palmer@dabbelt.com>
In-Reply-To: <20170606230007.19101-1-palmer@dabbelt.com>
References: <20170523004107.536-1-palmer@dabbelt.com>
 <20170606230007.19101-1-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, olof@lixom.net
Cc: albert@sifive.com, patches@groups.riscv.org, "Wesley W. Terpstra" <wesley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
Message-ID: <20170606225953.7xyEp__lu2lg9QQTcmWhYCzBvekIF8BXEjmfxacYlRo@z>

From: "Wesley W. Terpstra" <wesley@sifive.com>

This fixes: [    0.010000] cpu cpu0: Error -2 creating of_node link
... which you get for every CPU on all architectures with a OF cpu/ node.

This affects riscv, nios, etc.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 drivers/base/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/init.c b/drivers/base/init.c
index 48c0e220acc0..0dcd17e561d0 100644
--- a/drivers/base/init.c
+++ b/drivers/base/init.c
@@ -31,9 +31,9 @@ void __init driver_init(void)
 	/* These are also core pieces, but must come after the
 	 * core core pieces.
 	 */
+	of_core_init();
 	platform_bus_init();
 	cpu_dev_init();
 	memory_dev_init();
 	container_dev_init();
-	of_core_init();
 }
-- 
2.13.0
