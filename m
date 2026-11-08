Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794122901;
	b=IKl4SYGDEFCK1JL4+bB8IxHpUb4k2Rs9cLFT058ohOYlOkxmWts+iJrWojW9BBX+heKO
	 /r0Xgmq9ZaVnU8DFUauexDyjaCXfZWDPdwCRMxFkuv8kOZ5aa1qad4PNa/5nzxksWTtJ+
	 DhrMVTwjoenWuwndYGbElDkLrEI7j4+odHq3DprRnsRrqcunrp2V+HvAvmzXkxBZYNvgj
	 LFRbhcTV4kjQnLe5f6FbScHTJ8JHIK3XuyiaPFkVi22vidHuwzpfznd7Wjtoa0a8iwdex
	 Zeo+PYFpo0IPOEokkMkzfkyMSFINaW/WtZdLxkQmEHyrBej/Ieol8iMtMR6m9lbCDKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794122901;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3GPdPWtz5u4EzHahKBPeD/s+natUps7WDXeM/yF/8SA=;
	b=RGZN5UsHIQPmvOnuS19bcyCJ1ACmJwLiAeTQOMvY5FUF67at37ubJBhhsziC+BvGW3Kw
	 5KlXdPl6SMskq5RVLYHRcBzA8OZ3Rk3EkUtJbuTUknjQUlpCIDHx8bKOT1mpsBQLzEuSG
	 b0+w6vy/+gKnq8zrQmXKR5v4LohkmkzUq2OTB81QyW7KD24ufEmQlmsdG6C6kTkT5WOMI
	 lLmguemGYKppryUxbk54/Sc5hwujJgRM83sDw1xE23K6NCK91BGkb3Utf0xKsdz4UbR41
	 4ckvB+CtWp8vJkcFhDcHFro2e706/X94lRM3o9xlW1HTxFiKurYufSx9DI0daVaT5+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=WeH7TKdG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66345606A321
	for <linux-arch@vger.kernel.org>; Sun,  8 Nov 2026 07:28:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66345606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=WeH7TKdG
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-845788309b4so89507a34.1
        for <linux-arch@vger.kernel.org>; Sat, 07 Nov 2026 23:28:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794122899; cv=none;
        d=google.com; s=arc-20260327;
        b=Y6ToSronFQNbr7B7s4lZKwjq8M5DtduM8FxbSDMtYMHKkAleXI/85st4GtSBFgZGge
         qTKuWr+HWrmseSZdvuGIZ69lQFKOqx5bFM6bOGmOgtJPWz84kJ41rvAOy2T9qDMqysDL
         ayHQEBy8iulSgOr+c6hoUsygudC4xg3ePz3zXeqRycRRte8V6vaoMQFmQGIRkgdBfnvn
         qws5nP0ARoEbVDKLRjz+217MWJdODRSQDP9ahhNKVssolwhopOjl8oX/d7lbDv2k9rh9
         SicjM5mydQClrz2rzRyS71XtCsIRFaeDd1t0oZu0ZpuFFkiHe/1a2URDMF7PlGyZqSKj
         b2qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3GPdPWtz5u4EzHahKBPeD/s+natUps7WDXeM/yF/8SA=;
        fh=PZcki/GxtiqxHM1dzmMX6WRZwJPy3ANtCiiHGe1ijac=;
        b=ZK/qREOK5XOJjgxVhU3+qRcVcAp5sx0O33oXGqvoX4j5p0aKh6o7xBk3DsuGH/r2sn
         hL1XpuSt0VcO8650EqCp75Mw+NESUAlOyMifMjTNEUkUhZcazyYiGFMQU5CAAcgNqYZX
         7ZPw/tuv36h1MY30ZwskvcDqK9VCVJEfvOpZuO2Qo0M2Zva3vEXjMx/rwY1ziBYQp5R2
         AhIOt2l56k+OmXLMtJ9X0CLIWhdHlPLhwVpOb2pIODRM5AqLBs6hpIfHs0E0vjXQPLA0
         apRNUmEGij9SGRpW8Omjcbv6CdVXNvAHbXDBeiL0+anagul/1x279SAGIapU9rjx1NDj
         jdlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794122899; x=1794727699; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3GPdPWtz5u4EzHahKBPeD/s+natUps7WDXeM/yF/8SA=;
        b=WeH7TKdGrs1Ow7zPTAoMdzv7JOc+fO38Bp+uhlxQz+1jUwMv0Isy44tFCD65yx5Bsd
         5cHd8kTpl/6RZi05CCw5Hwgu4TT5S+XDyLtNGdlESLuAlhPvE6LTLWEsyZMPvVgZAakc
         trhdTwVwo24cmPNCOr31y834JITed9ucDNoOcMzMbqit7fCRK+lc1fKHEu1c7854QTJp
         kvmA8Rp7FpfIze9KXcP8Yjroflt6PIjZhNR77MdMLkxFZpO7YFcsDQYrIprjAMZG2Yth
         x5XFlOvq8e53VNfPOH0nc1/YtGY250Am5JPJmPy9uj7qPcM5ryhgyNbWN/+AhqfJj2NB
         LDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794122899; x=1794727699;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3GPdPWtz5u4EzHahKBPeD/s+natUps7WDXeM/yF/8SA=;
        b=HbZp9uGo33cSbYNCaKQ3p2TrWbfg21WyIrZAWTXt+8K9mRrzs9HF2hZC+TuyU8Vbt9
         amad1yQOnUxflaeS9VYP5f7K1g8xJ8eapKzBSPeJwxwPPcV94n0vKeO+B/Q8SQk69Sg0
         E0FR1DZrvjJcHIhb/r2mGzzNELS+FjnptXdWDKot+e8IhndRUy3hLIJCDN7kf0fT2IsK
         nJVOik+FRIFrPm/IwN4bvJCt/bCitoDk16jWVbwJTpkQHgiS2ZZ2riDeX7s/iA6By8SX
         UdQnJsqSh8n254CICMch8aasJ4+iJZLbUeDF8QUXL/iFDtZfzUeA/hkwHk2f8hPot6bh
         Ztaw==
X-Forwarded-Encrypted: i=1; AKwUvBwq7W2T5ESJPt7jPS/nHomA1TuWzm5oQHh9E7C5b26vmFXLCKAZ1BOZFuGXDQnglM5HTxEt58wH/YzK@vger.kernel.org
X-Gm-Message-State: APuU4Z+x/VY0EbVrySxFIkKRRWOtHG6AKs4vRf/f8EvouHDbfZc7LJK0
	hJqDpXZIurQcNJvTnL5tCiFbe1OFSoYtVMwhGk+w6sfUlF36CoUNsJrHBYmT48Anhf/gTF9EA7p
	NHJEQ3G/kIb7MXy4ndVkZDHQQqhAz3QuM7b684HPMrQ==
X-Gm-Gg: AYBFou1BBmLAOAUisx8NtqjHOPDc1UFzEJAK0c6Nd6Y17hlNghKwjD1zDs5qzRysbGs
	tna3qJr63+Ey6ZAr1fWMXCZksiYX8ssQZO5GGMOaPCToTYSVbwOgm3sgoosZFWUTA5ocTRDaCTc
	S//h/ahVgNAO+KnTiuEfBVgBwN+D0QMwZ6JcrGLbcb7LNU/q9vT+pL3pdeHvS1lOPNowWQZpobm
	bTNXIQlyPHGTabn2qNQBHq4VVV3Fo8RFuHbJu075XzmLzW7qnaPfa/srssLkC01c1UKB80PKkh4
	6tnXWYTPPd2sz63J8I3bDpjftF9YrZmpzJse4eAvDrsgqa1c1YI+HvYZSAc9jnWyfqwNGYuevIy
	1KHk+WkzaaYv3EMZixmKsRSZjIN88mUszH/z/+Ua3tZs=
X-Received: by 2002:a05:6830:4492:b0:816:a9dc:6d05 with SMTP id
 46e09a7af769-85f50450ebemr666748a34.4.1794122899111; Sat, 07 Nov 2026
 23:28:19 -0800 (PST)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260703122832.15984-1-cuiyunhui@bytedance.com>
 <20260703122832.15984-3-cuiyunhui@bytedance.com> <20260826010748.zphu3wh2hlm4t4o2@offworld>
In-Reply-To: <20260826010748.zphu3wh2hlm4t4o2@offworld>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Sun, 8 Nov 2026 15:28:07 +0800
X-Gm-Features: AclHuK_SNtR7Na4NEO8eC4WpcHN1PCPzaC_4JypevS8z-dbzdNtdoctuDfoYllw
Message-ID: <CAEEQ3wn2+coQyDz1+cvGRDsFZu8u0d--HTyxqSz2sxq1obZFHA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v8 2/3] riscv: introduce percpu.h into include/asm
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	dennis@kernel.org, tj@kernel.org, cl@gentwo.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, bjorn@kernel.org, pulehui@huawei.com, puranjay@kernel.org, 
	thuth@redhat.com, ajones@ventanamicro.com, ben.dooks@codethink.co.uk, 
	rkrcmar@ventanamicro.com, samuel.holland@sifive.com, zong.li@sifive.com, 
	conor.dooley@microchip.com, tglx@kernel.org, debug@rivosinc.com, 
	seanwascoding@gmail.com, andybnac@gmail.com, menglong8.dong@gmail.com, 
	cyrilbur@tenstorrent.com, wangruikang@iscas.ac.cn, atishp@rivosinc.com, 
	apatel@ventanamicro.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
	arnd@arndb.de, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	morbo@google.com, justinstitt@google.com, qingfang.deng@siflower.com.cn, 
	linux-arch@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Davidlohr,

On Wed, Aug 26, 2026 at 9:08=E2=80=AFAM Davidlohr Bueso <dave@stgolabs.net>=
 wrote:
>
> On Fri, 03 Jul 2026, Yunhui Cui wrote:
>
> >Add RISC-V specific this_cpu helpers so common percpu operations can use
> >short architecture sequences instead of the generic implementation.
> >Native-width operations use AMOs, while 8/16-bit operations use Zabha wh=
en
> >available and a local 32-bit LR/SC fallback otherwise.
>
> The subject and changelog could use some improvement. How about:
>
> riscv: implement this_cpu operations

Agreed.

>
> riscv has no asm/percpu.h, so every this_cpu_*() read-modify-write
> takes the generic fallback, which disables local irqs.
>
> A single AMO is atomic with respect to interrupts on the local hart,
> so this can be replaced by one relaxed AMO under preemption disabled.
> Native-width operations use AMOs, while 8/16-bit operations use Zabha whe=
n
> available, or a local LR/SC sequence otherwise.
>
> Some comments below, but I ran this on my sifive p550, feel free to add m=
y:
>
> Tested-by: Davidlohr Bueso <dave@stgolabs.net>

Thanks for testing. I will add your Tested-by.

>
> >
> >Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> >---
> > arch/riscv/include/asm/percpu.h | 296 ++++++++++++++++++++++++++++++++
> > 1 file changed, 296 insertions(+)
> > create mode 100644 arch/riscv/include/asm/percpu.h
> >
> >diff --git a/arch/riscv/include/asm/percpu.h b/arch/riscv/include/asm/pe=
rcpu.h
> >new file mode 100644
> >index 0000000000000..76b1b8c1fb953
> >--- /dev/null
> >+++ b/arch/riscv/include/asm/percpu.h
> >@@ -0,0 +1,296 @@
> >+/* SPDX-License-Identifier: GPL-2.0-or-later */
> >+
> >+#ifndef __ASM_PERCPU_H
> >+#define __ASM_PERCPU_H
> >+
> >+#include <linux/bits.h>
> >+#include <linux/preempt.h>
> >+
> >+#include <asm/alternative-macros.h>
> >+#include <asm/cmpxchg.h>
> >+#include <asm/cpufeature-macros.h>
> >+#include <asm/hwcap.h>
> >+
> >+#define PERCPU_RW_OPS(sz)                                             \
> >+static inline unsigned long __percpu_read_##sz(void *ptr)             \
> >+{                                                                     \
> >+      return READ_ONCE(*(u##sz *)ptr);                                \
> >+}                                                                     \
> >+                                                                      \
> >+static inline void __percpu_write_##sz(void *ptr, unsigned long val)  \
> >+{                                                                     \
> >+      WRITE_ONCE(*(u##sz *)ptr, (u##sz)val);                          \
> >+}
> >+
> >+PERCPU_RW_OPS(8)
> >+PERCPU_RW_OPS(16)
> >+PERCPU_RW_OPS(32)
> >+
> >+#ifdef CONFIG_64BIT
> >+PERCPU_RW_OPS(64)
> >+#endif
> >+
> >+#define __PERCPU_AMO_OP_CASE(sfx, name, sz, amo_insn)                 \
> >+static inline void                                                    \
> >+__percpu_##name##_amo_case_##sz(void *ptr, unsigned long val)         \
> >+{                                                                     \
> >+      asm volatile (                                                  \
> >+              "amo" #amo_insn #sfx " zero, %[val], %[ptr]"            \
>
> So afaict that rd=3Dzero could steer the AMO away from the hart, no? From=
 the
> Zaamo chapter, it notes that complex implementations "might also implemen=
t
> AMOs at memory controllers, and can optimize away fetching the original v=
alue
> when the destination is x0". Similar for the others (PERCPU_8_16_OP).
>
> Maybe use a tmp register instead and force the old value from L1 ("near")=
:

Agreed.

>
>         u##sz tmp;
>         asm volatile (
>                 "amo" #amo_insn #sfx " %[tmp], %[val], %[ptr]"
>                 : [ptr] "+A" (*(u##sz *)ptr), [tmp] "=3Dr" (tmp)
>                 : [val] "r" ((u##sz)(val)));
>
>
> ... which arm64 now does for its pcpu ops:
>
>         /*
>          * Use value-returning atomics for CPU-local ops as they are
>          * more likely to execute "near" to the CPU (e.g. in L1$).
>          *
>          * https://lore.kernel.org/r/e7d539ed-ced0-4b96-8ecd-048a5b803b85=
@paulmck-laptop
>          */
>
> >+              : [ptr] "+A" (*(u##sz *)ptr)                            \
> >+              : [val] "r" ((u##sz)(val))                              \
> >+              : "memory");                                            \
>
> Should not need this clobber either - these don't imply barriers (but you=
 also get
> them with the preemption disable/enable).
>

Agreed.

> >+}
> >+
>
> ...
>
> >+#define this_cpu_cmpxchg_1(pcp, o, n) _pcp_protect_return(cmpxchg_relax=
ed, pcp, o, n)
>
> This triggers that cmpxchg variable shadowing issue you mentioned in patc=
h 1 with
> that __cpu_fallback_try_cmpxchg also using '__old'.
>

Agreed. I will put arch_cmpxchg_relaxed() behind a typed __always_inline he=
lper.

> >+#define this_cpu_cmpxchg_2(pcp, o, n) _pcp_protect_return(cmpxchg_relax=
ed, pcp, o, n)
> >+#define this_cpu_cmpxchg_4(pcp, o, n) _pcp_protect_return(cmpxchg_relax=
ed, pcp, o, n)
> >+
> >+#ifdef CONFIG_64BIT
> >+#define this_cpu_cmpxchg_8(pcp, o, n) _pcp_protect_return(cmpxchg_relax=
ed, pcp, o, n)
> >+
> >+#define this_cpu_cmpxchg64(pcp, o, n) this_cpu_cmpxchg_8(pcp, o, n)
> >+#endif
> >+
> >+#ifdef system_has_cmpxchg128
> >+#define this_cpu_cmpxchg128(pcp, o, n)                                 =
       \
> >+({                                                                    \
> >+      u128 ret__;                                                     \
> >+      typeof(pcp) *ptr__;                                             \
> >+                                                                      \
> >+      preempt_disable_notrace();                                      \
> >+      ptr__ =3D raw_cpu_ptr(&(pcp));                                   =
 \
> >+      if (system_has_cmpxchg128())                                    \
> >+              ret__ =3D cmpxchg128_local(ptr__, (o), (n));             =
 \
> >+      else                                                            \
> >+              ret__ =3D this_cpu_generic_cmpxchg(pcp, (o), (n));       =
 \
> >+      preempt_enable_notrace();                                       \
> >+      ret__;                                                          \
> >+})
>
> With those above this_cpu_cmpxchg() you could now enable HAVE_CMPXCHG_LOC=
AL.
>

Yes, I will select it in a separate patch.

> Thanks,
> Davidlohr

Thanks,
Yunhui
