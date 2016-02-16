From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 5/5] gpio: allow setting ARCH_NR_GPIOS from Kconfig
Date: Tue, 16 Feb 2016 16:40:38 +0100
Message-ID: <1455637261-2920972-5-git-send-email-arnd@arndb.de>
References: <455637086-2794174-1-git-send-email-arnd@arndb.de>
 <1455637261-2920972-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455637261-2920972-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Russell King <rmk+kernel@arm.linux.org.uk>, Bjorn Helgaas <bhelgaas@google.com>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

The ARM version of asm/gpio.h basically just contains the same definitions
as the gpiolib version, with the exception of ARCH_NR_GPIOS.

This adds the option for overriding the constant through Kconfig to
the architecture-independent header, so we can remove the ARM specific
file later.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/gpio.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
index 40ec1433f05d..8ca627dcea11 100644
--- a/include/asm-generic/gpio.h
+++ b/include/asm-generic/gpio.h
@@ -26,8 +26,12 @@
  */
 
 #ifndef ARCH_NR_GPIOS
+#if defined(CONFIG_ARCH_NR_GPIO) && CONFIG_ARCH_NR_GPIO > 0
+#define ARCH_NR_GPIOS CONFIG_ARCH_NR_GPIO
+#else
 #define ARCH_NR_GPIOS		512
 #endif
+#endif
 
 /*
  * "valid" GPIO numbers are nonnegative and may be passed to
-- 
2.7.0
