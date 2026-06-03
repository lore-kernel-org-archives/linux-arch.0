Received: from va-2-115.ptr.blmpb.com (va-2-115.ptr.blmpb.com [209.127.231.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB85396B9A
	for <linux-arch@vger.kernel.org>; Wed,  3 Jun 2026 08:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780474029; cv=none; b=joVPJgJVCIAWYyoCEJ09oUmdai2zfcSIDH25On/bRDxH9hx6/wyPQdxcBwPzSQWhnWDCKKq8V+rzIODRcu3iFVP8P++hmrRCOXJkmXFXzP1PBpSNfFQGckQUyJnkJaiUPV+UzYjHmegZFbi0+lRgp0iUa9ObV4ra24liTurLdQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780474029; c=relaxed/simple;
	bh=63NMpe0PRElzthaZjCab7XFUgcysrLnekDQoCS6vnp4=;
	h=From:Subject:Date:Content-Type:Cc:In-Reply-To:References:
	 Mime-Version:To:Message-Id; b=KdAfNG+pk3z4gXmAOroFM0sRoAlCpq71Xsb0nlUmkkMXOOO2OfD0D8oupDt4b7TXqr6cxSD6ZkvcYOTHTlFZO2gKBuJXVMtyN5WXqf5ttLhAv7QW+yWrk/S2YllZdCAFCiflR+olxFLzm6WFDjBDX5+HsaDpe9Lvt4JFpXPqdec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=U4dMfXKX; arc=none smtp.client-ip=209.127.231.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="U4dMfXKX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1780474023; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=QbTAW4+JtusN/1ajk2i57VFeY4ZMdb/3rGS57KirNj4=;
 b=U4dMfXKXNBR99SZJTA3fZeC7T+ReleTpxNpkP5iVjZwBtp1OeC6g2aTZGuDRc+eJwpED+i
 NY6uRJ1TGh20Ek4WJOxe1ZtTdNydHqNmQ7+CcoK3Eq3zLcc4rD8MoKZoIfeF79HUymeyev
 UQ/4IXBCLuG8l0mcM5JLX8xABZaAKFw3ZZRdrbZCGjHx0xiAmiGAeMrMdvFFYu19TVH+RS
 xxacHLnKPIRxM6D+0iuqSgRAqq5/ccz1Twu+4Q/m95WqO4bV+DHwiLb/G63thl5jc+0J+4
 nJkB4DiJ8wR07xqGb1Zl1lIiOrD4UoHnqIeFHvnxcqo+/gMATzvX4xToDNsBuA==
From: "Li Zhe" <lizhe.67@bytedance.com>
Subject: [PATCH v4 6/8] string: introduce memcpy_streaming() helpers
Date: Wed,  3 Jun 2026 16:01:50 +0800
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
In-Reply-To: <20260603080152.64728-1-lizhe.67@bytedance.com>
References: <20260603080152.64728-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a1fe0a5+d17dd1+vger.kernel.org+lizhe.67@bytedance.com>
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
Message-Id: <20260603080152.64728-7-lizhe.67@bytedance.com>

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
 arch/x86/include/asm/string_64.h | 32 ++++++++++++++++++++++++++++++++
 include/linux/string.h           | 20 ++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 4635616863f5..aee63108577f 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -4,6 +4,7 @@
 
 #ifdef __KERNEL__
 #include <linux/jump_label.h>
+#include <linux/align.h>
 
 /* Written 2002 by Andi Kleen */
 
@@ -100,6 +101,37 @@ static __always_inline void memcpy_flushcache(void *dst, const void *src, size_t
 	}
 	__memcpy_flushcache(dst, src, cnt);
 }
+
+/*
+ * Only map memcpy_streaming() to memcpy_flushcache() when the destination
+ * is already 8-byte aligned and the size can be handled without cached
+ * head/tail fragments in __memcpy_flushcache().
+ */
+static __always_inline bool memcpy_flushcache_nt_safe(const void *dst,
+						      size_t cnt)
+{
+	unsigned long d = (unsigned long)dst;
+
+	return cnt && IS_ALIGNED(d, 8) && IS_ALIGNED(cnt, 4);
+}
+
+#define __HAVE_ARCH_MEMCPY_STREAMING 1
+static __always_inline void memcpy_streaming(void *dst, const void *src,
+					     size_t cnt)
+{
+	if (!cnt)
+		return;
+
+	if (memcpy_flushcache_nt_safe(dst, cnt))
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
