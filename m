From: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/8] kernel: add common infrastructure for unaligned access
Date: Thu, 10 Apr 2008 12:44:06 -0700
Message-ID: <1207856646.22001.25.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Create a linux/unaligned folder similar in spirit to the linux/byteorder
folder to hold generic implementations collected from various arches.

Currently there are five implementations:
1) cpu_endian.h: C-struct based, heavily based on asm-generic/unaligned.h
2) little_endian.h: Open coded byte-swapping, heavily based on asm-arm
3) big_endian.h: Open coded byte-swapping, heavily based on asm-arm
4) no_builtin_memcpy.h: taken from multiple implementations in tree
5) access_ok.h: taken from x86 and others, unaligned access is ok.

API additions:

get_unaligned_{le16|le32|le64|be16|be32|be64}(p) which is meant to replace
code of the form:
le16_to_cpu(get_unaligned((__le16 *)p));

put_unaligned_{le16|le32|le64|be16|be32|be64}(val, pointer) which is meant to
replace code of the form:
put_unaligned(cpu_to_le16(val), (__le16 *)p);

Headers to create these based on the selected implementation and defining the
appropriate get_unaligned() and put_unaligned() macros are:

generic_le.h: Use the C-struct for get/put_unaligned and the le helpers, use the
opencoded be byteswapping implementation for big-endian.

generic_be.h: Use the C-struct for get/put_unaligned and the be helpers, use the
opencoded le byteswapping implementation for little-endian.

generic.h: Use opencoded byteswapping for all helpers, leaves it to the arch to
define get/put_unaligned.

Signed-off-by: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 include/linux/unaligned/access_ok.h         |   70 +++++++++++++++++++++
 include/linux/unaligned/big_endian.h        |   84 +++++++++++++++++++++++++
 include/linux/unaligned/cpu_endian.h        |   90 +++++++++++++++++++++++++++
 include/linux/unaligned/generic.h           |   67 ++++++++++++++++++++
 include/linux/unaligned/generic_be.h        |   70 +++++++++++++++++++++
 include/linux/unaligned/generic_le.h        |   70 +++++++++++++++++++++
 include/linux/unaligned/little_endian.h     |   84 +++++++++++++++++++++++++
 include/linux/unaligned/no_builtin_memcpy.h |   80 ++++++++++++++++++++++++
 8 files changed, 615 insertions(+), 0 deletions(-)

diff --git a/include/linux/unaligned/access_ok.h b/include/linux/unaligned/access_ok.h
new file mode 100644
index 0000000..e9d8ff4
--- /dev/null
+++ b/include/linux/unaligned/access_ok.h
@@ -0,0 +1,70 @@
+#ifndef _LINUX_UNALIGNED_ACCESS_OK_H_
+#define _LINUX_UNALIGNED_ACCESS_OK_H_
+
+#include <linux/kernel.h>
+#include <asm/byteorder.h>
+
+#define get_unaligned(ptr) (*(ptr))
+#define put_unaligned(val, ptr) ((void)( *(ptr) = (val) ))
+
+static inline u16 get_unaligned_le16(const __le16 *p)
+{
+	return le16_to_cpup(p);
+}
+
+static inline u32 get_unaligned_le32(const __le32 *p)
+{
+	return le32_to_cpup(p);
+}
+
+static inline u64 get_unaligned_le64(const __le64 *p)
+{
+	return le64_to_cpup(p);
+}
+
+static inline u16 get_unaligned_be16(const __be16 *p)
+{
+	return be16_to_cpup(p);
+}
+
+static inline u32 get_unaligned_be32(const __be32 *p)
+{
+	return be32_to_cpup(p);
+}
+
+static inline u64 get_unaligned_be64(const __be64 *p)
+{
+	return be64_to_cpup(p);
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
diff --git a/include/linux/unaligned/big_endian.h b/include/linux/unaligned/big_endian.h
new file mode 100644
index 0000000..48802be
--- /dev/null
+++ b/include/linux/unaligned/big_endian.h
@@ -0,0 +1,84 @@
+#ifndef _LINUX_UNALIGNED_BIG_ENDIAN_H_
+#define _LINUX_UNALIGNED_BIG_ENDIAN_H_
+
+#include <linux/kernel.h>
+
+static inline u16 __get_unaligned_be16(const u8 *p)
+{
+	return (u16)(p[0] << 8 | p[1]);
+}
+
+static inline u32 __get_unaligned_be32(const u8 *p)
+{
+	return (u32)(p[0] << 24 | p[1] << 16 | p[2] << 8 | p[3]);
+}
+
+static inline u64 __get_unaligned_be64(const u8 *p)
+{
+	return ((u64)__get_unaligned_be32(p) << 32) |
+	       __get_unaligned_be32(p + 4);
+}
+
+#define __get_unaligned_be(ptr) ({			\
+	const void *__gu_p = (ptr);			\
+	typeof(*(ptr)) __val;				\
+	switch (sizeof(*(ptr))) {			\
+	case 1:						\
+		__val = *(const u8 *)__gu_p;		\
+		break;					\
+	case 2:						\
+		__val = __get_unaligned_be16(__gu_p);	\
+		break;					\
+	case 4:						\
+		__val = __get_unaligned_be32(__gu_p);	\
+		break;					\
+	case 8:						\
+		__val = __get_unaligned_be64(__gu_p);	\
+		break;					\
+	default:					\
+		BUILD_BUG_ON(1);			\
+		break;					\
+	};						\
+	__val; })
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
+#define __put_unaligned_be(val, ptr) ({					\
+	(void)sizeof(*(ptr) = (val));					\
+	void *__gu_p = (ptr);						\
+	switch (sizeof(*(ptr))) {					\
+	case 1:								\
+		*(u8 *)__gu_p = (__force u8)(val);			\
+		break;							\
+	case 2:								\
+		__put_unaligned_be16((__force u16)(val), __gu_p);	\
+		break;							\
+	case 4:								\
+		__put_unaligned_be32((__force u32)(val), __gu_p);	\
+		break;							\
+	case 8:								\
+		__put_unaligned_be64((__force u64)(val), __gu_p);	\
+		break;							\
+	default:							\
+		BUILD_BUG_ON(1);					\
+		break;							\
+	}								\
+	(void)0; })
+
+#endif /* _LINUX_UNALIGNED_BIG_ENDIAN_H_ */
diff --git a/include/linux/unaligned/cpu_endian.h b/include/linux/unaligned/cpu_endian.h
new file mode 100644
index 0000000..8189286
--- /dev/null
+++ b/include/linux/unaligned/cpu_endian.h
@@ -0,0 +1,90 @@
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
+#define __get_unaligned_cpu(ptr) ({			\
+	const void *__gu_p = (ptr);			\
+	typeof(*(ptr)) __val;				\
+	switch (sizeof(*(ptr))) {			\
+	case 1:						\
+		__val = *(const u8 *)__gu_p;		\
+		break;					\
+	case 2:						\
+		__val = __get_unaligned_cpu16(__gu_p);	\
+		break;					\
+	case 4:						\
+		__val = __get_unaligned_cpu32(__gu_p);	\
+		break;					\
+	case 8:						\
+		__val = __get_unaligned_cpu64(__gu_p);	\
+		break;					\
+	default:					\
+		BUILD_BUG_ON(1);			\
+		break;					\
+	};						\
+	__val; })
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
+#define __put_unaligned_cpu(val, ptr) ({				\
+	(void)sizeof(*(ptr) = (val));					\
+	void *__gu_p = (ptr);						\
+	switch (sizeof(*(ptr))) {					\
+	case 1:								\
+		*(u8 *)__gu_p = (__force u8)(val);			\
+		break;							\
+	case 2:								\
+		__put_unaligned_cpu16((__force u16)(val), __gu_p);	\
+		break;							\
+	case 4:								\
+		__put_unaligned_cpu32((__force u32)(val), __gu_p);	\
+		break;							\
+	case 8:								\
+		__put_unaligned_cpu64((__force u64)(val), __gu_p);	\
+		break;							\
+	default:							\
+		BUILD_BUG_ON(1);					\
+		break;							\
+	}								\
+	(void)0; })
+
+#endif /* _LINUX_UNALIGNED_CPU_ENDIAN_H_ */
diff --git a/include/linux/unaligned/generic.h b/include/linux/unaligned/generic.h
new file mode 100644
index 0000000..9cd3fab
--- /dev/null
+++ b/include/linux/unaligned/generic.h
@@ -0,0 +1,67 @@
+#ifndef _LINUX_UNALIGNED_GENERIC_H_
+#define _LINUX_UNALIGNED_GENERIC_H_
+
+#include <linux/unaligned/little_endian.h>
+#include <linux/unaligned/big_endian.h>
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
+	return __get_unaligned_be16((const u8 *)p);
+}
+
+static inline u32 get_unaligned_be32(const __be32 *p)
+{
+	return __get_unaligned_be32((const u8 *)p);
+}
+
+static inline u64 get_unaligned_be64(const __be64 *p)
+{
+	return __get_unaligned_be64((const u8 *)p);
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
+#endif /* _LINUX_UNALIGNED_GENERIC_H_ */
diff --git a/include/linux/unaligned/generic_be.h b/include/linux/unaligned/generic_be.h
new file mode 100644
index 0000000..dd7e323
--- /dev/null
+++ b/include/linux/unaligned/generic_be.h
@@ -0,0 +1,70 @@
+#ifndef _LINUX_UNALIGNED_GENERIC_BE_H_
+#define _LINUX_UNALIGNED_GENERIC_BE_H_
+
+#include <linux/unaligned/cpu_endian.h>
+#include <linux/unaligned/little_endian.h>
+
+#define get_unaligned	__get_unaligned_cpu
+#define put_unaligned	__put_unaligned_cpu
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
+	return __get_unaligned_cpu16((const u8 *)p);
+}
+
+static inline u32 get_unaligned_be32(const __be32 *p)
+{
+	return __get_unaligned_cpu32((const u8 *)p);
+}
+
+static inline u64 get_unaligned_be64(const __be64 *p)
+{
+	return __get_unaligned_cpu64((const u8 *)p);
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
+#endif /* _LINUX_UNALIGNED_GENERIC_BE_H_ */
diff --git a/include/linux/unaligned/generic_le.h b/include/linux/unaligned/generic_le.h
new file mode 100644
index 0000000..7b7de52
--- /dev/null
+++ b/include/linux/unaligned/generic_le.h
@@ -0,0 +1,70 @@
+#ifndef _LINUX_UNALIGNED_GENERIC_LE_H_
+#define _LINUX_UNALIGNED_GENERIC_LE_H_
+
+#include <linux/unaligned/cpu_endian.h>
+#include <linux/unaligned/big_endian.h>
+
+#define get_unaligned	__get_unaligned_cpu
+#define put_unaligned	__put_unaligned_cpu
+
+static inline u16 get_unaligned_le16(const __le16 *p)
+{
+	return __get_unaligned_cpu16((const u8 *)p);
+}
+
+static inline u32 get_unaligned_le32(const __le32 *p)
+{
+	return __get_unaligned_cpu32((const u8 *)p);
+}
+
+static inline u64 get_unaligned_le64(const __le64 *p)
+{
+	return __get_unaligned_cpu64((const u8 *)p);
+}
+
+static inline u16 get_unaligned_be16(const __be16 *p)
+{
+	return __get_unaligned_be16((const u8 *)p);
+}
+
+static inline u32 get_unaligned_be32(const __be32 *p)
+{
+	return __get_unaligned_be32((const u8 *)p);
+}
+
+static inline u64 get_unaligned_be64(const __be64 *p)
+{
+	return __get_unaligned_be64((const u8 *)p);
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
+#endif /* _LINUX_UNALIGNED_GENERIC_LE_H_ */
diff --git a/include/linux/unaligned/little_endian.h b/include/linux/unaligned/little_endian.h
new file mode 100644
index 0000000..38de5c1
--- /dev/null
+++ b/include/linux/unaligned/little_endian.h
@@ -0,0 +1,84 @@
+#ifndef _LINUX_UNALIGNED_LITTLE_ENDIAN_H_
+#define _LINUX_UNALIGNED_LITTLE_ENDIAN_H_
+
+#include <linux/kernel.h>
+
+static inline u16 __get_unaligned_le16(const u8 *p)
+{
+	return (u16)(p[0] | p[1] << 8);
+}
+
+static inline u32 __get_unaligned_le32(const u8 *p)
+{
+	return (u32)(p[0] | p[1] << 8 | p[2] << 16 | p[3] << 24);
+}
+
+static inline u64 __get_unaligned_le64(const u8 *p)
+{
+	return ((u64)__get_unaligned_le32(p + 4) << 32) |
+	       __get_unaligned_le32(p);
+}
+
+#define __get_unaligned_le(ptr) ({			\
+	const void *__gu_p = (ptr);			\
+	typeof(*(ptr)) __val;				\
+	switch (sizeof(*(ptr))) {			\
+	case 1:						\
+		__val = *(const u8 *)__gu_p;		\
+		break;					\
+	case 2:						\
+		__val = __get_unaligned_le16(__gu_p);	\
+		break;					\
+	case 4:						\
+		__val = __get_unaligned_le32(__gu_p);	\
+		break;					\
+	case 8:						\
+		__val = __get_unaligned_le64(__gu_p);	\
+		break;					\
+	default:					\
+		BUILD_BUG_ON(1);			\
+		break;					\
+	};						\
+	__val; })
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
+#define __put_unaligned_le(val, ptr) ({					\
+	(void)sizeof(*(ptr) = (val));					\
+	void *__gu_p = (ptr);						\
+	switch (sizeof(*(ptr))) {					\
+	case 1:								\
+		*(u8 *)__gu_p = (__force u8)(val);			\
+		break;							\
+	case 2:								\
+		__put_unaligned_le16((__force u16)(val), __gu_p);	\
+		break;							\
+	case 4:								\
+		__put_unaligned_le32((__force u32)(val), __gu_p);	\
+		break;							\
+	case 8:								\
+		__put_unaligned_le64((__force u64)(val), __gu_p);	\
+		break;							\
+	default:							\
+		BUILD_BUG_ON(1);					\
+		break;							\
+	}								\
+	(void)0; })
+
+#endif /* _LINUX_UNALIGNED_LITTLE_ENDIAN_H_ */
diff --git a/include/linux/unaligned/no_builtin_memcpy.h b/include/linux/unaligned/no_builtin_memcpy.h
new file mode 100644
index 0000000..9365807
--- /dev/null
+++ b/include/linux/unaligned/no_builtin_memcpy.h
@@ -0,0 +1,80 @@
+#ifndef _LINUX_UNALIGNED_NO_BUILTIN_MEMCPY_H_
+#define _LINUX_UNALIGNED_NO_BUILTIN_MEMCPY_H_
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <asm/byteorder.h>
+
+/* Use memmove here, so gcc does not insert a __builtin_memcpy. */
+
+#define get_unaligned(ptr) ({				\
+	__typeof__(*(ptr)) __tmp;			\
+	memmove(&__tmp, (ptr), sizeof(*(ptr)));		\
+	__tmp; })
+
+#define put_unaligned(val, ptr) ({			\
+	__typeof__(*(ptr)) __tmp = (val);		\
+	memmove((ptr), &__tmp, sizeof(*(ptr)));		\
+	(void)0; })
+
+static inline u16 get_unaligned_le16(const __le16 *p)
+{
+	return le16_to_cpu(get_unaligned(p));
+}
+
+static inline u32 get_unaligned_le32(const __le32 *p)
+{
+	return le32_to_cpu(get_unaligned(p));
+}
+
+static inline u64 get_unaligned_le64(const __le64 *p)
+{
+	return le64_to_cpu(get_unaligned(p));
+}
+
+static inline u16 get_unaligned_be16(const __be16 *p)
+{
+	return be16_to_cpu(get_unaligned(p));
+}
+
+static inline u32 get_unaligned_be32(const __be32 *p)
+{
+	return be32_to_cpu(get_unaligned(p));
+}
+
+static inline u64 get_unaligned_be64(const __be64 *p)
+{
+	return be64_to_cpu(get_unaligned(p));
+}
+
+static inline void put_unaligned_le16(u16 val, void *p)
+{
+	put_unaligned(cpu_to_le16(val), (__le16 *)p);
+}
+
+static inline void put_unaligned_le32(u32 val, void *p)
+{
+	put_unaligned(cpu_to_le32(val), (__le32 *)p);
+}
+
+static inline void put_unaligned_le64(u64 val, void *p)
+{
+	put_unaligned(cpu_to_le64(val), (__le64 *)p);
+}
+
+static inline void put_unaligned_be16(u16 val, void *p)
+{
+	put_unaligned(cpu_to_be16(val), (__be16 *)p);
+}
+
+static inline void put_unaligned_be32(u32 val, void *p)
+{
+	put_unaligned(cpu_to_be32(val), (__be32 *)p);
+}
+
+static inline void put_unaligned_be64(u64 val, void *p)
+{
+	put_unaligned(cpu_to_be64(val), (__be64 *)p);
+}
+
+#endif
-- 
1.5.5.144.g3e42
