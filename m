Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794480305;
	b=EBwlvm1uWJU+Sg4k9A+CMekvB+iwcp1rXy+pL6cpDHT2SGNS+Kmqr6fL+X+P+r2pPrCe
	 baAUuNUVslvtIilU/5t6upCus8lnGedUhLRnlC8StmqDGcUfxzM6deRzjjNgYqqD+Yrs3
	 AWlmtlGB6PJfprlQ7IIFhNmzUUKBygEoZ5LO/1MW4lGXnPMIcmK8h1AXK6h6GPJOhP3cT
	 mIwUUeoLYlVB7T9cld9DFDo607gXv4cXEGFaLi57bjPcHfQBsaqqgRWfanrHXlxzQSzBc
	 nTIi8H5vvwVIGmR/v7z+/OtDvqp85B23tXbsJuMhItkYz8y4M7iZNwqfmHci0WJdjyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480305;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=INpeTcchLLbS0psUlyWopVBCXTqH0HdLEcZJcLgnzp8=;
	b=zeeVMiSfr50JozfjGkFWtmCHPhpBd0cuCUHYILe3owNWwgOEg1rAtDtMmdmWN1Pdd9nj
	 HaxleSy7FZzMwYtjCP+nwgYFh3oRHIhTdDZuqSfjBaKR2icf556xkrFzZO9rqpp8n121A
	 wVLhFv87i4wzQttzbp8IgeRjCSYMmAYmQo/LZPVecSiG26t1G8/nJF/UPNKRkZsbHCMvb
	 KMA+lwsS3syG+f7T5G3unfQWw/r8X7Xe2oNxWCkxXJX3Kgau5KmYirPiVy+RBVMssRRtt
	 c8hsXZ+USwK9F6o906FCEmato7jLWERgihPPNKuKV6w6EtZtitf3vJOqao14YZXxEFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=VhSAjEJT;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEA3606A33F
	for <linux-arch@vger.kernel.org>; Thu, 12 Nov 2026 10:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDEA3606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=VhSAjEJT
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1a3c08d6928so6810565c88.0
        for <linux-arch@vger.kernel.org>; Thu, 12 Nov 2026 02:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794480304; x=1795085104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=INpeTcchLLbS0psUlyWopVBCXTqH0HdLEcZJcLgnzp8=;
        b=VhSAjEJTXAaXpQdaf5y/37clY9qum96I3OhdyoKcrPdx+eQDYT1E8PzrMoO3VlQurs
         YHhhVBZNj/IgW66JlKShiypHEubXT+akNNMBoQ+k3KEI/6H8UwZ/nD3lT2xEGA643A4W
         cvW5sUY6nAGixGav8ggIG5AEFVZCoImkhfTz+k8o2a6GEfFtlfJ2uv79ocuQQsqJTSdv
         r4gQbyLtAMihEboCJCe3TbqPES8SyE5dulGcxXI9Gkwm1Xs5MVXnJcNbBpx7TB/026gt
         dAFy19CipMBI7/CGRzjPJ1NiXqXnXOl+kmn4j1w6yyjppCB+kiR/rdbYLXGvIfo0Z7+V
         HJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794480304; x=1795085104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=INpeTcchLLbS0psUlyWopVBCXTqH0HdLEcZJcLgnzp8=;
        b=Feoo6mgXL1Bj9r6by51/Eyo8pFOzJlCjl9aSJVsyxQAVJxH5m8vnGrenYHObvvTV2y
         2ff7xguD5Q3b3ZpoP8ajMJQBTgImXgoq+cWbCU0GNMNEy4hCM03XDEIyUyX2H58wZnMo
         DlM1+J5qSsrornpUO5NXsNBivR2/f8TL7J3Rb6YvAJCuN7qCWXiJr56i2sFU+BBlrzEs
         3RPzctFcJC1WZkMrPyHzhH8sXiMuNZ3DG9+IQo2sOkvx9sZ7k/kc86uZOr/AxzU/Ouf0
         V6uWnsE2PQ5BbSIBlo1uWeL26Ards5Fla5DQaVmYZ3FyGYJe45GWbB9zLhhrpgYgU49t
         Tmzg==
X-Forwarded-Encrypted: i=1; AL+hErGspRgU4c9hxVMGFzkR61CITe42DPC8yczDyq2NC7kVS8FaB7sS3xEO/XW04YKDzVcjiOfH9XucaaqF@vger.kernel.org
X-Gm-Message-State: APuU4Z9EDz7UzzfmWtERrpocT3N0MdR6RGZqTgmF8sYOw1j9uTc9dIHb
	NeNuEYyh4hqiZajd8bSs+mLZge0vi3iXg9n2YNflUo/vBwLkSjXY43HFN4/Jy4V0YH8=
X-Gm-Gg: AYBFou11ohhSq1JboSb1Q1Z430WAB65uFkcgOlyI250exsrlN6BHwnHJudtu0sGRyyW
	pwSkLKTJjVSWRjLQ30iaZ/cfdMCvISoXifi7HH/khqXprBIR8GIovY/dugT1DPSjQZrrBLcGiPz
	tdlJ1u2WQasBJB1Uly6XniJQkH1U35qyD776SXddSDQgz3MvrapuNqfPi4CoLBxk1NW8PDJfXkz
	hyTEyUGLymn7reYDnwp7XNDwEf7br0GHxV2SgvtPguIwp/8HMi3n0lETqyeKb7b9XkqcIUxx8jn
	3JSHA04jOuXPe+1hfntIopt43C7swj/dHmGRHOfZ2/WuJHbbco3YozlOGnMoIBiTnXUVdx9OPL8
	/l1dUCAcfUYJc+o7hHeNZMuSm11bLwW4AkySIw6jX3Wjcvei0bqgTeTd+/5byrOv9IROutcH/ts
	Fp6/bWso9/EvYfSrDtz1J0TLqnmpsFBlFc72iN5gEX49Zr2YxJNvpFQCFxR3SJKmrQmyC6WLy/C
	ZbbpGhqcISWT/LwVrhyi9Xr2I8uuOy9GpIdThL+e8y/Grh9mDEWMJECGNMaM9KHnxxNnSHnTo7U
	UPKNQ8fjYy35MwrEM0tJ7lygPsnZ3ivvOYaDr3V0X82gunOe+M2hQlOhGqsGvolLKG0=
X-Received: by 2002:a05:701a:ca05:b0:166:5552:780a with SMTP id a92af1059eb24-1b3c02f379amr4916378c88.8.1794480303681;
        Thu, 12 Nov 2026 02:45:03 -0800 (PST)
Received: from FR9WL0RHKY.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3772121e654sm13228694eec.2.2026.11.12.02.44.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 02:45:02 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	dennis@kernel.org,
	tj@kernel.org,
	cl@gentwo.org,
	oleg@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	bjorn@kernel.org,
	pulehui@huawei.com,
	puranjay@kernel.org,
	broonie@kernel.org,
	cuiyunhui@bytedance.com,
	dave@stgolabs.net,
	david.laight.linux@gmail.com,
	jszhang@kernel.org,
	tglx@kernel.org,
	conor.dooley@microchip.com,
	thuth@redhat.com,
	ajones@ventanamicro.com,
	ben.dooks@codethink.co.uk,
	rkrcmar@ventanamicro.com,
	samuel.holland@sifive.com,
	zong.li@sifive.com,
	debug@rivosinc.com,
	seanwascoding@gmail.com,
	andybnac@gmail.com,
	menglong8.dong@gmail.com,
	cyrilbur@tenstorrent.com,
	wangruikang@iscas.ac.cn,
	atishp@rivosinc.com,
	apatel@ventanamicro.com,
	arnd@arndb.de,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	qingfang.deng@siflower.com.cn,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	linux-arch@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v10 8/9] riscv: implement preemptible this_cpu cmpxchg128
Date: Thu, 12 Nov 2026 18:41:48 +0800
Message-Id: <20261112104149.38589-9-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20261112104149.38589-1-cuiyunhui@bytedance.com>
References: <20261112104149.38589-1-cuiyunhui@bytedance.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the preemptible compare-and-exchange support to 128-bit values on
systems with native AMOCAS.Q support.

AMOCAS.Q implicitly consumes register pairs, so keep both halves of the new
value in fixed registers even when either half is zero. Retain the
local-IRQ-protected fallback when native cmpxchg128 is unavailable.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/percpu.h | 66 +++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/riscv/include/asm/percpu.h b/arch/riscv/include/asm/percpu.h
index 4d2fc10cbdab1..1d35fc89eeeb2 100644
--- a/arch/riscv/include/asm/percpu.h
+++ b/arch/riscv/include/asm/percpu.h
@@ -9,10 +9,12 @@
 #include <linux/thread_info.h>
 
 #include <asm/asm.h>
+#include <asm/cmpxchg.h>
 #include <asm/cpufeature-macros.h>
 #include <asm/current.h>
 #include <asm/gpr-num.h>
 #include <asm/hwcap.h>
+#include <asm/irqflags.h>
 
 #define __my_cpu_offset (((struct thread_info *)current)->pcpu_offset)
 
@@ -518,6 +520,65 @@ __percpu_cmpxchg_case_##sz(void __percpu *pcp, unsigned long old,	\
 
 __PERCPU_8_16_CMPXCHG_CASE(8, .b)
 __PERCPU_8_16_CMPXCHG_CASE(16, .h)
+
+#ifdef system_has_cmpxchg128
+static __always_inline u128
+__percpu_cmpxchg128_case(void __percpu *pcp, u128 old, u128 new)
+{
+	__PCPU_OP_CONTEXT();
+	union __u128_halves old_halves = { .full = old };
+	union __u128_halves new_halves = { .full = new };
+
+	register unsigned long new_lo asm("t1") = new_halves.low;
+	register unsigned long new_hi asm("t2") = new_halves.high;
+	register unsigned long old_lo asm("t3") = old_halves.low;
+	register unsigned long old_hi asm("t4") = old_halves.high;
+
+	asm volatile (__PCPU_GPRS_BEGIN
+		".option push\n"
+		".option arch, +zacas\n"
+		"amocas.q %[old_lo], %[new_lo], 0(%[addr])\n"
+		".option pop\n"
+		__PCPU_GPRS_END
+		: [gprs] "=m" (__ti->pcpu_gprs),
+		  [off] "=&r" (__off), [addr] "=&r" (__addr),
+		  [old_lo] "+&r" (old_lo), [old_hi] "+&r" (old_hi)
+		: [pcpu_offset] "m" (__ti->pcpu_offset),
+		  [pcp] "r" (pcp), [new_lo] "r" (new_lo),
+		  [new_hi] "r" (new_hi)
+		: "memory");
+
+	return ((u128)old_hi << 64) | old_lo;
+}
+
+static __always_inline u128
+__percpu_generic_cmpxchg128(void __percpu *pcp, u128 old, u128 new)
+{
+	unsigned long flags;
+	u128 *ptr;
+	u128 ret;
+
+	flags = arch_local_irq_save();
+	ptr = (u128 *)((__force unsigned long)pcp +
+			 __my_cpu_offset);
+	ret = *ptr;
+	if (ret == old)
+		*ptr = new;
+	arch_local_irq_restore(flags);
+
+	return ret;
+}
+
+static __always_inline u128
+__percpu_cmpxchg128(void __percpu *pcp, u128 old, u128 new)
+{
+	if (system_has_cmpxchg128())
+		return __percpu_cmpxchg128_case(pcp, old, new);
+
+	return __percpu_generic_cmpxchg128(pcp, old, new);
+}
+#endif
+
 #define _pcp_wrap(op, pcp, ...)						\
 ({									\
 	op(&(pcp), __VA_ARGS__);					\
@@ -618,6 +679,11 @@ __PERCPU_8_16_CMPXCHG_CASE(16, .h)
 #define this_cpu_cmpxchg64(pcp, o, n)	this_cpu_cmpxchg_8(pcp, o, n)
 #endif
 
+#ifdef system_has_cmpxchg128
+#define this_cpu_cmpxchg128(pcp, o, n)					\
+	_pcp_wrap_return(__percpu_cmpxchg128, pcp, (u128)(o), (u128)(n))
+#endif
+
 #undef PERCPU_RW_OPS
 #undef __PERCPU_AMO_OP_CASE
 #undef __PERCPU_8_16_OP_CASE
-- 
2.39.5

