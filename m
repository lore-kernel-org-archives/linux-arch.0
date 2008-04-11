From: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv2 1/8] kernel: add common infrastructure for unaligned
	access
Date: Thu, 10 Apr 2008 17:06:34 -0700
Message-ID: <1207872394.22001.69.camel@brick>
References: <1207856646.22001.25.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1207856646.22001.25.camel@brick>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Small update changing the exposed API of get_unaligned_* take
a void * to avoid casts in every single caller.  We are already
specifying what we want to get explicitly in the function name:
get_unaligned_le16...le32...le64..etc.

This will make 8/8 look even cleaner as a bunch of casts are not
needed.

Harvey

diff --git a/include/linux/unaligned/access_ok.h b/include/linux/unaligned/access_ok.h
new file mode 100644
index 0000000..3668b45
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
diff --git a/include/linux/unaligned/big_endian.h b/include/linux/unaligned/big_endian.h
new file mode 100644
index 0000000..f3cd105
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
index 0000000..50ce393
--- /dev/null
+++ b/include/linux/unaligned/generic.h
@@ -0,0 +1,67 @@
+#ifndef _LINUX_UNALIGNED_GENERIC_H_
+#define _LINUX_UNALIGNED_GENERIC_H_
+
+#include <linux/unaligned/little_endian.h>
+#include <linux/unaligned/big_endian.h>
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
index 0000000..a200aca
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
index 0000000..8a6f6ae
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
index 0000000..860af6b
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
index 0000000..9b9e803
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
+static inline u16 get_unaligned_le16(const void *p)
+{
+	return le16_to_cpu(get_unaligned((__le16 *)p));
+}
+
+static inline u32 get_unaligned_le32(const void *p)
+{
+	return le32_to_cpu(get_unaligned((__le32 *)p));
+}
+
+static inline u64 get_unaligned_le64(const void *p)
+{
+	return le64_to_cpu(get_unaligned((__le64 *)p));
+}
+
+static inline u16 get_unaligned_be16(const void *p)
+{
+	return be16_to_cpu(get_unaligned((__be16 *)p));
+}
+
+static inline u32 get_unaligned_be32(const void *p)
+{
+	return be32_to_cpu(get_unaligned((__be32 *)p));
+}
+
+static inline u64 get_unaligned_be64(const void *p)
+{
+	return be64_to_cpu(get_unaligned((__be64 *)p));
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
