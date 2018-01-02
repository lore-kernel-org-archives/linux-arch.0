Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42800 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751981AbeABI0Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Jan 2018 03:26:16 -0500
From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v5 04/39] earlycon: add reg-offset to physical address before mapping
Date: Tue,  2 Jan 2018 16:24:36 +0800
Message-ID: <030b9e2ee2d6ee309eebe00feea0e92687304e64.1514874857.git.green.hu@gmail.com>
In-Reply-To: <cover.1514874857.git.green.hu@gmail.com>
References: <cover.1514874857.git.green.hu@gmail.com>
In-Reply-To: <cover.1514874857.git.green.hu@gmail.com>
References: <cover.1514874857.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, rdunlap@infradead.org, davem@davemloft.net, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com
Cc: green.hu@gmail.com
Message-ID: <20180102082436.5NPDXk7CwxqTJxUb2N2VmUoG2Q2J3SbctvoX6R4h0gg@z>

From: Greentime Hu <greentime@andestech.com>

It will get the wrong virtual address because port->mapbase is not added
the correct reg-offset yet. We have to update it before earlycon_map()
is called

Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 drivers/tty/serial/earlycon.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 98928f0..17dba0a 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -253,11 +253,12 @@ int __init of_setup_earlycon(const struct earlycon_id *match,
 	}
 	port->mapbase = addr;
 	port->uartclk = BASE_BAUD * 16;
-	port->membase = earlycon_map(port->mapbase, SZ_4K);
 
 	val = of_get_flat_dt_prop(node, "reg-offset", NULL);
 	if (val)
 		port->mapbase += be32_to_cpu(*val);
+	port->membase = earlycon_map(port->mapbase, SZ_4K);
+
 	val = of_get_flat_dt_prop(node, "reg-shift", NULL);
 	if (val)
 		port->regshift = be32_to_cpu(*val);
-- 
1.7.9.5
