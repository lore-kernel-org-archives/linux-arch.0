Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4E04189BA
	for <linux-arch@vger.kernel.org>; Fri, 11 Sep 2026 07:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789110265; cv=none; b=PsmW/f6ZIoHzLLH0iud60X0xu4Zx+f7QJNKzBj7z3rtgb9X7p13ZYG2bLPqasW1dMhYK1RD0NmA2wLCk6GpDR8WArhY4LvSx54tdF/P166Jei7EHciYoiSmrxrtXHB4J6dalymnpybUZ30EsiQEVzi9Epla67loMk9hZe/+aLFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789110265; c=relaxed/simple;
	bh=R3mamHcjqtuk8KE+ymGSXTr7kdrGSGWqP7eBuJzhREA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KqdqZnmvSudYcwreV4dRyiaTtJeP04rKd482XDuSVuHwuSh4vLJs6JadUBgh6WWtnznVCLTd72NHX3B4EVYEjDmKYjQ370qS40buggeoCqGIO4h+9qHAbDTHEBDbnhJYJcYUoqdvrgmN/C/xi7Xzw94xkwJyMwhrA/IK48mp+gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hSAKQ/S2; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hSAKQ/S2"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cec4226c70so7973035ad.1
        for <linux-arch@vger.kernel.org>; Fri, 11 Sep 2026 00:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789110253; x=1789715053; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v4log2b7lXSyNC0NL5JxC6rtxmWq5NdYaV3uhGWFgpQ=;
        b=hSAKQ/S2mhCvMF2YYH3xWnDEBCvTgwRmu+c2IkdWvo2Cn1xKPrMPO8Fch9nBooG+jN
         Yo5nINC9akFagDai8BWJTafV2gQVFKk6A1TSVCbANNaV8XwLvB0QZ2k0D7eI80Oo2F8y
         U/EBYpJmBTwIVT6ABFKNwnCAmoeAMp62vtA2Rs401YCydnmJBvaD6wXqRFwUjyvMsMQu
         YNyfDri9jdmoWJ7kt1b6uaUE5En/vyVZu1tr6lCrL9Sc0y8GpSE90kpa18sHd20S+Isc
         P62GONAd/6oeUUtNwxqUvYNGmmnKGpB89oPpGsDBveTHTev4tAPijB7xGLbnPx+nOAxO
         FoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789110253; x=1789715053;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v4log2b7lXSyNC0NL5JxC6rtxmWq5NdYaV3uhGWFgpQ=;
        b=Bc8QZ+3ZwrW8XN2HuzfOlNXJVOZr0e6cQNT9MJtGlJ5FwBYb1UOi9gzLPE8+jUHOqI
         e+l0/8kx4XSMI8XgxDDuV6H8JR1iHWJvNr4dOXqKX/B68zvTeQ1lCAirxLQAjG+SH1vK
         gUnYkX/mRlpUjOS+k+7/frFg5Gzeoq+DkakBCzmXdhEkP4TAHEu7FIc+MF77t5rDXd+r
         LsUhKTtX1n8zOFSJL7hIOIxxM+x5wBA9heveud1smZJAbbGEHolJjj+0TW1Bsw7ib/PU
         xemcsWjpEWMkmngZoO+AB8MyllNgOTYEVAmFTV3aH8zG9G2CqNUhvkQldUMWn/dD0bHL
         LfbA==
X-Forwarded-Encrypted: i=1; AKwUvBz1/CIHBzTI0tEkXVcBZ+AFf8Mdmmn5qx5Sg4UDUsmfMOFRXct84Iw8BA4QqPqnX+jDflq/xCdGZ/Df@vger.kernel.org
X-Gm-Message-State: AFuF++ln+V3swMy06DLNGMf26ACfVGxpoeOAorMfQ+U1XUh+3g4vWHgf
	Q48NM5MCk20lWZwTp9ZNOEFc3c83eXY8vvwGD4Gu54AnO+FiHmDZXF86ltw859slRLwBeBVB6EN
	/
X-Received: from plbmm11.prod.google.com ([2002:a17:903:a0b:b0:2db:34ec:27e6])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2983:b0:2db:257c:9fd5
 with SMTP id d9443c01a7336-2dd2a35dd2bmr69446655ad.16.1789110252766; Fri, 11
 Sep 2026 00:04:12 -0700 (PDT)
Date: Fri, 11 Sep 2026 07:03:40 +0000
In-Reply-To: <20260911070346.801948-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260911070346.801948-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog
Message-ID: <20260911070346.801948-3-morbo@google.com>
Subject: [PATCH 2/7] x86/word-at-a-time: Instrument load_unaligned_zeropad()
From: Bill Wendling <morbo@google.com>
To: linux-kernel@vger.kernel.org
Cc: Bill Wendling <morbo@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Kees Cook <kees@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Peter Collingbourne <peter@pcc.me.uk>, linux-arch@vger.kernel.org, 
	linux-riscv@lists.infradead.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

load_unaligned_zeropad() is implemented as inline asm plus an
exception table entry on every architecture, so the compiler never
sees the actual memory access and cannot emit KASAN/KCSAN
instrumentation for it.

Resurrect the instrumentation that was lost when migrating from
read_word_at_a_time() by renaming load_unaligned_zeropad() to
arch_load_unaligned_zeropad() and adding a common instrumented
load_unaligned_zeropad() in the new
asm-generic/word-at-a-time-instrumented.h, pulled in from the bottom
of asm/word-at-a-time.h. This mirrors the existing
arch_atomic_*()/atomic_*() split in linux/atomic/atomic-instrumented.h,
where the arch_* version is the raw, uninstrumented primitive and the
plain name is the instrumented one everyone should call.

The wrapper is __always_inline, so it compiles down to exactly the
same inline asm as before plus instrument_read() -- confirmed via
objdump that no calls or relocations to load_unaligned_zeropad(),
instrument_read(), or the KASAN/KCSAN check functions remain when
KASAN and KCSAN are both disabled.

Convert x86 to the new split here. Follow-up patches convert the
remaining architectures (arm64, arm, riscv, s390, powerpc) that
implement load_unaligned_zeropad().

Fixes: d94c12bd97d5 ("string: Add load_unaligned_zeropad() code path to sized_strscpy()")
Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Bill Wendling <morbo@google.com>
---
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Walmsley <pjw@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: Kees Cook <kees@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Collingbourne <peter@pcc.me.uk>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: x86@kernel.org
---
 arch/x86/include/asm/word-at-a-time.h         |  4 ++-
 .../asm-generic/word-at-a-time-instrumented.h | 25 +++++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)
 create mode 100644 include/asm-generic/word-at-a-time-instrumented.h

diff --git a/arch/x86/include/asm/word-at-a-time.h b/arch/x86/include/asm/word-at-a-time.h
index 422a47746657..483d27dc96b2 100644
--- a/arch/x86/include/asm/word-at-a-time.h
+++ b/arch/x86/include/asm/word-at-a-time.h
@@ -67,7 +67,7 @@ static inline unsigned long find_zero(unsigned long mask)
  * and the next page not being mapped, take the exception and
  * return zeroes in the non-existing part.
  */
-static inline unsigned long load_unaligned_zeropad(const void *addr)
+static inline unsigned long arch_load_unaligned_zeropad(const void *addr)
 {
 	unsigned long ret;
 
@@ -81,4 +81,6 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
 	return ret;
 }
 
+#include <asm-generic/word-at-a-time-instrumented.h>
+
 #endif /* _ASM_WORD_AT_A_TIME_H */
diff --git a/include/asm-generic/word-at-a-time-instrumented.h b/include/asm-generic/word-at-a-time-instrumented.h
new file mode 100644
index 000000000000..8a66d53bf538
--- /dev/null
+++ b/include/asm-generic/word-at-a-time-instrumented.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_WORD_AT_A_TIME_INSTRUMENTED_H
+#define _ASM_GENERIC_WORD_AT_A_TIME_INSTRUMENTED_H
+
+#include <linux/instrumented.h>
+
+/*
+ * Each arch's asm/word-at-a-time.h defines arch_load_unaligned_zeropad()
+ * as inline asm plus an exception table entry, so the compiler never sees
+ * the actual memory access and cannot emit KASAN/KCSAN instrumentation
+ * for it. Provide the common, instrumented load_unaligned_zeropad() that
+ * every caller uses by wrapping the arch version with instrument_read().
+ *
+ * This is marked __always_inline, and arch_load_unaligned_zeropad() is
+ * itself a tiny inline-asm-only function, so this compiles down to the
+ * same inline asm as before plus instrument_read() (which itself compiles
+ * to nothing when KASAN and KCSAN are both disabled) -- no actual call.
+ */
+static __always_inline unsigned long load_unaligned_zeropad(const void *addr)
+{
+	instrument_read(addr, 1);
+	return arch_load_unaligned_zeropad(addr);
+}
+
+#endif /* _ASM_GENERIC_WORD_AT_A_TIME_INSTRUMENTED_H */
-- 
2.47.3

