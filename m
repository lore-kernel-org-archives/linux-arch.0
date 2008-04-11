From: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCHv3 1/2] kernel: add common infrastructure for unaligned
	access
Date: Fri, 11 Apr 2008 14:46:50 -0700
Message-ID: <1207950410.22001.104.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Russell King <rmk-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>

Create a linux/unaligned folder similar in spirit to the linux/byteorder
folder to hold generic implementations collected from various arches.

Currently there are five implementations:
1) packed_struct.h: C-struct based, from asm-generic/unaligned.h
2) le_byteshift.h: Open coded byte-swapping, heavily based on asm-arm
3) be_byteshift.h: Open coded byte-swapping, heavily based on asm-arm
4) memmove.h: taken from multiple implementations in tree
5) access_ok.h: taken from x86 and others, unaligned access is ok.

All of the new implementations checks for sizes not equal to 1,2,4,8
and will fail to link.

API additions:

get_unaligned_{le16|le32|le64|be16|be32|be64}(p) which is meant to replace
code of the form:
le16_to_cpu(get_unaligned((__le16 *)p));

put_unaligned_{le16|le32|le64|be16|be32|be64}(val, pointer) which is meant to
replace code of the form:
put_unaligned(cpu_to_le16(val), (__le16 *)p);

The headers that arches should include from their asm/unaligned.h:

access_ok.h : Wrappers of the byteswapping functions in asm/byteorder

Choose a particular implementation for little-endian access:
le_byteshift.h
le_memmove.h (arch must be LE)
le_struct.h (arch must be LE)

Choose a particular implementation for big-endian access:
be_byteshift.h
be_memmove.h (arch must be BE)
be_struct.h (arch must be BE)

After including as needed from the above, include unaligned/generic.h and
define your arch's get/put_unaligned as (for LE):

Signed-off-by: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 include/linux/unaligned/access_ok.h     |   67 +++++++++++++++++++++++++++++
 include/linux/unaligned/be_byteshift.h  |   70 +++++++++++++++++++++++++++++++
 include/linux/unaligned/be_memmove.h    |   36 ++++++++++++++++
 include/linux/unaligned/be_struct.h     |   36 ++++++++++++++++
 include/linux/unaligned/generic.h       |   68 ++++++++++++++++++++++++++++++
 include/linux/unaligned/le_byteshift.h  |   70 +++++++++++++++++++++++++++++++
 include/linux/unaligned/le_memmove.h    |   36 ++++++++++++++++
 include/linux/unaligned/le_struct.h     |   36 ++++++++++++++++
 include/linux/unaligned/memmove.h       |   45 ++++++++++++++++++++
 include/linux/unaligned/packed_struct.h |   46 ++++++++++++++++++++
 10 files changed, 510 insertions(+), 0 deletions(-)

diff --git a/include/linux/unaligned/access_ok.h b/include/linux/unaligned/access_ok.h
new file mode 100644
index 0000000..08e1359
--- /dev/null
+++ b/include/linux/unaligned/access_ok.h
@@ -0,0 +1,67 @@
+#ifndef _LINUX_UNALIGNED_ACCESS_OK_H_
+#define _LINUX_UNALIGNED_ACCESS_OK_H_
+
+#include <linux/kernel.h>
+#include <asm/byteorder.h>
+
+static inline u16 get_unaligned_le16(const void *p)
+{
+	return le16_to_cpup((__le16 *)p);
+}
+
+static inline u32 get_unaligned_le32(const void *p)
+{
+	return le32_to_cpup((__le32 *)p);
+}
+
+static inline u64 get_unaligned_le64(const void *p)
+{
+	return le64_to_cpup((__le64 *)p);
+}
+
+static inline u16 get_unaligned_be16(const void *p)
+{
+	return be16_to_cpup((__be16 *)p);
+}
+
+static inline u32 get_unaligned_be32(const void *p)
+{
+	return be32_to_cpup((__be32 *)p);
+}
+
+static inline u64 get_unaligned_be64(const void *p)
+{
+	return be64_to_cpup((__be64 *)p);
+}
+
+static inline void put_unaligned_le16(u16 val, void *p)
+{
+	*((__le16 *)p) = cpu_to_le16(val);
+}
+
+static inline void put_unaligned_le32(u32 val, void *p)
+{
+	*((__le32 *)p) = cpu_to_le32(val);
+}
+
+static inline void put_unaligned_le64(u64 val, void *p)
+{
+	*((__le64 *)p) = cpu_to_le64(val);
+}
+
+static inline void put_unaligned_be16(u16 val, void *p)
+{
+	*((__be16 *)p) = cpu_to_be16(val);
+}
+
+static inline void put_unaligned_be32(u32 val, void *p)
+{
+	*((__be32 *)p) = cpu_to_be32(val);
+}
+
+static inline void put_unaligned_be64(u64 val, void *p)
+{
+	*((__be64 *)p) = cpu_to_be64(val);
+}
+
+#endif /* _LINUX_UNALIGNED_ACCESS_OK_H_ */
diff --git a/include/linux/unaligned/be_byteshift.h b/include/linux/unaligned/be_byteshift.h
new file mode 100644
index 0000000..7b7ac79
--- /dev/null
+++ b/include/linux/unaligned/be_byteshift.h
@@ -0,0 +1,70 @@
+#ifndef _LINUX_UNALIGNED_BE_BYTESHIFT_H_
+#define _LINUX_UNALIGNED_BE_BYTESHIFT_H_
+
+#include <linux/kernel.h>
+
+static inline u16 __get_unaligned_be16(const u8 *p)
+{
+	return p[0] << 8 | p[1];
+}
+
+static inline u32 __get_unaligned_be32(const u8 *p)
+{
+	return p[0] << 24 | p[1] << 16 | p[2] << 8 | p[3];
+}
+
+static inline u64 __get_unaligned_be64(const u8 *p)
+{
+	return (u64)__get_unaligned_be32(p) << 32 |
+	       __get_unaligned_be32(p + 4);
+}
+
+static inline void __put_unaligned_be16(u16 val, u8 *p)
+{
+	*p++ = val >> 8;
+	*p++ = val;
+}
+
+static inline void __put_unaligned_be32(u32 val, u8 *p)
+{
+	__put_unaligned_be16(val >> 16, p);
+	__put_unaligned_be16(val, p + 2);
+}
+
+static inline void __put_unaligned_be64(u64 val, u8 *p)
+{
+	__put_unaligned_be32(val >> 32, p);
+	__put_unaligned_be32(val, p + 4);
+}
+
+static inline u16 get_unaligned_be16(const void *p)
+{
+	return __get_unaligned_be16((const u8 *)p);
+}
+
+static inline u32 get_unaligned_be32(const void *p)
+{
+	return __get_unaligned_be32((const u8 *)p);
+}
+
+static inline u64 get_unaligned_be64(const void *p)
+{
+	return __get_unaligned_be64((const u8 *)p);
+}
+
+static inline void put_unaligned_be16(u16 val, void *p)
+{
+	__put_unaligned_be16(val, p);
+}
+
+static inline void put_unaligned_be32(u32 val, void *p)
+{
+	__put_unaligned_be32(val, p);
+}
+
+static inline void put_unaligned_be64(u64 val, void *p)
+{
+	__put_unaligned_be64(val, p);
+}
+
+#endif /* _LINUX_UNALIGNED_BE_BYTESHIFT_H_ */
diff --git a/include/linux/unaligned/be_memmove.h b/include/linux/unaligned/be_memmove.h
new file mode 100644
index 0000000..85b9d5a
--- /dev/null
+++ b/include/linux/unaligned/be_memmove.h
@@ -0,0 +1,36 @@
+#ifndef _LINUX_UNALIGNED_BE_MEMMOVE_H_
+#define _LINUX_UNALIGNED_BE_MEMMOVE_H_
+
+#include <linux/unaligned/memmove.h>
+
+static inline u16 get_unaligned_be16(const void *p)
+{
+	return __get_unaligned_memmove16((const u8 *)p);
+}
+
+static inline u32 get_unaligned_be32(const void *p)
+{
+	return __get_unaligned_memmove32((const u8 *)p);
+}
+
+static inline u64 get_unaligned_be64(const void *p)
+{
+	return __get_unaligned_memmove64((const u8 *)p);
+}
+
+static inline void put_unaligned_be16(u16 val, void *p)
+{
+	__put_unaligned_memmove16(val, p);
+}
+
+static inline void put_unaligned_be32(u32 val, void *p)
+{
+	__put_unaligned_memmove32(val, p);
+}
+
+static inline void put_unaligned_be64(u64 val, void *p)
+{
+	__put_unaligned_memmove64(val, p);
+}
+
+#endif /* _LINUX_UNALIGNED_LE_MEMMOVE_H_ */
diff --git a/include/linux/unaligned/be_struct.h b/include/linux/unaligned/be_struct.h
new file mode 100644
index 0000000..3201fcf
--- /dev/null
+++ b/include/linux/unaligned/be_struct.h
@@ -0,0 +1,36 @@
+#ifndef _LINUX_UNALIGNED_BE_STRUCT_H_
+#define _LINUX_UNALIGNED_BE_STRUCT_H_
+
+#include <linux/unaligned/packed_struct.h>
+
+static inline u16 get_unaligned_be16(const void *p)
+{
+	return __get_unaligned_cpu16((const u8 *)p);
+}
+
+static inline u32 get_unaligned_be32(const void *p)
+{
+	return __get_unaligned_cpu32((const u8 *)p);
+}
+
+static inline u64 get_unaligned_be64(const void *p)
+{
+	return __get_unaligned_cpu64((const u8 *)p);
+}
+
+static inline void put_unaligned_be16(u16 val, void *p)
+{
+	__put_unaligned_cpu16(val, p);
+}
+
+static inline void put_unaligned_be32(u32 val, void *p)
+{
+	__put_unaligned_cpu32(val, p);
+}
+
+static inline void put_unaligned_be64(u64 val, void *p)
+{
+	__put_unaligned_cpu64(val, p);
+}
+
+#endif /* _LINUX_UNALIGNED_BE_STRUCT_H_ */
diff --git a/include/linux/unaligned/generic.h b/include/linux/unaligned/generic.h
new file mode 100644
index 0000000..54e1a56
--- /dev/null
+++ b/include/linux/unaligned/generic.h
@@ -0,0 +1,68 @@
+#ifndef _LINUX_UNALIGNED_GENERIC_H_
+#define _LINUX_UNALIGNED_GENERIC_H_
+
+/*
+ * Cause a link-time error if we try an unaligned access other than
+ * 1,2,4 or 8 bytes long
+ */
+extern void __bad_unaligned_access_size(void);
+
+#define __get_unaligned_le(ptr) ((__force typeof(*(ptr)))({			\
+	__builtin_choose_expr(sizeof(*(ptr)) == 1, *(ptr),			\
+	__builtin_choose_expr(sizeof(*(ptr)) == 2, get_unaligned_le16((ptr)),	\
+	__builtin_choose_expr(sizeof(*(ptr)) == 4, get_unaligned_le32((ptr)),	\
+	__builtin_choose_expr(sizeof(*(ptr)) == 8, get_unaligned_le64((ptr)),	\
+	__bad_unaligned_access_size()))));					\
+	}))
+
+#define __get_unaligned_be(ptr) ((__force typeof(*(ptr)))({			\
+	__builtin_choose_expr(sizeof(*(ptr)) == 1, *(ptr),			\
+	__builtin_choose_expr(sizeof(*(ptr)) == 2, get_unaligned_be16((ptr)),	\
+	__builtin_choose_expr(sizeof(*(ptr)) == 4, get_unaligned_be32((ptr)),	\
+	__builtin_choose_expr(sizeof(*(ptr)) == 8, get_unaligned_be64((ptr)),	\
+	__bad_unaligned_access_size()))));					\
+	}))
+
+#define __put_unaligned_le(val, ptr) ({					\
+	void *__gu_p = (ptr);						\
+	switch (sizeof(*(ptr))) {					\
+	case 1:								\
+		*(u8 *)__gu_p = (__force u8)(val);			\
+		break;							\
+	case 2:								\
+		put_unaligned_le16((__force u16)(val), __gu_p);		\
+		break;							\
+	case 4:								\
+		put_unaligned_le32((__force u32)(val), __gu_p);		\
+		break;							\
+	case 8:								\
+		put_unaligned_le64((__force u64)(val), __gu_p);		\
+		break;							\
+	default:							\
+		__bad_unaligned_access_size();				\
+		break;							\
+	}								\
+	(void)0; })
+
+#define __put_unaligned_be(val, ptr) ({					\
+	void *__gu_p = (ptr);						\
+	switch (sizeof(*(ptr))) {					\
+	case 1:								\
+		*(u8 *)__gu_p = (__force u8)(val);			\
+		break;							\
+	case 2:								\
+		put_unaligned_be16((__force u16)(val), __gu_p);		\
+		break;							\
+	case 4:								\
+		put_unaligned_be32((__force u32)(val), __gu_p);		\
+		break;							\
+	case 8:								\
+		put_unaligned_be64((__force u64)(val), __gu_p);		\
+		break;							\
+	default:							\
+		__bad_unaligned_access_size();				\
+		break;							\
+	}								\
+	(void)0; })
+
+#endif /* _LINUX_UNALIGNED_GENERIC_H_ */
diff --git a/include/linux/unaligned/le_byteshift.h b/include/linux/unaligned/le_byteshift.h
new file mode 100644
index 0000000..63364df
--- /dev/null
+++ b/include/linux/unaligned/le_byteshift.h
@@ -0,0 +1,70 @@
+#ifndef _LINUX_UNALIGNED_LE_BYTESHIFT_H_
+#define _LINUX_UNALIGNED_LE_BYTESHIFT_H_
+
+#include <linux/kernel.h>
+
+static inline u16 __get_unaligned_le16(const u8 *p)
+{
+	return p[0] | p[1] << 8;
+}
+
+static inline u32 __get_unaligned_le32(const u8 *p)
+{
+	return p[0] | p[1] << 8 | p[2] << 16 | p[3] << 24;
+}
+
+static inline u64 __get_unaligned_le64(const u8 *p)
+{
+	return (u64)__get_unaligned_le32(p + 4) << 32 |
+	       __get_unaligned_le32(p);
+}
+
+static inline void __put_unaligned_le16(u16 val, u8 *p)
+{
+	*p++ = val;
+	*p++ = val >> 8;
+}
+
+static inline void __put_unaligned_le32(u32 val, u8 *p)
+{
+	__put_unaligned_le16(val >> 16, p + 2);
+	__put_unaligned_le16(val, p);
+}
+
+static inline void __put_unaligned_le64(u64 val, u8 *p)
+{
+	__put_unaligned_le32(val >> 32, p + 4);
+	__put_unaligned_le32(val, p);
+}
+
+static inline u16 get_unaligned_le16(const void *p)
+{
+	return __get_unaligned_le16((const u8 *)p);
+}
+
+static inline u32 get_unaligned_le32(const void *p)
+{
+	return __get_unaligned_le32((const u8 *)p);
+}
+
+static inline u64 get_unaligned_le64(const void *p)
+{
+	return __get_unaligned_le64((const u8 *)p);
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
+#endif /* _LINUX_UNALIGNED_LE_BYTESHIFT_H_ */
diff --git a/include/linux/unaligned/le_memmove.h b/include/linux/unaligned/le_memmove.h
new file mode 100644
index 0000000..e0e5575
--- /dev/null
+++ b/include/linux/unaligned/le_memmove.h
@@ -0,0 +1,36 @@
+#ifndef _LINUX_UNALIGNED_LE_MEMMOVE_H_
+#define _LINUX_UNALIGNED_LE_MEMMOVE_H_
+
+#include <linux/unaligned/memmove.h>
+
+static inline u16 get_unaligned_le16(const void *p)
+{
+	return __get_unaligned_memmove16((const u8 *)p);
+}
+
+static inline u32 get_unaligned_le32(const void *p)
+{
+	return __get_unaligned_memmove32((const u8 *)p);
+}
+
+static inline u64 get_unaligned_le64(const void *p)
+{
+	return __get_unaligned_memmove64((const u8 *)p);
+}
+
+static inline void put_unaligned_le16(u16 val, void *p)
+{
+	__put_unaligned_memmove16(val, p);
+}
+
+static inline void put_unaligned_le32(u32 val, void *p)
+{
+	__put_unaligned_memmove32(val, p);
+}
+
+static inline void put_unaligned_le64(u64 val, void *p)
+{
+	__put_unaligned_memmove64(val, p);
+}
+
+#endif /* _LINUX_UNALIGNED_LE_MEMMOVE_H_ */
diff --git a/include/linux/unaligned/le_struct.h b/include/linux/unaligned/le_struct.h
new file mode 100644
index 0000000..78c0d38
--- /dev/null
+++ b/include/linux/unaligned/le_struct.h
@@ -0,0 +1,36 @@
+#ifndef _LINUX_UNALIGNED_LE_STRUCT_H_
+#define _LINUX_UNALIGNED_LE_STRUCT_H_
+
+#include <linux/unaligned/packed_struct.h>
+
+static inline u16 get_unaligned_le16(const void *p)
+{
+	return __get_unaligned_cpu16((const u8 *)p);
+}
+
+static inline u32 get_unaligned_le32(const void *p)
+{
+	return __get_unaligned_cpu32((const u8 *)p);
+}
+
+static inline u64 get_unaligned_le64(const void *p)
+{
+	return __get_unaligned_cpu64((const u8 *)p);
+}
+
+static inline void put_unaligned_le16(u16 val, void *p)
+{
+	__put_unaligned_cpu16(val, p);
+}
+
+static inline void put_unaligned_le32(u32 val, void *p)
+{
+	__put_unaligned_cpu32(val, p);
+}
+
+static inline void put_unaligned_le64(u64 val, void *p)
+{
+	__put_unaligned_cpu64(val, p);
+}
+
+#endif /* _LINUX_UNALIGNED_LE_STRUCT_H_ */
diff --git a/include/linux/unaligned/memmove.h b/include/linux/unaligned/memmove.h
new file mode 100644
index 0000000..6ae6fb1
--- /dev/null
+++ b/include/linux/unaligned/memmove.h
@@ -0,0 +1,45 @@
+#ifndef _LINUX_UNALIGNED_MEMMOVE_H_
+#define _LINUX_UNALIGNED_MEMMOVE_H_
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+
+/* Use memmove here, so gcc does not insert a __builtin_memcpy. */
+
+static inline u16 __get_unaligned_memmove16(const void *p)
+{
+	u16 tmp;
+	memmove(&tmp, p, 2);
+	return tmp;
+}
+
+static inline u32 __get_unaligned_memmove32(const void *p)
+{
+	u32 tmp;
+	memmove(&tmp, p, 4);
+	return tmp;
+}
+
+static inline u64 __get_unaligned_memmove64(const void *p)
+{
+	u64 tmp;
+	memmove(&tmp, p, 8);
+	return tmp;
+}
+
+static inline void __put_unaligned_memmove16(u16 val, void *p)
+{
+	memmove(p, &val, 2);
+}
+
+static inline void __put_unaligned_memmove32(u32 val, void *p)
+{
+	memmove(p, &val, 4);
+}
+
+static inline void __put_unaligned_memmove64(u64 val, void *p)
+{
+	memmove(p, &val, 8);
+}
+
+#endif /* _LINUX_UNALIGNED_MEMMOVE_H_ */
diff --git a/include/linux/unaligned/packed_struct.h b/include/linux/unaligned/packed_struct.h
new file mode 100644
index 0000000..bebc670
--- /dev/null
+++ b/include/linux/unaligned/packed_struct.h
@@ -0,0 +1,46 @@
+#ifndef _LINUX_UNALIGNED_CPU_ENDIAN_H_
+#define _LINUX_UNALIGNED_CPU_ENDIAN_H_
+
+#include <linux/kernel.h>
+
+struct __una_u16 { u16 x __attribute__((packed)); };
+struct __una_u32 { u32 x __attribute__((packed)); };
+struct __una_u64 { u64 x __attribute__((packed)); };
+
+static inline u16 __get_unaligned_cpu16(const void *p)
+{
+	const struct __una_u16 *ptr = (const struct __una_u16 *)p;
+	return ptr->x;
+}
+
+static inline u32 __get_unaligned_cpu32(const void *p)
+{
+	const struct __una_u32 *ptr = (const struct __una_u32 *)p;
+	return ptr->x;
+}
+
+static inline u64 __get_unaligned_cpu64(const void *p)
+{
+	const struct __una_u64 *ptr = (const struct __una_u64 *)p;
+	return ptr->x;
+}
+
+static inline void __put_unaligned_cpu16(u16 val, void *p)
+{
+	struct __una_u16 *ptr = (struct __una_u16 *)p;
+	ptr->x = val;
+}
+
+static inline void __put_unaligned_cpu32(u32 val, void *p)
+{
+	struct __una_u32 *ptr = (struct __una_u32 *)p;
+	ptr->x = val;
+}
+
+static inline void __put_unaligned_cpu64(u64 val, void *p)
+{
+	struct __una_u64 *ptr = (struct __una_u64 *)p;
+	ptr->x = val;
+}
+
+#endif /* _LINUX_UNALIGNED_CPU_ENDIAN_H_ */
-- 
1.5.5.144.g3e42
