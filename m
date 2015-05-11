From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: [PATCH v1 07/15] drm/i915: use pagefault_disabled() to check for disabled pagefaults
Date: Mon, 11 May 2015 17:52:12 +0200
Message-ID: <1431359540-32227-8-git-send-email-dahi@linux.vnet.ibm.com>
References: <1431359540-32227-1-git-send-email-dahi@linux.vnet.ibm.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1431359540-32227-1-git-send-email-dahi@linux.vnet.ibm.com>
Sender: owner-linux-mm@kvack.org
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, yang.shi@windriver.com, bigeasy@linutronix.de, benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, tglx@linutronix.de, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz, ralf@linux-mips.org, herbert@gondor.apana.org.au, linux@arm.linux.org.uk, airlied@linux.ie, daniel.vetter@intel.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, peterz@infradead.org, dahi@linux.vnet.ibm.com
List-Id: linux-arch.vger.kernel.org

Now that the pagefault disabled counter is in place, we can replace
the in_atomic() check by a pagefault_disabled() checks.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
---
 drivers/gpu/drm/i915/i915_gem_execbuffer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/i915_gem_execbuffer.c
index 560c79a..cfed3dd 100644
--- a/drivers/gpu/drm/i915/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/i915_gem_execbuffer.c
@@ -32,6 +32,7 @@
 #include "i915_trace.h"
 #include "intel_drv.h"
 #include <linux/dma_remapping.h>
+#include <linux/uaccess.h>
 
 #define  __EXEC_OBJECT_HAS_PIN (1<<31)
 #define  __EXEC_OBJECT_HAS_FENCE (1<<30)
@@ -458,7 +459,7 @@ i915_gem_execbuffer_relocate_entry(struct drm_i915_gem_object *obj,
 	}
 
 	/* We can't wait for rendering with pagefaults disabled */
-	if (obj->active && in_atomic())
+	if (obj->active && pagefault_disabled())
 		return -EFAULT;
 
 	if (use_cpu_reloc(obj))
-- 
2.1.4

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
