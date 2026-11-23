Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795457561;
	b=RcaYVQgNLH6GLweTREl5hrtXwmc/cLpZ+vBz78LGfviBiYWta7TglPVmYRvJwYk5P3gO
	 Lji971yaOM4gqexz/7UM4WTWtLuo0ZhBcr9U59Zo4qt4YG01RjpLy3Tbn4ww0PhbubOcD
	 r5eaD5+NBfRQONv3zU41pGKi91KTygFpT+rGp6UcjnrpkfQQKUbvhXf2knXPxo2HnXedu
	 uRT0egaFgBy2XVfzcDKxJ/ntIHAh+fIrexU/5PGH6vPmIbZTyUoxkNjADlTFIU+3gvtA0
	 EO1whPNuNMjLeTYWVxcSYK6usmHgt41M8VY4FzRRTM2BkXnpIjrgKgywQav1GWpFJyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HP8VBm9AwBGBl3fsWmTi0HJKAowy+01FlMfGnwz4/xQ=;
	b=0nJwdWdRaZazjE3iLy5xPjA5hXcQl1eHS5A2ICyoJUpBn0CUu1YcWOxNdDg4aElHC+VD
	 1TCgeBWE9hJWQhrEvMPcuUyUCURK84Oi/K/Ca+A74ZyOgCFaFWzP1PEshnF1LdwO5WeFa
	 svRCpT2bPyf1Vnsz94a2eSqA6EycZYK1V/9TetGbEzisNQRO9Dw2+vKetb3DSA7xk8qAG
	 PH+PpKC+W23hDsmxPrmxFntS7tN19AM61Tk7XqwFNFgDmyGfGxUsc5QemLXSg1Y6XHNo6
	 FLhvN6vDB9rzDxyistgQyC4AxwcDMoH0xC69AYQCTKh1JXbV8EpEGwnBBI3D5C0pBxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZvLZA2pc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3411A606A31E
	for <linux-arch@vger.kernel.org>; Mon, 23 Nov 2026 18:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3411A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZvLZA2pc
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b2d14968c9so34159677b3.0
        for <linux-arch@vger.kernel.org>; Mon, 23 Nov 2026 10:12:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795457559; cv=none;
        d=google.com; s=arc-20260327;
        b=smdck5Xp0NBURbj6ayF2e9sz7dW1/Gu5oB53EchMjHnPPS0+/TNcY2ati0ONYdtNj+
         RV0qa6uG7gEzMFq3J7NakfWHHqk0kplgNSx7RrkaDJKjy0N/1PMD6elNAto9wzenCVQn
         AmDVv3mCiMzMZ3OFKTrqdZkIbBQ4JZ/EmIugZq1OfUL5XWpxhkvQkC4xQWS1Mt0kndKA
         8WlZytLfJf6Sy0ZiALhz/sWFQp8iss1+4e5YqxxtU1CGOnTnpKRVfwhw19S963eHu9lX
         MU2kAtAvCha5C8EpaWUVrzwrMidviOcsrEb49HZhOUrEH8hVO3bJ1JbQw4pVvp5Rrix3
         4gyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HP8VBm9AwBGBl3fsWmTi0HJKAowy+01FlMfGnwz4/xQ=;
        fh=/hJp3NrjK/UtQXbKCgJxlSLbJb3O1j57L2CzV0/9KcQ=;
        b=ACYni7sn/Vl/UV8+VQT07cLbbr9UQ+4yaY4RyfKoBGxeb/Zf3HLzgTs6yGmxcjf6jS
         myVNsgHB/z8qjU6jaFJDPtTa+90VNfHuyHAa/NJ6e5yF/x99FU0ydKq4az+Y2LMPNNMi
         fn37jGzQTbFpYtBh3KfFjjX7tTqTowQUBsW2woh6Nq2Ddn6ws60rP68j2L4dp2hfXSux
         8Mh5m5Dl4O49hu+QySaBnDWpDba7mLRghFJDtmiChVQSHe/7QNVnl4hhjzqDIeUbD/IF
         eDm/jWKJCfYEH83bM8b6SfQtM906oxAGKDlqsrxxmn11VbnLSQ1Q+MXBmC/P/Tqn7FEq
         r0KA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795457559; x=1796062359; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HP8VBm9AwBGBl3fsWmTi0HJKAowy+01FlMfGnwz4/xQ=;
        b=ZvLZA2pcD9FH9HECe7LfubP1g4r7DtXRTfLw+a0fSCVHRJ58hcWDYhSRacl6iWIhx1
         vem+3JyEz4vOLSZ+IkUJHfzXgIjCFVthSNx3d4mzu9P79SfAolAw4Jt4yzHmEPZftFFs
         rR44xHk1UdKlXpN4nsj8cuw28Pu4f7r8OoDysRubVnO2x1wYTvw4Cv7a++edFCAgU7xv
         FwyOp8/bmeVoA8845IWW+N0pphOdNNyL2IUTX1caZ67sYL7dqc3DVPzzaQ1OhL8UsU0T
         ppHemCUM2GWad10r+4RYwS/DZlVBqx2dNyPjbDasXB+7Kxeyd98kKRzbZqgwtR86cUL7
         YuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795457559; x=1796062359;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HP8VBm9AwBGBl3fsWmTi0HJKAowy+01FlMfGnwz4/xQ=;
        b=wsGh/ajb3j96NNQpp+jFdIXivnmaXDy8qq5xODG0QSsURImWsRnxrSl55Q498Se2S1
         wv9JfRG3ROKeCetu/4tl9V4T+ETq3N7kd5VQbIRsqnK99KA01v2Yqo76etC8Px9UeSYA
         w6vD3Y1Pbuxyvk9lsVJZjSH+SmJkpXOvwyloS61h3LtVBciKhE/wRHZg8IrMimaBlWA+
         2VkD2t1iueJM57G+VNAfV3fcLJXXLkCxdPFxb5jqeQBxwsMBIOKLhE8/HA2igDTNIyHj
         0kDnz5CMeoN+cxdlovMyCsmrGCH971nR7YiAMtHI+wZUN+iU/0v1/k9NXfgBRWaos+Xk
         Pl4A==
X-Forwarded-Encrypted: i=1; AL+hErEcu31H7clm9f4Zvxf0idZbBBrpaltxE+y1nJxk/Dlzh/FI8456zTWoHuI95m2KMesfm1XXSUveX1BK@vger.kernel.org
X-Gm-Message-State: APuU4Z9WTAH/L6hFdZxt29pLS7hI9Drd5LEzZeVOl/pSs9jvkSg+cmbs
	Uh3fsQxX6MYuxo6qxYQfByVRO+u7eaaHtI9nDdYGadH/wEqmZHApUSN3toGDMX1Aqa7MLFCNmhs
	X4m7Esj3le5C/ljnuzkv/nPMewCEKvxA=
X-Gm-Gg: AZFdTZdHiqWKbC6nhcfeUozdMDMFN2MzswTmRjHWCgyG8z7suNugqhECK+kvHjZiG5p
	SE+I/U0lh0LSHXxesCyOxHlYtw+P7/R0NEmTcUmz7UIr4ySgQgBf91zx8O2hLuz0W4yzAQb1d7a
	qQhUltOJ2vQDurLBQVygzkK3ssnSkoJTLb9qX2KAF2ilRK4RKJ2WB0e2VLN4GIdoLiM54f8pHT9
	S6+JwEkZjm/jZChfvAJdMUFCVGeFnTxoI8X3kH00inH36PkXmohfE8z4bhSzfQxqaQ8hFQ/l9Mi
	vsI6e63elzhzK9vLRXhtIMXr7Rnx0AO80kftET8I93ukIDjGr9tA7wp32GKrQcsLve/yNMDjB66
	OxfSCGYUzZnAmwe8Di5hcmrVdZwRGmGHoEPewtvJ4gkDWGu8e7f/6Xr0RNvipLeL+ib0n+LHDt6
	muDFRUEuoAkfHjZ47VQjcTfkKdxHnIakAPoYtz
X-Received: by 2002:a05:690c:c96:b0:8b3:4b5d:b26c with SMTP id
 00721157ae682-8b520435e51mr43853877b3.13.1795457559039; Mon, 23 Nov 2026
 10:12:39 -0800 (PST)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121-vmlinux-lds-v1-0-49818f3f5cc0@gmail.com>
 <20261121-vmlinux-lds-v1-2-49818f3f5cc0@gmail.com> <20261122115458.1da4b8e9@pumpkin>
In-Reply-To: <20261122115458.1da4b8e9@pumpkin>
From: jim.cromie@gmail.com
Date: Mon, 23 Nov 2026 11:12:12 -0700
X-Gm-Features: Aa3M54p7oziKjc6uiBqsKJw-wMOKZwA0vwboFiGz1_X4unEm3KI8bOmikp-yLOk
Message-ID: <CAJfuBxyxu6FgcX-0yr3QaYOyDH0VZwvtaSU7HpqBU7_AV8qCVg@mail.gmail.com>
Subject: Re: [PATCH 2/6] vmlinux.lds.h: drop unused HEADERED_SECTION* macros
To: David Laight <david.laight.linux@gmail.com>
Cc: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 22, 2026 at 4:55=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Sat, 21 Nov 2026 15:49:20 -0700
> Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org> wrote:
>
> > From: Jim Cromie <jim.cromie@gmail.com>
> >
> > These macros are unused, no point in carrying them any more.
> >
> > NB: these macros were just moved to bounded_sections.lds.h, from
> > vmlinux.lds.h, which is the known entity, and therefore more
> > meaningful in the 1-line summary, so thats what I used as the topic.
>
> Maybe remove them first?
>

yea, I'll do that.
thanks

> David
>
> >
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > ---
> >  include/asm-generic/bounded_sections.lds.h | 15 ---------------
> >  1 file changed, 15 deletions(-)
> >
> > diff --git a/include/asm-generic/bounded_sections.lds.h b/include/asm-g=
eneric/bounded_sections.lds.h
> > index 8c29293ca7fb..268cdc34389b 100644
> > --- a/include/asm-generic/bounded_sections.lds.h
> > +++ b/include/asm-generic/bounded_sections.lds.h
> > @@ -18,19 +18,4 @@
> >
> >  #define BOUNDED_SECTION(_sec)         BOUNDED_SECTION_BY(_sec, _sec)
> >
> > -#define HEADERED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_, _HD=
R_) \
> > -     _HDR_##_label_  =3D .;                                           =
 \
> > -     KEEP(*(.gnu.linkonce.##_sec_))                                  \
> > -     BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)
> > -
> > -#define HEADERED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_, _H=
DR_) \
> > -     _label_##_HDR_ =3D .;                                            =
 \
> > -     KEEP(*(.gnu.linkonce.##_sec_))                                  \
> > -     BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)
> > -
> > -#define HEADERED_SECTION_BY(_sec_, _label_)                          \
> > -     HEADERED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
> > -
> > -#define HEADERED_SECTION(_sec)        HEADERED_SECTION_BY(_sec, _sec)
> > -
> >  #endif /* _ASM_GENERIC_BOUNDED_SECTIONS_H */
> >
>
