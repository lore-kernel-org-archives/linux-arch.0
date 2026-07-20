Received: from va-2-114.ptr.blmpb.com (va-2-114.ptr.blmpb.com [209.127.231.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A3F40B6F0
	for <linux-arch@vger.kernel.org>; Mon, 20 Jul 2026 12:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784549266; cv=none; b=QezMvdJCL4Td60rTM14avk4ZvwoFCKB6EiDOG+l0b+2OuL6beosc1ZeDbYmGwYzP5I6sqXhb+zuUnqNufGjihY4WPbGf1uo+iRG+JWg8RFDYYZv+0uTMvsXZA+mpfwdlbc7tEwLTHaMpGOsARJswFhgD4WfVaohH/WicnCuwTGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784549266; c=relaxed/simple;
	bh=lOfsESTU3A3Vrg05a/Gf2lU/W74DqePtJvn0GwFEsjc=;
	h=Mime-Version:References:Content-Type:To:Date:From:Message-Id:
	 In-Reply-To:Cc:Subject; b=Q3C30UgTyJHwmLwstiYKWZtP6euwmhbrRb1cdXXOHoLGDvu+LBXkMiNzOezbg2wMf6T42eRMQ5I5vxu/EJ5RSXwRirYQYWL8KPkBpeGXWyBuNjwthwRtXV9aTeM4a+uBXieqgELq8IPXItjhVABg0eH1eMf7hxWUS94CZORZRNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ftFnKYQq; arc=none smtp.client-ip=209.127.231.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ftFnKYQq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1784549254; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=03h9QJRQ38dlV/nJWkLzpVtuC5RS5+G1+uFcq5bFKQ8=;
 b=ftFnKYQqQuFKWSqHj5SNMkUoBU0f3Ii5AnU+ll4cIJOziCJy7uwqOaeRa/H32STGQAolSI
 dmpeUUTjrvf581GHIfQvAm7olQG8sdGgIu1dL34a3wtl5LW9w8QPp6PTMtUy3hVHO0/RoA
 dtNfWdHhzS1wOjRm56x1EvQpr1bZWujOIwbBx79F7OR2gd2K42RBfjZhDAfWtTm1cQAwpu
 prhOYXawaAwSpU2ke156yX6Co64OdNvnVgiwTrpWygN+pd84BPiXA59TqL6LXxA8+NnXKG
 DfMRHTYYitDBbI+IONtqRyMvTHuhTaaWw08AiTqNU844KoCojr2fr1jDLvGLlg==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260720120259.1545-1-lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<rppt@kernel.org>, <tglx@kernel.org>, <muchun.song@linux.dev>
Date: Mon, 20 Jul 2026 20:02:57 +0800
X-Lms-Return-Path: <lba+26a5e0f84+a84939+vger.kernel.org+lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
From: "Li Zhe" <lizhe.67@bytedance.com>
Message-Id: <20260720120259.1545-9-lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
In-Reply-To: <20260720120259.1545-1-lizhe.67@bytedance.com>
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
Subject: [PATCH v7 7/9] x86/string: extend memcpy_flushcache() fixed-size fastpaths

The new x86 memcpy_nontemporal() helper in this series maps to
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
index 21ae515ae35a..bc6a9f34b346 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -82,7 +82,35 @@ int strcmp(const char *cs, const char *ct);
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
@@ -96,8 +124,34 @@ static __always_inline void memcpy_flushcache(void *dst, const void *src, size_t
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
