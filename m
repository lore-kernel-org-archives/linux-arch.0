From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 3/3] arch: move common mmap flags to linux/mman.h
Date: Fri, 8 Feb 2019 01:03:00 -0500
Message-ID: <20190124142448.23243-5-mst@redhat.com>
References: <20190124142448.23243-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190124142448.23243-1-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-xtensa@linux-xtensa.org
List-Id: linux-arch.vger.kernel.org

Now that we have 3 mmap flags shared by all architectures,
let's move them into the common header.

This will help discourage future architectures from duplicating code.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/alpha/include/uapi/asm/mman.h     | 4 +---
 arch/mips/include/uapi/asm/mman.h      | 4 +---
 arch/parisc/include/uapi/asm/mman.h    | 4 +---
 arch/xtensa/include/uapi/asm/mman.h    | 4 +---
 include/uapi/asm-generic/mman-common.h | 4 +---
 include/uapi/linux/mman.h              | 4 ++++
 6 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
index f9d4e6b6d4bd..ac23379b7a87 100644
--- a/arch/alpha/include/uapi/asm/mman.h
+++ b/arch/alpha/include/uapi/asm/mman.h
@@ -10,9 +10,7 @@
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
 
-#define MAP_SHARED	0x01		/* Share changes */
-#define MAP_PRIVATE	0x02		/* Changes are private */
-#define MAP_SHARED_VALIDATE 0x03	/* share + validate extension flags */
+/* 0x01 - 0x03 are defined in linux/mman.h */
 #define MAP_TYPE	0x0f		/* Mask for type of mapping (OSF/1 is _wrong_) */
 #define MAP_FIXED	0x100		/* Interpret addr exactly */
 #define MAP_ANONYMOUS	0x10		/* don't use a file */
diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/asm/mman.h
index 3035ca499cd8..c2b40969eb1f 100644
--- a/arch/mips/include/uapi/asm/mman.h
+++ b/arch/mips/include/uapi/asm/mman.h
@@ -27,9 +27,7 @@
 /*
  * Flags for mmap
  */
-#define MAP_SHARED	0x001		/* Share changes */
-#define MAP_PRIVATE	0x002		/* Changes are private */
-#define MAP_SHARED_VALIDATE 0x003	/* share + validate extension flags */
+/* 0x01 - 0x03 are defined in linux/mman.h */
 #define MAP_TYPE	0x00f		/* Mask for type of mapping */
 #define MAP_FIXED	0x010		/* Interpret addr exactly */
 
diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi/asm/mman.h
index 870fbf8c7088..c98162f494db 100644
--- a/arch/parisc/include/uapi/asm/mman.h
+++ b/arch/parisc/include/uapi/asm/mman.h
@@ -10,9 +10,7 @@
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
 
-#define MAP_SHARED	0x01		/* Share changes */
-#define MAP_PRIVATE	0x02		/* Changes are private */
-#define MAP_SHARED_VALIDATE 0x03	/* share + validate extension flags */
+/* 0x01 - 0x03 are defined in linux/mman.h */
 #define MAP_TYPE	0x2b		/* Mask for type of mapping, includes bits 0x08 and 0x20 */
 #define MAP_FIXED	0x04		/* Interpret addr exactly */
 #define MAP_ANONYMOUS	0x10		/* don't use a file */
diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/uapi/asm/mman.h
index 58f29a9d895d..be726062412b 100644
--- a/arch/xtensa/include/uapi/asm/mman.h
+++ b/arch/xtensa/include/uapi/asm/mman.h
@@ -34,9 +34,7 @@
 /*
  * Flags for mmap
  */
-#define MAP_SHARED	0x001		/* Share changes */
-#define MAP_PRIVATE	0x002		/* Changes are private */
-#define MAP_SHARED_VALIDATE 0x003	/* share + validate extension flags */
+/* 0x01 - 0x03 are defined in linux/mman.h */
 #define MAP_TYPE	0x00f		/* Mask for type of mapping */
 #define MAP_FIXED	0x010		/* Interpret addr exactly */
 
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index e7ee32861d51..abd238d0f7a4 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -15,9 +15,7 @@
 #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
 #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */
 
-#define MAP_SHARED	0x01		/* Share changes */
-#define MAP_PRIVATE	0x02		/* Changes are private */
-#define MAP_SHARED_VALIDATE 0x03	/* share + validate extension flags */
+/* 0x01 - 0x03 are defined in linux/mman.h */
 #define MAP_TYPE	0x0f		/* Mask for type of mapping */
 #define MAP_FIXED	0x10		/* Interpret addr exactly */
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
index d0f515d53299..fc1a64c3447b 100644
--- a/include/uapi/linux/mman.h
+++ b/include/uapi/linux/mman.h
@@ -12,6 +12,10 @@
 #define OVERCOMMIT_ALWAYS		1
 #define OVERCOMMIT_NEVER		2
 
+#define MAP_SHARED	0x01		/* Share changes */
+#define MAP_PRIVATE	0x02		/* Changes are private */
+#define MAP_SHARED_VALIDATE 0x03	/* share + validate extension flags */
+
 /*
  * Huge page size encoding when MAP_HUGETLB is specified, and a huge page
  * size other than the default is desired.  See hugetlb_encode.h.
-- 
MST
