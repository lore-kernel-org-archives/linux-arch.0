From: Alex Chiang <achiang@hp.com>
Subject: [PATCH 09/14] [SH] Populate cpu_enabled_map
Date: Mon, 14 Jul 2008 20:34:30 -0600
Message-ID: <20080715023430.2528.48009.stgit@blender.achiang>
References: <20080715023344.2528.1836.stgit@blender.achiang>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20080715023344.2528.1836.stgit@blender.achiang>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Alex Chiang <achiang@hp.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-arch.vger.kernel.org

Populate the cpu_enabled_map correctly.

Note that this patch does not actually make any decisions based
on the contents of the map.

However, as the map is presented via sysfs in:

	/sys/devices/system/cpu/

It should be populated correctly.

Signed-off-by: Alex Chiang <achiang@hp.com>
Cc: Paul Mundt <lethal@linux-sh.org>
---

 arch/sh/kernel/smp.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/smp.c b/arch/sh/kernel/smp.c
index 5d039d1..b91fdfa 100644
--- a/arch/sh/kernel/smp.c
+++ b/arch/sh/kernel/smp.c
@@ -60,6 +60,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 
 #ifndef CONFIG_HOTPLUG_CPU
 	cpu_present_map = cpu_possible_map;
+	cpu_enabled_map = cpu_possible_map;
 #endif
 }
 

