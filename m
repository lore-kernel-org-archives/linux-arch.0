From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 09/12] platform/early: add an init section for early driver data
Date: Fri, 11 May 2018 18:20:25 +0200
Message-ID: <20180511162028.20616-10-brgl@bgdev.pl>
References: <20180511162028.20616-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180511162028.20616-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, David Lechner <david@lechnology.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Magnus Damm <magnus.damm@gmail.com>, Johan Hovold <johan@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-arch.vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Provide a separate section in which pointers to early platform driver
structs will be stored.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/asm-generic/vmlinux.lds.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index af240573e482..6b5205f30ef2 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -214,6 +214,16 @@
 #define CPU_METHOD_OF_TABLES()	OF_TABLE(CONFIG_SMP, cpu_method)
 #define CPUIDLE_METHOD_OF_TABLES() OF_TABLE(CONFIG_CPU_IDLE, cpuidle_method)
 
+#ifdef CONFIG_EARLY_PLATFORM
+#define EARLY_PLATFORM_DRIVERS_TABLE()					\
+	. = ALIGN(8);							\
+	VMLINUX_SYMBOL(__early_platform_drivers_table) = .;		\
+	KEEP(*(__early_platform_drivers_table))				\
+	VMLINUX_SYMBOL(__early_platform_drivers_table_end) = .;
+#else
+#define EARLY_PLATFORM_DRIVERS_TABLE()
+#endif
+
 #ifdef CONFIG_ACPI
 #define ACPI_PROBE_TABLE(name)						\
 	. = ALIGN(8);							\
@@ -593,6 +603,7 @@
 	RESERVEDMEM_OF_TABLES()						\
 	TIMER_OF_TABLES()						\
 	IOMMU_OF_TABLES()						\
+	EARLY_PLATFORM_DRIVERS_TABLE()					\
 	CPU_METHOD_OF_TABLES()						\
 	CPUIDLE_METHOD_OF_TABLES()					\
 	KERNEL_DTB()							\
-- 
2.17.0
