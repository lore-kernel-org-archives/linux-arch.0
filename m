Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB72736683D
	for <linux-arch@vger.kernel.org>; Wed,  1 Jul 2026 03:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782875476; cv=pass; b=SrTAxrpFfmvczFVxSqDApy6TPpkwr15o6v7VJS7gHkuoG/4sp9+FOI8zqhmD8EKP9/2T3D0OTchxyd9z9axkxvf0U8u6yYnZEh11jxh7ywpJbV8U37c6pBlUCBmX9uX68a4fhkSLClMk3rBHgombNWanekaDGlay1hJB/H+QpHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782875476; c=relaxed/simple;
	bh=0uOca1qt2gUEPBJfSHH0c1IQv17V7spgn+tiXL+gnJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOXsLWoEdpKWYYE3Ig50VDy8g7pmU5ag90TiH5aH3DZQC9qtrq47oXDFq/7KHr0/lI0FB9q1H/KjwHyXzHXkM7044JIi69bmdkuws0X3E6Axr3Lz/8PqDcxtRxVo1qBQ1exzSyw+WCY5ywcQ/do3tjNDCkAJAEp4gCp8BFoE2Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RhtWkNr9; arc=pass smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RhtWkNr9"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e9f6b94a49so112467a34.3
        for <linux-arch@vger.kernel.org>; Tue, 30 Jun 2026 20:11:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782875473; cv=none;
        d=google.com; s=arc-20260327;
        b=N3vXuTXZ/ahT3RA4onaUxsjiahx039SPcoOw1GqaQbIOJThKIKw1Fk/JvCmAVYVF4M
         g3l5vaYc4HKxgwE9G3WV+JTi4ClGcGlFk0QIo3v9aN+zRVbNsyCjeSO64eYZHiPCwK3C
         tjjsy4W3lhQT0OFxLP7dstHlmiRJk8nqOee/CGRU4TPIGQ0UPKfbKM0MCeVODdICftd2
         Hh6Mv7+DCHfzMrq79kQC4L4k/ohPa4n0gV0Kbk7Qvfu4CTzfuLOwiZpWbnKpEVrm7lb3
         pXTqr+Nz5qUOWKXGzisdURscuy/AGqHuzRPkp6MF4f/E6C4KuhUY7trxuhdDwtpitOtn
         cyLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AW+XVWe2JL0df9uuAdxaZgi837urm1REze6zO62j7wg=;
        fh=09aWepV8r+JwmT7MneSqpVurjnZIHe0s0hVevG04lvo=;
        b=foZsmmLV6QIKNc2PW0pyahIt+eSVpDCn9PpS9ReAPP8ItOiccE8D1DHSgyXyI1vYa4
         QxpvAmFLdy7CzKsuhCjt7YR6hjyNP/q3ffupz9CI+Ex9qXjzBgXZrR8U9UtdOMNQXvxU
         kRngptpuQpXoh59XIAEWmy5JJ/dCkWYcnRigy8Q4p0lRL2JWdldtxVHLRtQLKKds52p+
         WArmy2RgOhXbSGBpjNOdGdCpyFmCyvh5iXd9rVEdWxczXoLiRPawzyqcGLAPAUWvFqsD
         YVyGfdYj2UiIVR97fhUAp49Q4UIdOcURWp/83CSK9o2kiX0Ru6rlg2fjVBTXxMMb26/c
         2wqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1782875473; x=1783480273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AW+XVWe2JL0df9uuAdxaZgi837urm1REze6zO62j7wg=;
        b=RhtWkNr9HQpCqgGvJVbgjiv2wzGAcrVQ+TANpvNCyIUXljKu9PhtnvdatILuTv1M1K
         PrDLUPg+L7Up4A24TBlk8gNNNUFTfWfELGRA83Bu5YBwNAeVvzgeBTO+E+21KLaAY7Hu
         Q1xWOUMDe4mjI5IBlU/nYxcT/OBYKg6lN93XIQTcYJUK73YvCUufLIqMdE5sea5peJEN
         ReZrZMf8DKYjiafiuZ7tlictI6Diw29QfSbSlM+LnvsK/8+lMadzvNT44xJTAPxa4X69
         3DROgSsOLwDWlz7PcRyj4SWl38cPKL3A/fNJJyaX9833yI8RXvn+OTqR5VokoT24MyAH
         VFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782875473; x=1783480273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AW+XVWe2JL0df9uuAdxaZgi837urm1REze6zO62j7wg=;
        b=nagkoc2oHguDuObAR1swjtrlUqBg1soLFiTdoArriu3zCTEusxdD9pr5h5IFhuu+Ud
         CH4R5HpbJkjrQ6DNDepHSy9mBzV6eG447EOMKoUviJaR05KWPkcBUqzQT+piqeH7yOqv
         ssuM+LLmKJNH0tlM27MBgHHpXghVAIIoQoZlfiy3xv+cjegUoxy9z24rU6ClFp7t7bOi
         Q1hquvvh5Rzs4mGuue51PHoJ0W+qdt/yv3exW0CXVjIbtQNThck55EHnH6yrMooZm3sA
         P5v8x3BL1eukUY01S4dkv6JVGJ5QqbmHmBzVYLKBeMbnHZvN6cxs3vJv00oBm3O0wsIQ
         ZP6A==
X-Forwarded-Encrypted: i=1; AFNElJ/5XMTheW2xB7Qh6LbekCNn+V76SbJ6a3xaNNv4elHzFH6NvNdQbbgrYJAxCh5StU0v0e2CoWs9kKlV@vger.kernel.org
X-Gm-Message-State: AOJu0YxOiAYjEWSbhkTLX8RHA0qSl+Ph9f9a+tKdQbedXDWnU7A1+8AN
	0+qW9Q8HJNxZi8PO3/8NHhN/pqUXXV2ZU6oatx9z2jls6GxgqrGQQDOdfbKc72g2pKLKrh9fZNc
	rUlqXh2nhUvOgm/YmnHalVCXsg8mJLlP8oeBYhtSzrg==
X-Gm-Gg: AfdE7cl3+lEDXTyBCC5SCdIzUJUgzAoY5xthqr+2p+7YJq63bY0gRByjDZcjGALdRMZ
	UPc0UvXOoVILrHXgDfWFYlNvvr8o6AQCk2hCsrSkviZWS73kcWTxHeZMYGGvhjXXa1ub8nCsz4E
	wmkRFW+eW0mgvpy4su+67NDxoOsP7bUNme2RvWD3/hOmeJQTuvtwFI7dg7AKPs9IAgt6ym84UIu
	OfybX8Leo4ogYNmbS++bpBPE4dhFwBAalbqRvnWlkAwkvYnnbZs8DOQikeloSVCvMum2dklLF8=
X-Received: by 2002:a05:6830:4901:b0:7dc:c4ae:a689 with SMTP id
 46e09a7af769-7e9ec586d01mr4829708a34.2.1782875473497; Tue, 30 Jun 2026
 20:11:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505062026.91724-1-cuiyunhui@bytedance.com>
 <20260505062026.91724-2-cuiyunhui@bytedance.com> <3720c3a4-cc0d-4ba8-97ae-35def0189e2e@app.fastmail.com>
In-Reply-To: <3720c3a4-cc0d-4ba8-97ae-35def0189e2e@app.fastmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 1 Jul 2026 11:11:02 +0800
X-Gm-Features: AVVi8CfCZ39PlUVHuhvVesQ30Ayu5byi3NLY-dGR5ZLniizemgTSehNq4vDg6QE
Message-ID: <CAEEQ3wn8AFVqWZAiXfQd4a1ZzH=2L8qRX4W3S=KcmQ5FORjn+Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v4 1/3] riscv: io: avoid null-pointer
 arithmetic in PIO helpers
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, "Christoph Lameter (Ampere)" <cl@gentwo.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, pulehui@huawei.com, 
	puranjay@kernel.org, Thomas Huth <thuth@redhat.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Ben Dooks <ben.dooks@codethink.co.uk>, 
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Zong Li <zong.li@sifive.com>, 
	"Conor.Dooley" <conor.dooley@microchip.com>, Thomas Gleixner <tglx@kernel.org>, 
	Deepak Gupta <debug@rivosinc.com>, seanwascoding@gmail.com, 
	Andy Chiu <andybnac@gmail.com>, menglong8.dong@gmail.com, cyrilbur@tenstorrent.com, 
	wangruikang@iscas.ac.cn, Atish Patra <atishp@rivosinc.com>, 
	Anup Patel <apatel@ventanamicro.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, qingfang.deng@siflower.com.cn, 
	Linux-Arch <linux-arch@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Tue, May 5, 2026 at 2:34=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, May 5, 2026, at 08:20, Yunhui Cui wrote:
> > The RISC-V PIO helpers derive I/O addresses from PCI_IOBASE in ins*(),
> > outs*(), and ioport_map().
> >
> > Under configurations where I/O port support is not available, these
> > expressions can still be formed during compilation and trigger
> > -Wnull-pointer-arithmetic warnings from clang.
>
> If a driver attempts to use ISA port operations in a configuration
> without CONFIG_HAS_IOPORT, there is a NULL pointer warning because
> this is actually a NULL pointer access that will crash the
> kernel if the driver is ever loaded. You should not attempt
> to shut up the useful warning here but instead make sure every
> such code has a proper 'depends on HAS_IOPORT' dependency.

Thanks for the review.

I agree that NULL-pointer arithmetic warnings can point to real missing
HAS_IOPORT dependencies in drivers, and we should not hide those globally.

You are right about the generic ioport_map() change: the helper is already
guarded by CONFIG_HAS_IOPORT_MAP, so the extra CONFIG_HAS_IOPORT check is
redundant. I will drop that change.

For the RISC-V ins*/outs* helpers, they use PIO-specific fences
(__io_pbr()/__io_par() and __io_pbw()/__io_paw()), while the asm-generic
helpers would go through readsb()/writesb() and use normal MMIO string
ordering. So removing them would change ordering semantics.

I will keep the RISC-V helpers for now and only guard the port-I/O
variants with CONFIG_HAS_IOPORT.

>
> >
> > +#ifdef CONFIG_HAS_IOPORT
> >  __io_reads_ins(ins,  u8, b, __io_pbr(), __io_par(addr))
> >  __io_reads_ins(ins, u16, w, __io_pbr(), __io_par(addr))
> >  __io_reads_ins(ins, u32, l, __io_pbr(), __io_par(addr))
> > -#define insb(addr, buffer, count) __insb(PCI_IOBASE + (addr), buffer, =
count)
> > -#define insw(addr, buffer, count) __insw(PCI_IOBASE + (addr), buffer, =
count)
> > -#define insl(addr, buffer, count) __insl(PCI_IOBASE + (addr), buffer, =
count)
> > +#define insb(addr, buffer, count) __insb(PCI_IO_ADDR(addr), buffer, co=
unt)
> > +#define insw(addr, buffer, count) __insw(PCI_IO_ADDR(addr), buffer, co=
unt)
> > +#define insl(addr, buffer, count) __insl(PCI_IO_ADDR(addr), buffer, co=
unt)
> > +#endif
>
> Can you try to remove the custom accessors altogether and
> use the ones from asm-generic instead? These should already
> have the correct behavior all the time, in particular they
> already come with the correct #ifdef check that is apparently
> missing in the riscv version.
>
> > diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> > index ca5a1ce6f0f89..d799e5ccc9437 100644
> > --- a/include/asm-generic/io.h
> > +++ b/include/asm-generic/io.h
> > @@ -1205,8 +1205,12 @@ static inline void __iomem
> > *ioremap_np(phys_addr_t offset, size_t size)
> >  #define ioport_map ioport_map
> >  static inline void __iomem *ioport_map(unsigned long port, unsigned
> > int nr)
> >  {
> > +#ifdef CONFIG_HAS_IOPORT
> >       port &=3D IO_SPACE_LIMIT;
> >       return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
> > +#else
> > +     return NULL;
> > +#endif
> >  }
>
> The function definition here is guarded by the #ifdef CONFIG_HAS_IOPORT_M=
AP
> check, which should already prevent it from being visible when
> CONFIG_HAS_IOPORT is disabled.
>
>      Arnd

Thanks,
Yunhui
