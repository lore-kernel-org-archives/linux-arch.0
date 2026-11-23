Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795432525;
	b=wJML73ammjXXfeWF7DwTcjK/w1NPA2wj3qoLtF9pqkdK6hOxeIc2g/asqgCgsRL95Zm5
	 tVskX9XMtC9vtzUWoGMnB3W+RWRcq7wCtlV+My2Es9jWXsyIWNj55C9lArZzBJoaR5n5P
	 TNbGyhAoOD2a1/DiK6Q6LywDNSvtfk4kQESyIcYi8hnnry3rbUYZjTZfNakL+AwyMFt1J
	 7wfW4VMVcInFPLKJ5P/ky7IcE7mlw3xLMXEmTptlJvM2z8VDrVWpOW8GowQlrOSWXVGkA
	 CwteIU4LLuOB2iH0C6Bju/Rtby6Itjiz2tfOPbJ7U+M92jF+s51jZeVzxILKOlFDs+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795432525;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=m3FH9Inv0u/v073kkt2usO8SlhkKeOQiuSBxAimhluw=;
	b=efJK1dIxteUJnNqfwAb9WJQA6j32InhSea0rvGaXzJQTElPEGmBkhYYVNzQps/En3fso
	 qShS33Ti7avHaq2j8UTpntZVyVGZcB7dTFuhrzWEBJz5rjwxTCPTVE+MZ+s1sEmu1dKat
	 rGIaM6kfgyZaV0EG/PvyGrS+7iox4Upr7LW7kvsUI87EUecVVSYpay1zcIu+EmjnAjoTY
	 TGE+QUFLJt4dUFEjY3++v9J9Q1722dbIdXchRg5Iak2/Kd7mNQRS/aquo6CyBupptpODC
	 SeOv+u3txzM3tLmhIF0qWs/uJocdupizO1mpAPBaSI1Yzncw41hvV0ZXz6g9TZ67acg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lKfQIv4G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A41606A31E
	for <linux-arch@vger.kernel.org>; Mon, 23 Nov 2026 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lKfQIv4G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53851F000D4
	for <linux-arch@vger.kernel.org>; Mon, 23 Nov 2026 11:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795432524;
	bh=m3FH9Inv0u/v073kkt2usO8SlhkKeOQiuSBxAimhluw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lKfQIv4GogcIKtrj0EtxkNLuZ9GNbq2PszXlji7xvZ4I9C7gr++DHlV4IigfjcK3N
	 jTtnKgGCM1GGpr9+md7zKjyNN1QBnZnbfPS5Mal0rNyyH/+b6ZvAl4HUQ8pOphNYsx
	 8KebWB9WQQpSEdeRw3Pa4RR6J/k4mDOtQw70nw2ZucE9d6xhr2U5OnhawE6iZmQnXy
	 2xJOSvka7n2u6i3OWquD9LSifjCBJyDDDdKpMHLHpKXUnwZAcBxhXS6moGYewdx8yw
	 au4S35FRFQSUZHqo+0znW6Q2u56wztiB7FNx3KZOGwPkyNqcaFSw0PB7GRPwIGGjnZ
	 qR+XnOAbxb9rA==
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-497614c95f0so1729689f8f.1
        for <linux-arch@vger.kernel.org>; Mon, 23 Nov 2026 03:15:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEF+Gzf+Izqy6XuGufaY6k/0825hG5XKljnK4U4ndZDfWQhkl2kxr1WlXbFeWYgD8rXsg1gidP1NAkx@vger.kernel.org
X-Gm-Message-State: APuU4Z/yKrilpYXuwSTuX4GSeT2pOFwBuyjgGdUBUUW2kMcCC6bshmNO
	ROtWh+PJ2GabNIG85Lvrzsm50jCRpbgXh74wHqe5cQShsF3XG+KbKf52NtNZLGCYdj2TUny05X1
	UwCJ75GOOHQgJlN9hYgyMaiyLYO0VDKI=
X-Received: by 2002:a05:6000:4381:b0:4a6:5a2a:f5a3 with SMTP id
 ffacd0b85a97d-4abaa9773abmr21927640f8f.3.1795432522530; Mon, 23 Nov 2026
 03:15:22 -0800 (PST)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120012712.1957564-1-guoren@kernel.org> <awPgjwuswbjeDftg@thelio>
In-Reply-To: <awPgjwuswbjeDftg@thelio>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 23 Nov 2026 19:15:07 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ+cOYfQX=JsK6T6Aij79FU9RGuyxAAouyL958z8ABqng@mail.gmail.com>
X-Gm-Features: Aa3M54qkVWzvIW1E3JY7I_38vKo1jeuZ7f-WFYjpRl8FFdSV5EvMxwly24Z7rYs
Message-ID: <CAJF2gTQ+cOYfQX=JsK6T6Aij79FU9RGuyxAAouyL958z8ABqng@mail.gmail.com>
Subject: Re: [PATCH V6] riscv: errata: Add ERRATA WRITE_ONCE fixup
To: Drew Fustini <fustini@kernel.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, arnd@arndb.de, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Leonardo Bras <leobras@redhat.com>, Inochi Amaoto <inochiama@gmail.com>, Han Gao <gaohan@iscas.ac.cn>, 
	Yao Zi <me@ziyao.cc>, Chen Wang <unicorn_wang@outlook.com>, 
	Xiaoguang Xing <xiaoguang.xing@sophgo.com>, Paul Walmsley <pjw@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 2:43=E2=80=AFPM Drew Fustini <fustini@kernel.org> w=
rote:
>
> On Thu, Nov 19, 2026 at 08:27:12PM -0500, guoren@kernel.org wrote:
> > From: "GUO Ren (XuanTie)" <guoren@kernel.org>
> >
> > The early version of XuanTie C910 core has a store merge buffer
> > delay problem. The store merge buffer could improve the store queue
> > performance by merging multi-store requests, but when there are not
> > continued store requests, the prior single store request would be
> > waiting in the store queue for a long time. That would cause
> > significant problems for communication between multi-cores. This
> > problem was found on sg2042 platform with the qspinlock lock torture
> > test.
> >
> > So appending a fence w.o could immediately flush the store merge
> > buffer and let other cores see the write result.
> >
> > This will apply the WRITE_ONCE errata to handle the non-standard
> > behavior via appending a fence w.o instruction for WRITE_ONCE().
> >
> > This problem is only observed on the sg2042 hardware platform by
> > running the lock_torture test program for half an hour. The problem
> > was not found in the user space application, because interrupt can
> > break the livelock.
> >
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > Reviewed-by: Leonardo Bras <leobras@redhat.com>
> > Reviewed-by: Inochi Amaoto <inochiama@gmail.com>
> > Tested-by: Han Gao <gaohan@iscas.ac.cn>
> > Tested-by: Yao Zi <me@ziyao.cc>
> > Cc: Chen Wang <unicorn_wang@outlook.com>
> > Cc: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> > Cc: Paul Walmsley <pjw@kernel.org>
> > Signed-off-by: GUO Ren (XuanTie) <guoren@kernel.org>
> [..]
> > diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead=
/errata.c
> > index 6f1c683f0ec0..64683882d50b 100644
> > --- a/arch/riscv/errata/thead/errata.c
> > +++ b/arch/riscv/errata/thead/errata.c
> > @@ -168,6 +168,23 @@ static bool errata_probe_ghostwrite(unsigned int s=
tage,
> >       return true;
> >  }
> >
> > +static bool errata_probe_write_once(unsigned int stage,
> > +                                 unsigned long arch_id, unsigned long =
impid)
> > +{
> > +     if (!IS_ENABLED(CONFIG_ERRATA_THEAD_WRITE_ONCE))
> > +             return false;
> > +
> > +     /* target-c9xx cores report arch_id and impid as 0 */
> > +     if (arch_id !=3D 0 || impid !=3D 0)
> > +             return false;
>
> Doesn't this match more SoCs than just the SG2042 and TH1520 like the
> commit message mentions?
The issue has only been observed on SG2042, though TH1520 is
theoretically affected as well. To the best of my knowledge, it has
not been observed on any other chips.

>
> [..]
>
> > +#if defined(CONFIG_ERRATA_THEAD_WRITE_ONCE) && !defined(NO_ALTERNATIVE=
)
> > +
> > +#define write_once_fence()                           \
> > +do {                                                 \
> > +     asm volatile(ALTERNATIVE(                       \
> > +             "nop",                                  \
> > +             "fence w, o",                           \
>
> I tried this on v7.4-rc3 in qemu with -cpu thead-c906 which matches this
> errata, and I discovered boot fails when CONFIG_DEBUG_VIRTUAL=3Dy.
>
>   kernel BUG at mm/vmalloc.c:879!
>   epc : vmalloc_to_page+0x212/0x260
>    ra : patch_insn_write+0x1a2/0x414
>   [...]
>   [<ffffffff8026ba1a>] vmalloc_to_page+0x212/0x260
>   [<ffffffff8000fa76>] patch_insn_write+0x1a2/0x414
>   [<ffffffff8000fcf6>] patch_text_nosync+0xe/0x22
>   [<ffffffff8001b886>] thead_errata_patch_func+0xac/0x144
>   [<ffffffff80009548>] _apply_alternatives+0x76/0x96
>   [<ffffffff80e038a4>] apply_boot_alternatives+0x48/0x54
>   [<ffffffff80e04d4a>] setup_arch+0x92/0xe8
>
> The vdso getrandom code uses WRITE_ONCE(), so it now has entries in
> .alternative. patch_map() ends up calling vmalloc_to_page() on an
> address in the vdso and triggers VIRTUAL_BUG_ON().
Oh, thx Drew for catching it. I would disable it in VDSO code.

diff --git a/arch/riscv/include/asm/rwonce.h b/arch/riscv/include/asm/rwonc=
e.h
index 081793d4d772..5305b8bf82bd 100644
--- a/arch/riscv/include/asm/rwonce.h
+++ b/arch/riscv/include/asm/rwonce.h
@@ -8,7 +8,7 @@
 #include <asm/vendorid_list.h>
 #include <asm/errata_list_vendors.h>

-#if defined(CONFIG_ERRATA_THEAD_WRITE_ONCE) && !defined(NO_ALTERNATIVE)
+#if defined(CONFIG_ERRATA_THEAD_WRITE_ONCE) &&
!defined(NO_ALTERNATIVE) && !defined(BUILD_VDSO)

 #define write_once_fence()                             \
 do {

--
Best Regards



 Guo Ren
