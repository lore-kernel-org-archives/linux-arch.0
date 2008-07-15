From: Alex Chiang <achiang@hp.com>
Subject: [PATCH 04/14] [ARM] Populate cpu_enabled_map
Date: Mon, 14 Jul 2008 20:34:05 -0600
Message-ID: <20080715023405.2528.34106.stgit@blender.achiang>
References: <20080715023344.2528.1836.stgit@blender.achiang>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20080715023344.2528.1836.stgit@blender.achiang>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Alex Chiang <achiang@hp.com>, Catalin Marinas <catalin.marinas@arm.com>, Russell King <rmk@dyn-67.arm.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

Populate the cpu_enabled_map correctly.

Note that this patch does not actually make any decisions based
on the contents of the map.

However, as the map is presented via sysfs in:

	/sys/devices/system/cpu/

It should be populated correctly.

Signed-off-by: Alex Chiang <achiang@hp.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <rmk@dyn-67.arm.linux.org.uk>
---

 arch/arm/mach-realview/platsmp.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-realview/platsmp.c b/arch/arm/mach-realview/platsmp.c
index 8e813ed..c33f298 100644
--- a/arch/arm/mach-realview/platsmp.c
+++ b/arch/arm/mach-realview/platsmp.c
@@ -241,8 +241,10 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	 * Initialise the present map, which describes the set of CPUs
 	 * actually populated at the present time.
 	 */
-	for (i = 0; i < max_cpus; i++)
+	for (i = 0; i < max_cpus; i++) {
 		cpu_set(i, cpu_present_map);
+		cpu_set(i, cpu_enabled_map);
+	}
 
 	/*
 	 * Initialise the SCU if there are more than one CPU and let

