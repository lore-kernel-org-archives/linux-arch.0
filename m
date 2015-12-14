Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g4t3425.houston.hp.com ([15.201.208.53]:34244 "EHLO
	g4t3425.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932990AbbLNXiR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Dec 2015 18:38:17 -0500
From: Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH 11/11] ACPI/EINJ: Allow memory error injection to NVDIMM
Date: Mon, 14 Dec 2015 16:37:26 -0700
Message-ID: <1450136246-17053-11-git-send-email-toshi.kani@hpe.com>
In-Reply-To: <1450136246-17053-1-git-send-email-toshi.kani@hpe.com>
References: <1450136246-17053-1-git-send-email-toshi.kani@hpe.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org, bp@alien8.de
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Vishal Verma <vishal.l.verma@intel.com>, linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org, Toshi Kani <toshi.kani@hpe.com>
Message-ID: <20151214233726.oHXrs10Kjmp7IUzCCDB2Iefrx-NxV2RrKXRYyMCHHZM@z>

In the case of memory error injection, einj_error_inject() checks
if a target address is System RAM.  Change this check to allow
injecting a memory error to NVDIMM by calling region_intersects()
with "Persistent Memory".  This enables memory error testing on
both System RAM and NVDIMM.

In addition, page_is_ram() is replaced with region_intersects()
with IORESOURCE_SYSTEM_RAM, so that it can verify a target address
range with the requested size.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: linux-nvdimm@lists.01.org
Cc: linux-acpi@vger.kernel.org
Acked-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
---
 drivers/acpi/apei/einj.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 0431883..cad6fd7 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -519,7 +519,7 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 			     u64 param3, u64 param4)
 {
 	int rc;
-	unsigned long pfn;
+	u64 base_addr, size;
 
 	/* If user manually set "flags", make sure it is legal */
 	if (flags && (flags &
@@ -545,10 +545,17 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	/*
 	 * Disallow crazy address masks that give BIOS leeway to pick
 	 * injection address almost anywhere. Insist on page or
-	 * better granularity and that target address is normal RAM.
+	 * better granularity and that target address is normal RAM or
+	 * NVDIMM.
 	 */
-	pfn = PFN_DOWN(param1 & param2);
-	if (!page_is_ram(pfn) || ((param2 & PAGE_MASK) != PAGE_MASK))
+	base_addr = param1 & param2;
+	size = ~param2 + 1;
+
+	if (((param2 & PAGE_MASK) != PAGE_MASK) ||
+	    ((region_intersects(base_addr, size, IORESOURCE_SYSTEM_RAM,
+				NULL) != REGION_INTERSECTS) &&
+	     (region_intersects(base_addr, size, IORESOURCE_MEM,
+				"Persistent Memory") != REGION_INTERSECTS)))
 		return -EINVAL;
 
 inject:
