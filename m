Received: from va-2-114.ptr.blmpb.com (va-2-114.ptr.blmpb.com [209.127.231.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089E62BDC13
	for <linux-arch@vger.kernel.org>; Thu, 21 May 2026 04:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779336278; cv=none; b=Pn6iH1tZG1PgZs+F+KOBWxFhzY2TPimNrwDyAXOqtB6xKkfmWMgZYkhRy2cw+4CBLOvJlvNtY8afjTlFOD1LxLoHFlFC1Ok3XEejupl+vWTswM7KpOeonfCgZICYRNU0NmxqK9hzSQbOSuW7Nt13rIGIkN1DDMVpAuKqN1P5Cvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779336278; c=relaxed/simple;
	bh=zG3UBy3bN51MuM7g5fnOAGrmA/YDR+ftiY9OAsc6nXc=;
	h=Subject:Message-Id:References:From:Content-Type:Cc:To:
	 Mime-Version:In-Reply-To:Date; b=c6SemMDl9GaeopSuY1aLTBJKc7iS+aKuHg/U6Zk+C8p1JlTuH9qiQpGN+xy2o/1eWAL8OiRuZ+TZsjwEajBcsGDRA9xLpCq1/h40YbW7t6B6FJusAE/NxZylzCLJghuDNYMPeAG6AGua8rcSS4DP3vHWoCJA490DeRN+2y+c/0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EA4VpO6r; arc=none smtp.client-ip=209.127.231.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EA4VpO6r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779336266; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=r9TVpMbLVKEQZRuZT9zKl5Z3AjyKm+f5ptKPy8P2UEQ=;
 b=EA4VpO6ra8HpDmB1WeSCujlUe50Ak9dOdMDG7jb8NQvtDGoNMzLP45SkTgr4nE9UMNWIv4
 ddNKS2KrGi3t6ejQAr/YT346Y8HNUKwJjn1G6xQdwKaoIp5l3vukfZyo5YXTwSoQgKTUfh
 SRRur+i8ySagziSCUlKdbD4P3TMsDkGrpokbhq3zZIUm6IRapXjZalCtjmHvyn40069Eyi
 FlUeQpSrvUzmfNwvJq4Xq2my4rcq1CIZOeGFXmuwiiPSsrK+BD/VnOxsWiaQzyS6kqFlpn
 8Ifc3Sx+lDTAfyiNoG1LI2XHVp1mMX0qGM1KGBoIrTWJaMUnkp7cVk0wdPT5rQ==
Subject: [PATCH v2 5/7] string: introduce memcpy_streaming() helpers
Message-Id: <20260521040124.10608-6-lizhe.67@bytedance.com>
References: <20260521040124.10608-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a0e8448+4c2071+vger.kernel.org+lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Cc: <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, <lizhe.67@bytedance.com>, <x86@kernel.org>, 
	<linux-hardening@vger.kernel.org>
Content-Transfer-Encoding: 7bit
To: <apopple@nvidia.com>, <akpm@linux-foundation.org>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<mingo@redhat.com>, <rppt@kernel.org>, <tglx@kernel.org>, 
	<kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20260521040124.10608-1-lizhe.67@bytedance.com>
Date: Thu, 21 May 2026 12:01:22 +0800

Introduce a generic memcpy_streaming() interface for write-once copy
sites that can fall back to memcpy() when no architecture-specific
optimization is available.

Add memcpy_streaming_drain() alongside it so callers can separate the
copy primitive from any required ordering point. On x86, wire the helper
to memcpy_flushcache() and sfence so common code can request a streaming
copy without embedding x86-specific movnti details.

Callers are responsible for invoking memcpy_streaming_drain() before
later normal stores that must be ordered after the streaming copy.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 arch/x86/include/asm/string_64.h | 13 +++++++++++++
 include/linux/string.h           | 18 ++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 4635616863f5..15504b844f1e 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -100,6 +100,19 @@ static __always_inline void memcpy_flushcache(void *dst, const void *src, size_t
 	}
 	__memcpy_flushcache(dst, src, cnt);
 }
+
+#define __HAVE_ARCH_MEMCPY_STREAMING 1
+static __always_inline void memcpy_streaming(void *dst, const void *src,
+					     size_t cnt)
+{
+	memcpy_flushcache(dst, src, cnt);
+}
+
+static __always_inline void memcpy_streaming_drain(void)
+{
+	asm volatile("sfence" : : : "memory");
+}
+
 #endif
 
 #endif /* __KERNEL__ */
diff --git a/include/linux/string.h b/include/linux/string.h
index b850bd91b3d8..ba029be9c187 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -281,6 +281,24 @@ static inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
 }
 #endif
 
+#ifndef __HAVE_ARCH_MEMCPY_STREAMING
+/*
+ * memcpy_streaming() is for write-once copy sites that may use
+ * non-temporal stores on some architectures. Callers must follow it
+ * with memcpy_streaming_drain() before later normal stores that need to
+ * be ordered after the streaming copy. Implementations that use regular
+ * cached stores can make the drain a no-op.
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
