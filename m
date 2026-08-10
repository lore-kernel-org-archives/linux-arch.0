Received: from va-2-112.ptr.blmpb.com (va-2-112.ptr.blmpb.com [209.127.231.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F0F3CF69E
	for <linux-arch@vger.kernel.org>; Mon, 10 Aug 2026 12:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786364724; cv=none; b=g4T2pfKR7Fd7Qckaryda9hxW4VZxbuMN6GiDHbZwrnLA5V9eOFXUfhOEwYhBrdC3XCs+pi2DRYaUGIHWSnOz6Neldz8QA5Bw9gZvz3QvoLD56ZENBOd6z/q055gLiduYwFYareTlPKo6XZFZkV7K4aiglEgclAC0MHAGQ9owqP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786364724; c=relaxed/simple;
	bh=7Sbay6owjwp61KH6sE/CioV+gRC8N8OjwI7PcMzzr6M=;
	h=Cc:From:To:Message-Id:In-Reply-To:Subject:Date:Mime-Version:
	 References:Content-Type; b=R7/iazubBte2x3663e15wpuxDf4Z8AbTvj+2PlItM73WYk9oZrC62WPl0mR3yeGe7hob1Se6l7yngWn4Eke0sNAOr5vPoDrAu3eV16vfxICkiqzWAN8JkzWHzPUOntJnBpmPZ7/Tcqh+D/A7kw/pmaSpPFOElWIaFO7+qdhbJXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RB3opE5L; arc=none smtp.client-ip=209.127.231.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RB3opE5L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1786364711; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=TZuj0HlrM29RM25pBmz0Kgx3giTvhF2mK+AyOkzDqng=;
 b=RB3opE5LVCgkGE5rfHDkFT1Tfq+6NbTyih9BYBYGaPHlL59rpvKi/WxrX/7pluVH19X6a6
 kfxyru4nPf9HKjT/U3NI6n6XdHdIcX5KcZcv6rtMw83BgJdxsSEv7ZWArjTPg6CgvoNkPn
 MKKd3FLTVoZ22AESQi0sg4BpYhjYa9bzolWzFWUUmTq6r0ebZZ3AWRdbUnAjyWKQDtWbU1
 M9FAYokMUFydSyZvy7AiUYMXTToOW9tyMODipuvWabQ85+nzDQ17egsbGWBJPH5VeZ7g8Z
 ODApinJa6WrdmrxR9tF5a2b35KJ0OSq4FsCNPdYt+6P8j5eSW41Tufs6UBvNew==
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<muchun.song@linux.dev>, <rppt@kernel.org>, <tglx@kernel.org>
Message-Id: <20260810122057.30447-9-lizhe.67@bytedance.com>
In-Reply-To: <20260810122057.30447-1-lizhe.67@bytedance.com>
Subject: [PATCH v10 8/8] x86/string: extend memcpy_flushcache() fixed-size fastpaths
Date: Mon, 10 Aug 2026 20:20:57 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26a79c326+d4bca9+vger.kernel.org+lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
References: <20260810122057.30447-1-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8

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

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 arch/x86/include/asm/string_64.h | 71 +++++++++++++++++++++++++-------
 1 file changed, 56 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 21ae515ae35a..831d3dda3b38 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -82,23 +82,64 @@ int strcmp(const char *cs, const char *ct);
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 #define __HAVE_ARCH_MEMCPY_FLUSHCACHE 1
 void __memcpy_flushcache(void *dst, const void *src, size_t cnt);
-static __always_inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
+
+static __always_inline void movnti_4(void *dst, const void *src)
+{
+	asm volatile("movntil %1, %0"
+		     : "=m"(*(u32 *)dst)
+		     : "r"(*(const u32 *)src)
+		     : "memory");
+}
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
-	if (__builtin_constant_p(cnt)) {
-		switch (cnt) {
-			case 4:
-				asm ("movntil %1, %0" : "=m"(*(u32 *)dst) : "r"(*(u32 *)src));
-				return;
-			case 8:
-				asm ("movntiq %1, %0" : "=m"(*(u64 *)dst) : "r"(*(u64 *)src));
-				return;
-			case 16:
-				asm ("movntiq %1, %0" : "=m"(*(u64 *)dst) : "r"(*(u64 *)src));
-				asm ("movntiq %1, %0" : "=m"(*(u64 *)(dst + 8)) : "r"(*(u64 *)(src + 8)));
-				return;
-		}
+	if (!__builtin_constant_p(cnt))
+		return __memcpy_flushcache(dst, src, cnt);
+
+	/*
+	 * The relevant fixed-size copies here are the x86_64 struct page sizes:
+	 * 64, 80, and 96 bytes. Keep 32-byte and 48-byte copies inline as well
+	 * instead of sending those nearby fixed-size cases back to
+	 * __memcpy_flushcache().
+	 */
+	switch (cnt) {
+	case 4:  movnti_4(dst, src); break;
+	case 8:  movnti_8(dst, src); break;
+	case 16: movnti_16(dst, src); break;
+	case 32: movnti_32(dst, src); break;
+	case 48: movnti_32(dst, src); movnti_16(dst + 32, src + 32); break;
+	case 64: movnti_64(dst, src); break;
+	case 80: movnti_64(dst, src); movnti_16(dst + 64, src + 64); break;
+	case 96: movnti_64(dst, src); movnti_32(dst + 64, src + 64); break;
+	default: __memcpy_flushcache(dst, src, cnt); break;
 	}
-	__memcpy_flushcache(dst, src, cnt);
 }
 
 #define memcpy_nontemporal memcpy_nontemporal
-- 
2.20.1
