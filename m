Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793353173;
	b=sMgG3GxmDP8vxMvXxEp8X8mucTFPtoqiqT39Wlx9GwXGYCpxAuJcbH3PGano7cTh6BEM
	 N9naf7M+Y/X8kRtRs0zipzjpahhD/XgiTKkbNClVRbu5sO2PEenOfndJu54Mool4lrBxX
	 62hschw/QHJHjGqlQ3RVeRx7TlB7HycbOQjSDZFP0CPxZGXuUcWlJ01rB9ySKwY2cl6VN
	 R3AHEkpvSFt2q20ziVRugxjH3Jo3GwpYyFZQ9DDhKStkkxjscAUIE5ASv28qjD8TcPkId
	 3vBNfS+gWPbG92B7G6wKNospvyBbUhZmEn/Nsviip3Fv1Ij+Qc1BkmFJbEz1GMgz2lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793353173;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=UvOO6JqfZMd+v5QBaFPCO17vd6AxfiDuRyj9QuuRkjg=;
	b=H6axn4QwYlvBWV7my+r0DcmDZjYa/bDb9wPWYbwLPITB2dTISVs9gtRxyfFbC8ytnGWs
	 kd46MXZQz5MQM1+OVBtcuo/beEpFkE8994E/A7x8EpLodRQ6rAyHACoBE+rSzsMguK0t5
	 MrhSABYds8IezJaWM7MaSLTYMGbuKMNdWVOuT5Ee5uOcS58u39PBS7p3IkIsqFmvm1LIH
	 Zwc/N8uJ2IAVTbpUZ8XmDmIM5mDOVF3TI1A2izgC2KLNQTeDY8RPeOZgI8FYMgJAnOWF5
	 26naqXtU4aKlTTdc1ZZkrcJB+bBTiii7EPoPJgrmgL/5Z5wcmIaalPKSqatdCmCoEyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.49
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026B3606A31A
	for <linux-arch@vger.kernel.org>; Fri, 30 Oct 2026 09:39:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 026B3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-98ff53fb739so296163241.3
        for <linux-arch@vger.kernel.org>; Fri, 30 Oct 2026 02:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793353172; x=1793957972;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UvOO6JqfZMd+v5QBaFPCO17vd6AxfiDuRyj9QuuRkjg=;
        b=NkUkXE7SOR28N8m2Xp+nu83S4J1iS1V5X6BAQUERwLwRM/xPq+qytGYc7ZQAwz7QjY
         iCeidS6cAd+287uE7WzmQNY+GScRj4CimNS5YVa0TrQRqB3q7JDZC8WVn/3kVURL7KEY
         eygfX79ycFXz/Xi6rz88mhgOrsJ58RI2VA+aH4ArZ8GNXU//af+tJ6EEJdlgX24lCQzy
         dS5iE1KtcshqZKIiJaprLJg/j/X6GP71p6RIPQATMVMZ7HqIG2L5kaJ8YMzro7Ph1du6
         ONYosvusKxcD/b5bZDMfCCOgllT2438uEfdAwPZ8Vpla2rJ4P4vLYZe+ePtmv1eEpmDF
         +ZEw==
X-Forwarded-Encrypted: i=1; AKwUvBwENC/whKfIR1ZX1Sstqm2wK06RnYyc/474Gm598nAS9Npi7mD/NnyNwyaaC/RfophMUzAohGyLgEbS@vger.kernel.org
X-Gm-Message-State: AFq9FYIUIpxv/EnLaxVI74OM44JBHTI2MSxfTavD60y9YUqI0eKtseJV
	x7OJgFLq9vU6xYJ4OLH0tEc6Aa2Z3Le42ktff2dTtsffcMY1Uv1QPh6aneBKoQQg
X-Gm-Gg: AYBFou1P6P0LlIjXFaBWPjcbNFSohNx5xEeOdGy0jBxB90HTYtKMZfDvI41kj44EI6i
	P0y128NVxlhz6NfBMIlJGT3M8OKJe+v4LsuOL+mgnv6vtsfsYhR4Zr4nQcrr1+6lsJpUJGquhI4
	gJYsAo0y4YlKcdtli4+oKqxiTagxUXlL9+GVXk2N2l+Ec0vxcokLlakjZKC36E8HmTwEGaZ7hz4
	9AEUTFXAhBd0EnhhZc1R5Iys6ztzpo0LR8NVqIhJugffLsApKgUr3Pm3MKfDW/DKSPSyYkMzSFf
	RdHdIlo0fhZ4NGmpEoIPVEyScHaokaR7HTYcahZRHLIwsKL38UtZtLShaI4ibcpVZ7z8R4g/jp7
	E3IyG6ORVjkhjWMR6jookG5JT2VWJIogA0/ZkBBFow9DXO+UZOjguqGxCvD7gAeijlcG1S8hn33
	JBCbHyVXYFSwcmHK419WB5gwoQvf5snKItmoIMb+IMV0U2sLCwumgtqdfcFLSEmMvS0EQX4ka+U
	GiZoect2emqnzYp7J53NdytKpqPGkGn81jXEC79yzBbz5aggjb4k9yLmoyO58SPfpambP8ksvwA
	IgODHuIPh1aWf0wdCjs6u5PI5tvKpjlmQ2POEYZUYd+sjLlwKD+HkQUjvisOXJHsM8Y=
X-Received: by 2002:a05:6102:3588:b0:7cc:2c52:47aa with SMTP id ada2fe7eead31-7d071f2ec61mr1051023137.0.1793353171978;
        Fri, 30 Oct 2026 02:39:31 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-992ee41f108sm1890974241.7.2026.10.30.02.39.30
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 02:39:31 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-98ff53fb739so296152241.3
        for <linux-arch@vger.kernel.org>; Fri, 30 Oct 2026 02:39:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx0Mxn5dvLu9y1l6wlPtqaiuu/Jth2ONdc/7Azk3DgTtIbMED23tsrxZqmJOUDCkPhgdpOtCebvGmwx@vger.kernel.org
X-Received: by 2002:a05:6102:14a3:b0:7c3:1395:a090 with SMTP id
 ada2fe7eead31-7d0726152famr950274137.6.1793353170421; Fri, 30 Oct 2026
 02:39:30 -0700 (PDT)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030083800.599152-1-songmuchun@bytedance.com> <20261030083800.599152-3-songmuchun@bytedance.com>
In-Reply-To: <20261030083800.599152-3-songmuchun@bytedance.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 Oct 2026 10:39:18 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVYbJOGCd82fNm8dD5kXTWQvRnymkx3w2PFH-dKnH7G8g@mail.gmail.com>
X-Gm-Features: AclHuK8vFqi3dqWRxr6f8_rNGo4Y5wLrZ0prryPEwyIfD0-s59WP5msq_iDtOig
Message-ID: <CAMuHMdVYbJOGCd82fNm8dD5kXTWQvRnymkx3w2PFH-dKnH7G8g@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: remove redundant pagetable_dtor() calls
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Oscar Salvador <osalvador@suse.de>, Alistair Popple <apopple@nvidia.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S . Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 Oct 2026 at 09:38, Muchun Song <songmuchun@bytedance.com> wrote:
> pagetable_free() now runs pagetable_dtor() for constructed page
> tables. Calling the destructor immediately before freeing the page table
> therefore duplicates the lifecycle handling at each caller.
>
> Remove the redundant calls and let pagetable_free() handle the
> destructor. No functional change is intended.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  arch/m68k/include/asm/mcf_pgalloc.h    | 1 -

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
