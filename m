Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40847 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752148AbdK0MzN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Nov 2017 07:55:13 -0500
From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v2 31/35] earlycon: add reg-offset to physical address before mapping
Date: Mon, 27 Nov 2017 20:28:18 +0800
Message-ID: <5b5f07ffd75d509a661398d02d6f1336156554ae.1511785528.git.green.hu@gmail.com>
In-Reply-To: <cover.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com>
In-Reply-To: <cover.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org
Cc: green.hu@gmail.com
Message-ID: <20171127122818.tzsR6OivegmP63jq-Sx-UgItw_Fhm1DuX5x54qX80Kw@z>

From: Greentime Hu <greentime@andestech.com>

It will get the wrong virtual address because port->mapbase is not added
the correct reg-offset yet. We have to update it before earlycon_map()
is called
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
