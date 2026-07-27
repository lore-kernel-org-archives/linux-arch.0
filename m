Received: from va-2-113.ptr.blmpb.com (va-2-113.ptr.blmpb.com [209.127.231.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351B53FF1B8
	for <linux-arch@vger.kernel.org>; Mon, 27 Jul 2026 12:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155882; cv=none; b=Rxtu9vHpt9lCuRYp0Crb5VTqLquTriySdxA7IXMfA2S+eRF/obacmDtV4nKWv3b2/h90JFLNuVjDIJOt8t+v8o1AfYJUZG2h8VDEtW1NDo7W4WuW40r12PHnCy1X8ycKMLb1ugtiil112CLoil+e2ac6ofqhprk3/2b1faAHU7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155882; c=relaxed/simple;
	bh=q1EvQQ62BMNwZgK35kzTMo8Pc1Vv2TWHCTr28ELsF64=;
	h=Cc:Date:Content-Type:In-Reply-To:Subject:Message-Id:References:To:
	 From:Mime-Version; b=I34my/owr2VQ3WivS6FpLB0C1pqSE0mPRMdPDrJrDnq7O+GnPCH1Yo+6C3RDSm+NUkr3XdZZpzTTNDI2hme/AThdXFCRiTI30fujwUscwz3e6Cp1JtiAUDwUHhiJHvET2XO+x/+j2hKql2mnj7O22kQqRpd+xGI5Oh7xqORLAPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=mdgLSgPW; arc=none smtp.client-ip=209.127.231.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="mdgLSgPW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1785155869; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=KbqR+I8FS5y6RR72nDD58GEAE+Ku54boR4Q6mpg4Crs=;
 b=mdgLSgPWkTvD6UeGP1UOja1m9uh8Z7abdaOOI9e9zcL453M7B8rHW/P8qWGR8EPlieOfDh
 oQ20WthNzwzcu8wHUNBkGw5Hk2BjYGln3lTLgLJKEwh0f2Vws6Vm+2IkWEYHIAl7MeoZbK
 zT/XaJXs4AUhwk/cUMwbVQlPn8Yc69HsFr/74q5isAuANxt36YsgLksEDW0Wiq/oBQK2K+
 gmSaYu+penDmTHxziiYEO/NMnUb7JNZSWj6CbmmLXNjCNwYqHg5PMbYB7omwtmAopPhMnv
 HmEwK+05cGsHYyBjuoMO8bJnifbB5Ad0VLXV34SsTGhO3pYugYvsIBmzSZQdDg==
Cc: <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>, 
	<lizhe.67@bytedance.com>
Date: Mon, 27 Jul 2026 20:34:27 +0800
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20260727123429.5673-1-lizhe.67@bytedance.com>
Subject: [PATCH v8 7/9] x86/string: extend memcpy_flushcache() fixed-size fastpaths
Message-Id: <20260727123429.5673-8-lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26a67511b+c54bfc+vger.kernel.org+lizhe.67@bytedance.com>
References: <20260727123429.5673-1-lizhe.67@bytedance.com>
To: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<balbirs@nvidia.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<david@kernel.org>, <kees@kernel.org>, <mingo@redhat.com>, 
	<muchun.song@linux.dev>, <rppt@kernel.org>, <tglx@kernel.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2

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

These new fixed-size cases follow the existing memcpy_flushcache()
fixed-size MOVNTI cases. The existing 4/8/16-byte cases already use
MOVNTI without a separate destination alignment check.

The movnti_8()/16()/32()/64() helpers keep the "memory" clobber
intentionally. The destination memory operand describes the MOVNTI
destination, but it does not express the broader compiler-scheduling
constraint that this path wants: keep the fixed-size copy as a compact
sequence of streaming stores and avoid moving unrelated memory accesses
into the middle of that sequence.

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

The correctness rationale for not adding a separate destination
alignment check is that these cases follow the existing 4/8/16-byte
memcpy_flushcache() MOVNTI cases, and I did not find Intel SDM text
requiring an 8-byte aligned destination for MOVNTI.

The microbenchmark is only the performance motivation for keeping
these small constant-size copies in the inline path.

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
