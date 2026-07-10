Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AF13E023E
	for <linux-arch@vger.kernel.org>; Fri, 10 Jul 2026 07:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783669972; cv=none; b=Ne8SsBnLPymxvyqOCEdCcutdZfjEp4YhD5oNYhkwjAajqavP2eT22jKfSraKpuXGBlmqqEG+kIW0Z5iPBejpqFJjufohLnOs+oZVVk5ITLe5lht6eVv38/TdNcxd1nDTs67vO4OxT78u8kCzNrA+sC3Kz+ewsNk1UeFVShVHH4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783669972; c=relaxed/simple;
	bh=9p4KOQc1NA7flV+LCDS3yU/hvIyMCPN4SrCd+V/TQfs=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=YPAF48pZhxVxJAcPcds/CPu2KekEpVqBXtmJEoypbGlkkAc6pi0WMopi9fUsdB+2KjLg2TGVUH1Rxh3juCJoM2TA6boQcgEpxnOATgoJqUuymDnf4/qtnl2sK+ISkSRsBTD78fl4tiYL4AQxZUAXWKO50YxJGgtwdSnz+XEODX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhHNLRNe; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhHNLRNe"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso1027537a91.1
        for <linux-arch@vger.kernel.org>; Fri, 10 Jul 2026 00:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783669970; x=1784274770; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Rg/Ie/7b7qgWKuC0VaavvDFjCiYtgIOuaIEl9tofAzE=;
        b=ZhHNLRNeI8znRgBdhnlgMYR1KY0TZV5HotHcCDUkGjlRy3ARXbj1tjyeGZiyMKPFpk
         T0oK6KlIMbNTHCgS6QkhgR/gRxsxqD4iDxJfA/PxaEYTcVIem5NIROe1t/vPPKeahqDv
         pvP0uCXA5XUCgeA/+QBCw3YNSrfkWbMxXcLVXet7XtKJVW8cYjmOFqa3c4cMT4zmBTFP
         /NNVDaCoAejTzZPLY0kS7TrYPYGVgN3hMrlhyxWjoMRwyJc+0sxo/9ud8gu4oCtGqqEs
         PJ910jdAzzQFgJRRonAG0EAXBdB7xyyOg6hvVIlih6sdJFOXrMpnHDNtPoFRHDvvLeRG
         HAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783669970; x=1784274770;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rg/Ie/7b7qgWKuC0VaavvDFjCiYtgIOuaIEl9tofAzE=;
        b=OmAux+hhXv/xGME3WZ4z0hFjJEZX1p/0q+Nfa8gQnYaQNeSRdFDcWX0UlKcbzXCAJv
         SBS6aFXVdfNyO6HXA2MXPLP9TYuZlDrnEOAeLE6+Spm19E5vJznjUmYBkuhb7Gnk2a/h
         k7gGUxzbRukYl0ep1IBCQbpAAb1V7vHuCWM7X18flgTzDUb2CHxdZTWbqzQBD34OrxHD
         5KI1MId/1YofE0dMygOnfrxvGnvSJpY3bOx5N7n0WeYHyUPIsBaU/SRIKM7hmJjqc9YF
         t19PlCHRPZKVYv6EhXeeeBqlhCCdMGQrcKR4erbmE5h3AGWdACfaGkLVOGeuixvSJI1T
         4eFg==
X-Forwarded-Encrypted: i=1; AHgh+RqTjWmKoj+Mj92Ay+XHhyB4n3vvLhDshImYfi4iwn09ORjFLZTGmVEHv66LTOjutaJHVTssk/fzDC/v@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn3HeouuYJpCGRNgKBaIm2fPLG0kh8MndpIROnKPG6JN1c+gsP
	NmYwxD4ErdedU+KeEt20LpoeT+DQPugIYvT3tEJ5vmVvrvIxohcAhNcW
X-Gm-Gg: AfdE7cnGfwNdHnwEROs8ToE3te9vhmyGcVFUHy0rBQxJ/lVdR+snCBpVOTLbnPRrilh
	CO1ycZ8xBOiaXtcu0g/+qmiYIrpAHb20Y4Tf0+LATVDXFrAiqvaZjG0UeGeRCJbqluecpucPsak
	n+Hrvih0PC3iLD/Spyhjzj8SkyVYFSbI81tvkN6LPd35v+Iq1KzK2ezWzgv3m8uew/PG3Iu0SgV
	52wcpNxn+AZyu+JKkPy8zwMqtFwzAm66PZ2MTl47cXtKqlu8jyOogtySPg3Kc3i0uqOC7XIfp8d
	GM0Q1+9NboAkHsCmIKdCMnxRF5v9gR8rOMXH8wSiT6+mKVWMycRb2SISawx4BIlmwRbN+xh79dc
	b/o6T0Cw3rT/uk+YEd79YPPe32CvHZhTeI/nvsbRJLwFXFYE80jJjt0fttsoj1P0KSAfMPPUOko
	edZpi2laki9QONZSQlANI5QkrS4PpSRpKVdCaNJQW99NWrvquIrTM=
X-Received: by 2002:a05:6a21:7018:b0:3c0:278c:6a31 with SMTP id adf61e73a8af0-3c0bcf16417mr11875813637.11.1783669969796;
        Fri, 10 Jul 2026 00:52:49 -0700 (PDT)
Received: from [10.0.0.65] ([2601:647:6700:64d0::94ac])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174839f89sm38555369eec.10.2026.07.10.00.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 00:52:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 5/8] riscv/runtime-const: Introduce
 runtime_const_mask_32()
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Darren Hart <dvhart@infradead.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-s390@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>, 
 Jisheng Zhang <jszhang@kernel.org>
In-Reply-To: <20260630045531.3939-6-kprateek.nayak@amd.com>
References: <20260630045531.3939-1-kprateek.nayak@amd.com>
 <20260630045531.3939-6-kprateek.nayak@amd.com>
Date: Fri, 10 Jul 2026 00:52:39 -0700
Message-Id: <178366995930.1208691.2993932866462893112.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783669964; l=4236;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=9p4KOQc1NA7flV+LCDS3yU/hvIyMCPN4SrCd+V/TQfs=;
 b=F/QGuANRjQCatrmX5WvWw/8bzNn749xVtEASOBTvIfRlhzbACPiXU+b9sdtK9qiaZEF/txk+I
 Ahbuf6kQMDPASKMUgAUa9R1xTJatFeJ22eP5BSrccd2Hke4cw9LtrXi
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=

On Tue, 30 Jun 2026 04:55:28 +0000, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
> Futex hash computation requires a mask operation with read-only after
> init data that will be converted to a runtime constant in the subsequent
> commit.
> 
> Introduce runtime_const_mask_32 to further optimize the mask operation
> in the futex hash computation hot path. Since all the current use-cases
> are of the form GENMASK(n, 0), with n > 0, following sequence:

I really appreciate you spending the time to do this, thank you!

>
>
> diff --git a/arch/riscv/include/asm/runtime-const.h b/arch/riscv/include/asm/runtime-const.h
> index 1ce02605d2e4..dbf96c937dbb 100644
> --- a/arch/riscv/include/asm/runtime-const.h
> +++ b/arch/riscv/include/asm/runtime-const.h
> @@ -262,6 +279,33 @@ static inline void __runtime_fixup_shift(void *where, unsigned long val)
> [ ... skip 24 lines ... ]
> +	BUG_ON(!val || width > 31 || (GENMASK(width - 1, 0) != val));
> +
> +	__runtime_fixup_shift(where, 32 - width);
> +	__runtime_fixup_shift(where + 4, 32 - width);
> +}
> +

It would be "optimal" to use an andi when the mask is <=11 bits since
andi can fit an 11 bit mask. What you have is good enough but I'll leave
my stab at doing the andi patching here in case you want to apply it.

From 9e5527aaddd464783af795aacdb6d094e11cc31e Mon Sep 17 00:00:00 2001
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
Date: Thu, 9 Jul 2026 23:18:09 -0700
Subject: [PATCH] riscv: Optimize __runtime_fixup_mask for masks with <= 11
 bits

---
 arch/riscv/include/asm/insn.h          |  2 ++
 arch/riscv/include/asm/runtime-const.h | 29 ++++++++++++++++++++++++--
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
index c3005573e8c9..0a34cd7305d0 100644
--- a/arch/riscv/include/asm/insn.h
+++ b/arch/riscv/include/asm/insn.h
@@ -141,6 +141,7 @@
 #define RVG_OPCODE_JALR		0x67
 #define RVG_OPCODE_JAL		0x6f
 #define RVG_OPCODE_SYSTEM	0x73
+#define RVG_OPCODE_ANDI		0x13
 #define RVG_SYSTEM_CSR_OFF	20
 #define RVG_SYSTEM_CSR_MASK	GENMASK(12, 0)

@@ -175,6 +176,7 @@
 #define RVG_FUNCT3_BGE		0x5
 #define RVG_FUNCT3_BLTU		0x6
 #define RVG_FUNCT3_BGEU		0x7
+#define RVG_FUNCT3_ANDI		0x7

 /* parts of funct3 code for C extension*/
 #define RVC_FUNCT3_C_BEQZ	0x6
diff --git a/arch/riscv/include/asm/runtime-const.h b/arch/riscv/include/asm/runtime-const.h
index dbf96c937dbb..24a9b13081f7 100644
--- a/arch/riscv/include/asm/runtime-const.h
+++ b/arch/riscv/include/asm/runtime-const.h
@@ -9,6 +9,7 @@
 #include <asm/asm.h>
 #include <asm/alternative.h>
 #include <asm/cacheflush.h>
+#include <asm/insn.h>
 #include <asm/insn-def.h>
 #include <linux/memory.h>
 #include <asm/text-patching.h>
@@ -302,8 +303,32 @@ static inline void __runtime_fixup_mask(void *where, unsigned long val)
 	 */
 	BUG_ON(!val || width > 31 || (GENMASK(width - 1, 0) != val));

-	__runtime_fixup_shift(where, 32 - width);
-	__runtime_fixup_shift(where + 4, 32 - width);
+	/*
+	 * A riscv 'andi' instruction can fit an 11 bit immediate, so the mask
+	 * can be directly applied. Otherwise fall back to SRLI + SLLI.
+	 */
+	if (width < 11) {
+		__le16 *parcel = where;
+		u32 insn;
+		__le32 res, nop;
+
+		insn = (u32)le16_to_cpu(parcel[0]) | (u32)le16_to_cpu(parcel[1]) << 16;
+
+		/* Replace the slli/slliw with an andi */
+		insn &= 0x000fcf80;
+		insn |= val << 20 | RV_ENCODE_FUNCT3(ANDI) | RVG_OPCODE_ANDI;
+
+		res = cpu_to_le32(insn);
+		/* Replace the srli/srliw with a nop */
+		nop = cpu_to_le32(RISCV_INSN_NOP4);
+		mutex_lock(&text_mutex);
+		patch_text_nosync(where, &res, sizeof(insn));
+		patch_text_nosync(where + 4, &nop, sizeof(insn));
+		mutex_unlock(&text_mutex);
+	} else {
+		__runtime_fixup_shift(where, 32 - width);
+		__runtime_fixup_shift(where + 4, 32 - width);
+	}
 }

 static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
--
2.54.0


I would prefer including this, but I am happy to approve this
regardless.

Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

-- 
- Charlie

