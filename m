Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1B5480DD1
	for <linux-arch@vger.kernel.org>; Wed,  1 Jul 2026 11:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907069; cv=pass; b=RS3s8nIQTqSe6IRUNOKT57DfRar8Iws1W0BrIzE0/Q7rdhqwMF2a71rq+SszernmISVht00UOvm8SOw/PV+DjyDFgYgebU089RakqqVKdLiNrtBBBtKyqNziTZkmPHKi41D8BckVRoYoaa15CRgriVsXcn0XcA/KKQfzlzBQhZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907069; c=relaxed/simple;
	bh=k/m7mOwOe2VK+7j1exKhxSnw3ozmGI8iEWqvbTFE6eI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rfOnbckwj47R374SgR5rUgNsl9hGguIooLfF8eBDZElD3Dvo7MwdTivC3w0tY8GRAcmIFusbwa9aJTTC1pyzG0YuHz+leT5BAE00IBt+1AgydR63WRh6jOTQGJMC/AHJx/88tzsuSXIg3KE3qmzvEGtJTbDlFBPssIxGsfCLvsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=beayJkSQ; arc=pass smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="beayJkSQ"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4896ae35be9so269368b6e.0
        for <linux-arch@vger.kernel.org>; Wed, 01 Jul 2026 04:57:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782907065; cv=none;
        d=google.com; s=arc-20260327;
        b=l73SkcVOVNPMUytJbyNX0fp5psqa/EVZn+Ni2EfjIq6WfxfwN4E32DQhbcrn0pX1n1
         6E0k5ZXSUOQNJqLzwZ9HBy+tAK8xpSRJffxG8fTzl/OpHpQUxCZYRWraMfpQ1BQKTemD
         jHC6YjpNw7J2VCMTdrtREw8QcTO8cA7kf1wObmm+Jq/kgHTMJPGXWRrQOiB9Qz0lSvWe
         ERJREOL+XE9QfiEamac4HK5bXcy9bG09DfA4EyqKjVOA/8oirpZMsa4EIsdEZC6nWqzU
         s9K5Szf+8HCC28FVdGgTX6kZESGOnivz9scDfFCJx+KKYRsl/afrUda78qiECTc9MQF7
         ObZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lqKxpCifHTwVLxyMY/FMijSWYZ0kJMALXZou2Lu6auM=;
        fh=PPCiDfWqpRv9A3Jb+A09Bd1DlcFxJHqBXxQ7xpWBdnA=;
        b=HAvAuiMS/+xnSrJTEh6VOXvw04ZaMxR6jPYUYpbVGEewjwD3G9kmP3iwE5hdeC1/AD
         B1aQh4i3tOswtpLHTDStR476H/oUzez9xCQN0L8g5W40hn4jGUWdRJ6xf9le/amLwtI1
         r7VVltLQQYRJ+C9nZdb8xraNrIp43l7JD4sM1GTgSA2QFgfdn3NMKITW7jaydr6/Gmjy
         bBCxyAet/kzFE/g8mg1670kNBX9uwHbgC2dx00XkdqHxK8G4nxwAwH4ELXR5AkgwO+HA
         xRsYL7JI6lKZMhIEbeYH2YUbyIgiT9ezC9RjOs82ayRHRmLN+lCkb3Hd3RALHiqlio6x
         Ilig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1782907065; x=1783511865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqKxpCifHTwVLxyMY/FMijSWYZ0kJMALXZou2Lu6auM=;
        b=beayJkSQr05vWYthJphsua2qi+wI2deN3ee4s+RMMCcgG36dU/SEXscL3RrMizBEa3
         eOAxxSCX2hqgrkeKXxMxF7dAXzzyw67pfUz/T15fHCiNkUaPTnlR/pZynfzeNlGeDDKq
         buWXeDmcWf/HUMynqzaP/5i1vsu9w/Yj0BGAeuvAZ4gZ1WMo11SqajiqzMHOIlAJsTtw
         FOzLTQj7VUgrAQdAIS5uuRU2zq7AGqH3shd3tSFeo31+Uvd59dItC1E/EROQsNmp0rAT
         GrjUFCOZfpGFgvYMRBTNx+zSAIk5+nIHn0pTElTWQqb8uHmUnEi87FV+p3IjP54ID4OV
         HxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782907065; x=1783511865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lqKxpCifHTwVLxyMY/FMijSWYZ0kJMALXZou2Lu6auM=;
        b=VYrPsrhMmvNEIIVXEQbyyCP3DtwHphteL9AuWx/qTi/Gbq2aGnIBf39PhCXkO3C8cn
         7ZOoRUPsttnXIfqZpuuovEvAgFgCRb1iGcCwsx1VX7ruS+F9dj7ZhHuvQUxsefBUpf0X
         bxMCJWiYplp5HdP1Wh3RIppetRFHm6mop39VT7stG03AU1IsDjxB0jBpHgvBI1bULnFc
         20uDQTnFB30YXXBio8TxkQE2MipUZ30gP0xM6shFfR2rHF060kMJf5Gvr/NLwunjW9Sk
         8hMqzl0ojFYVt66jOe8Rnp7bUxDWEQuOrQo9N6UN3z5635wWGxLbF3mI0HMewcgxcGIC
         265w==
X-Forwarded-Encrypted: i=1; AFNElJ+YamSZhAGhL9WUOm16eye0+6n1XuYvlgR5jVjwSIsrCGKQwlgtMEEJTorTHDJKnSgvNPj5Iz0aQ9bM@vger.kernel.org
X-Gm-Message-State: AOJu0YxQaGs81UUtdQ+D0Rp2gY3RhIxfVCx4U2IVpoDt88g7eEhdTir8
	BJ4LvP98yU+DgNibNZ3vuDXePan9OQYy8HMpxzfO86TQfRA9gdCXbFTpsTNZL1MFMGBF4Nn0mWG
	NGgRP3JTAQ865/Rzntvir8EMg45uDB9cl8NVlc792bw==
X-Gm-Gg: AfdE7cn7MCve7F0/1F69wL57/3SS3N811kOJ535vV1w8lJB6ND/yqfKCgWY+TkID1oU
	9KOmKh8mP3eyFjNaei1vrKWpecOkp9qMdYeOd/fBU/RlzDeW8YvsDP5ubM3g9R8ZGmiKzUJZLCl
	9KwEnJeOZbKNuvzrbMVmXWWmWOlan7L5Zml7RjOeBXkZD4MPM4zxj7J6zMXezepTNf4gioVdEP+
	h35TmSaemz/RKbLgBvt+Rzy9YEB5fSwJMR/8v1b8Hjo8lgx6LMgZUuvkI2PHD/yN2W+2mISNFA=
X-Received: by 2002:a05:6808:1389:b0:492:5bf0:d29f with SMTP id
 5614622812f47-4960f0d2101mr838181b6e.37.1782907065542; Wed, 01 Jul 2026
 04:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782877663.git.cuiyunhui@bytedance.com> <7988df83f6341ea045ebd7294af2e8907dbd5ee7.1782877663.git.cuiyunhui@bytedance.com>
 <ea525a80-1e6f-4304-a371-3ec17d91ee96@app.fastmail.com>
In-Reply-To: <ea525a80-1e6f-4304-a371-3ec17d91ee96@app.fastmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 1 Jul 2026 19:57:33 +0800
X-Gm-Features: AVVi8Ce8Hvhgv036NZvyTtBZ5NMmFq-2bEMlGWh7WwSjecXpQvRJF8LZ_SFRCM4
Message-ID: <CAEEQ3wnDACZ08kk6ycpgXezgyS5zxi+P_vF_yBScK2sxU+UKaw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 1/3] riscv: io: avoid null-pointer
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
	Vivian Wang <wangruikang@iscas.ac.cn>, Atish Patra <atishp@rivosinc.com>, 
	Anup Patel <apatel@ventanamicro.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, qingfang.deng@siflower.com.cn, 
	Linux-Arch <linux-arch@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Wed, Jul 1, 2026 at 2:25=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Jul 1, 2026, at 06:20, Yunhui Cui wrote:
> > @@ -56,6 +56,8 @@
> >  #define __io_pbw()   RISCV_FENCE(iow, o)
> >  #define __io_paw()   RISCV_FENCE(o, io)
> >
> > +#define PCI_IO_ADDR(addr)    ((void __iomem *)((unsigned long)PCI_IOBA=
SE
> > + (addr)))
>
> This does not seem to have any purpose, is this just left over
> from the previous version?
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
> As far as I can tell, just adding the #ifdef here should be sufficient.

Okay.

>
>       Arnd

Thanks,
Yunhui
