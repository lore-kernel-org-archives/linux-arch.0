Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36451 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837AbcD1NYQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 28 Apr 2016 09:24:16 -0400
From: Michal Hocko <mhocko@kernel.org>
Subject: [PATCH 03/20] x86/efi: get rid of superfluous __GFP_REPEAT
Date: Thu, 28 Apr 2016 15:23:49 +0200
Message-ID: <1461849846-27209-4-git-send-email-mhocko@kernel.org>
In-Reply-To: <1461849846-27209-1-git-send-email-mhocko@kernel.org>
References: <1461849846-27209-1-git-send-email-mhocko@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>, linux-arch@vger.kernel.org, Matt Fleming <matt@codeblueprint.co.uk>
Message-ID: <20160428132349._TL1hNtF_IePcPdhKhR9lklYRpxiI7_UTPdefL2dqkw@z>

From: Michal Hocko <mhocko@suse.com>

__GFP_REPEAT has a rather weak semantic but since it has been introduced
around 2.6.12 it has been ignored for low order allocations.

efi_alloc_page_tables uses __GFP_REPEAT but it allocates an order-0
page. This means that this flag has never been actually useful here
because it has always been used only for PAGE_ALLOC_COSTLY requests.

Cc: linux-arch@vger.kernel.org
Acked-by: Matt Fleming <matt@codeblueprint.co.uk>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 arch/x86/platform/efi/efi_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 49e4dd4a1f58..a7ee3f08074f 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -141,7 +141,7 @@ int __init efi_alloc_page_tables(void)
 	if (efi_enabled(EFI_OLD_MEMMAP))
 		return 0;
 
-	gfp_mask = GFP_KERNEL | __GFP_NOTRACK | __GFP_REPEAT | __GFP_ZERO;
+	gfp_mask = GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO;
 	efi_pgd = (pgd_t *)__get_free_page(gfp_mask);
 	if (!efi_pgd)
 		return -ENOMEM;
-- 
2.8.0.rc3

