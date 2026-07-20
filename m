Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6248F40D56D
	for <linux-arch@vger.kernel.org>; Mon, 20 Jul 2026 12:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784549247; cv=none; b=cyb2RR+8SVm5kCwzghTbhFSp3hgjFGAoUBCq46XxYfV+Vfl9AaQHf0YBVaXw3Qjwr+OHtjYdITDU0BgbGY2K8wkbyfP1cLHtZ29ycoPkC24ph5Lt7z1AtlM9dpZQ915D9WDuNmb3Mxz2AMf19dhACLFFgb7EUX7z54WI7iw0exU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784549247; c=relaxed/simple;
	bh=LI2u6cYOjnFYacZ6NJqKaWuuHjSmz5yGa1W1BpxWZAk=;
	h=Date:In-Reply-To:To:From:Cc:Message-Id:Mime-Version:References:
	 Subject:Content-Type; b=QUHgGzczmcHkRRk47RZhuGC0lVe8GciXktA9HzLyGbI+Kay218L5YJCguR4idcwqSjQEBmqp3S+yf4ISdCSEs6wlhpxIZngtBoLPsGvEju48asxHkmYRSSxSBsezh+akeXQn/VDtEf4TdIpF8tffeZboVP9Lsj13TrE+kTApC24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UVkkQAHM; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UVkkQAHM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1784549233; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=D0OG9QWc77q/zAL8FPrnNLiG/3kvsdhyOefV1kn8AAY=;
 b=UVkkQAHMLAeDzlYg/0cLIGmCA4LcXbccTSAL29whzLZDcvB/FJuYzSRR2qZXK/c9qfX1J4
 xDzH5LR6rEgEsGl/xwJV27XpLvQNi/pZxds54Bhtd5aXLoVNOZ2cz4KrpdzKiKJ3v6vr0k
 V/G2fxSK1gRST59EGJ/RTkGZIW69NCrmwqB3QImNdqjcJlN1y8De/nR8pLtWVRnxvUUuTX
 LOrkHBpkcLe8fcvtvO35hX6omqToioenJV6oAnKv4pOQf5cnjbp6nXE2/n+9G/WK5RFi7G
 fEskuZoGK8lyaB8uBWmCI5iFVg41C83OCONbajDf5gWH2EEoJD1x6uAfgpXcvw==
Date: Mon, 20 Jul 2026 20:02:56 +0800
In-Reply-To: <20260720120259.1545-1-lizhe.67@bytedance.com>
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<rppt@kernel.org>, <tglx@kernel.org>, <muchun.song@linux.dev>
From: "Li Zhe" <lizhe.67@bytedance.com>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
Message-Id: <20260720120259.1545-8-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26a5e0f6f+635813+vger.kernel.org+lizhe.67@bytedance.com>
References: <20260720120259.1545-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
Subject: [PATCH v7 6/9] string: introduce memcpy_nontemporal()
Content-Type: text/plain; charset=UTF-8
X-Original-From: Li Zhe <lizhe.67@bytedance.com>

Introduce memcpy_nontemporal() for write-once copy sites that want a
named non-temporal copy primitive.

On x86_64, override the helper in arch/x86/include/asm/string_64.h using
the usual self-macro pattern, next to the existing memcpy_flushcache()
backend that memcpy_nontemporal() wraps.

include/linux/string.h provides the generic memcpy_nontemporal()
fallback as

  #define memcpy_nontemporal memcpy

instead of an inline wrapper, so architectures without a specialized
backend keep the usual memcpy() FORTIFY coverage when the compiler can
still see object sizes at the original call site.

The immediate user is the ZONE_DEVICE template-copy path. It populates
struct page descriptors in a write-once pattern, so a regular cached
memcpy() can incur avoidable write-allocate traffic and cache pollution
for data with little near-term reuse.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 arch/x86/include/asm/string_64.h | 12 ++++++++++++
 include/linux/string.h           | 12 ++++++++++++
 2 files changed, 24 insertions(+)

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
index 5702daca4326..9815c08867d7 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -278,6 +278,18 @@ static inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
 }
 #endif
 
+#ifndef memcpy_nontemporal
+/*
+ * memcpy_nontemporal() requests a non-temporal copy when the
+ * architecture has a suitable backend. Architectures without a
+ * specialized backend fall back to memcpy(). Keep this as a macro alias
+ * so the compiler can still see the original memcpy() call site and
+ * preserve the usual FORTIFY coverage when object sizes remain visible
+ * there.
+ */
+#define memcpy_nontemporal memcpy
+#endif
+
 void *memchr_inv(const void *s, int c, size_t n);
 char *strreplace(char *str, char old, char new);
 
-- 
2.20.1
