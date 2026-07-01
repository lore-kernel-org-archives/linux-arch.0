Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF313C060F
	for <linux-arch@vger.kernel.org>; Wed,  1 Jul 2026 09:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782896969; cv=none; b=iJun4FO7duLzDFFV00OHQpYaMxuddxJe1DWDcZhbvIkJ+xCXWmUyleprKB+cSN0mikE6cpgSf5jVkjP+uHudwlzwPhLjuRlGZzVJ0U/IHLyMthWMzkgXGiBDZp0h6tgP7nfKIAapmNXHsbKPCM42pq1qRso8887yBGs5qqEJAMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782896969; c=relaxed/simple;
	bh=/FLdCG32++MJAY5z9lbhzw8lh2pbQxMOp+IfVl7XrKc=;
	h=In-Reply-To:Cc:From:Date:References:Subject:To:Message-Id:
	 Mime-Version:Content-Type; b=FBb8k8f5HGDifJZnb3FMwXb7hw+sb4N9Gc0GFVUCrVYljutx0p4ypy9XOySayz1EHm04Z+rkRpyr/bIldPJ/z9WUocIV88hANj2F3ZcFJBNLAQXFLl8JQ5wHoj8HxJTezGBpHGfV9sW3LwRNeOLr7Z7I5Oqb1rTLHQyaIIFdv3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Q1K7xKup; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Q1K7xKup"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1782896964; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=EChoIRhSwBKjl45mE0KYtfQBcAG6r3vpLScAhY4aGho=;
 b=Q1K7xKupQgvsLGWwTJeT4z95PsQq+f0qhQs/5RFf+q+HMObCkLcVxWwSg8m/LX3hxbvBqI
 OOqXyVvh4GkwImqh1SjFXQEnROhT5WdEVxLUo5wo+aeJOJd6GaIeXkRGWG31uxZzJFepwC
 9Z4fF/dJDnVVOGE68KhDW2M4HGU69mThyOZY8fyv8rKJ1ghPX+5TSCTfD45Yq6zw9nvwnz
 FIEWtdB2sLzqKIahJ9eBGwKCOrh66KTasj/tkp1HVhafMmxwMLvs/b5ngPrA1ZjL+nZAzi
 m0gRzPxBGVQH/RtgUd79U+DTmAeTC6pzSm1TAC+8c6dffaftVsK4XGuKB94UGw==
In-Reply-To: <20260701090553.62691-1-lizhe.67@bytedance.com>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
Date: Wed,  1 Jul 2026 17:05:51 +0800
References: <20260701090553.62691-1-lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Subject: [PATCH v5 6/8] string: introduce memcpy_nt() helpers
Content-Transfer-Encoding: 7bit
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>
Message-Id: <20260701090553.62691-7-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a44d942+4ec882+vger.kernel.org+lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8

Introduce memcpy_nt() and memcpy_nt_drain() for write-once copy sites
that want a named non-temporal copy primitive plus an explicit ordering
point. On x86, place the arch-visible wrapper in
arch/x86/include/asm/string_64.h and map it to the existing
memcpy_flushcache() backend plus sfence. Architectures that do not
override the helper fall back to memcpy() and a no-op drain in
include/linux/string.h.

The immediate user is the ZONE_DEVICE template-copy path. That path
populates struct page descriptors in a write-once pattern, so most
destination cachelines are not expected to be reused immediately after
the copy. A regular cached memcpy() can therefore incur avoidable
write-allocate traffic and pollute the cache with data that has little
near-term reuse.

This interface lets callers request that non-temporal-copy semantics
directly, while x86 simply reuses the existing memcpy_flushcache()
backend instead of adding another generic memcpy-like wrapper with
extra selection policy above it.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 arch/x86/include/asm/string_64.h | 16 ++++++++++++++++
 include/linux/string.h           | 18 ++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 4635616863f5..6f36abedc56a 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -100,6 +100,22 @@ static __always_inline void memcpy_flushcache(void *dst, const void *src, size_t
 	}
 	__memcpy_flushcache(dst, src, cnt);
 }
+
+#define __HAVE_ARCH_MEMCPY_NT 1
+/*
+ * Reuse the existing x86 flushcache backend as the nt copy primitive.
+ * Callers pair it with memcpy_nt_drain() when later stores must be
+ * ordered after the copy.
+ */
+static __always_inline void memcpy_nt(void *dst, const void *src, size_t cnt)
+{
+	memcpy_flushcache(dst, src, cnt);
+}
+
+static __always_inline void memcpy_nt_drain(void)
+{
+	asm volatile("sfence" : : : "memory");
+}
 #endif
 
 #endif /* __KERNEL__ */
diff --git a/include/linux/string.h b/include/linux/string.h
index 5702daca4326..5165763ab812 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -278,6 +278,24 @@ static inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
 }
 #endif
 
+#ifndef __HAVE_ARCH_MEMCPY_NT
+/*
+ * memcpy_nt() requests a non-temporal copy when the architecture has a
+ * suitable backend. Callers must follow it with memcpy_nt_drain()
+ * before later normal stores that need to be ordered after the copy.
+ * Architectures that do not override it fall back to memcpy() and a
+ * no-op drain.
+ */
+static inline void memcpy_nt(void *dst, const void *src, size_t cnt)
+{
+	memcpy(dst, src, cnt);
+}
+
+static inline void memcpy_nt_drain(void)
+{
+}
+#endif
+
 void *memchr_inv(const void *s, int c, size_t n);
 char *strreplace(char *str, char old, char new);
 
-- 
2.20.1
