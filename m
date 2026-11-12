Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794483043;
	b=l5ORRA9zvZFMp6R7xpelOEBDyvWzngU05B73LcJoFevhEqVsBLEn4jaJpG7NDOkYAlVw
	 8Auc2Cr86Nz1QOiuTRyA2KPt8ugKwyxzz2mnOUhSMSWNj2n67Hcx6I7bMf+HXTr1xI0UI
	 c2+uAx/7e3KfJ1HTWRSh3ucTYuqi6QFZl+KNBtN+kByYYSO5d2J9sjYr3erBgBJglStn/
	 SNvHC2tGA9rfNBaGLzlAivdQDN/xTf6GpTfNePvx39AS72QVPc//U1QcuTA4dWgFAQ2m8
	 b1vz0GkUSYfT7me7/UV9sox1Zw8pE0VZd3d79z09uT85ylYMseMX3S5I6tLnj4Vj+yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794483043;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=TH0+wCv5ifM8REH9nQg/3agFqlZ5DUFIscm/3LxWRo0=;
	b=NM0qb5E9BPgAnRDZP9mrUpCJ0i58yMbyiPg94ryHcdsQ9DP4A2pPopl70Uji3frLHLbk
	 DaqQOZhaA7/lgb5A4V1AWyxPKtdBY7+A2f4aeSgltM+LZvLzPMSwlkoK8uqtZa+2AEjKJ
	 qTr7jwvxEkxdXDyON0V1/1Wljd8jkptz59nxjZB30X0iyKbfrcvNCWRpPQ1nEj8QUbFoD
	 fEbi/3RxEsWP1yLxGFN5YtNapSvwjd33RLRj2Fvtva/6jRuwaSzXrGgkm9fhf8RN0Y2b/
	 AVaIMClqeuYScdN2n6pB/OxQRSc/9Xh/QFB5oL9X/eUlIB+aqKUt9DKL5Q46xuxxi3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=fail reason="signature verification failed" header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dHY9/lJM";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A39A606A8BF;
	Thu, 12 Nov 2026 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dHY9/lJM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797931F00A0B;
	Thu, 12 Nov 2026 11:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794483042;
	bh=TH0+wCv5ifM8REH9nQg/3agFqlZ5DUFIscm/3LxWRo0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=dHY9/lJMFRTkdoK0UtBygoZvi0viJvrQDXFX2s5FvKi786pb0Fxhon1g90q0LAJNn
	 PENqDFIZIbjRAr6env65rzcSprlxQbjXkDe0p4+7/+w1cPdM9UvcoaclCxkmEnvx/L
	 oE9DKvkZ2ClL78AeiJ7MU1YcU2e6+Dliu2fKS7trzQcaY8LOeI391uTkm+viM/MxVy
	 WDMDLV/0R+iz9jXmxmDqgcXL1XCSVSjY8aMO+Og+0+8IwKBzCv70WgbblclOZGVhak
	 6d/l5yZ3gEYyAKuzNgCi7t9AcEuUPoxh/sg66l5EHUZ40X4td6nIxtPKl+gGBVsMFH
	 3yeE/40xoNEGw==
Content-Type: multipart/mixed; boundary="===============1184916852212940912=="
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <a0cf14f466cffe1ae1e1138e7ea4466152c96c1b89ba8268a5923a0d13534f28@mail.kernel.org>
In-Reply-To: <20261112104149.38589-6-cuiyunhui@bytedance.com>
References: <20261112104149.38589-6-cuiyunhui@bytedance.com>
Subject: Re: [PATCH v10 5/9] riscv: implement preemptible this_cpu add_return operations
From: bot+bpf-ci@kernel.org
To: cuiyunhui@bytedance.com,pjw@kernel.org,palmer@dabbelt.com,aou@eecs.berkeley.edu,alex@ghiti.fr,dennis@kernel.org,tj@kernel.org,cl@gentwo.org,oleg@redhat.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,bjorn@kernel.org,pulehui@huawei.com,puranjay@kernel.org,broonie@kernel.org,cuiyunhui@bytedance.com,dave@stgolabs.net,david.laight.linux@gmail.com,jszhang@kernel.org,tglx@kernel.org,conor.dooley@microchip.com,thuth@redhat.com,ajones@ventanamicro.com,ben.dooks@codethink.co.uk,rkrcmar@ventanamicro.com,samuel.holland@sifive.com,zong.li@sifive.com,debug@rivosinc.com,seanwascoding@gmail.com,andybnac@gmail.com,menglong8.dong@gmail.com,cyrilbur@tenstorrent.com,wangruikang@iscas.ac.cn,atishp@rivosinc.com,apatel@ventanamicro.com,arnd@arndb.de,nathan@kernel.org,nick.desaulniers+lkml@gmail.com,morbo@google.com,justinstitt@google.c
 om,qingfang.deng@siflower.com.cn,linux-riscv@lists.infradead.org,linux-kernel@vger.kernel.org,linux-mm@kvack.org,bpf@vger.kernel.org,linux-arch@vger.kernel.org,llvm@lists.linux.dev
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 12 Nov 2026 11:30:37 +0000 (UTC)

--===============1184916852212940912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> riscv: implement preemptible this_cpu add_return operations

TL;DR: Nit only: the riscv this_cpu add_return helpers duplicate the 32/64 and
8/16 code and the field mask; could they use the existing macro-generated
pattern like neighbouring ops? Not a bug.

> diff --git a/arch/riscv/include/asm/percpu.h b/arch/riscv/include/asm/percpu.h
> --- a/arch/riscv/include/asm/percpu.h
> +++ b/arch/riscv/include/asm/percpu.h

[ ... ]

> +static __always_inline u32
> +__percpu_add_return_amo_case_32(void __percpu *pcp, unsigned long val)
> +{
[ ... ]
> +	return ret + (u32)val;
> +}
> +
> +#ifdef CONFIG_64BIT
> +static __always_inline u64
> +__percpu_add_return_amo_case_64(void __percpu *pcp, unsigned long val)
> +{
[ ... ]
> +static __always_inline unsigned long
> +__percpu_add_return_8_16(void __percpu *pcp, unsigned long val,
> +			 unsigned int bits)
> +{
> +	__PCPU_OP_CONTEXT();
> +	const u32 field_mask = GENMASK(bits - 1, 0);

This isn't a bug, but the add_return helpers repeat code that the rest of
this header generates with macros.

__percpu_add_return_amo_case_32() and __percpu_add_return_amo_case_64() are
identical apart from the width and the .w/.d suffix.  Inside
__percpu_add_return_8_16(), the amoadd.b and amoadd.h asm blocks are
identical apart from the suffix and the (u8)/(u16) casts.  The field mask is
rebuilt with GENMASK(bits - 1, 0) even though PERCPU_8_16_GET_MASK(sz)
already exists.

The neighbouring __PERCPU_AMO_OP_CASE and __PERCPU_8_16_OP_CASE helpers take
the width and suffix as macro parameters.

Could the add_return variants be generated the same way (taking sz/sfx, and
using PERCPU_8_16_GET_MASK), so the 32/64 and 8/16 copies don't need to be
kept in sync by hand?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43205409812
--===============1184916852212940912==--
