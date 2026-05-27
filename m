Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7D5383C95
	for <linux-arch@vger.kernel.org>; Wed, 27 May 2026 03:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779853238; cv=none; b=KwiTFSkfuxbij75b7oDnXymqiEAT8eZvHKXTdkQzpX+pAVC/or0F6SHEeSFlW9vRt/d5e0qwymUkx2vS9Sr4zQ+tusZuOsiXQWX2tiC9uBpu6EpnfKIWgpSXKxQUeZFEQgzG5OAxCwzPhTLOjyqrDOyUazTg8fxxxW0qDhRjyQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779853238; c=relaxed/simple;
	bh=owEAbc5vf/a1Bh9MErm0fqtO4o73BLGK9Nbp32zKEYE=;
	h=Message-Id:References:Cc:From:Content-Type:To:Date:In-Reply-To:
	 Subject:Mime-Version; b=cz2YNVLSrGWpPawHAIbowXNeUrCv9GqNhkTcyEXcqrEdHnoCgW5R0Ez4OOeI3qWx1hZ9jYXw3HnV32rTp2Al9xIBuo80rpwh2Bg3RJQ887YMMWAV20ZMGWzkdlu+mx9dzezfxoN9pJsKwZEXaVgzZiU455c6Pc32jghqCmX9DHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=oFjOk4qQ; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="oFjOk4qQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779853232; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=kJpm339USLr3ZYM719LtoiE3fktdOEdjk2CrZTZZdLc=;
 b=oFjOk4qQhMiG8po92VVLk9UGTEdsfPyQrFr9BomK8iJHh708mm9zzBxXZQ6TVZIJm6acg+
 pIOrHYW0J5avxnddrvuFXKJva1Hi+xwp5A/qPyVKdyQjqt4cR3TNoZX0enxsAL5kVNRoY+
 fF+DTM/v0oDf5lilrLp4RORkejPyj2yzi2LOow2oCJpj4j9J7SgfFXi3FfBsn32FhodHg0
 4vMLfjj2BgxfOzbLegZ0IR8ofrkFe6bw3FkWVMdJ0onztcyzil8mPQB4J9YdZh/S0hHn+t
 lc0us9jWcHzpFKiTWTavFA8FZaudtlu9tNRdj3/ZhzMQWoJms+gFIQsbYBrceQ==
Message-Id: <20260527033636.28231-8-lizhe.67@bytedance.com>
References: <20260527033636.28231-1-lizhe.67@bytedance.com>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	"Li Zhe" <lizhe.67@bytedance.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a1667ae+fc958e+vger.kernel.org+lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>
Date: Wed, 27 May 2026 11:36:35 +0800
In-Reply-To: <20260527033636.28231-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
Subject: [PATCH v3 7/8] x86/string: extend memcpy_flushcache() fixed-size fastpaths
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

Small constant-sized flushcache copies currently fall back to
__memcpy_flushcache() unless they are exactly 4, 8, or 16 bytes.

Factor the existing inline movnti sequences into small helpers and
extend the fixed-size fastpath coverage to 24..96 bytes for naturally
aligned transfers. This keeps common struct-page-sized copies on the
inline path for the upcoming memcpy_streaming() user, while still
falling back to __memcpy_flushcache() for unaligned or uncommon sizes.
Zero-length copies return immediately.

Issue the fixed-size stores in ascending address order so
write-combining sees a forward stream.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 arch/x86/include/asm/string_64.h | 125 ++++++++++++++++++++++++++-----
 1 file changed, 107 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 0b57e9e6f3db..8e6fca0185ee 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -82,24 +82,6 @@ int strcmp(const char *cs, const char *ct);
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 #define __HAVE_ARCH_MEMCPY_FLUSHCACHE 1
 void __memcpy_flushcache(void *dst, const void *src, size_t cnt);
-static __always_inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
-{
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
-	}
-	__memcpy_flushcache(dst, src, cnt);
-}
 
 /*
  * Only reuse memcpy_flushcache() for transfers that can stay entirely
@@ -123,6 +105,113 @@ static __always_inline int memcpy_flushcache_nt_safe(const void *dst,
 	return cnt == 4 && !(d & 3) && !(s & 3);
 }
 
+static __always_inline void memcpy_flushcache_4(void *dst, const void *src)
+{
+	asm volatile("movntil %1, %0"
+		     : "=m"(*(u32 *)dst)
+		     : "r"(*(const u32 *)src)
+		     : "memory");
+}
+
+static __always_inline void memcpy_flushcache_8(void *dst, const void *src)
+{
+	asm volatile("movntiq %1, %0"
+		     : "=m"(*(u64 *)dst)
+		     : "r"(*(const u64 *)src)
+		     : "memory");
+}
+
+static __always_inline void memcpy_flushcache_16(void *dst,
+						 const void *src)
+{
+	memcpy_flushcache_8(dst, src);
+	memcpy_flushcache_8(dst + 8, src + 8);
+}
+
+static __always_inline void memcpy_flushcache_32(void *dst,
+						 const void *src)
+{
+	memcpy_flushcache_16(dst, src);
+	memcpy_flushcache_16(dst + 16, src + 16);
+}
+
+static __always_inline void memcpy_flushcache_64(void *dst,
+						 const void *src)
+{
+	memcpy_flushcache_32(dst, src);
+	memcpy_flushcache_32(dst + 32, src + 32);
+}
+
+/*
+ * Keep common fixed-size copies on the inline movnti path when they can
+ * stay entirely on aligned non-temporal stores. Issue the stores in
+ * ascending address order so write-combining sees a forward stream.
+ */
+static __always_inline int memcpy_flushcache_small(void *dst,
+						   const void *src,
+						   size_t cnt)
+{
+	char *d = dst;
+	const char *s = src;
+
+	if (!memcpy_flushcache_nt_safe(dst, src, cnt))
+		return 0;
+
+	switch (cnt) {
+	case 4:
+		memcpy_flushcache_4(d, s);
+		return 1;
+	case 8:
+		memcpy_flushcache_8(d, s);
+		return 1;
+	}
+
+	if (cnt & 8) {
+		memcpy_flushcache_8(d, s);
+		d += 8;
+		s += 8;
+		cnt -= 8;
+	}
+
+	switch (cnt) {
+	case 16:
+		memcpy_flushcache_16(d, s);
+		return 1;
+	case 32:
+		memcpy_flushcache_32(d, s);
+		return 1;
+	case 48:
+		memcpy_flushcache_32(d, s);
+		memcpy_flushcache_16(d + 32, s + 32);
+		return 1;
+	case 64:
+		memcpy_flushcache_64(d, s);
+		return 1;
+	case 80:
+		memcpy_flushcache_64(d, s);
+		memcpy_flushcache_16(d + 64, s + 64);
+		return 1;
+	case 96:
+		memcpy_flushcache_64(d, s);
+		memcpy_flushcache_32(d + 64, s + 64);
+		return 1;
+	}
+
+	return 0;
+}
+
+static __always_inline void memcpy_flushcache(void *dst, const void *src,
+					      size_t cnt)
+{
+	if (!cnt)
+		return;
+
+	if (__builtin_constant_p(cnt) && memcpy_flushcache_small(dst, src, cnt))
+		return;
+
+	__memcpy_flushcache(dst, src, cnt);
+}
+
 #define __HAVE_ARCH_MEMCPY_STREAMING 1
 static __always_inline void memcpy_streaming(void *dst, const void *src,
 					     size_t cnt)
-- 
2.20.1
