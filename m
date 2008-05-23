From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [PATCH 1/2] include: add linux/byteorder.h and linux/swab.h
Date: Fri, 23 May 2008 11:01:06 -0700
Message-ID: <1211565666.6888.29.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:61586 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755252AbYEWSBJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 23 May 2008 14:01:09 -0400
Received: by wf-out-1314.google.com with SMTP id 27so616123wfd.4
        for <linux-arch@vger.kernel.org>; Fri, 23 May 2008 11:01:07 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch <linux-arch@vger.kernel.org>

RFC: this would allow include/linux/byteorder/* to go away.

Arches must also now explicitly define either __LITTLE_ENDIAN or
__BIG_ENDIAN in asm/byteorder.h, there are guards in place in
linux/byteorder.h to make sure only one is defined.

All of the byteswapping routines now live in linux/swab.h taken from
linux/byteorder/swab.h and swabb.h
__swab16
__swab32
__swab64
__swahw32
__swahb32

There are p (pointer) and s (in-place) versions of each.

Tracing through the implementation order (swab16 family):

asm/byteorder.h:

__arch_swab16
{}

linux/swab.h:

__const_swab16 is a macro opencoding the byte-swapping in C.

___swab16() is an inline function that uses __arch_swab16 if HAVE_ARCH_SWAB16
was defined, otherwise it checks for an arch-defined pointer variant HAVE_ARCH_SWAP16P
and finally defaults to using __const_swab16.

__swab16p() is an inline function that uses __arch_swab16p if HAVE_ARCH_SWAB16P,
otherwise defaults to using ___swab16().

___swab16s() is an inline function that uses __arch_swab16s is HAVE_ARCH_SWAB16S,
otherwise defaults to using __swab16p().

__swab16 and __swab16s are defined as macros to allow constant folding.

Finally, define no-underscore versions if we are #ifdef __KERNEL__

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 include/linux/byteorder.h |  303 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/swab.h      |  228 ++++++++++++++++++++++++++++++++++
 2 files changed, 531 insertions(+), 0 deletions(-)

diff --git a/include/linux/byteorder.h b/include/linux/byteorder.h
new file mode 100644
index 0000000..62a098b
--- /dev/null
+++ b/include/linux/byteorder.h
@@ -0,0 +1,303 @@
+#ifndef _LINUX_BYTEORDER_H
+#define _LINUX_BYTEORDER_H
+
+#include <linux/types.h>
+#include <linux/swab.h>
+#include <asm/byteorder.h>
+
+#if defined(__LITTLE_ENDIAN) && defined(__BIG_ENDIAN)
+# error Fix asm/byteorder.h to define one endianness
+#endif
+
+#if !defined(__LITTLE_ENDIAN) && !defined(__BIG_ENDIAN)
+# error Fix asm/byteorder.h to define arch endianness
+#endif
+
+#if defined(__LITTLE_ENDIAN) && !defined(__LITTLE_ENDIAN_BITFIELD)
+# define __LITTLE_ENDIAN_BITFIELD
+#endif
+
+#if defined(__BIG_ENDIAN) && !defined(__BIG_ENDIAN_BITFIELD)
+# define __BIG_ENDIAN_BITFIELD
+#endif
+
+#ifdef __LITTLE_ENDIAN
+# define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
+# define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
+# define __le64_to_cpu(x) ((__force __u64)(__le64)(x))
+# define __cpu_to_le16(x) ((__force __le16)(__u16)(x))
+# define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
+# define __cpu_to_le64(x) ((__force __le64)(__u64)(x))
+# define __le16_to_cpus(x) do {} while (0)
+# define __le32_to_cpus(x) do {} while (0)
+# define __le64_to_cpus(x) do {} while (0)
+# define __cpu_to_le16s(x) do {} while (0)
+# define __cpu_to_le32s(x) do {} while (0)
+# define __cpu_to_le64s(x) do {} while (0)
+
+# define __be16_to_cpu(x) __swab16((__force __u16)(__be16)(x))
+# define __be32_to_cpu(x) __swab32((__force __u32)(__be32)(x))
+# define __be64_to_cpu(x) __swab64((__force __u64)(__be64)(x))
+# define __cpu_to_be16(x) ((__force __be16)__swab16((x)))
+# define __cpu_to_be32(x) ((__force __be32)__swab32((x)))
+# define __cpu_to_be64(x) ((__force __be64)__swab64((x)))
+# define __be16_to_cpus(x) __swab16s((x))
+# define __be32_to_cpus(x) __swab32s((x))
+# define __be64_to_cpus(x) __swab64s((x))
+# define __cpu_to_be16s(x) __swab16s((x))
+# define __cpu_to_be32s(x) __swab32s((x))
+# define __cpu_to_be64s(x) __swab64s((x))
+#endif
+
+#ifdef __BIG_ENDIAN
+# define __be16_to_cpu(x) ((__force __u16)(__be16)(x))
+# define __be32_to_cpu(x) ((__force __u32)(__be32)(x))
+# define __be64_to_cpu(x) ((__force __u64)(__be64)(x))
+# define __cpu_to_be16(x) ((__force __be16)(__u16)(x))
+# define __cpu_to_be32(x) ((__force __be32)(__u32)(x))
+# define __cpu_to_be64(x) ((__force __be64)(__u64)(x))
+# define __be16_to_cpus(x) do {} while (0)
+# define __be32_to_cpus(x) do {} while (0)
+# define __be64_to_cpus(x) do {} while (0)
+# define __cpu_to_be16s(x) do {} while (0)
+# define __cpu_to_be32s(x) do {} while (0)
+# define __cpu_to_be64s(x) do {} while (0)
+
+# define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
+# define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
+# define __le64_to_cpu(x) __swab64((__force __u64)(__le64)(x))
+# define __cpu_to_le16(x) ((__force __le16)__swab16((x)))
+# define __cpu_to_le32(x) ((__force __le32)__swab32((x)))
+# define __cpu_to_le64(x) ((__force __le64)__swab64((x)))
+# define __le16_to_cpus(x) __swab16s((x))
+# define __le32_to_cpus(x) __swab32s((x))
+# define __le64_to_cpus(x) __swab64s((x))
+# define __cpu_to_le16s(x) __swab16s((x))
+# define __cpu_to_le32s(x) __swab32s((x))
+# define __cpu_to_le64s(x) __swab64s((x))
+#endif
+
+/*
+ * These helpers could be phased out over time as the base version
+ * handles constants.
+ */
+#define __constant_htonl(x) __cpu_to_be32((x))
+#define __constant_ntohl(x) __be32_to_cpu((x))
+#define __constant_htons(x) __cpu_to_be16((x))
+#define __constant_ntohs(x) __be16_to_cpu((x))
+
+#define __constant_le16_to_cpu(x) __le16_to_cpu((x))
+#define __constant_le32_to_cpu(x) __le32_to_cpu((x))
+#define __constant_le64_to_cpu(x) __le64_to_cpu((x))
+#define __constant_be16_to_cpu(x) __be16_to_cpu((x))
+#define __constant_be32_to_cpu(x) __be32_to_cpu((x))
+#define __constant_be64_to_cpu(x) __be64_to_cpu((x))
+
+#define __constant_cpu_to_le16(x) __cpu_to_le16((x))
+#define __constant_cpu_to_le32(x) __cpu_to_le32((x))
+#define __constant_cpu_to_le64(x) __cpu_to_le64((x))
+#define __constant_cpu_to_be16(x) __cpu_to_be16((x))
+#define __constant_cpu_to_be32(x) __cpu_to_be32((x))
+#define __constant_cpu_to_be64(x) __cpu_to_be64((x))
+
+static inline __u16 __le16_to_cpup(const __le16 *p)
+{
+#ifdef __LITTLE_ENDIAN
+	return (__force __u16)*p;
+#else
+	return __swab16p((__force __u16 *)p);
+#endif
+}
+
+static inline __u32 __le32_to_cpup(const __le32 *p)
+{
+#ifdef __LITTLE_ENDIAN
+	return (__force __u32)*p;
+#else
+	return __swab32p((__force __u32 *)p);
+#endif
+}
+
+static inline __u64 __le64_to_cpup(const __le64 *p)
+{
+#ifdef __LITTLE_ENDIAN
+	return (__force __u64)*p;
+#else
+	return __swab64p((__force __u64 *)p);
+#endif
+}
+
+static inline __le16 __cpu_to_le16p(const __u16 *p)
+{
+#ifdef __LITTLE_ENDIAN
+	return (__force __le16)*p;
+#else
+	return (__force __le16)__swab16p(p);
+#endif
+}
+
+static inline __le32 __cpu_to_le32p(const __u32 *p)
+{
+#ifdef __LITTLE_ENDIAN
+	return (__force __le32)*p;
+#else
+	return (__force __le32)__swab32p(p);
+#endif
+}
+
+static inline __le64 __cpu_to_le64p(const __u64 *p)
+{
+#ifdef __LITTLE_ENDIAN
+	return (__force __le64)*p;
+#else
+	return (__force __le64)__swab64p(p);
+#endif
+}
+
+static inline __u16 __be16_to_cpup(const __be16 *p)
+{
+#ifdef __BIG_ENDIAN
+	return (__force __u16)*p;
+#else
+	return __swab16p((__force __u16 *)p);
+#endif
+}
+
+static inline __u32 __be32_to_cpup(const __be32 *p)
+{
+#ifdef __BIG_ENDIAN
+	return (__force __u32)*p;
+#else
+	return __swab32p((__force __u32 *)p);
+#endif
+}
+
+static inline __u64 __be64_to_cpup(const __be64 *p)
+{
+#ifdef __BIG_ENDIAN
+	return (__force __u64)*p;
+#else
+	return __swab64p((__force __u64 *)p);
+#endif
+}
+
+static inline __be16 __cpu_to_be16p(const __u16 *p)
+{
+#ifdef __BIG_ENDIAN
+	return (__force __be16)*p;
+#else
+	return (__force __be16)__swab16p(p);
+#endif
+}
+
+static inline __be32 __cpu_to_be32p(const __u32 *p)
+{
+#ifdef __BIG_ENDIAN
+	return (__force __be32)*p;
+#else
+	return (__force __be32)__swab32p(p);
+#endif
+}
+
+static inline __be64 __cpu_to_be64p(const __u64 *p)
+{
+#ifdef __BIG_ENDIAN
+	return (__force __be64)*p;
+#else
+	return (__force __be64)__swab64p(p);
+#endif
+}
+
+#ifdef __KERNEL__
+
+# define le16_to_cpu __le16_to_cpu
+# define le32_to_cpu __le32_to_cpu
+# define le64_to_cpu __le64_to_cpu
+# define be16_to_cpu __be16_to_cpu
+# define be32_to_cpu __be32_to_cpu
+# define be64_to_cpu __be64_to_cpu
+# define cpu_to_le16 __cpu_to_le16
+# define cpu_to_le32 __cpu_to_le32
+# define cpu_to_le64 __cpu_to_le64
+# define cpu_to_be16 __cpu_to_be16
+# define cpu_to_be32 __cpu_to_be32
+# define cpu_to_be64 __cpu_to_be64
+
+# define le16_to_cpup __le16_to_cpup
+# define le32_to_cpup __le32_to_cpup
+# define le64_to_cpup __le64_to_cpup
+# define be16_to_cpup __be16_to_cpup
+# define be32_to_cpup __be32_to_cpup
+# define be64_to_cpup __be64_to_cpup
+# define cpu_to_le16p __cpu_to_le16p
+# define cpu_to_le32p __cpu_to_le32p
+# define cpu_to_le64p __cpu_to_le64p
+# define cpu_to_be16p __cpu_to_be16p
+# define cpu_to_be32p __cpu_to_be32p
+# define cpu_to_be64p __cpu_to_be64p
+
+# define le16_to_cpus __le16_to_cpus
+# define le32_to_cpus __le32_to_cpus
+# define le64_to_cpus __le64_to_cpus
+# define be16_to_cpus __be16_to_cpus
+# define be32_to_cpus __be32_to_cpus
+# define be64_to_cpus __be64_to_cpus
+# define cpu_to_le16s __cpu_to_le16s
+# define cpu_to_le32s __cpu_to_le32s
+# define cpu_to_le64s __cpu_to_le64s
+# define cpu_to_be16s __cpu_to_be16s
+# define cpu_to_be32s __cpu_to_be32s
+# define cpu_to_be64s __cpu_to_be64s
+
+/*
+ * They have to be macros in order to do the constant folding
+ * correctly - if the argument passed into a inline function
+ * it is no longer constant according to gcc..
+ */
+# undef ntohl
+# undef ntohs
+# undef htonl
+# undef htons
+
+# define ___htonl(x) __cpu_to_be32(x)
+# define ___htons(x) __cpu_to_be16(x)
+# define ___ntohl(x) __be32_to_cpu(x)
+# define ___ntohs(x) __be16_to_cpu(x)
+
+# define htonl(x) ___htonl(x)
+# define ntohl(x) ___ntohl(x)
+# define htons(x) ___htons(x)
+# define ntohs(x) ___ntohs(x)
+
+static inline void le16_add_cpu(__le16 *var, u16 val)
+{
+	*var = cpu_to_le16(le16_to_cpup(var) + val);
+}
+
+static inline void le32_add_cpu(__le32 *var, u32 val)
+{
+	*var = cpu_to_le32(le32_to_cpup(var) + val);
+}
+
+static inline void le64_add_cpu(__le64 *var, u64 val)
+{
+	*var = cpu_to_le64(le64_to_cpup(var) + val);
+}
+
+static inline void be16_add_cpu(__be16 *var, u16 val)
+{
+	*var = cpu_to_be16(be16_to_cpup(var) + val);
+}
+
+static inline void be32_add_cpu(__be32 *var, u32 val)
+{
+	*var = cpu_to_be32(be32_to_cpup(var) + val);
+}
+
+static inline void be64_add_cpu(__be64 *var, u64 val)
+{
+	*var = cpu_to_be64(be64_to_cpup(var) + val);
+}
+
+#endif /* __KERNEL__ */
+#endif /* _LINUX_BYTEORDER_H */
diff --git a/include/linux/swab.h b/include/linux/swab.h
new file mode 100644
index 0000000..e1b4128
--- /dev/null
+++ b/include/linux/swab.h
@@ -0,0 +1,228 @@
+#ifndef _LINUX_SWAB_H
+#define _LINUX_SWAB_H
+
+#include <linux/types.h>
+#include <linux/compiler.h>
+#include <asm/swab.h>
+
+/*
+ * casts are necessary for constants, because we never know how for sure
+ * how U/UL/ULL map to __u16, __u32, __u64. At least not in a portable way.
+ */
+#define __const_swab16(x) ((__u16)(				\
+	(((__u16)(x) & (__u16)0x00ffU) << 8) |			\
+	(((__u16)(x) & (__u16)0xff00U) >> 8)))
+
+#define __const_swab32(x) ((__u32)(				\
+	(((__u32)(x) & (__u32)0x000000ffUL) << 24) |		\
+	(((__u32)(x) & (__u32)0x0000ff00UL) <<  8) |		\
+	(((__u32)(x) & (__u32)0x00ff0000UL) >>  8) |		\
+	(((__u32)(x) & (__u32)0xff000000UL) >> 24)))
+
+#define __const_swab64(x) ((__u64)(				\
+	(((__u64)(x) & (__u64)0x00000000000000ffULL) << 56) |	\
+	(((__u64)(x) & (__u64)0x000000000000ff00ULL) << 40) |	\
+	(((__u64)(x) & (__u64)0x0000000000ff0000ULL) << 24) |	\
+	(((__u64)(x) & (__u64)0x00000000ff000000ULL) <<  8) |	\
+	(((__u64)(x) & (__u64)0x000000ff00000000ULL) >>  8) |	\
+	(((__u64)(x) & (__u64)0x0000ff0000000000ULL) >> 24) |	\
+	(((__u64)(x) & (__u64)0x00ff000000000000ULL) >> 40) |	\
+	(((__u64)(x) & (__u64)0xff00000000000000ULL) >> 56)))
+
+#define __const_swahw32(x) ((__u32)(				\
+	(((__u32)(x) & (__u32)0x0000ffffUL) << 16) |		\
+	(((__u32)(x) & (__u32)0xffff0000UL) >> 16)))
+
+#define __const_swahb32(x) ((__u32)(				\
+	(((__u32)(x) & (__u32)0x00ff00ffUL) << 8) |		\
+	(((__u32)(x) & (__u32)0xff00ff00UL) >> 8)))
+
+static inline __attribute_const__ __u16 ___swab16(__u16 val)
+{
+#ifdef HAVE_ARCH_SWAB16
+	return __arch_swab16(val);
+#elif HAVE_ARCH_SWAB16P
+	return __arch_swab16p(&val);
+#else
+	return __const_swab16(val);
+#endif
+}
+
+static inline __attribute_const__ __u32 ___swab32(__u32 val)
+{
+#ifdef HAVE_ARCH_SWAB32
+	return __arch_swab32(val);
+#elif HAVE_ARCH_SWAB32P
+	return __arch_swab32p(&val);
+#else
+	return __const_swab32(val);
+#endif
+}
+
+static inline __attribute_const__ __u64 ___swab64(__u64 val)
+{
+#ifdef HAVE_ARCH_SWAB64
+	return __arch_swab64(val);
+#elif HAVE_ARCH_SWAB64P
+	return __arch_swab64p(&val);
+#else
+	return __const_swab64(val);
+#endif
+}
+
+static inline __attribute_const__ __u32 ___swahw32(__u32 val)
+{
+#ifdef HAVE_ARCH_SWAHW32
+	return __arch_swahw32(val);
+#elif HAVE_ARCH_SWAHW32P
+	return __arch_swahw32p(&val);
+#else
+	return __const_swahw32(val);
+#endif
+}
+
+static inline __attribute_const__ __u32 ___swah32(__u32 val)
+{
+#ifdef HAVE_ARCH_SWAHB32
+	return __arch_swahb32(val);
+#elif HAVE_ARCH_SWAHB32P
+	return __arch_swahb32p(&val);
+#else
+	return __const_swahb32(val);
+#endif
+}
+
+static inline __u16 ___swab16p(const __u16 *p)
+{
+#ifdef HAVE_ARCH_SWAB16P
+	return __arch_swab16p(p);
+#else
+	return ___swab16(*p);
+#endif
+}
+
+static inline __u32 ___swab32p(const __u32 *p)
+{
+#ifdef HAVE_ARCH_SWAB32P
+	return __arch_swab32p(p);
+#else
+	return ___swab32(*p);
+#endif
+}
+
+static inline __u64 ___swab64p(const __u64 *p)
+{
+#ifdef HAVE_ARCH_SWAB64P
+	return __arch_swab64p(p);
+#else
+	return ___swab64(*p);
+#endif
+}
+
+static inline __u32 ___swahw32p(const __u32 *p)
+{
+#ifdef HAVE_ARCH_SWAHW32P
+	return __arch_swahw32p(p);
+#else
+	return ___swahw32(*p);
+#endif
+}
+
+static inline __u32 ___swahb32p(const __u32 *p)
+{
+#ifdef HAVE_ARCH_SWAHB32P
+	return __arch_swahb32p(p);
+#else
+	return ___swahb32(*p);
+#endif
+}
+
+static inline void ___swab16s(__u16 *p)
+{
+#ifdef HAVE_ARCH_SWAB16S
+	__arch_swab16s(p);
+#else
+	*p = __swab16p(p);
+#endif
+}
+
+static inline void ___swab32s(__u32 *p)
+{
+#ifdef HAVE_ARCH_SWAB32S
+	__arch_swab32s(p);
+#else
+	*p = __swab32p(p);
+#endif
+}
+
+static inline void ___swab64s(__u64 *p)
+{
+#ifdef HAVE_ARCH_SWAB64S
+	__arch_swab64s(p);
+#else
+	*p = __swab64p(p);
+#endif
+}
+
+static inline void ___swahw32s(__u32 *p)
+{
+#ifdef HAVE_ARCH_SWAHW32S
+	__arch_swahw32s(p);
+#else
+	*p = __swahw32p(p);
+#endif
+}
+
+static inline void ___swahb32s(__u32 *p)
+{
+#ifdef HAVE_ARCH_SWAHB32S
+	__arch_swahb32s(p);
+#else
+	*p = __swahb32p(p);
+#endif
+}
+
+#define __swab16(x)				\
+	(__builtin_constant_p((__u16)(x)) ?	\
+	__const_swab16((x)) :			\
+	___swab16((x)))
+
+#define __swab32(x)				\
+	(__builtin_constant_p((__u32)(x)) ?	\
+	__const_swab32((x)) :			\
+	___swab32((x)))
+
+#define __swab64(x)				\
+	(__builtin_constant_p((__u64)(x)) ?	\
+	__const_swab64((x)) :			\
+	___swab64((x)))
+
+#define __swahw32(x)				\
+	(__builtin_constant_p((__u32)(x)) ?	\
+	__const_swahw32((x)) :			\
+	___swahw32((x)))
+
+#define __swahb32(x)				\
+	(__builtin_constant_p((__u32)(x)) ?	\
+	__const_swahb32((x)) :			\
+	___swahb32((x)))
+
+#ifdef __KERNEL__
+# define swab16 __swab16
+# define swab32 __swab32
+# define swab64 __swab64
+# define swahw32 __swahw32
+# define swahb32 __swahb32
+# define swab16p __swab16p
+# define swab32p __swab32p
+# define swab64p __swab64p
+# define swahw32p __swahw32p
+# define swahb32p __swahb32p
+# define swab16s __swab16s
+# define swab32s __swab32s
+# define swab64s __swab64s
+# define swahw32s __swahw32s
+# define swahb32s __swahb32s
+#endif /* __KERNEL__ */
+
+#endif /* _LINUX_SWAB_H */
-- 
1.5.5.1.579.g4e43
