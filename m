From: Mike Rapoport <rppt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/6] mmap: make mlock_future_check() global
Date: Mon, 20 Jul 2020 12:24:31 +0300
Message-ID: <20200720092435.17469-3-rppt@kernel.org>
References: <20200720092435.17469-1-rppt@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200720092435.17469-1-rppt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Alexander Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Christopher Lameter <cl-vYTEC60ixJUAvxtiuMwx3w@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dave Hansen <dave.hansen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Elena Reshetova <elena.reshetova-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Idan Yaniv <idan.yaniv-qyM6JfAXOaQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, James Bottomley <jejb-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, "Kirill A. Shutemov" <kirill-oKw7cIdHH8eLwutG50LtGA@public.gmane.org>, Matthew Wilcox <willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Mike Rapoport <rppt-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, Mike Rapoport <rppt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Palmer Dabbelt <palmer-96lFi9zoCfxBDgjK7y7TUQ@public.gmane.org>, Paul Walmsley <paul.walmsley-SpMDHPYPyPbQT0dZR+AlfA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

From: Mike Rapoport <rppt-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>

It will be used by the upcoming secret memory implementation.

Signed-off-by: Mike Rapoport <rppt-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
---
 mm/internal.h | 3 +++
 mm/mmap.c     | 5 ++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 9886db20d94f..af0a92f8f6bc 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -349,6 +349,9 @@ static inline void munlock_vma_pages_all(struct vm_area_struct *vma)
 extern void mlock_vma_page(struct page *page);
 extern unsigned int munlock_vma_page(struct page *page);
 
+extern int mlock_future_check(struct mm_struct *mm, unsigned long flags,
+			      unsigned long len);
+
 /*
  * Clear the page's PageMlocked().  This can be useful in a situation where
  * we want to unconditionally remove a page from the pagecache -- e.g.,
diff --git a/mm/mmap.c b/mm/mmap.c
index 59a4682ebf3f..4dd40a4fedfb 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1310,9 +1310,8 @@ static inline unsigned long round_hint_to_min(unsigned long hint)
 	return hint;
 }
 
-static inline int mlock_future_check(struct mm_struct *mm,
-				     unsigned long flags,
-				     unsigned long len)
+int mlock_future_check(struct mm_struct *mm, unsigned long flags,
+		       unsigned long len)
 {
 	unsigned long locked, lock_limit;
 
-- 
2.26.2
