Received: from va-1-111.ptr.blmpb.com (va-1-111.ptr.blmpb.com [209.127.230.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FAE396B9A
	for <linux-arch@vger.kernel.org>; Wed,  3 Jun 2026 08:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780474066; cv=none; b=YoYOL/5kHEotemDJ2Q6gOR0KFKHgEG9Qh7yOZuXD7REZco3ANmxLu4W4vOGmeyO10Sq28w6O/I6BxV1THjsL8C4wPTVwWFuXuvGMD7lpyrLJvBPJ3mh6E4s9r/4hoItoIAWpZmHUVl1liOgv787zes/+Y2Rklp6LJhWgAWIB4oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780474066; c=relaxed/simple;
	bh=z/Ea2k7fpYsGEUt9hh88F/a4jksvVj//QreE6FccEYs=;
	h=Subject:Date:From:In-Reply-To:Message-Id:Mime-Version:To:
	 References:Content-Type:Cc; b=d5kDwwiU4AvoxtROPyyQj0qRvZTlfXZLnfRE9dJhwhrefoeOKjGcQ5TJUPgpSjeiFLiJmcIJv6Qmq8KIxjA3lLqjeHql8SJwFSeUYzTvMGzymsMXoDToDfhPm5S5o21d8d6ChdGnUMfzy0rhgNlfuppbUjI+2nP0HnmOHVRQEzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UzbACo83; arc=none smtp.client-ip=209.127.230.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UzbACo83"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1780474061; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=gRJ/J0Nb17+iEYOrMVREQ16d2zbIiv+jVQRVIwQKMg0=;
 b=UzbACo833+fZrHQgsSodG9/cGosdHc9uxTR0mzQTdV/YYzjBVArtNlLsAR1Fuwvu2ewzTK
 6D4DJIRRTAKPLSjDCDgpzkgLVxy9k1KmkL4cqXxHo1WmZdeNhK5oAdFZF6h8Qq21bMk39d
 Jq9qOAMpmD9cog0JqIBZCyaVcg/6k9LU4A7Dksc5p8/Yc38fs/hQKHkpthMYuMC4praukD
 8dpIf16uBEtZnyCmclYuhgprQ9MXD9HMRZv60Khhwg1M885ZWxHa54mnR+BW2Xpv1ebjte
 IUdRAAkeeJuY89e3CqOtB70jLu/u0qi1qrX6aCiDnhulkYt8lE/bPpaGwsQOug==
Subject: [PATCH v4 7/8] x86/string: extend memcpy_flushcache() fixed-size fastpaths
Date: Wed,  3 Jun 2026 16:01:51 +0800
From: "Li Zhe" <lizhe.67@bytedance.com>
In-Reply-To: <20260603080152.64728-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
Message-Id: <20260603080152.64728-8-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>
X-Lms-Return-Path: <lba+26a1fe0cb+c6757b+vger.kernel.org+lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
References: <20260603080152.64728-1-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>

Small constant-sized flushcache copies currently inline only the 4, 8,
and 16-byte cases. Larger constant sizes fall back to
__memcpy_flushcache() even when the destination is naturally aligned.

Factor the movnti sequences into 4/8/16/32/64-byte helpers and extend
the inline fastpath coverage to the additional aligned constant sizes
32, 48, 64, 80, and 96 bytes. Keep the existing 4/8/16-byte cases
handled directly in memcpy_flushcache() so they do not pick up the
extra alignment gating used by the larger fixed-size helpers.

Because memcpy_streaming() maps aligned transfers to
memcpy_flushcache(), these additional fixed-size cases also stay on
the inline movnti path for that helper.

Issue the stores in ascending address order so write-combining sees a
forward stream. Keep all other sizes on __memcpy_flushcache(), and keep
zero-length copies returning immediately.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 arch/x86/include/asm/string_64.h | 122 ++++++++++++++++++++++++++-----
 1 file changed, 104 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index aee63108577f..16d1aac2da24 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -83,24 +83,6 @@ int strcmp(const char *cs, const char *ct);
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
  * Only map memcpy_streaming() to memcpy_flushcache() when the destination
@@ -115,6 +97,110 @@ static __always_inline bool memcpy_flushcache_nt_safe(const void *dst,
 	return cnt && IS_ALIGNED(d, 8) && IS_ALIGNED(cnt, 4);
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
+ * Keep the additional aligned fixed-size cases on the inline movnti path.
+ * Leave the existing 4/8/16-byte cases handled directly in
+ * memcpy_flushcache() so they do not pick up the extra alignment gating
+ * used by the larger fixed-size helpers.
+ */
+static __always_inline int memcpy_flushcache_large(void *dst,
+						   const void *src,
+						   size_t cnt)
+{
+	unsigned long d = (unsigned long)dst;
+	char *dptr = dst;
+	const char *sptr = src;
+
+	if (!IS_ALIGNED(d, 8))
+		return 0;
+
+	switch (cnt) {
+	case 32:
+		memcpy_flushcache_32(dptr, sptr);
+		return 1;
+	case 48:
+		memcpy_flushcache_32(dptr, sptr);
+		memcpy_flushcache_16(dptr + 32, sptr + 32);
+		return 1;
+	case 64:
+		memcpy_flushcache_64(dptr, sptr);
+		return 1;
+	case 80:
+		memcpy_flushcache_64(dptr, sptr);
+		memcpy_flushcache_16(dptr + 64, sptr + 64);
+		return 1;
+	case 96:
+		memcpy_flushcache_64(dptr, sptr);
+		memcpy_flushcache_32(dptr + 64, sptr + 64);
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
+	if (__builtin_constant_p(cnt)) {
+		switch (cnt) {
+		case 4:
+			memcpy_flushcache_4(dst, src);
+			return;
+		case 8:
+			memcpy_flushcache_8(dst, src);
+			return;
+		case 16:
+			memcpy_flushcache_16(dst, src);
+			return;
+		}
+
+		if (memcpy_flushcache_large(dst, src, cnt))
+			return;
+	}
+
+	__memcpy_flushcache(dst, src, cnt);
+}
+
 #define __HAVE_ARCH_MEMCPY_STREAMING 1
 static __always_inline void memcpy_streaming(void *dst, const void *src,
 					     size_t cnt)
-- 
2.20.1
