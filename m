Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B34C4E5358
	for <linux-arch@vger.kernel.org>; Thu, 17 Sep 2026 20:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675384; cv=pass; b=gXu3vZjWDnsXnuJpnAjy2o1bMeVBkRRoL1QMg/KuzQJyzGW0GGhaWulE1NjguJrWaZi+MBYCjp2A7WQDNKRnuANGy5ON0aQNYJuxkijD8e30fJ6Z4jFHCe03qR0BvJbPTnKPVtVtEpRSLyHnRlE1WJqoVv9h3viP7iyNCH8Syj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675384; c=relaxed/simple;
	bh=GpHjDtqu+AzW6bYVn14IR7601Ha7EtaAYwvYSeYG9jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHgHd/T8RsCf7Vr2JiLFM2wfNHOkwgc7oCkGQHFGIzJJbQSRui0h5TKLMVAp0B7za+03PJG9TY/oVK5hbDIIMH4pSpws5DF4kNsHRRLizKDzU6cJPG+XJAacqhcWub46W2Q1Tai27NzHvF/looCwWylli1m0agzhhiraMmxiFDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RfRoG1si; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RfRoG1si"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccfd61ecaso244435e9.3
        for <linux-arch@vger.kernel.org>; Thu, 17 Sep 2026 13:03:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789675380; cv=none;
        d=google.com; s=arc-20260327;
        b=jufh7XFdbvrKXQCfdnT/a5dVGyzXfh3zhE3X8AhXo9v4/pzU3UenRZTK2VMaTc8gir
         RGmGyaKNIKe31/ZKe9liPL141tt93ckGUjLClsC/Mm4i4iRWA6QloSJcQ+azGfPxKdPL
         ITZJUFztbx/WhlzHeboWT4mcdSoL2f6RdCwdsgwnPrWyEDT2UQIeqUl+C9akUkI4+IE8
         Pdrv/v67yL2/rSN5LSXmMLsBzE4VJ/k8pdEoAByF2B9K75ndjya1Gm2rKfiNsXTse3uC
         Ri07uiI4i2yoDh/JcfNlEfxviDVYngXOE2UZDWBwlTxT70opmqKulJLvN7F3knXK5lpj
         7+SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=25a39fQthoJQenvf3ilsmj4we8U0R1UDFLTQO2djkUo=;
        fh=1nzlt73FMgorsP6GtEfaGaBMOxI0b+zeuXmP/PJnk1o=;
        b=Xg8NsR91pjOY0wHliSezP+lgHE/A9/ygYQd9CxKmAID27MxyiVLw3nC0aiWNkPr/Dl
         PHflxz1FCyQoK9CCl6R2JF9ynCcPIsPcf45gg9Cg78W3LNV3C82851yHcPb7BwebhzvD
         lD6MXOSpfDSKRCPHciQCD0+AZmPvGx21mua22osEBkjtyC4wWQhDlTJ2qGfnfKkmVDX1
         wOKIVuRpqNqPwLcoxalmFBIO5w5Pm+fnaDkr+UDEiP9nhTMVH4HHap4qL0LoWs3eGVoy
         GxcYjaQfUUfM6584X9ySOOiYeSMy6ITzAmtOMtMBBLwpYX+RvjEvAR08gKfKc9rxpy5+
         Gq0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789675380; x=1790280180; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=25a39fQthoJQenvf3ilsmj4we8U0R1UDFLTQO2djkUo=;
        b=RfRoG1sioHwQsGYSkcve3ZDGfErdmSWrgCWHA2JlCBaobnXxnBfdr0TKVq27LK2zIZ
         UOvE17R6vYGLa6zQAttig93toa0GDEpwxIgGBTum0FIhjWQ2ZvB9dyNYwvdV/otOI5vm
         A3ZFMmlVd6uq3DhAGMGK/mu80sINzK4rP2D3RMyU2gORKLRV1tGre9kz1kts6W1QAYaT
         9XuABFIURZMRzl1KZihvHVFw9CQ9VbWSNQiQyhE/Rv/Yb9DXy8oRagR/6b1gegQS3v8y
         YYEboH4Y45Pq3GkmJCdeXvha1ezGt4n7sH0US7ujlIUX6kFFOMpc2oolhcFXbjqXk/zG
         N+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789675380; x=1790280180;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=25a39fQthoJQenvf3ilsmj4we8U0R1UDFLTQO2djkUo=;
        b=1y+eXTawVPO12ykfuclXw8kCNwpWdmO2zS2u7zxSfqBgF8lOAIpnSzZm4qBSmvF+B9
         ncAnXxETxjguV+mt5EzrlZ1PGXRBVH8eN4bFEM78pNybBmRULvpN+0FuztusYrXomyre
         T0OXistRfnEeIb87z7znchKl+BscoEFRhqhz7ldqPkFLejc+nxnPfKHSoWWYFh51GLXq
         tNyXc9Qnw2u/wEMnd/7G5ZcRy8burJ7I1aqQ0CF/tMVLBh8tGSF/fN6HdYW4lD9IfeeU
         Fe+E7VifDwknDErRMVov8/0PjfAMp9W2n6O8kp5+IBN++/Z0PGSKNr0X6uH2av7cYnE+
         tkwA==
X-Forwarded-Encrypted: i=1; AKwUvByM73Q2kj4jrkrIq/18uqtZicB4FEkP8CRyF7c/WdUuwfRuBlRK1rRW5MiluIjapFFXqcoCGwN1S34L@vger.kernel.org
X-Gm-Message-State: AFuF++lPfdrVQYQiWeKX5MyfBuVwdWMDoeZgG6n32PBkKcNteHC4ny9h
	Sas2O9jZ5QU0mw1olRLzPYwHVDxo6FMlVzFNtT4B/YIQjk9cXbgZ+RTB4KEAVIuSHnWM0GsDe0f
	Bl8x4k0NEeMa96jdbzBaEtxpWxx0RQYcb6VfIuJQi
X-Gm-Gg: AYBFou0nqLJPaHFCRNlGCuyac4qL2k3dJRDPrkCoK3KV8heN66+Zm45IhgvtCUFVjKX
	zvrZTCDwnp90iUQJTiFW87CyAUPNEqSjPOCyb6MWhyVqehy+EwcwBnjBRtQDU4f3r+TaR9VTCRE
	SHV2VF8lbJC66RJNyMmyormrQzP20wicnVi1z/HvSjWAGDARDDB0TG/dF0JyA0q2z9EAOWYVTTZ
	zUUBuUNhk8WY5evyuqdk0bkoXUaVKNoLpThQ1WUvB+oddZpdXHxVpWM8dnMvbT+m3+zK5IdTtzd
	wZokfMcLAYRfzXLMvf+Sl8x+KXL1bY/67NKjG7VFcuHPsV+UR5pP7glFVQbpJF800TM2SkTOujA
	//mCx8Xm58V37eswGgawuYTIBH7/SD988v/buWI5MGNQTIWVJYOWXSxO7iw9l8cnO5lTV/NM=
X-Received: by 2002:a05:600c:a013:b0:49e:6891:27a8 with SMTP id
 5b1f17b1804b1-49fc574a9bcmr72735e9.25.1789675379819; Thu, 17 Sep 2026
 13:02:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917-build-speedup-v3-0-9ecf4163ff36@kernel.org>
 <CAHk-=wjwtJQPW+MRAkQCcSGA1EZWehxBTUiEUUhdACCNHSKvTQ@mail.gmail.com>
 <aqwkk7FcQ0XWeqJW@gremlin> <aqxCNyxYRzN2Oher@gremlin>
In-Reply-To: <aqxCNyxYRzN2Oher@gremlin>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 17 Sep 2026 13:02:48 -0700
X-Gm-Features: AcwNN1XUt93HLe1Zu-oZLdknUZyAU05hxj4P7Ko_JzOHOx4U0fnT6yaI1XKYaw4
Message-ID: <CAKwvOd=zbE8MZXCNCBJNpd2WWn7f+AOfxYcmCp7e-8uFSM+D9g@mail.gmail.com>
Subject: Re: [PATCH v3 00/20] kbuild: significantly speed up kernel builds
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Alexey Gladkov <legion@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 12:42=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
>
> On Thu, Sep 17, 2026 at 06:36:18PM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Thu, Sep 17, 2026 at 10:15:26AM -0700, Linus Torvalds wrote:
> > > On Thu, 17 Sept 2026 at 09:06, Lorenzo Stoakes (ARM) <ljs@kernel.org>=
 wrote:
> > > >
> > > >                 =3D=3D defconfig FULL build =3D=3D
> > > >
> > > >                         before    after     delta
> > > >                       ----------------------------------
> > > > Threadripper, gcc        32.5s    26.3s     -6.1s (-19%)
> > > > Threadripper, clang      34.5s    27.2s     -7.3s (-21%)
> > > > EPYC, gcc                28.7s    20.6s     -8.1s (-28%)
> > > > EPYC, clang              39.8s    32.2s     -7.6s (-19%)
> > > > M2, gcc                 519.3s   512.4s     -6.9s (-1%)
> > > > M2, clang               634.5s   569.4s    -65.1s (-10%)
> > >
> > > There's something odd going on with that M2 gcc build. Why is it such
> > > an odd duck?
> >
> > Ugh dear lord I think the LLM somehow corrupted the numbers... Let me
> > re-run those myself locally and come back with the actual times!
>
> OK numbers are in:
>
> M2, gcc                 564.7s   512.1s    -52.6s (-9%)
> M2, clang               615.1s   564.1s    -51.0s (-8%)
>
> From the v1:
>
> M2, gcc                 564.0s   512.4s    -51.6s (-9%)
> M2, clang               616.1s   569.4s    -46.7s (-8%)
>
> (Tested as per the cover letter pre-reqs, i.e. applying dependent series
> first etc.)
>
> Not sure on the -5s delta on the clang build :) that might have been me

Clang is faster on Thursdays.

> being more disciplined this time to not use the laptop at the same time.
>
> But broadly in line with the original numbers.
>
> >
> > >
> > >              Linus
> >
> > --
> > Cheers, Lorenzo
>
> --
> Cheers, Lorenzo



--=20
Thanks,
~Nick Desaulniers
