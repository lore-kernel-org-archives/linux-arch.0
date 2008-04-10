From: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 6/8] frv: add new unaligned API support
Date: Thu, 10 Apr 2008 12:44:09 -0700
Message-ID: <1207856649.22001.30.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Naive movement of inline asm from existing unaligned API to include
the new unaligned helpers.

Signed-off-by: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 include/asm-frv/unaligned.h |  360 +++++++++++++++++++++++++------------------
 1 files changed, 212 insertions(+), 148 deletions(-)

diff --git a/include/asm-frv/unaligned.h b/include/asm-frv/unaligned.h
index dc8e9c9..06224d9 100644
--- a/include/asm-frv/unaligned.h
+++ b/include/asm-frv/unaligned.h
@@ -9,9 +9,175 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#ifndef _ASM_UNALIGNED_H
-#define _ASM_UNALIGNED_H
+#ifndef _ASM_FRV_UNALIGNED_H
+#define _ASM_FRV_UNALIGNED_H
 
+#include <linux/unaligned/little_endian.h>
+
+static inline u16 get_unaligned_le16(const __le16 *p)
+{
+	return __get_unaligned_le16((const u8 *)p);
+}
+
+static inline u32 get_unaligned_le32(const __le32 *p)
+{
+	return __get_unaligned_le32((const u8 *)p);
+}
+
+static inline u64 get_unaligned_le64(const __le64 *p)
+{
+	return __get_unaligned_le64((const u8 *)p);
+}
+
+static inline u16 get_unaligned_be16(const __be16 *p)
+{
+	u8 a;
+	u16 x;
+	const char *__p = (const char *)p;
+
+	asm("	ldub%I2		%M2,%0		\n"
+	    "	ldub%I3.p	%M3,%1		\n"
+	    "	slli		%0,#8,%0	\n"
+	    "	or		%0,%1,%0	\n"
+	    : "=&r"(x), "=&r"(a)
+	    : "m"(__p[0]),  "m"(__p[1])
+	    );
+
+	return x;
+}
+
+static inline u32 get_unaligned_be32(const __be32 *p)
+{
+	u8 a;
+	u32 x;
+	const char *__p = (const char *)p;
+
+	asm("	ldub%I2		%M2,%0		\n"
+	    "	ldub%I3.p	%M3,%1		\n"
+	    "	slli		%0,#8,%0	\n"
+	    "	or		%0,%1,%0	\n"
+	    "	ldub%I4.p	%M4,%1		\n"
+	    "	slli		%0,#8,%0	\n"
+	    "	or		%0,%1,%0	\n"
+	    "	ldub%I5.p	%M5,%1		\n"
+	    "	slli		%0,#8,%0	\n"
+	    "	or		%0,%1,%0	\n"
+	    : "=&r"(x), "=&r"(a)
+	    : "m"(__p[0]),  "m"(__p[1]), "m"(__p[2]), "m"(__p[3])
+	    );
+
+	return x;
+}
+
+static inline u64 get_unaligned_be64(const __be64 *p)
+{
+	u8 a;
+	u32 x;
+	const char *__p = (const char *)p;
+	union { u64 x; u32 y[2]; } z;
+
+	asm("	ldub%I3		%M3,%0		\n"
+	    "	ldub%I4.p	%M4,%2		\n"
+	    "	slli		%0,#8,%0	\n"
+	    "	or		%0,%2,%0	\n"
+	    "	ldub%I5.p	%M5,%2		\n"
+	    "	slli		%0,#8,%0	\n"
+	    "	or		%0,%2,%0	\n"
+	    "	ldub%I6.p	%M6,%2		\n"
+	    "	slli		%0,#8,%0	\n"
+	    "	or		%0,%2,%0	\n"
+	    "	ldub%I7		%M7,%1		\n"
+	    "	ldub%I8.p	%M8,%2		\n"
+	    "	slli		%1,#8,%1	\n"
+	    "	or		%1,%2,%1	\n"
+	    "	ldub%I9.p	%M9,%2		\n"
+	    "	slli		%1,#8,%1	\n"
+	    "	or		%1,%2,%1	\n"
+	    "	ldub%I10.p	%M10,%2		\n"
+	    "	slli		%1,#8,%1	\n"
+	    "	or		%1,%2,%1	\n"
+	    : "=&r"(z.y[0]), "=&r"(z.y[1]), "=&r"(a)
+	    : "m"(__p[0]), "m"(__p[1]), "m"(__p[2]), "m"(__p[3]),
+	      "m"(__p[4]), "m"(__p[5]), "m"(__p[6]), "m"(__p[7])
+	    );
+	x = z.x;
+
+	return x;
+}
+
+static inline void put_unaligned_le16(u16 val, void *p)
+{
+	__put_unaligned_le16(val, p);
+}
+
+static inline void put_unaligned_le32(u32 val, void *p)
+{
+	__put_unaligned_le32(val, p);
+}
+
+static inline void put_unaligned_le64(u64 val, void *p)
+{
+	__put_unaligned_le64(val, p);
+}
+
+static inline void put_unaligned_be16(u16 val, void *p)
+{
+	char *__p = p;
+	int x;
+
+	asm("	stb%I1.p	%0,%M1		\n"
+	    "	srli		%0,#8,%0	\n"
+	    "	stb%I2		%0,%M2		\n"
+	    : "=r"(x), "=m"(__p[1]),  "=m"(__p[0])
+	    : "0"(val)
+	    );
+}
+
+static inline void put_unaligned_be32(u32 val, void *p)
+{
+	char *__p = p;
+	int x;
+
+	asm("	stb%I1.p	%0,%M1		\n"
+	    "	srli		%0,#8,%0	\n"
+	    "	stb%I2.p	%0,%M2		\n"
+	    "	srli		%0,#8,%0	\n"
+	    "	stb%I3.p	%0,%M3		\n"
+	    "	srli		%0,#8,%0	\n"
+	    "	stb%I4		%0,%M4		\n"
+	    : "=r"(x), "=m"(__p[3]),  "=m"(__p[2]), "=m"(__p[1]), "=m"(__p[0])
+	    : "0"(val)
+	    );
+}
+
+static inline void put_unaligned_be64(u64 val, void *p)
+{
+	char *__p = p;
+	u32 __high, __low;
+
+	__high = val >> 32;
+	__low = val & 0xffffffff;
+	asm("	stb%I2.p	%0,%M2		\n"
+	    "	srli		%0,#8,%0	\n"
+	    "	stb%I3.p	%0,%M3		\n"
+	    "	srli		%0,#8,%0	\n"
+	    "	stb%I4.p	%0,%M4		\n"
+	    "	srli		%0,#8,%0	\n"
+	    "	stb%I5.p	%0,%M5		\n"
+	    "	srli		%0,#8,%0	\n"
+	    "	stb%I6.p	%1,%M6		\n"
+	    "	srli		%1,#8,%1	\n"
+	    "	stb%I7.p	%1,%M7		\n"
+	    "	srli		%1,#8,%1	\n"
+	    "	stb%I8.p	%1,%M8		\n"
+	    "	srli		%1,#8,%1	\n"
+	    "	stb%I9		%1,%M9		\n"
+	    : "=&r"(__low), "=&r"(__high), "=m"(__p[7]), "=m"(__p[6]),
+	      "=m"(__p[5]), "=m"(__p[4]), "=m"(__p[3]), "=m"(__p[2]),
+	      "=m"(__p[1]), "=m"(__p[0])
+	    : "0"(__low), "1"(__high)
+	    );
+}
 
 /*
  * Unaligned accesses on uClinux can't be performed in a fault handler - the
@@ -49,153 +215,51 @@ extern int handle_misalignment(unsigned long esr0, unsigned long ear0, unsigned
 
 #else
 
-#define get_unaligned(ptr)							\
-({										\
-	typeof(*(ptr)) x;							\
-	const char *__p = (const char *) (ptr);					\
-										\
-	switch (sizeof(x)) {							\
-	case 1:									\
-		x = *(ptr);							\
-		break;								\
-	case 2:									\
-	{									\
-		uint8_t a;							\
-		asm("	ldub%I2		%M2,%0		\n"			\
-		    "	ldub%I3.p	%M3,%1		\n"			\
-		    "	slli		%0,#8,%0	\n"			\
-		    "	or		%0,%1,%0	\n"			\
-		    : "=&r"(x), "=&r"(a)					\
-		    : "m"(__p[0]),  "m"(__p[1])					\
-		    );								\
-		break;								\
-	}									\
-										\
-	case 4:									\
-	{									\
-		uint8_t a;							\
-		asm("	ldub%I2		%M2,%0		\n"			\
-		    "	ldub%I3.p	%M3,%1		\n"			\
-		    "	slli		%0,#8,%0	\n"			\
-		    "	or		%0,%1,%0	\n"			\
-		    "	ldub%I4.p	%M4,%1		\n"			\
-		    "	slli		%0,#8,%0	\n"			\
-		    "	or		%0,%1,%0	\n"			\
-		    "	ldub%I5.p	%M5,%1		\n"			\
-		    "	slli		%0,#8,%0	\n"			\
-		    "	or		%0,%1,%0	\n"			\
-		    : "=&r"(x), "=&r"(a)					\
-		    : "m"(__p[0]),  "m"(__p[1]), "m"(__p[2]), "m"(__p[3])	\
-		    );								\
-		break;								\
-	}									\
-										\
-	case 8:									\
-	{									\
-		union { uint64_t x; u32 y[2]; } z;				\
-		uint8_t a;							\
-		asm("	ldub%I3		%M3,%0		\n"			\
-		    "	ldub%I4.p	%M4,%2		\n"			\
-		    "	slli		%0,#8,%0	\n"			\
-		    "	or		%0,%2,%0	\n"			\
-		    "	ldub%I5.p	%M5,%2		\n"			\
-		    "	slli		%0,#8,%0	\n"			\
-		    "	or		%0,%2,%0	\n"			\
-		    "	ldub%I6.p	%M6,%2		\n"			\
-		    "	slli		%0,#8,%0	\n"			\
-		    "	or		%0,%2,%0	\n"			\
-		    "	ldub%I7		%M7,%1		\n"			\
-		    "	ldub%I8.p	%M8,%2		\n"			\
-		    "	slli		%1,#8,%1	\n"			\
-		    "	or		%1,%2,%1	\n"			\
-		    "	ldub%I9.p	%M9,%2		\n"			\
-		    "	slli		%1,#8,%1	\n"			\
-		    "	or		%1,%2,%1	\n"			\
-		    "	ldub%I10.p	%M10,%2		\n"			\
-		    "	slli		%1,#8,%1	\n"			\
-		    "	or		%1,%2,%1	\n"			\
-		    : "=&r"(z.y[0]), "=&r"(z.y[1]), "=&r"(a)			\
-		    : "m"(__p[0]), "m"(__p[1]), "m"(__p[2]), "m"(__p[3]),	\
-		      "m"(__p[4]), "m"(__p[5]), "m"(__p[6]), "m"(__p[7])	\
-		    );								\
-		x = z.x;							\
-		break;								\
-	}									\
-										\
-	default:								\
-		x = 0;								\
-		BUG();								\
-		break;								\
-	}									\
-										\
-	x;									\
-})
+#define get_unaligned(ptr) ({				\
+	typeof(*(ptr)) x;				\
+							\
+	switch (sizeof(x)) {				\
+	case 1:						\
+		x = *(ptr);				\
+		break;					\
+	case 2:						\
+		x = get_unaligned_be16((ptr));		\
+		break;					\
+	case 4:						\
+		x = get_unaligned_be32((ptr));		\
+		break;					\
+	case 8:						\
+		x = get_unaligned_be64((ptr));		\
+		break;					\
+	default:					\
+		BUILD_BUG_ON(1);			\
+		break;					\
+	}						\
+	x; })
 
-#define put_unaligned(val, ptr)								\
-do {											\
-	char *__p = (char *) (ptr);							\
-	int x;										\
-											\
-	switch (sizeof(*ptr)) {								\
-	case 2:										\
-	{										\
-		asm("	stb%I1.p	%0,%M1		\n"				\
-		    "	srli		%0,#8,%0	\n"				\
-		    "	stb%I2		%0,%M2		\n"				\
-		    : "=r"(x), "=m"(__p[1]),  "=m"(__p[0])				\
-		    : "0"(val)								\
-		    );									\
-		break;									\
-	}										\
-											\
-	case 4:										\
-	{										\
-		asm("	stb%I1.p	%0,%M1		\n"				\
-		    "	srli		%0,#8,%0	\n"				\
-		    "	stb%I2.p	%0,%M2		\n"				\
-		    "	srli		%0,#8,%0	\n"				\
-		    "	stb%I3.p	%0,%M3		\n"				\
-		    "	srli		%0,#8,%0	\n"				\
-		    "	stb%I4		%0,%M4		\n"				\
-		    : "=r"(x), "=m"(__p[3]),  "=m"(__p[2]), "=m"(__p[1]), "=m"(__p[0])	\
-		    : "0"(val)								\
-		    );									\
-		break;									\
-	}										\
-											\
-	case 8:										\
-	{										\
-		uint32_t __high, __low;							\
-		__high = (uint64_t)val >> 32;						\
-		__low = val & 0xffffffff;						\
-		asm("	stb%I2.p	%0,%M2		\n"				\
-		    "	srli		%0,#8,%0	\n"				\
-		    "	stb%I3.p	%0,%M3		\n"				\
-		    "	srli		%0,#8,%0	\n"				\
-		    "	stb%I4.p	%0,%M4		\n"				\
-		    "	srli		%0,#8,%0	\n"				\
-		    "	stb%I5.p	%0,%M5		\n"				\
-		    "	srli		%0,#8,%0	\n"				\
-		    "	stb%I6.p	%1,%M6		\n"				\
-		    "	srli		%1,#8,%1	\n"				\
-		    "	stb%I7.p	%1,%M7		\n"				\
-		    "	srli		%1,#8,%1	\n"				\
-		    "	stb%I8.p	%1,%M8		\n"				\
-		    "	srli		%1,#8,%1	\n"				\
-		    "	stb%I9		%1,%M9		\n"				\
-		    : "=&r"(__low), "=&r"(__high), "=m"(__p[7]), "=m"(__p[6]), 		\
-		      "=m"(__p[5]), "=m"(__p[4]), "=m"(__p[3]), "=m"(__p[2]), 		\
-		      "=m"(__p[1]), "=m"(__p[0])					\
-		    : "0"(__low), "1"(__high)						\
-		    );									\
-		break;									\
-	}										\
-											\
-        default:									\
-		*(ptr) = (val);								\
-		break;									\
-	}										\
-} while(0)
+#define put_unaligned(val, ptr) ({			\
+							\
+	char *__p = (char *) (ptr);			\
+	int x;						\
+							\
+	switch (sizeof(*ptr)) {				\
+	case 1:						\
+		*(ptr) = (val);				\
+		break;					\
+	case 2:						\
+		put_unaligned_be16((val), (ptr));	\
+		break;					\
+	case 4:						\
+		put_unaligned_be32((val), (ptr));	\
+		break;					\
+	case 8:						\
+		put_unaligned_be64((val), (ptr));	\
+		break;					\
+	default:					\
+		BUILD_BUG_ON(1);			\
+		break;					\
+	}						\
+	(void)0; })
 
 #endif
 
-- 
1.5.5.144.g3e42
