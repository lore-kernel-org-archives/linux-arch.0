Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794483049;
	b=1KKe6ZY9xrzUPhsVSjUePqJt6c8LGBRy8nbculK9w5LosF62rghUIkgy0ZuSnFGwNQnq
	 HTfbP6IqxY2GSNAh+T8lMy4kHxaIPBrQm8wjN11h2AugHz8lVFeyjW3648ofOMhX+8KzC
	 +8nsaFcITEkSrybvvCh7vWh+xxDrWfsIiphq3xrOSf6bfFl1uj+gHq5HL7FBfs4Gr/nUj
	 PWYXAofdH4eh/c3j0At4G7j2gfjtjqq9H913y8FXJ4Ddq4wzSClL22aPefztn9evrEsI5
	 9xfdRbpC8cpZoHL2i3T4DR0am/6XKsPHWhhd39KOMbiFhHsDl2SFMysnnk3wynbfX/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794483049;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=4VQE+wCw+63cnThzXfE5m3Wkr677M0OSU+v7x8jQn64=;
	b=mE+MlHmWYMuzi9o6bZLL9tMUjz8JnHp3tU0MSTsvKPk4QH78deVI6HhqCvam9KYBivi3
	 QxrGwrQq1sAuh5OLzy2qYNRMRRXzhvsXp5dXXflPbt4QfcXb6R9mgV4G3swl2opEel58W
	 6SjJIkwwFPgga3H1yxGDEivnyFIVsTil9APUhg1I0G4n9wrPFJZWQmrRZkGkFfRlaFwM9
	 6JrA/fipTd1HkfIboxSWztZ1RZWZ2PKOiUxxj6uFhp+DLzl8AY7fnmyimqlhfCUQNv9i8
	 lT0nHn3OhCqxkxZbnulWlnQEC2FW0QHeg4lk2tUyBAYc42YJmkHSB1bEFdM2M+rTjKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=fail reason="signature verification failed" header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lv0uE8rD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD817606A8BF;
	Thu, 12 Nov 2026 11:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lv0uE8rD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758841F00A09;
	Thu, 12 Nov 2026 11:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794483049;
	bh=4VQE+wCw+63cnThzXfE5m3Wkr677M0OSU+v7x8jQn64=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Lv0uE8rD32wyRfV5sPXfxmly+/H4WSct6DgNgB+borGLOHQHrPLIX+nDFWq8WIR5a
	 6AtC7CnbNeLwvde/cSjhKEvSpenf4t0Wu4NTtXot75V8BVGl2rFunUOcGyNsN4UI68
	 wNERe8a2KaEWMchf+DBb8Bs1DvhulbUFaoAuvnrKGZEac6tb6LCixMCO2ciI45WqCn
	 5rzApcOojjQxqR7Be5XjATEt71gD58xH7QXIWmI8trxikOKPyX7zLM0t/f/t7TwpTp
	 molNGWnrHSHxcdMFd0azahw83gPRaA1oGx6MU/a7XQjmmEtHkAo1P+T8dMYcy21pbm
	 BNy/IJvPTGAsw==
Content-Type: multipart/mixed; boundary="===============8011434571142281874=="
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <9c88485e232da5a503d56c83b14b7765e672fd0c4ccc92686c342cec03c8e350@mail.kernel.org>
In-Reply-To: <20261112104149.38589-10-cuiyunhui@bytedance.com>
References: <20261112104149.38589-10-cuiyunhui@bytedance.com>
Subject: Re: [PATCH v10 9/9] riscv: select HAVE_CMPXCHG_LOCAL
From: bot+bpf-ci@kernel.org
To: cuiyunhui@bytedance.com,pjw@kernel.org,palmer@dabbelt.com,aou@eecs.berkeley.edu,alex@ghiti.fr,dennis@kernel.org,tj@kernel.org,cl@gentwo.org,oleg@redhat.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,bjorn@kernel.org,pulehui@huawei.com,puranjay@kernel.org,broonie@kernel.org,cuiyunhui@bytedance.com,dave@stgolabs.net,david.laight.linux@gmail.com,jszhang@kernel.org,tglx@kernel.org,conor.dooley@microchip.com,thuth@redhat.com,ajones@ventanamicro.com,ben.dooks@codethink.co.uk,rkrcmar@ventanamicro.com,samuel.holland@sifive.com,zong.li@sifive.com,debug@rivosinc.com,seanwascoding@gmail.com,andybnac@gmail.com,menglong8.dong@gmail.com,cyrilbur@tenstorrent.com,wangruikang@iscas.ac.cn,atishp@rivosinc.com,apatel@ventanamicro.com,arnd@arndb.de,nathan@kernel.org,nick.desaulniers+lkml@gmail.com,morbo@google.com,justinstitt@google.c
 om,qingfang.deng@siflower.com.cn,linux-riscv@lists.infradead.org,linux-kernel@vger.kernel.org,linux-mm@kvack.org,bpf@vger.kernel.org,linux-arch@vger.kernel.org,llvm@lists.linux.dev
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 12 Nov 2026 11:30:44 +0000 (UTC)

--===============8011434571142281874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> riscv: select HAVE_CMPXCHG_LOCAL

TL;DR: Nit only, no runtime problem: selecting HAVE_CMPXCHG_LOCAL on riscv may
need the cmpxchg-local arch-support.txt feature table updated from TODO to ok
in the same patch.

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -155,6 +155,7 @@ config RISCV
>  	select HAVE_ARCH_VMAP_STACK if MMU && 64BIT
>  	select HAVE_ASM_MODVERSIONS
>  	select HAVE_BUILDTIME_MCOUNT_SORT
> +	select HAVE_CMPXCHG_LOCAL
>  	select HAVE_CONTEXT_TRACKING_USER

This isn't a runtime problem, but should the feature table be updated in
this patch as well?

Documentation/features/locking/cmpxchg-local/arch-support.txt is keyed on
this Kconfig symbol and still lists riscv as TODO:

    |       riscv: | TODO |

Nothing later in the series changes it.  Other riscv patches that select a
feature symbol update the matching arch-support.txt in the same commit, for
example d1f014012571 ("riscv: enable HAVE_IOREMAP_PROT").  LoongArch
selected the same symbol without updating the table, and it needed a
follow-up in 0c4c9abbf68b ("Documentation/features: Mark cmpxchg-local as
supported on loongarch").  Would changing the riscv row to "ok" here keep
the table accurate?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43205409812
--===============8011434571142281874==--
