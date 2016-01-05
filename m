Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g9t5008.houston.hp.com ([15.240.92.66]:48736 "EHLO
	g9t5008.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbcAESzm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 5 Jan 2016 13:55:42 -0500
From: Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH v3 11/17] arm/samsung: Change s3c_pm_run_res() to use System RAM type
Date: Tue,  5 Jan 2016 11:54:35 -0700
Message-ID: <1452020081-26534-11-git-send-email-toshi.kani@hpe.com>
In-Reply-To: <1452020081-26534-1-git-send-email-toshi.kani@hpe.com>
References: <1452020081-26534-1-git-send-email-toshi.kani@hpe.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org, bp@alien8.de
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Toshi Kani <toshi.kani@hpe.com>
Message-ID: <20160105185435.ZFmOoalOayqor81-p7dUyxXHXwEwOcP4E-wyIb_8hbg@z>

Change s3c_pm_run_res() to check with IORESOURCE_SYSTEM_RAM,
instead of strcmp() with "System RAM", to walk through
System RAM ranges in the iomem table.

No functional change is made to the interface.

Cc: linux-samsung-soc@vger.kernel.org
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
---
 arch/arm/plat-samsung/pm-check.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-samsung/pm-check.c b/arch/arm/plat-samsung/pm-check.c
index 04aff2c..70f2f69 100644
--- a/arch/arm/plat-samsung/pm-check.c
+++ b/arch/arm/plat-samsung/pm-check.c
@@ -53,8 +53,8 @@ static void s3c_pm_run_res(struct resource *ptr, run_fn_t fn, u32 *arg)
 		if (ptr->child != NULL)
 			s3c_pm_run_res(ptr->child, fn, arg);
 
-		if ((ptr->flags & IORESOURCE_MEM) &&
-		    strcmp(ptr->name, "System RAM") == 0) {
+		if ((ptr->flags & IORESOURCE_SYSTEM_RAM)
+				== IORESOURCE_SYSTEM_RAM) {
 			S3C_PMDBG("Found system RAM at %08lx..%08lx\n",
 				  (unsigned long)ptr->start,
 				  (unsigned long)ptr->end);
