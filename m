Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB5E400968
	for <linux-arch@vger.kernel.org>; Mon, 27 Jul 2026 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155855; cv=none; b=KzLzP4uxOkWJVmWQaNGZ2weCduljR/wA0ICQftRjIHjRJ5jfhHubLKzUNJVr2nwMTm3q16iZDG92b3MjybFIB6H97uI/JlOrUz70tI70Hpu2wAYR0y7lGYBpzKxEt+cvHxHcanG0p59lbnfbr8UQSDhax4E29vcmzwALZdlMbOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155855; c=relaxed/simple;
	bh=EfJYEoeIj+mCjp87mw4swqkDiGUflYopMu+3ZYEHKXk=;
	h=Content-Type:From:Message-Id:Mime-Version:References:Cc:Date:To:
	 Subject:In-Reply-To; b=VADN+iu4Xr9uaBB0my9gj13X1AVfcOm7WPDMT+IiOX502nbtdvA2BnqoM5RNxU8MVg9hC+XFiJwNwA6VoEYODqaqar4nVhXPqxh4SWm8L3i7iu7RDZSG4Amgpz1GNwW/IV09klRlXKXqVN3qsEQPQ0M2dQK+OGj9jrkxTH20Z/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GSFclNsg; arc=none smtp.client-ip=209.127.230.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GSFclNsg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1785155848; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=vLcTykUrPpLwId0/keP/ANeuOzuTtpvXBhogtTbcEIQ=;
 b=GSFclNsglDCGfGJRdtvcdheDSfTeFeYjIqDZSrsm9iA6KPjhFnN1yvwWa8BPA5rIOeiPL5
 3miHH4FA51hOjkqDaFULrWOnHQNwn4StQFiyXXL9dQ8r7ugtRtraI6gLN9zGOZt62oh34b
 DGBBtVqtZUnN/nMEjlsx3N63YjfLxCyu5ibwHQb3h1w5kMsV3cSP9N+Iuh9e8mEKUbXpXy
 K+KVqNFJtpj7mLXz4PqblUTlBThRsl2GS8P+9VOALLVZbPrCNg7FucUWP0ubCbVGGIXFnX
 e868MmEVIj9iEwGoldWT5e+CJzWgip2Grj3SbbCcSPH5fJXLLdRIr0eWmehtnQ==
Content-Type: text/plain; charset=UTF-8
From: "Li Zhe" <lizhe.67@bytedance.com>
Message-Id: <20260727123429.5673-7-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260727123429.5673-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
Date: Mon, 27 Jul 2026 20:34:26 +0800
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26a675107+8d3ae4+vger.kernel.org+lizhe.67@bytedance.com>
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<muchun.song@linux.dev>, <rppt@kernel.org>, <tglx@kernel.org>
Subject: [PATCH v8 6/9] string: introduce memcpy_nontemporal()
In-Reply-To: <20260727123429.5673-1-lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>

Introduce memcpy_nontemporal() for write-once copy sites that want a
named non-temporal copy primitive.

On x86_64, override the helper in arch/x86/include/asm/string_64.h using
the usual self-macro pattern, next to the existing memcpy_flushcache()
backend that memcpy_nontemporal() wraps.

include/linux/string.h provides the generic memcpy_nontemporal()
fallback as

  #define memcpy_nontemporal(dst, src, len) \
	((void)memcpy(dst, src, len))

instead of an inline wrapper, so architectures without a specialized
backend keep the usual memcpy() FORTIFY coverage when the compiler can
still see object sizes at the original call site. It also makes the
memcpy_nontemporal() API uniformly void, matching memcpy_flushcache()
and the x86 backend, so callers cannot accidentally depend on a return
value on fallback architectures.

memcpy_nontemporal() is only a copy primitive. It does not imply a drain
or a publication barrier. Callers that use it before a producer-consumer
or device-visible handoff must provide the required ordering at that
handoff point.

The immediate user is the ZONE_DEVICE template-copy path. It populates
struct page descriptors in a write-once pattern, so a regular cached
memcpy() can incur avoidable write-allocate traffic and cache pollution
for data with little near-term reuse.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 arch/x86/include/asm/string_64.h | 12 ++++++++++++
 include/linux/string.h           | 13 +++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 4635616863f5..21ae515ae35a 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -100,6 +100,18 @@ static __always_inline void memcpy_flushcache(void *dst, const void *src, size_t
 	}
 	__memcpy_flushcache(dst, src, cnt);
 }
+
+#define memcpy_nontemporal memcpy_nontemporal
+/*
+ * Reuse the existing x86 flushcache backend as the non-temporal copy
+ * primitive.
+ */
+static __always_inline void memcpy_nontemporal(void *dst, const void *src,
+		size_t cnt)
+{
+	memcpy_flushcache(dst, src, cnt);
+}
+
 #endif
 
 #endif /* __KERNEL__ */
diff --git a/include/linux/string.h b/include/linux/string.h
index 5702daca4326..6cb5cdd01158 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -278,6 +278,19 @@ static inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
 }
 #endif
 
+#ifndef memcpy_nontemporal
+/*
+ * memcpy_nontemporal() requests a non-temporal copy when the
+ * architecture has a suitable backend. Architectures without a
+ * specialized backend fall back to memcpy(). Keep this as a
+ * function-like macro so the compiler can still see the original
+ * memcpy() call site and preserve the usual FORTIFY coverage when
+ * object sizes remain visible there, while keeping the API void.
+ */
+#define memcpy_nontemporal(dst, src, len) \
+	((void)memcpy(dst, src, len))
+#endif
+
 void *memchr_inv(const void *s, int c, size_t n);
 char *strreplace(char *str, char old, char new);
 
-- 
2.20.1
