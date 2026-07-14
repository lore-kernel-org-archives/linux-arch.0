Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E1B3D6493
	for <linux-arch@vger.kernel.org>; Tue, 14 Jul 2026 06:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784008808; cv=none; b=ggI7ac8pu+KOUAdV6i/JxNlWFwLIkYcZGF38KXkKNke1HznyAi2xkSU1Xr/fBlc4vLUTAW9L+lxkrjDweGJlpMaWnvDsCWIxAcnAG8QAu9NiUld8J/wBJLRFtM1oo/cKjHyGbgpGFR4lopa+fubLFUpF1I1rfaW+AYJmdIGQEsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784008808; c=relaxed/simple;
	bh=xlJMw2tMmCEPTBG7tQsXutCy9H4kFNuobvk0IKQRiyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nD6WFm+/6/rCG2KcaNscKmikLT5fe7JkVZFVEphgohrBwxh8m+f/9beNuBSSwn/AMoRtE8cqliOFZMbk992w23A6jHzEyMXaLP+Su6g998cCfAymR+EkjNdzFhQwUqZWlA0Mc7Qye6yNo0GaNyx5/vWukj0eCbNP3ZB0e96Lzbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ydjbv7oF; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ydjbv7oF"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cea3004256so35491955ad.0
        for <linux-arch@vger.kernel.org>; Mon, 13 Jul 2026 23:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784008807; x=1784613607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ekTn3UMJic44VT5Ls673Az1lxgbjw95C1C5IWJSyBYM=;
        b=Ydjbv7oFS1gbZMQYzoi6cloRIjR4qzza5dDyY483Z56tHbeyITTS4wBhBlKQpNuyiN
         tJA0pPeL0SyGzd/wCbHUHwX3dTgRg4nMuIGmWFNsPuRpYgh4p9fmzk1Uo1UTjNCarKYv
         smpHf+VZg3XkrUM6AHRyaRZsKJOyoAUwUqk93W1RYNv0lnU2FHsmFedXNB1TLC/J0ye/
         WjA7bnIGd1zJc6zv0exSo24U6v4vKMPQdpG1clZPEvGmL6W+A1KAqbZYgzpx94m92GZY
         6B5N0S76JN3fnKcQPBJKQimMPiE/Z7H5RyhPduK0hmgtixbgwa3NqwqN48UbHnxiUui7
         MNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784008807; x=1784613607;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ekTn3UMJic44VT5Ls673Az1lxgbjw95C1C5IWJSyBYM=;
        b=Oo18ZK59YYISm1ZYBN8bmZO8Y1MfhtmPa/GlNARX+CVIc2+AmvhjL/As70Dh2ZJuhy
         vWoRbE+Bf5lqj4v7jkWJe10LI3pqmtd9q/UECXEjHNKbw4cY+Q39ySQpx/syEoR15VdM
         XuTZQB+pI68wTaCPqjoGKJsxP2NV8H3xmLKM9d0PYKRwjOL1gymYcTdjl5Dw2kqCrfCl
         RZh1BnY3rFdn5PGeSwYZCg5XU8uiZa/XsSSV15g0P8I/M3SPd7jShr/vvKiTVsaw9zVE
         JRz5YEukvsiOBzKdrh9yM3Bf8Z3cpDRwJh0fqq9hE1d8AilEuiKMJ/3cfqQF65uKLzwG
         klJA==
X-Forwarded-Encrypted: i=1; AHgh+RqH1gbtOqT5oCQalITEZSY90muzL8b5JPQ3SlXzCR7QC1TJh8hHTu8j2HYmaBHWh1ojIpRCq8pxftwE@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6BnvTBD4z9m22bZnxiUWkZXmnrXLVBJUpe4vlFD0A/pXLO5Z7
	AOFM7B6SOTQI0p1paTlCDQnJkb2RcMKnI3cibvYosMmPSTyEKqdsyWvn
X-Gm-Gg: AfdE7cncz48HxEqreta6Y8sYNpGIe8BqZAEJx3uwJZgkAXPVbQV7USLpuQYGylQIdeK
	dAYH6o4pLgCSZeJ+st+HVRgye+AVBZNCa53gSjf+hBGitI44fOCFFfpu5VkCC+1eWrt/ivYp6RR
	7v1zwS9SzUx2/8bumHyJjPNoPl570gFnNryVX7KNa3PRVXXknGPGtRuI0KzeUvyfjqPhrku/+Rv
	l8QV3sJV3DpOz/0wUBxUP13mVCqFNnVWJP12og6G10PA991jyHTcDlBXFyM7594/HfuPE9pbdny
	1BcCDWis7UOoP3kUxGR4nDipmnxHayvr0jYDeEpDp9CeUZwj2Umd/tKzOxHXtTMMeK4UGLn+lRm
	M+taEcRMdx9m0okngSPD7T/kdehatqrbOOiy0qiRv/mZUhaer2AuGU5x4UyUS90X+fZhEdQa2HS
	dNKdLONXu+PKNcadfyYuHrFMxpk5TO+MN6
X-Received: by 2002:a05:6a21:8cc1:b0:3bf:6011:53b with SMTP id adf61e73a8af0-3c3571d0438mr1375652637.38.1784008806472;
        Mon, 13 Jul 2026 23:00:06 -0700 (PDT)
Received: from blinky ([2601:647:4000:5070::76e1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b924258a2sm63657400c88.1.2026.07.13.23.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 23:00:05 -0700 (PDT)
Date: Mon, 13 Jul 2026 23:00:03 -0700
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>, Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH v5 5/8] riscv/runtime-const: Introduce
 runtime_const_mask_32()
Message-ID: <alXQY4hgZYLmr8x7@blinky>
References: <20260630045531.3939-1-kprateek.nayak@amd.com>
 <20260630045531.3939-6-kprateek.nayak@amd.com>
 <178366995930.1208691.2993932866462893112.b4-review@b4>
 <650c7050-2a77-4415-b597-3bb39ccfb1e8@amd.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <650c7050-2a77-4415-b597-3bb39ccfb1e8@amd.com>

On Fri, Jul 10, 2026 at 01:47:10PM +0530, K Prateek Nayak wrote:
> Hello Charlie,
> 
> On 7/10/2026 1:22 PM, Charlie Jenkins wrote:
> > [You don't often get email from thecharlesjenkins@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > On Tue, 30 Jun 2026 04:55:28 +0000, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
> >> Futex hash computation requires a mask operation with read-only after
> >> init data that will be converted to a runtime constant in the subsequent
> >> commit.
> >>
> >> Introduce runtime_const_mask_32 to further optimize the mask operation
> >> in the futex hash computation hot path. Since all the current use-cases
> >> are of the form GENMASK(n, 0), with n > 0, following sequence:
> > 
> > I really appreciate you spending the time to do this, thank you!
> 
> My pleasure! And I really appreciate you taking time to review and test
> this series. Thanks a ton for that!
> 
> > 
> >>
> >>
> >> diff --git a/arch/riscv/include/asm/runtime-const.h b/arch/riscv/include/asm/runtime-const.h
> >> index 1ce02605d2e4..dbf96c937dbb 100644
> >> --- a/arch/riscv/include/asm/runtime-const.h
> >> +++ b/arch/riscv/include/asm/runtime-const.h
> >> @@ -262,6 +279,33 @@ static inline void __runtime_fixup_shift(void *where, unsigned long val)
> >> [ ... skip 24 lines ... ]
> >> +     BUG_ON(!val || width > 31 || (GENMASK(width - 1, 0) != val));
> >> +
> >> +     __runtime_fixup_shift(where, 32 - width);
> >> +     __runtime_fixup_shift(where + 4, 32 - width);
> >> +}
> >> +
> > 
> > It would be "optimal" to use an andi when the mask is <=11 bits since
> > andi can fit an 11 bit mask. What you have is good enough but I'll leave
> > my stab at doing the andi patching here in case you want to apply it.
> > 
> > From 9e5527aaddd464783af795aacdb6d094e11cc31e Mon Sep 17 00:00:00 2001
> > From: Charlie Jenkins <thecharlesjenkins@gmail.com>
> > Date: Thu, 9 Jul 2026 23:18:09 -0700
> > Subject: [PATCH] riscv: Optimize __runtime_fixup_mask for masks with <= 11
> >  bits
> 
> Peter seems to have merged the v5 series in his tree but If you could give
> your S-o-b, I can throw in a commit log, some testing along with a few
> cosmetic modifications, and send it for official review on top of
> queue:locking/core ;-)

I'm glad it got merged, I missed that! Here's my tag that I forgot to
add...

Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>

> 
> > 
> > ---
> >  arch/riscv/include/asm/insn.h          |  2 ++
> >  arch/riscv/include/asm/runtime-const.h | 29 ++++++++++++++++++++++++--
> >  2 files changed, 29 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
> > index c3005573e8c9..0a34cd7305d0 100644
> > --- a/arch/riscv/include/asm/insn.h
> > +++ b/arch/riscv/include/asm/insn.h
> > @@ -141,6 +141,7 @@
> >  #define RVG_OPCODE_JALR                0x67
> >  #define RVG_OPCODE_JAL         0x6f
> >  #define RVG_OPCODE_SYSTEM      0x73
> > +#define RVG_OPCODE_ANDI                0x13
> >  #define RVG_SYSTEM_CSR_OFF     20
> >  #define RVG_SYSTEM_CSR_MASK    GENMASK(12, 0)
> > 
> > @@ -175,6 +176,7 @@
> >  #define RVG_FUNCT3_BGE         0x5
> >  #define RVG_FUNCT3_BLTU                0x6
> >  #define RVG_FUNCT3_BGEU                0x7
> > +#define RVG_FUNCT3_ANDI                0x7
> > 
> >  /* parts of funct3 code for C extension*/
> >  #define RVC_FUNCT3_C_BEQZ      0x6
> > diff --git a/arch/riscv/include/asm/runtime-const.h b/arch/riscv/include/asm/runtime-const.h
> > index dbf96c937dbb..24a9b13081f7 100644
> > --- a/arch/riscv/include/asm/runtime-const.h
> > +++ b/arch/riscv/include/asm/runtime-const.h
> > @@ -9,6 +9,7 @@
> >  #include <asm/asm.h>
> >  #include <asm/alternative.h>
> >  #include <asm/cacheflush.h>
> > +#include <asm/insn.h>
> >  #include <asm/insn-def.h>
> >  #include <linux/memory.h>
> >  #include <asm/text-patching.h>
> > @@ -302,8 +303,32 @@ static inline void __runtime_fixup_mask(void *where, unsigned long val)
> >          */
> >         BUG_ON(!val || width > 31 || (GENMASK(width - 1, 0) != val));
> > 
> > -       __runtime_fixup_shift(where, 32 - width);
> > -       __runtime_fixup_shift(where + 4, 32 - width);
> > +       /*
> > +        * A riscv 'andi' instruction can fit an 11 bit immediate, so the mask
> > +        * can be directly applied. Otherwise fall back to SRLI + SLLI.
> > +        */
> > +       if (width < 11) {
> > +               __le16 *parcel = where;
> > +               u32 insn;
> > +               __le32 res, nop;
> > +
> > +               insn = (u32)le16_to_cpu(parcel[0]) | (u32)le16_to_cpu(parcel[1]) << 16;
> > +
> > +               /* Replace the slli/slliw with an andi */
> > +               insn &= 0x000fcf80;
> > +               insn |= val << 20 | RV_ENCODE_FUNCT3(ANDI) | RVG_OPCODE_ANDI;
> > +
> > +               res = cpu_to_le32(insn);
> > +               /* Replace the srli/srliw with a nop */
> > +               nop = cpu_to_le32(RISCV_INSN_NOP4);
> > +               mutex_lock(&text_mutex);
> > +               patch_text_nosync(where, &res, sizeof(insn));
> > +               patch_text_nosync(where + 4, &nop, sizeof(insn));
> > +               mutex_unlock(&text_mutex);
> > +       } else {
> > +               __runtime_fixup_shift(where, 32 - width);
> > +               __runtime_fixup_shift(where + 4, 32 - width);
> > +       }
> >  }
> > 
> >  static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
> > --
> > 2.54.0
> > 
> > 
> > I would prefer including this, but I am happy to approve this
> > regardless.
> 
> Ack! I'll keep it as an optimization on top to retain your attribution.
> 
> > 
> > Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
> > Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
> 
> Thank you again!
> 
> -- 
> Thanks and Regards,
> Prateek
> 
