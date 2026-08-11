Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859E039099C
	for <linux-arch@vger.kernel.org>; Tue, 11 Aug 2026 06:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786431000; cv=none; b=oab3bffIe9DITmlFZxskewwasNJKyoS0y6D/8YOggiAyqU3H+RIQ9ofb8GJYOISafl75maUE34TMoDuE9wuMi5O77hUaXk5zoo7PzWLgL8YWmBY68/Vc8tjasWJI5RJAIrXL6VtB1TcE5Wg964B8YNZJB+Swntubor8shpeS1BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786431000; c=relaxed/simple;
	bh=tZZLV6eyiwcGv5N3oyI6rD0AMUqGK1dWtQ5SUdhqr2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GK/MZnPeVD/96lMdSyqQXtjpFBzHC+GN03fvSQEceMqVCTHW2ZtLccTSc0XkbUcbnI6ZI2hXX4VHCNVdYAGtiVfJ4XefAPF3kJYBK95t2JiFAhl1BP6I1NZmPgGsJp1rBpO5t3aQW90s5evIeBrPtIMbJiutZf9Y2IWjeUhenLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-7466771f1caso824498137.0
        for <linux-arch@vger.kernel.org>; Mon, 10 Aug 2026 23:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786430997; x=1787035797;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0iZRfAdzYvTsaTTh/J3ab87cNtJMKi7JiQC3Jqumorg=;
        b=eJSzNOyZaBcx1h4BOd47ujKiQ0MCbC3qUGd0PRYQKWIG0cKTaP5BRV3GN745IbyyUI
         9EcSMoC1SBuaR13SytYIOKIAM4ubzoBkmANVajG5abm806rEAiDCP5c/SgHElNsO9xPD
         voGiIrwNZO6gJDwEMLhhWKrUkP5fVWlvbyEQmg4rbtV5ozVLvmOac/IkqQxENPIREDGW
         t+BzbMCmQLUqbX5aGyzvaR8fhW2vRHgWHXMpLkbPiCWpC9un/ZXVlTB7jorAsIbftwc1
         wc+1iN/jAt31K/v+tekqem7Q5tmlGOMEAhey2ORMQyvYdHXVBWGp31aipeP/1VC6XIXn
         V2cQ==
X-Forwarded-Encrypted: i=1; AHgh+RoIoOl3awNWXMHBvYgwB1w8+NgLouzjopDjcKtUs0Zi3evWjaXnjKtK/MqUIV4lZk/GMyEHONbKLUrU@vger.kernel.org
X-Gm-Message-State: AOJu0YxsUlOWYrpVx6YV7klf1JGTKjfkj2LgXEi5xI7LoPJFUNSZBs51
	lCQqF9d07kpCPcnZ4JR7RaQhrmeLow/ERawJ2EnM7Ix9ptHGEozBeaFLvqz6jSd/
X-Gm-Gg: AR+sD13EmtQ97M9ESUYqGJsJ+p0f0m1JnrF1qVqx/wWhrHkWseaL56t1Uamq87zs6wJ
	1FUiR0+FnN+npcQtQaSivbEZNkQbivDETuVuzkU2J8C6OFqUNW7i8Yh4zZiDGXhNOOS4LbIE+D/
	9fzGt+uw7fCt+sfVfvtNkmaSMLfo5V22vOzAmrDXV0HRAuYepnw4if2tamYCuFycUpLwSVwTOQT
	xCPXP61gb7HFLJyxrnyOxPYgFWzD8yKyGHPL1os0I+NIncSQcfwLe+5MFf8o/f1tkfxgradMHim
	jp1MZ6QGVuofjHJKm8PyzQf18fa9JRJUkM91BrnI21k/tLfFYe1QbJAPUwxY+JGllE+Q9Ol8EqR
	jQBEF4MNSn4/XhaKljtGlHfiCsqVkKWmQg56LtKPp+v/Tj4dSg4PhEwWd/ArC+oRcPrKXLS8egH
	+n07aT6S9xkB1hlNBKO08uHv1jEJ2O1je6QYvbt30yxMmnxh9qfUZU4Qb3eqvxUkiawgGJj4vIz
	ELerFbRu6KwH0vfgrGmXwpI/Za27eBGZM181A==
X-Received: by 2002:a05:6102:a4e:b0:739:5f55:3c3c with SMTP id ada2fe7eead31-76b576c9319mr245430137.13.1786430997302;
        Mon, 10 Aug 2026 23:49:57 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97a36631fbasm120164241.6.2026.08.10.23.49.55
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 23:49:56 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7466771f1caso824482137.0
        for <linux-arch@vger.kernel.org>; Mon, 10 Aug 2026 23:49:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoCzD0bm+wi3Q87Db2WPSQy8zEsBlwWlNPxsRcdQqCSGReS64xhTe4CqOoXsGGfTH1VPHn2bGkBlf2B@vger.kernel.org
X-Received: by 2002:a05:6102:c4a:b0:738:ecd7:1984 with SMTP id
 ada2fe7eead31-76b54a7a17fmr283026137.3.1786430995503; Mon, 10 Aug 2026
 23:49:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811042119.3652929-1-anshuman.khandual@arm.com> <20260811042119.3652929-7-anshuman.khandual@arm.com>
In-Reply-To: <20260811042119.3652929-7-anshuman.khandual@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 11 Aug 2026 08:49:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXfpkpYzZWGVb0fQrdn3uYHU3pyCkyAX9o2ux_Jj=2ByA@mail.gmail.com>
X-Gm-Features: AUfX_mwgji-OqM2d70As4nCfmG84npBMa5IuhuEcV5XEKzcXYS3fe_Pqx16lD20
Message-ID: <CAMuHMdXfpkpYzZWGVb0fQrdn3uYHU3pyCkyAX9o2ux_Jj=2ByA@mail.gmail.com>
Subject: Re: [RFC V2 6/6] mm: Drop pxd_ERROR()
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, david@kernel.org, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Anshuman,

Thanks for your patch!

On Tue, 11 Aug 2026 at 06:22, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
> pxd_ERROR() has been used in generic mm just to print the page table entry
> in pxd_clear_bad() before clearing those out with pxd_clear() later. These
> pxd_ERROR() macros have been provided by all platforms which basically did
> the same thing.
>
> Make pxd_clear_bad() use recently added ptval_to_str() instead for printing
> page table entries thus completely dropping dependency on platform provided
> pxd_ERROR() macros which can then be dropped off. First move all required
> helpers in core MM into a header file which could then be used else where.

Oh, the "x" in "pxd" is a wildcard?
Except that is not, as it does not match "pte" ;-)

> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

>  arch/m68k/include/asm/mcf_pgtable.h           |  6 ---
>  arch/m68k/include/asm/motorola_pgtable.h      |  8 ----
>  arch/m68k/include/asm/sun3_pgtable.h          |  7 ----

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
