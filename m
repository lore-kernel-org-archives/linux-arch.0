From: Qian Cai <cai@lca.pw>
Subject: [PATCH v2] asm-generic: fix variable 'p4d' set but not used
Date: Tue,  6 Aug 2019 19:29:17 -0400
Message-ID: <20190806232917.881-1-cai@lca.pw>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: arnd@arndb.de, kirill.shutemov@linux.intel.com, mhocko@suse.com, jgg@ziepe.ca, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
List-Id: linux-arch.vger.kernel.org

A compiler throws a warning on an arm64 system since the
commit 9849a5697d3d ("arch, mm: convert all architectures to use
5level-fixup.h"),

mm/kasan/init.c: In function 'kasan_free_p4d':
mm/kasan/init.c:344:9: warning: variable 'p4d' set but not used
[-Wunused-but-set-variable]
 p4d_t *p4d;
        ^~~

because p4d_none() in "5level-fixup.h" is compiled away while it is a
static inline function in "pgtable-nopud.h". However, if converted
p4d_none() to a static inline there, powerpc would be unhappy as it
reads those in assembler language in
"arch/powerpc/include/asm/book3s/64/pgtable.h", so it needs to skip
assembly include for the static inline C function. While at it,
converted a few similar functions to be consistent with the ones in
"pgtable-nopud.h".

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: Convert them to static inline functions.

 include/asm-generic/5level-fixup.h | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/5level-fixup.h b/include/asm-generic/5level-fixup.h
index bb6cb347018c..f6947da70d71 100644
--- a/include/asm-generic/5level-fixup.h
+++ b/include/asm-generic/5level-fixup.h
@@ -19,9 +19,24 @@
 
 #define p4d_alloc(mm, pgd, address)	(pgd)
 #define p4d_offset(pgd, start)		(pgd)
-#define p4d_none(p4d)			0
-#define p4d_bad(p4d)			0
-#define p4d_present(p4d)		1
+
+#ifndef __ASSEMBLY__
+static inline int p4d_none(p4d_t p4d)
+{
+	return 0;
+}
+
+static inline int p4d_bad(p4d_t p4d)
+{
+	return 0;
+}
+
+static inline int p4d_present(p4d_t p4d)
+{
+	return 1;
+}
+#endif
+
 #define p4d_ERROR(p4d)			do { } while (0)
 #define p4d_clear(p4d)			pgd_clear(p4d)
 #define p4d_val(p4d)			pgd_val(p4d)
-- 
2.20.1 (Apple Git-117)
