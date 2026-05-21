Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F2D3672AE
	for <linux-arch@vger.kernel.org>; Thu, 21 May 2026 04:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779336295; cv=none; b=c0iu7U+IRIjV+LtbBDA/azW7D79NJ2mHoHxMPDdoZTob9MlJfQKVnesy5tpREjHiBsHHYQDfy723zGAs6MTPXB4DzK6pLivcFi66r2WDwRE1GepnodWn1evEfqsR6cr0o0BmFQIYFkEpa3pVtOo6qB2bqhxDcyVhFcmDk4WA0DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779336295; c=relaxed/simple;
	bh=AmeVe5Hp2ztXa2WuxT9zyFU1DfzjU9AbLYRTNtjd4MU=;
	h=Subject:Date:To:References:Content-Type:Cc:Mime-Version:
	 In-Reply-To:From:Message-Id; b=soEscjW+WxldMrnEUOiB0cgzRvIFrGOUAlnTRbgkRuo2RTICXoD3X0W8xn7DPnjMe8hbYkRzfA/AdXAybWYDMK/FVhOIiesz8B2Q5osjHFFrQT9fl4jM/WuDJITt6F6MV/bP5pXlh1X7d3BlDKIHW/tGgUIb8+bDk6KmADDXgUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=g97XaaPN; arc=none smtp.client-ip=209.127.230.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="g97XaaPN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779336287; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=sicZWKG3rnoRbRKtoOQyKoCtsso6gsJrl+5CfarRJY4=;
 b=g97XaaPNiPJ3647z+V3QwvP0CO4Yc0HqfORoTCIKvFrimoqzaQkV1bvtnTRKOh/jY23kMa
 mMgrYAo4Cf6oswf4s7OQR832ytKyoXWXboJ36Ckxnl+KGmG1IpwejnG3Ay8RBH3ibJDH9a
 uhcHAxmCuRn1i42TfFCt4ASTlbTFjopmx1V81JSU32X9yv3UKClJT4EW+56+nZ3YbrtbCS
 OmXAlr0yWRj0Swco3HPuGWGnwq7Xtto0I2NT8drOzpF57VDe8rsb9b+76M6GzqdXyPvZic
 NDpdMTKmVZp0FAmdibr58dne/Q2Jb5Xej/1xsiD0LuIud1gXtLDXQid5HTzXMg==
Subject: [PATCH v2 6/7] x86/string: extend memcpy_flushcache() fixed-size fastpaths
Date: Thu, 21 May 2026 12:01:23 +0800
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
To: <apopple@nvidia.com>, <akpm@linux-foundation.org>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<mingo@redhat.com>, <rppt@kernel.org>, <tglx@kernel.org>, 
	<kees@kernel.org>
References: <20260521040124.10608-1-lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
Cc: <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, <lizhe.67@bytedance.com>, <x86@kernel.org>, 
	<linux-hardening@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a0e845d+f0f232+vger.kernel.org+lizhe.67@bytedance.com>
In-Reply-To: <20260521040124.10608-1-lizhe.67@bytedance.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
Message-Id: <20260521040124.10608-7-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2

Small constant-sized flushcache copies currently fall back to
__memcpy_flushcache() unless they are exactly 4, 8, or 16 bytes.

Factor the existing inline movnti sequences into small helpers and
extend the fixed-size fastpath coverage to 24..96 bytes. This keeps
common struct-page-sized copies on the inline path for the upcoming
memcpy_streaming() user, while still falling back to
__memcpy_flushcache() for uncommon sizes.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 arch/x86/include/asm/string_64.h | 87 +++++++++++++++++++++++++++-----
 1 file changed, 73 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 15504b844f1e..94dc92f287f3 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -82,22 +82,81 @@ int strcmp(const char *cs, const char *ct);
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 #define __HAVE_ARCH_MEMCPY_FLUSHCACHE 1
 void __memcpy_flushcache(void *dst, const void *src, size_t cnt);
-static __always_inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
+
+static __always_inline void memcpy_flushcache_4(void *dst, const void *src)
+{
+	asm ("movntil %1, %0" : "=m"(*(u32 *)dst) : "r"(*(u32 *)src));
+}
+
+static __always_inline void memcpy_flushcache_8(void *dst, const void *src)
+{
+	asm ("movntiq %1, %0" : "=m"(*(u64 *)dst) : "r"(*(u64 *)src));
+}
+
+static __always_inline void memcpy_flushcache_16(void *dst, const void *src)
+{
+	memcpy_flushcache_8(dst, src);
+	memcpy_flushcache_8(dst + 8, src + 8);
+}
+
+/*
+ * Keep common fixed-size copies on the inline movnti path instead of
+ * dropping into the generic helper.
+ */
+static __always_inline int memcpy_flushcache_small(void *dst, const void *src,
+						   size_t cnt)
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
+	switch (cnt) {
+	case 96:
+		memcpy_flushcache_16(dst + 80, src + 80);
+		fallthrough;
+	case 80:
+		memcpy_flushcache_16(dst + 64, src + 64);
+		fallthrough;
+	case 64:
+		memcpy_flushcache_16(dst + 48, src + 48);
+		fallthrough;
+	case 48:
+		memcpy_flushcache_16(dst + 32, src + 32);
+		fallthrough;
+	case 32:
+		memcpy_flushcache_16(dst + 16, src + 16);
+		fallthrough;
+	case 16:
+		memcpy_flushcache_16(dst, src);
+		return 1;
+
+	case 88:
+		memcpy_flushcache_16(dst + 72, src + 72);
+		fallthrough;
+	case 72:
+		memcpy_flushcache_16(dst + 56, src + 56);
+		fallthrough;
+	case 56:
+		memcpy_flushcache_16(dst + 40, src + 40);
+		fallthrough;
+	case 40:
+		memcpy_flushcache_16(dst + 24, src + 24);
+		fallthrough;
+	case 24:
+		memcpy_flushcache_16(dst + 8, src + 8);
+		fallthrough;
+	case 8:
+		memcpy_flushcache_8(dst, src);
+		return 1;
+
+	case 4:
+		memcpy_flushcache_4(dst, src);
+		return 1;
 	}
+
+	return 0;
+}
+
+static __always_inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
+{
+	if (__builtin_constant_p(cnt) && memcpy_flushcache_small(dst, src, cnt))
+		return;
 	__memcpy_flushcache(dst, src, cnt);
 }
 
-- 
2.20.1
