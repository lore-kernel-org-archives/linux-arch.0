From: Michal Hocko <mhocko@kernel.org>
Subject: [PATCH 03/19] x86/efi: get rid of superfluous __GFP_REPEAT
Date: Mon, 11 Apr 2016 13:07:56 +0200
Message-ID: <1460372892-8157-4-git-send-email-mhocko@kernel.org>
References: <1460372892-8157-1-git-send-email-mhocko@kernel.org>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1460372892-8157-1-git-send-email-mhocko@kernel.org>
Sender: owner-linux-mm@kvack.org
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>, Matt Fleming <matt@codeblueprint.co.uk>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

__GFP_REPEAT has a rather weak semantic but since it has been introduced
around 2.6.12 it has been ignored for low order allocations.

efi_alloc_page_tables uses __GFP_REPEAT but it allocates an order-0
page. This means that this flag has never been actually useful here
because it has always been used only for PAGE_ALLOC_COSTLY requests.

Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: linux-arch@vger.kernel.org
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

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
