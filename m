From: Steve Capper <steve.capper@linaro.org>
Subject: [RFC PATCH v2 10/11] ARM64: mm: Raise MAX_ORDER for 64KB pages and THP.
Date: Wed,  8 May 2013 10:52:42 +0100
Message-ID: <1368006763-30774-11-git-send-email-steve.capper@linaro.org>
References: <1368006763-30774-1-git-send-email-steve.capper@linaro.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:45213 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754058Ab3EHJxY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 May 2013 05:53:24 -0400
Received: by mail-we0-f169.google.com with SMTP id x54so1614477wes.0
        for <linux-arch@vger.kernel.org>; Wed, 08 May 2013 02:53:23 -0700 (PDT)
In-Reply-To: <1368006763-30774-1-git-send-email-steve.capper@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Michal Hocko <mhocko@suse.cz>, Ken Chen <kenchen@google.com>, Mel Gorman <mgorman@suse.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, patches@linaro.org, Steve Capper <steve.capper@linaro.org>

The buddy allocator has a default MAX_ORDER of 11, which is too
low to allocate enough memory for 512MB Transparent HugePages if
our base page size is 64KB.

This patch introduces MAX_ZONE_ORDER and sets it to 14 when 64KB
pages are used in conjuction with THP, otherwise the default value
of 11 is used.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm64/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 053533b..a5f76cf 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -196,6 +196,11 @@ config ARCH_WANT_HUGE_PMD_SHARE
 
 source "mm/Kconfig"
 
+config FORCE_MAX_ZONEORDER
+	int
+	default "14" if (ARM64_64K_PAGES && TRANSPARENT_HUGEPAGE)
+	default "11"
+
 endmenu
 
 menu "Boot options"
-- 
1.8.1.4
