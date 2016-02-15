From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4/4] ARM: remove asm/gpio.h
Date: Mon, 15 Feb 2016 16:46:31 +0100
Message-ID: <1455551208-2825510-5-git-send-email-arnd@arndb.de>
References: <20160202194831.10827.63244.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <1455551208-2825510-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455551208-2825510-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Russell King <rmk+kernel@arm.linux.org.uk>, Bjorn Helgaas <bhelgaas@google.com>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

The ARM version of asm/gpio.h basically just contains the same definitions
as the gpiolib version, with the exception of ARCH_NR_GPIOS.

This adds the option for overriding the constant through Kconfig to
the architecture-independent header, and removes the ARM version at
the same time.

This patch depends on a series done by Bjorn Helgaas, and the patch
removing irq_to_gpio().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig            |  1 -
 arch/arm/include/asm/gpio.h | 25 -------------------------
 include/asm-generic/gpio.h  |  4 ++++
 3 files changed, 4 insertions(+), 26 deletions(-)
 delete mode 100644 arch/arm/include/asm/gpio.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0366ad63e2ed..27aefbe43eea 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -5,7 +5,6 @@ config ARM
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
-	select ARCH_HAVE_CUSTOM_GPIO_H
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_SUPPORTS_ATOMIC_RMW
diff --git a/arch/arm/include/asm/gpio.h b/arch/arm/include/asm/gpio.h
deleted file mode 100644
index 504dcddebfcc..000000000000
--- a/arch/arm/include/asm/gpio.h
+++ /dev/null
@@ -1,25 +0,0 @@
-#ifndef _ARCH_ARM_GPIO_H
-#define _ARCH_ARM_GPIO_H
-
-#if CONFIG_ARCH_NR_GPIO > 0
-#define ARCH_NR_GPIOS CONFIG_ARCH_NR_GPIO
-#endif
-
-/* Note: this may rely upon the value of ARCH_NR_GPIOS set in mach/gpio.h */
-#include <asm-generic/gpio.h>
-
-/* The trivial gpiolib dispatchers */
-#define gpio_get_value  __gpio_get_value
-#define gpio_set_value  __gpio_set_value
-#define gpio_cansleep   __gpio_cansleep
-
-/*
- * Provide a default gpio_to_irq() which should satisfy every case.
- * However, some platforms want to do this differently, so allow them
- * to override it.
- */
-#ifndef gpio_to_irq
-#define gpio_to_irq	__gpio_to_irq
-#endif
-
-#endif /* _ARCH_ARM_GPIO_H */
diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
index 40ec1433f05d..2d04b321db13 100644
--- a/include/asm-generic/gpio.h
+++ b/include/asm-generic/gpio.h
@@ -26,8 +26,12 @@
  */
 
 #ifndef ARCH_NR_GPIOS
+#ifdef CONFIG_ARCH_NR_GPIO
+#define ARCH_NR_GPIOS CONFIG_ARCH_NR_GPIO
+#else
 #define ARCH_NR_GPIOS		512
 #endif
+#endif
 
 /*
  * "valid" GPIO numbers are nonnegative and may be passed to
-- 
2.7.0
