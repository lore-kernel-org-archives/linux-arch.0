Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g9t5008.houston.hp.com ([15.240.92.66]:59249 "EHLO
	g9t5008.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932790AbbLNXhy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Dec 2015 18:37:54 -0500
From: Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH 03/11] x86/e820: Set IORESOURCE_SYSTEM_RAM to System RAM
Date: Mon, 14 Dec 2015 16:37:18 -0700
Message-ID: <1450136246-17053-3-git-send-email-toshi.kani@hpe.com>
In-Reply-To: <1450136246-17053-1-git-send-email-toshi.kani@hpe.com>
References: <1450136246-17053-1-git-send-email-toshi.kani@hpe.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org, bp@alien8.de
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org, Toshi Kani <toshi.kani@hpe.com>
Message-ID: <20151214233718.q3XxjFAMfqHwVkySdFiqGbJGj5LayiqabPMzA0SZcwg@z>

Change e820_reserve_resources() to set IORESOURCE_SYSTEM_RAM for
E820_RESERVED_KERN and E820_RAM, which are set to "System RAM".

Also set IORESOURCE_SYSTEM_RAM to "Kernel data", "Kernel code",
and "Kernel bss", which are children nodes of System RAM.

Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
---
 arch/x86/kernel/e820.c  |   18 +++++++++++++++++-
 arch/x86/kernel/setup.c |    6 +++---
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 569c1e4..4c8bcbc 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -925,6 +925,22 @@ static const char *e820_type_to_string(int e820_type)
 	}
 }
 
+static int e820_type_to_iomem_type(int e820_type)
+{
+	switch (e820_type) {
+	case E820_RESERVED_KERN:
+	case E820_RAM:
+		return IORESOURCE_SYSTEM_RAM;
+	case E820_ACPI:
+	case E820_NVS:
+	case E820_UNUSABLE:
+	case E820_PRAM:
+	case E820_PMEM:
+	default:
+		return IORESOURCE_MEM;
+	}
+}
+
 static bool do_mark_busy(u32 type, struct resource *res)
 {
 	/* this is the legacy bios/dos rom-shadow + mmio region */
@@ -967,7 +983,7 @@ void __init e820_reserve_resources(void)
 		res->start = e820.map[i].addr;
 		res->end = end;
 
-		res->flags = IORESOURCE_MEM;
+		res->flags = e820_type_to_iomem_type(e820.map[i].type);
 
 		/*
 		 * don't register the region that could be conflicted with
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index d2bbe34..a492c30 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -152,21 +152,21 @@ static struct resource data_resource = {
 	.name	= "Kernel data",
 	.start	= 0,
 	.end	= 0,
-	.flags	= IORESOURCE_BUSY | IORESOURCE_MEM
+	.flags	= IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM
 };
 
 static struct resource code_resource = {
 	.name	= "Kernel code",
 	.start	= 0,
 	.end	= 0,
-	.flags	= IORESOURCE_BUSY | IORESOURCE_MEM
+	.flags	= IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM
 };
 
 static struct resource bss_resource = {
 	.name	= "Kernel bss",
 	.start	= 0,
 	.end	= 0,
-	.flags	= IORESOURCE_BUSY | IORESOURCE_MEM
+	.flags	= IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM
 };
 
 
