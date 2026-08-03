Received: from va-2-115.ptr.blmpb.com (va-2-115.ptr.blmpb.com [209.127.231.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2278039F168
	for <linux-arch@vger.kernel.org>; Mon,  3 Aug 2026 07:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785741219; cv=none; b=k7ZPxn5YvVTKGg3d7TjGt+kmdMtZzuUup2PqV0Z1W3vSlpYlyMjiID7mLJBXhbmmZIfU2i3UF9ljv7XRZmOUzestjbQAw7vKdGCGWwneQUHNF7UR9bclFK4non49trXBcc0w00tH3ai47MKaAgObMgOUVfPLrg9sloQK7Mff1fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785741219; c=relaxed/simple;
	bh=TMtTGhhxZdFRxGsPHF5jJUnWLZuizSJM5R4OEVYMfjs=;
	h=Content-Type:From:Message-Id:Mime-Version:In-Reply-To:References:
	 To:Subject:Cc:Date; b=gTSubqYcQTQXhmkS/h0eRHOS89a7M6LJ8mtcuFsaWFvBV8dfU7urrMUCvUEuqmCYseVBg4kCueoSu98rHGEex0HGF9gLN0pvTKQi4mdpgklbGLaBfpjmzhOsxsb22n0MjwmKqrNW7S7MlY4CBrhE6N+4NpPpSsHR4fsDOmvjE4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=codJXF7y; arc=none smtp.client-ip=209.127.231.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="codJXF7y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1785741205; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=/NdI+a5QV2PO1JVHqbHPiO12lvnhARSugrgjYx4LQKM=;
 b=codJXF7y65AkdNReRLLLe0+Haqt7xmpCtF1D14X9cofjoXsd8B37OkJK9od5YigNunGvXK
 4xjGCBDBSb3KkPJTvLNYsU6EQ36Hhwaw9R1iKS4DsA/Mi41IRuqKXhpK2EnwAQaoXALC9T
 TTEJK1RsoxZ350Zzyet8W/NkYfTmotBWDJpc5/XRbu3Di9q7LqIS2A1+aYih0next75DJj
 bRrSgEDRKZZfk52WYpN8dT67ns/tvD4nJ1q9cX3VMTQ1WYRciMog5b32xzgzBtsrb4b3pl
 DnBNI5buM4XWWxXqv1WIgHOQOi/cvHRJf93f2UZMZOPL8yIXzo/6UhmAHrETgA==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
From: "Li Zhe" <lizhe.67@bytedance.com>
Message-Id: <20260803070929.86075-9-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a703f93+495a21+vger.kernel.org+lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260803070929.86075-1-lizhe.67@bytedance.com>
References: <20260803070929.86075-1-lizhe.67@bytedance.com>
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<muchun.song@linux.dev>, <rppt@kernel.org>, <tglx@kernel.org>
Subject: [PATCH v9 8/8] x86/string: extend memcpy_flushcache() fixed-size fastpaths
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
Date: Mon,  3 Aug 2026 15:09:29 +0800

The x86 memcpy_nontemporal() helper maps to memcpy_flushcache(), and the
ZONE_DEVICE template-copy path uses it to copy one struct page at a
time.

The relevant copy size is sizeof(struct page). On x86_64, the base struct
page layout is 64 bytes. Adding either the KMSAN metadata pointers or an
out-of-flags last_cpupid field can make it 80 bytes after alignment, and
enabling both can make it 96 bytes.

memcpy_flushcache() currently only has inline fixed-size cases for 4, 8,
and 16 bytes. As a result, these constant-sized struct page copies fall
through to __memcpy_flushcache() even though the compiler knows the copy
size at the call site.

Add fixed-size MOVNTI cases up to 96 bytes so the ZONE_DEVICE
template-copy path can keep these struct page copies in the inline
memcpy_flushcache() path.

This matters for ZONE_DEVICE memmap initialization because the copy
happens once per initialized struct page. For a 100 GB fsdax namespace
with map=dev, this is about 25 million struct page copies during nd_pmem
binding or rebinding.

Tested in a VM with a 100 GB fsdax namespace device configured with
map=dev and a 100 GB devdax namespace (align=2097152) on Intel Ice Lake
server.

Test procedure:
Rebind the nd_pmem and dax_pmem drivers 30 times and collect the memmap
initialization time from the pr_debug() output of
memmap_init_zone_device().

With memcpy_nontemporal() used by the ZONE_DEVICE template-copy path:
  Average of rebinds for nd_pmem driver: 150.83 ms
  Average of rebinds for dax_pmem driver: 153.55 ms

With this x86 fixed-size fastpath patch applied:
  Average of rebinds for nd_pmem driver: 96.79 ms
  Average of rebinds for dax_pmem driver: 119.04 ms

This further reduces the average memmap initialization time measured
during rebind by about 35.8% for nd_pmem and 22.5% for dax_pmem.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 arch/x86/include/asm/string_64.h | 56 +++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 21ae515ae35a..bc6a9f34b346 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -82,7 +82,35 @@ int strcmp(const char *cs, const char *ct);
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 #define __HAVE_ARCH_MEMCPY_FLUSHCACHE 1
 void __memcpy_flushcache(void *dst, const void *src, size_t cnt);
-static __always_inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
+
+static __always_inline void movnti_8(void *dst, const void *src)
+{
+	asm volatile("movntiq %1, %0"
+		     : "=m"(*(u64 *)dst)
+		     : "r"(*(const u64 *)src)
+		     : "memory");
+}
+
+static __always_inline void movnti_16(void *dst, const void *src)
+{
+	movnti_8(dst, src);
+	movnti_8(dst + 8, src + 8);
+}
+
+static __always_inline void movnti_32(void *dst, const void *src)
+{
+	movnti_16(dst, src);
+	movnti_16(dst + 16, src + 16);
+}
+
+static __always_inline void movnti_64(void *dst, const void *src)
+{
+	movnti_32(dst, src);
+	movnti_32(dst + 32, src + 32);
+}
+
+static __always_inline void memcpy_flushcache(void *dst, const void *src,
+					      size_t cnt)
 {
 	if (__builtin_constant_p(cnt)) {
 		switch (cnt) {
@@ -96,8 +124,34 @@ static __always_inline void memcpy_flushcache(void *dst, const void *src, size_t
 				asm ("movntiq %1, %0" : "=m"(*(u64 *)dst) : "r"(*(u64 *)src));
 				asm ("movntiq %1, %0" : "=m"(*(u64 *)(dst + 8)) : "r"(*(u64 *)(src + 8)));
 				return;
+			/*
+			 * The relevant fixed-size copies here are the
+			 * x86_64 struct page sizes: 64, 80, and 96 bytes.
+			 * Keep 32-byte and 48-byte copies inline as well
+			 * instead of sending those nearby fixed-size
+			 * cases back to __memcpy_flushcache().
+			 */
+			case 32:
+				movnti_32(dst, src);
+				return;
+			case 48:
+				movnti_32(dst, src);
+				movnti_16(dst + 32, src + 32);
+				return;
+			case 64:
+				movnti_64(dst, src);
+				return;
+			case 80:
+				movnti_64(dst, src);
+				movnti_16(dst + 64, src + 64);
+				return;
+			case 96:
+				movnti_64(dst, src);
+				movnti_32(dst + 64, src + 64);
+				return;
 		}
 	}
+
 	__memcpy_flushcache(dst, src, cnt);
 }
 
-- 
2.20.1
