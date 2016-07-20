From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v4 01/12] mm: Add is_migrate_cma_page
Date: Wed, 20 Jul 2016 13:26:56 -0700
Message-ID: <1469046427-12696-2-git-send-email-keescook@chromium.org>
References: <1469046427-12696-1-git-send-email-keescook@chromium.org>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1469046427-12696-1-git-send-email-keescook@chromium.org>
Sender: owner-linux-mm@kvack.org
To: kernel-hardening@lists.openwall.com
Cc: Kees Cook <keescook@chromium.org>, Laura Abbott <labbott@redhat.com>, Laura Abbott <labbott@fedoraproject.org>, Balbir Singh <bsingharora@gmail.com>, Daniel Micay <danielmicay@gmail.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Rik van Riel <riel@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, PaX Team <pageexec@freemail.hu>, Brad Spengler <spender@grsecurity.net>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, "David S. Miller" <davem@davemloft.net>, x86@kernel.org, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjo>
List-Id: linux-arch.vger.kernel.org

From: Laura Abbott <labbott@redhat.com>

Code such as hardened user copy[1] needs a way to tell if a
page is CMA or not. Add is_migrate_cma_page in a similar way
to is_migrate_isolate_page.

[1]http://article.gmane.org/gmane.linux.kernel.mm/155238

Signed-off-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/mmzone.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 02069c23486d..c8478b29f070 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -68,8 +68,10 @@ extern char * const migratetype_names[MIGRATE_TYPES];
 
 #ifdef CONFIG_CMA
 #  define is_migrate_cma(migratetype) unlikely((migratetype) == MIGRATE_CMA)
+#  define is_migrate_cma_page(_page) (get_pageblock_migratetype(_page) == MIGRATE_CMA)
 #else
 #  define is_migrate_cma(migratetype) false
+#  define is_migrate_cma_page(_page) false
 #endif
 
 #define for_each_migratetype_order(order, type) \
-- 
2.7.4

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
