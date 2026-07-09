Received: from va-1-111.ptr.blmpb.com (va-1-111.ptr.blmpb.com [209.127.230.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50B23F7AB4
	for <linux-arch@vger.kernel.org>; Thu,  9 Jul 2026 11:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783596491; cv=none; b=IdumuRiMxLirlyGS9uXBXqk77acVWXB0kit+BC3pOMVR4uH+RjJorWrEFlNhHRbn6qoz4x3N6ehIil0qr47UpaGNm0LqIb9CadRf0OosSABlnkNYtbKDo1LKZOr6yKi3OXupPvokezyRJI9snWhxyDIQueTNt6opI78DjhOLldw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783596491; c=relaxed/simple;
	bh=RVgSIGpZ8uAoEoXoqoGDdEXdRYSBUV3M4TAREl+MJRg=;
	h=In-Reply-To:References:Content-Type:To:Cc:Date:Message-Id:From:
	 Subject:Mime-Version; b=dhszTbkcj3zBChG2HOG5ctQ4ETnVKW7iCymzmBpNlKG1K1TdnLlZGnBQFbmy2zgFxQ96x0gzGst3O65l2+tlJnXSfhiQES+4VuKEK2SYkXVtFMsLpmTYQsL2Of+22GfPc9EJpw5m5/EEPazdgVm9T2himX9X7bdgcfSu76VxNTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ELW3/md9; arc=none smtp.client-ip=209.127.230.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ELW3/md9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1783596485; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=gtpXPQ/H4ZBimfcBe1xu9rcXWfMUV2ijOuTMHAq22Iw=;
 b=ELW3/md9IJpgFdhsKU8JS+ciQKPN6fAoW0iwiX0zhksg+SyIgwN3pkanfW/P7hXgXluMHi
 iMIBrgRa6sPPLLmgH0XyrSIf8bv1/tH/lcQEOAOZaaDzT0s54p388hF7IBqvu2cldP8ww8
 Oc4g/hbliSy4VUgVpNLH32so6VOGHKM3z1IfQmvVcjEy/+fnDfggu6hHkngPUoP1BHvCd/
 rXSmpVIn3nTGwjWpqNuc2TXnaMLz2g85mcukNeBZp5VRzgcmeQYJhFzZ0tsFiHvgr5kzf6
 zmxMxuPhkgDzXRc6oAeQX8VwBRCaLEOFLJHpcOiYhkiE0SdmSMZ5nLx/ECgQaA==
Content-Transfer-Encoding: 7bit
In-Reply-To: <20260709112520.24857-1-lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a4f85c3+3a8943+vger.kernel.org+lizhe.67@bytedance.com>
References: <20260709112520.24857-1-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<rppt@kernel.org>, <tglx@kernel.org>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<lizhe.67@bytedance.com>, <x86@kernel.org>
Date: Thu,  9 Jul 2026 19:25:18 +0800
Message-Id: <20260709112520.24857-7-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
From: "Li Zhe" <lizhe.67@bytedance.com>
Subject: [PATCH v6 6/8] string: introduce memcpy_nt() helpers
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Li Zhe <lizhe.67@bytedance.com>

Introduce memcpy_nt() and memcpy_nt_drain() for write-once copy sites
that want a named non-temporal copy primitive plus an explicit drain
step.

On x86_64, override both helpers in arch/x86/include/asm/string_64.h
using the usual self-macro pattern, next to the existing
memcpy_flushcache() backend that memcpy_nt() wraps. The x86_64
implementation maps memcpy_nt() to memcpy_flushcache() and uses wmb()
for memcpy_nt_drain(), because that backend issues MOVNTI stores and
callers need an ordering point before later normal stores that depend
on those writes becoming visible.

include/linux/string.h provides the generic fallback under
memcpy_nt() as plain memcpy() and leaves memcpy_nt_drain() empty, so
architectures that do not override memcpy_nt() do not pay an
unconditional barrier. Architectures that later grow a specialized
memcpy_nt() backend can override memcpy_nt_drain() with whatever
drain primitive their memory-ordering rules require.

The immediate user is the ZONE_DEVICE template-copy path. It populates
struct page descriptors in a write-once pattern, so a regular cached
memcpy() can incur avoidable write-allocate traffic and cache
pollution for data with little near-term reuse.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 arch/x86/include/asm/string_64.h | 22 ++++++++++++++++++++++
 include/linux/string.h           | 23 +++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 4635616863f5..6cb9e0ac7fa0 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -4,6 +4,7 @@
 
 #ifdef __KERNEL__
 #include <linux/jump_label.h>
+#include <asm/barrier.h>
 
 /* Written 2002 by Andi Kleen */
 
@@ -100,6 +101,27 @@ static __always_inline void memcpy_flushcache(void *dst, const void *src, size_t
 	}
 	__memcpy_flushcache(dst, src, cnt);
 }
+
+#define memcpy_nt memcpy_nt
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
+#define memcpy_nt_drain memcpy_nt_drain
+static __always_inline void memcpy_nt_drain(void)
+{
+	/*
+	 * Order the prior MOVNTI stores issued by memcpy_flushcache()
+	 * before later normal stores.
+	 */
+	wmb();
+}
 #endif
 
 #endif /* __KERNEL__ */
diff --git a/include/linux/string.h b/include/linux/string.h
index 5702daca4326..a109b2f86ca6 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -278,6 +278,29 @@ static inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
 }
 #endif
 
+#ifndef memcpy_nt
+/*
+ * memcpy_nt() requests a non-temporal copy when the architecture has a
+ * suitable backend. Architectures that do not override it fall back to
+ * memcpy().
+ */
+static inline void memcpy_nt(void *dst, const void *src, size_t cnt)
+{
+	memcpy(dst, src, cnt);
+}
+#endif
+
+#ifndef memcpy_nt_drain
+/*
+ * Callers use memcpy_nt_drain() before later normal stores that need to
+ * be ordered after memcpy_nt(). Architectures without a specialized
+ * backend can leave it empty.
+ */
+static inline void memcpy_nt_drain(void)
+{
+}
+#endif
+
 void *memchr_inv(const void *s, int c, size_t n);
 char *strreplace(char *str, char old, char new);
 
-- 
2.20.1
