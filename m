From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v3 2/2] mm: provide a fallback for PAGE_KERNEL_EXEC for architectures
Date: Thu, 10 May 2018 11:55:07 -0700
Message-ID: <20180510185507.2439-3-mcgrof@kernel.org>
References: <20180510185507.2439-1-mcgrof@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180510185507.2439-1-mcgrof@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: gregkh@linuxfoundation.org, willy@infradead.org, geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>
List-Id: linux-arch.vger.kernel.org

Some architectures just don't have PAGE_KERNEL_EXEC. The mm/nommu.c
and mm/vmalloc.c code have been using PAGE_KERNEL as a fallback for
years. Move this fallback to asm-generic.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 include/asm-generic/pgtable.h | 4 ++++
 mm/nommu.c                    | 4 ----
 mm/vmalloc.c                  | 4 ----
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 4e310e543fc8..81371468ed5a 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -1097,6 +1097,10 @@ static inline void init_espfix_bsp(void) { }
 # define PAGE_KERNEL_RO PAGE_KERNEL
 #endif
 
+#ifndef PAGE_KERNEL_EXEC
+# define PAGE_KERNEL_EXEC PAGE_KERNEL
+#endif
+
 #endif /* !__ASSEMBLY__ */
 
 #ifndef io_remap_pfn_range
diff --git a/mm/nommu.c b/mm/nommu.c
index 13723736d38f..08ad4dcd281d 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -364,10 +364,6 @@ void *vzalloc_node(unsigned long size, int node)
 }
 EXPORT_SYMBOL(vzalloc_node);
 
-#ifndef PAGE_KERNEL_EXEC
-# define PAGE_KERNEL_EXEC PAGE_KERNEL
-#endif
-
 /**
  *	vmalloc_exec  -  allocate virtually contiguous, executable memory
  *	@size:		allocation size
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ebff729cc956..89543d13e32a 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1920,10 +1920,6 @@ void *vzalloc_node(unsigned long size, int node)
 }
 EXPORT_SYMBOL(vzalloc_node);
 
-#ifndef PAGE_KERNEL_EXEC
-# define PAGE_KERNEL_EXEC PAGE_KERNEL
-#endif
-
 /**
  *	vmalloc_exec  -  allocate virtually contiguous, executable memory
  *	@size:		allocation size
-- 
2.17.0
