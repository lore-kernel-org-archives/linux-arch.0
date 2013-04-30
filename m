Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:36681 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932455Ab3D3QbU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 30 Apr 2013 12:31:20 -0400
Received: by mail-wi0-f174.google.com with SMTP id m6so4135412wiv.1
        for <linux-arch@vger.kernel.org>; Tue, 30 Apr 2013 09:31:18 -0700 (PDT)
From: Steve Capper <steve.capper@linaro.org>
Subject: [RFC PATCH 8/9] ARM64: mm: Introduce MAX_ZONE_ORDER for 64K and THP.
Date: Tue, 30 Apr 2013 17:30:47 +0100
Message-ID: <1367339448-21727-9-git-send-email-steve.capper@linaro.org>
In-Reply-To: <1367339448-21727-1-git-send-email-steve.capper@linaro.org>
References: <1367339448-21727-1-git-send-email-steve.capper@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Michal Hocko <mhocko@suse.cz>, Ken Chen <kenchen@google.com>, Mel Gorman <mgorman@suse.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Steve Capper <steve.capper@linaro.org>
Message-ID: <20130430163047.-TbWr3UGc9bzxkoMtylflHoRa2DiH6OLEzoXn4Mxy-s@z>

The buddy allocator has a default order of 11, which is too low to
allocate enough memory for 512MB Transparent HugePages if our base
page size is 64K. For any order less than 13, the combination of
THP with 64K pages will cause a compile error.

This patch introduces the MAX_ZONE_ORDER config option that allows
one to explicitly override the order of the buddy allocator. If
64K pages and THP are enabled the minimum value is set to 13.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm64/Kconfig | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 16aa780..908fd95 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -196,6 +196,23 @@ config ARCH_WANT_HUGE_PMD_SHARE
 
 source "mm/Kconfig"
 
+config FORCE_MAX_ZONEORDER
+	int "Maximum zone order"
+	range 11 64 if !(ARM64_64K_PAGES && TRANSPARENT_HUGEPAGE)
+	range 13 64 if ARM64_64K_PAGES && TRANSPARENT_HUGEPAGE
+	default "11" if !(ARM64_64K_PAGES && TRANSPARENT_HUGEPAGE)
+	default "13" if (ARM64_64K_PAGES && TRANSPARENT_HUGEPAGE)
+	help
+	  The kernel memory allocator divides physically contiguous memory
+	  blocks into "zones", where each zone is a power of two number of
+	  pages.  This option selects the largest power of two that the kernel
+	  keeps in the memory allocator.  If you need to allocate very large
+	  blocks of physically contiguous memory, then you may need to
+	  increase this value.
+
+	  This config option is actually maximum order plus one. For example,
+	  a value of 11 means that the largest free memory block is 2^10 pages.
+
 endmenu
 
 menu "Boot options"
-- 
1.8.1.4

