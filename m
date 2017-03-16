From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 6/7] mm/gup: Provide hook to check if __GUP_fast() is allowed for the range
Date: Thu, 16 Mar 2017 18:26:54 +0300
Message-ID: <20170316152655.37789-7-kirill.shutemov@linux.intel.com>
References: <20170316152655.37789-1-kirill.shutemov@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170316152655.37789-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Steve Capper <steve.capper@linaro.org>, Dann Frazier <dann.frazier@canonical.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

This is preparation patch for transition of x86 to generic GUP_fast()
implementation.

On x86, get_user_pages_fast() does few sanity checks to see if we can
call __get_user_pages_fast() for the range.

Wrapping protection should be useful for generic code too.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/gup.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index e04f76594eb9..a6e21380c8b0 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1600,6 +1600,21 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	return nr;
 }
 
+#ifndef gup_fast_permitted
+/*
+ * Check if it's allowed to use __get_user_pages_fast() for the range or
+ * need to fallback to non-fast version.
+ */
+bool gup_fast_permitted(unsigned long start, int nr_pages, int write)
+{
+	unsigned long len, end;
+
+	len = (unsigned long) nr_pages << PAGE_SHIFT;
+	end = start + len;
+	return end >= start;
+}
+#endif
+
 /**
  * get_user_pages_fast() - pin user pages in memory
  * @start:	starting user address
@@ -1619,11 +1634,14 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 			struct page **pages)
 {
-	int nr, ret;
+	int nr = 0, ret = 0;
 
 	start &= PAGE_MASK;
-	nr = __get_user_pages_fast(start, nr_pages, write, pages);
-	ret = nr;
+
+	if (gup_fast_permitted(start, nr_pages, write)) {
+		nr = __get_user_pages_fast(start, nr_pages, write, pages);
+		ret = nr;
+	}
 
 	if (nr < nr_pages) {
 		/* Try to get the remaining pages with get_user_pages */
-- 
2.11.0
