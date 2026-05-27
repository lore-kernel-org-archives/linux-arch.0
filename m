Received: from va-2-115.ptr.blmpb.com (va-2-115.ptr.blmpb.com [209.127.231.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A592E975E
	for <linux-arch@vger.kernel.org>; Wed, 27 May 2026 03:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779853219; cv=none; b=HZSh21Rj8kfNcwq7HXmnrFLeNxREHCv1QM7zIAXylB+28+4mcLpaXVp1bpYCHVizbnpvQjhIii3t3MQLYjnC95WAOv1gWkFCACOoJu284qaEV5bp4rBAZHsDRvtRepduHdMwpFAaxLRh+lgHwv9ayDe4oWkbeG14GB3h3ZiKmjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779853219; c=relaxed/simple;
	bh=/B9bHCzKxO2WBOFU4VOAAcAC/QSpAytvHDnH12PBs1Y=;
	h=Date:Mime-Version:In-Reply-To:References:Cc:Content-Type:From:
	 Message-Id:To:Subject; b=Sa97Bhw3nqZ6lQ1OGzc7crAN65vmO+0FfSRkW/7NOF7tvdr9I6IJ5fWlO0Jvg+pR2iVRV15xZfrLTjkwueJ1e8geAH0d2MrBBThohVjWAVYdF0xQMlVtZ0mjSTrnYp7uRBC6gh+uqyrusbUo+ISD4BgOEiqTWoftFM6ZmMcwVcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Q6/FJunI; arc=none smtp.client-ip=209.127.231.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Q6/FJunI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779853213; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=F7+PWjKsjsPUzsocI71Frs9HaxpL6NKJS1KqgSbi3hg=;
 b=Q6/FJunI3E3ldgk6G6CS8xZcUrSUIeLAp8D7H0/U0QGv72Eg7Pg18pLR5I436RPhCG6xXk
 bhpgSKowZ6br4VQWkDBbJ3L03tU6jZ4BgwoBsEV2XxVwhmDkK7Etd+taAiGb+ogDNS5O1z
 bXsUAWFjHxxgu2rJNYDmZfPXuiSrwTincCbEM/ngWhRZSGMm4+W0v+e1ieuGwEhXaCgOLd
 D67mLm19hNsA0WwwRbNveN/TRKmSVR/qXsxqXQil24CqgK75o9iQN3g0dIF+r+F4eATCyv
 O1DEwX6d1ovyFbnU0Vurnj3nctAHjFemzh+Lgg2R2EJYwckwSTZOpgq98GTPbw==
Date: Wed, 27 May 2026 11:36:34 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20260527033636.28231-1-lizhe.67@bytedance.com>
References: <20260527033636.28231-1-lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	"Li Zhe" <lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
From: "Li Zhe" <lizhe.67@bytedance.com>
Message-Id: <20260527033636.28231-7-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
X-Lms-Return-Path: <lba+26a16679b+08e28c+vger.kernel.org+lizhe.67@bytedance.com>
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Subject: [PATCH v3 6/8] string: introduce memcpy_streaming() helpers

Introduce a generic memcpy_streaming() interface for write-once copy
sites that can fall back to memcpy() when no architecture-specific
optimization is available, or when an architecture-specific backend
cannot safely handle a given transfer.

Add memcpy_streaming_drain() alongside it so callers can separate the
copy primitive from any required ordering point. On x86, use
memcpy_flushcache() and sfence only for aligned transfers that can stay
entirely on the non-temporal store path; otherwise fall back to memcpy()
so the generic API does not expose flushcache semantics on cached
head/tail fragments.

Callers are responsible for invoking memcpy_streaming_drain() before
later normal stores that must be ordered after the streaming copy.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 arch/x86/include/asm/string_64.h | 40 ++++++++++++++++++++++++++++++++
 include/linux/string.h           | 20 ++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 4635616863f5..0b57e9e6f3db 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -100,6 +100,46 @@ static __always_inline void memcpy_flushcache(void *dst, const void *src, size_t
 	}
 	__memcpy_flushcache(dst, src, cnt);
 }
+
+/*
+ * Only reuse memcpy_flushcache() for transfers that can stay entirely
+ * on its non-temporal store path. Fall back to memcpy() for zero-length
+ * copies and for unaligned transfers so the generic streaming API does
+ * not expose flushcache semantics on cached head/tail fragments.
+ */
+static __always_inline int memcpy_flushcache_nt_safe(const void *dst,
+						     const void *src,
+						     size_t cnt)
+{
+	unsigned long d = (unsigned long)dst;
+	unsigned long s = (unsigned long)src;
+
+	if (!cnt)
+		return 0;
+
+	if (cnt >= 8)
+		return !(d & 7) && !(s & 7) && !(cnt & 7);
+
+	return cnt == 4 && !(d & 3) && !(s & 3);
+}
+
+#define __HAVE_ARCH_MEMCPY_STREAMING 1
+static __always_inline void memcpy_streaming(void *dst, const void *src,
+					     size_t cnt)
+{
+	if (!cnt)
+		return;
+
+	if (memcpy_flushcache_nt_safe(dst, src, cnt))
+		memcpy_flushcache(dst, src, cnt);
+	else
+		memcpy(dst, src, cnt);
+}
+
+static __always_inline void memcpy_streaming_drain(void)
+{
+	asm volatile("sfence" : : : "memory");
+}
 #endif
 
 #endif /* __KERNEL__ */
diff --git a/include/linux/string.h b/include/linux/string.h
index b850bd91b3d8..a4c2d4347f58 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -281,6 +281,26 @@ static inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
 }
 #endif
 
+#ifndef __HAVE_ARCH_MEMCPY_STREAMING
+/*
+ * memcpy_streaming() is for write-once copy sites that may use
+ * non-temporal stores on some architectures. Callers must follow it
+ * with memcpy_streaming_drain() before later normal stores that need to
+ * be ordered after the streaming copy. Implementations may fall back to
+ * memcpy() when a specialized backend cannot safely handle the given
+ * transfer, and backends that use regular cached stores can make the
+ * drain a no-op.
+ */
+static inline void memcpy_streaming(void *dst, const void *src, size_t cnt)
+{
+	memcpy(dst, src, cnt);
+}
+
+static inline void memcpy_streaming_drain(void)
+{
+}
+#endif
+
 void *memchr_inv(const void *s, int c, size_t n);
 char *strreplace(char *str, char old, char new);
 
-- 
2.20.1
