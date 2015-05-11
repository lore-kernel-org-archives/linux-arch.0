From: Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>
Subject: [PATCH v12 04/21] sh-sci: Add h8300 SCI
Date: Mon, 11 May 2015 15:26:23 +0900
Message-ID: <1431325600-12333-5-git-send-email-ysato@users.sourceforge.jp>
References: <1431325600-12333-1-git-send-email-ysato@users.sourceforge.jp>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1431325600-12333-1-git-send-email-ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>
Acked-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 1 +
 drivers/tty/serial/Kconfig                                      | 2 +-
 drivers/tty/serial/sh-sci.c                                     | 6 ++++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index ae73bb0..7534d46 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -29,6 +29,7 @@ Required properties:
     - "renesas,scifa" for generic SCIFA compatible UART.
     - "renesas,scifb" for generic SCIFB compatible UART.
     - "renesas,hscif" for generic HSCIF compatible UART.
+    - "renesas,sci" for generic SCI compatible UART.
 
     When compatible with the generic version, nodes must list the
     SoC-specific version corresponding to the platform first followed by the
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index f8120c1..dea1eff 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -728,7 +728,7 @@ config SERIAL_IP22_ZILOG_CONSOLE
 
 config SERIAL_SH_SCI
 	tristate "SuperH SCI(F) serial port support"
-	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
+	depends on SUPERH || ARCH_SHMOBILE || H8300 || COMPILE_TEST
 	select SERIAL_CORE
 
 config SERIAL_SH_SCI_NR_UARTS
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index e7d6566..1468ec5 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2536,6 +2536,12 @@ static const struct of_device_id of_sci_match[] = {
 			.regtype = SCIx_HSCIF_REGTYPE,
 		},
 	}, {
+		.compatible = "renesas,sci",
+		.data = &(const struct sci_port_info) {
+			.type = PORT_SCI,
+			.regtype = SCIx_SCI_REGTYPE,
+		},
+	}, {
 		/* Terminator */
 	},
 };
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
