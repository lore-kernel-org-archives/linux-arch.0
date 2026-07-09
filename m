Received: from va-2-115.ptr.blmpb.com (va-2-115.ptr.blmpb.com [209.127.231.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164C73F5BDC
	for <linux-arch@vger.kernel.org>; Thu,  9 Jul 2026 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783596513; cv=none; b=DyMdZ9MvRW0dzRINk/5frLvngVKCk40iPZUiy7Nn+mEt5vL8UeskGO4c0NbpbAmSf0kLwMSDUlcVxFq6XyQWuMWlBo6RGVVdwWGxvM28LGMvz+fo84iuHuJ3SxXXiKaLlL3DAXTji8T+YsnD4B/4t8nbcA9P2yC3oBcAJTkIJMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783596513; c=relaxed/simple;
	bh=KL3mc7nUlJWrt7L+NhR6qS8dfJwZtMnmFhFWdby+22I=;
	h=Cc:Subject:From:Message-Id:In-Reply-To:Content-Type:To:Date:
	 Mime-Version:References; b=ZHhv8jSxKprizfbDzJLjkxOIMcASWrlsT2PT9KvHcLy3VGgWdzP2XpL/aActznnRJxzPzaG/oq3tDD8QU1V0O5HgOKHrk6tj6DTGn5tx4WJdr2iQg/cYB0pg7Aykdb79Hsqqc6WpE6HN0qoD6Mms+T5CfsGx5KvU714N88VkkWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=et2VeqbG; arc=none smtp.client-ip=209.127.231.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="et2VeqbG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1783596506; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=AN464t3GErrzCu0A8hyIj0aMpfRwo0PDzzsVvqxolEc=;
 b=et2VeqbGY3Yb26WM2odN801kehVtE1LMN9E9+kSbKQWi8OyTNkzF0dKE7/SplLzTRZT5Xq
 DlS2o8wxkCRO8fOD5UX6WeZ8okhfIUTQP/5mngLll3U5FSnqIcu+CgarfpyFLR2D6M1VkI
 TDJzKO7V/odmu6FOslia3CqaQOQnD3FSxlARnCzM6X9b34YJ8ZLRNFMl0G4wf+El4e9B4h
 jdM4vCCy0dFiFs5/OJUjk20mFjt2FeMbTQu56VohMLBU/LOSWqrgS2Ryl/m0JJZ+JxBHHV
 F8TPANhYmSsGnJ0g/mzwwt9iadY7o/nH3RbsoyTDanEV0DXLAsQheEXfTKxtnA==
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<lizhe.67@bytedance.com>, <x86@kernel.org>
Subject: [PATCH v6 7/8] x86/string: extend memcpy_flushcache() fixed-size fastpaths
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
Message-Id: <20260709112520.24857-8-lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a4f85d8+1fa58e+vger.kernel.org+lizhe.67@bytedance.com>
In-Reply-To: <20260709112520.24857-1-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<rppt@kernel.org>, <tglx@kernel.org>
Date: Thu,  9 Jul 2026 19:25:19 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709112520.24857-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 7bit

The new x86 memcpy_nt() helper in this series maps to
memcpy_flushcache(), and the ZONE_DEVICE fast path uses that primitive
for constant-sized struct page template copies.

The immediately relevant x86_64 sizeof(struct page) values here are 64,
80, and 96 bytes. memcpy_flushcache() currently inlines only the 4, 8,
and 16-byte cases, so even those constant-sized struct page copies fall
through to __memcpy_flushcache().

Add 32, 48, 64, 80, and 96-byte MOVNTI sequences to the main fixed-size
switch so those constant-sized copies can stay on the inline path.
Factor the larger sequences into movnti_8()/16()/32()/64() helpers so
the switch can reuse them without duplicating the inline assembly.
While the ZONE_DEVICE template-copy path only needs 64/80/96-byte
copies, keep 32-byte and 48-byte copies inline as well rather than
sending those nearby fixed-size cases back to __memcpy_flushcache().

A microbenchmark compared two memcpy_flushcache()-style helpers that
shared the same generic body and differed only in whether
32/48/64/80/96-byte copies stayed in the fixed-size switch or were
redirected to __memcpy_flushcache() when the destination was not 8-byte
aligned. The timed interval covered the copy loop only; wmb() was used
only to separate rounds.

In pseudo-code, the two variants were:

variant A:
	switch (len) {
		case 32:
		case 48:
		case 64:
		case 80:
		case 96:
			do fixed-size MOVNTI stores;
			return;
		default:
			generic __memcpy_flushcache()-style body;
	}

variant B:
	switch (len) {
		case 32:
		case 48:
		case 64:
		case 80:
		case 96:
			if (!IS_ALIGNED(dst, 8))
				goto generic_path;
			do fixed-size MOVNTI stores;
			return;
		default:
	generic_path:
			generic __memcpy_flushcache()-style body;
	}

For offsets 1..7 averaged, keeping those sizes in the fixed-size
switch took about 0.410/0.411/0.426/0.426/0.428 us per
32/48/64/80/96-byte copy, while redirecting the same cases to
__memcpy_flushcache() took about 0.962/0.956/0.923/0.998/1.001 us.

Based on that measurement, keep these new cases in the main
memcpy_flushcache() fixed-size switch without a separate
alignment check.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 arch/x86/include/asm/string_64.h | 56 +++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index 6cb9e0ac7fa0..1e634264a31b 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -83,7 +83,35 @@ int strcmp(const char *cs, const char *ct);
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 #define __HAVE_ARCH_MEMCPY_FLUSHCACHE 1
 void __memcpy_flushcache(void *dst, const void *src, size_t cnt);
-static __always_inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
+
+static __always_inline void movnti_8(void *dst, const void *src)
+{
+	asm volatile("movntiq %1, %0"
+		     : "=m"(*(u64 *)dst)
+		     : "r"(*(const u64 *)src)
+		     : "memory");
+}
+
+static __always_inline void movnti_16(void *dst, const void *src)
+{
+	movnti_8(dst, src);
+	movnti_8(dst + 8, src + 8);
+}
+
+static __always_inline void movnti_32(void *dst, const void *src)
+{
+	movnti_16(dst, src);
+	movnti_16(dst + 16, src + 16);
+}
+
+static __always_inline void movnti_64(void *dst, const void *src)
+{
+	movnti_32(dst, src);
+	movnti_32(dst + 32, src + 32);
+}
+
+static __always_inline void memcpy_flushcache(void *dst, const void *src,
+					      size_t cnt)
 {
 	if (__builtin_constant_p(cnt)) {
 		switch (cnt) {
@@ -97,8 +125,34 @@ static __always_inline void memcpy_flushcache(void *dst, const void *src, size_t
 				asm ("movntiq %1, %0" : "=m"(*(u64 *)dst) : "r"(*(u64 *)src));
 				asm ("movntiq %1, %0" : "=m"(*(u64 *)(dst + 8)) : "r"(*(u64 *)(src + 8)));
 				return;
+			/*
+			 * The relevant fixed-size copies here are the
+			 * x86_64 struct page sizes: 64, 80, and 96 bytes.
+			 * Keep 32-byte and 48-byte copies inline as well
+			 * instead of sending those nearby fixed-size
+			 * cases back to __memcpy_flushcache().
+			 */
+			case 32:
+				movnti_32(dst, src);
+				return;
+			case 48:
+				movnti_32(dst, src);
+				movnti_16(dst + 32, src + 32);
+				return;
+			case 64:
+				movnti_64(dst, src);
+				return;
+			case 80:
+				movnti_64(dst, src);
+				movnti_16(dst + 64, src + 64);
+				return;
+			case 96:
+				movnti_64(dst, src);
+				movnti_32(dst + 64, src + 64);
+				return;
 		}
 	}
+
 	__memcpy_flushcache(dst, src, cnt);
 }
 
-- 
2.20.1
