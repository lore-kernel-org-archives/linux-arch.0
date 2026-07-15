Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C611DF261;
	Wed, 15 Jul 2026 06:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784096248; cv=none; b=nrSZQ72Wxmma332YIbMTL+NWx9zY6d/c1ZXsfumGVa3/rMvsfzvlFIaGGHRyFpq3AVA2Kcc8OAyDs+YhRd4TRZ+7vrp67iF3hHd4u/1KBiOBnWXNDm8npmakhVKaIOZgV54SbhjqECMig0l8X0rQ8ZWX/nb174yqjn+3+jhPkEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784096248; c=relaxed/simple;
	bh=R7w8WDf0IA0/2pr5cbO928qK57kdMAshIWAldrpTyJA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=eLyipwwiop4Y0Af9GsM0HWGyvOIxgl3IEsqj0KepZ2aH9ryHf1ZZPsBygr78lXs1zbI7xnxTUnBI8TolduPMy3XQGmWK3ZjlPX/JgTi/mimyYxr0I+/4QCs1zUQDX8ZMZpnkPld2mwiMa/2soaHReDkTelo6PzzUzJvuEtIfdY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Br8RyOFd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jV2/fhH4; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Br8RyOFd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jV2/fhH4"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 9E02C13801A5;
	Wed, 15 Jul 2026 02:17:25 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Wed, 15 Jul 2026 02:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784096245;
	 x=1784103445; bh=9Zlh+AwrrnJNWN6iwdGzo8tmzqBKgmHLc8ZF5j+zMvU=; b=
	Br8RyOFdUU94WhnEqNGK6OUInEwtt42ECqpexhjmCAEtiEUbqF92211n+hxOfHMY
	ZEPZNepS6e+8b5e4Ny5oNgceLgGc5c3vLc4r+DxSTddj5qKK/VlPhAtv8gfyZypL
	VVhwha6CAnSjH23ukVh31ZHnKeJrBbcBfjdhjsA9Erz1NcVRn2D/aBT/96seeB84
	mf6GR4E2aXL75RlOqM5NPBrQmUNI68q5OUxqVV6/teUfiDYxF6d+zdYjKSFjb+t/
	9oYJ2Of3oxf9sYaet24kMDOpkQ0wPNWNbMYpn9a2NRPuxt6xLMqZoYqcOnUh59a+
	+snQXzLC6ACje/o05mzrQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784096245; x=
	1784103445; bh=9Zlh+AwrrnJNWN6iwdGzo8tmzqBKgmHLc8ZF5j+zMvU=; b=j
	V2/fhH4BpAIEas3AbTCLp5pwaexaM4H3pU2w1JHxfB3jtl6WngmQSemystLzp9qI
	kWMQ7JWcKJGnDPx9mRGLn2Umfn2cnwb+LWXFjfwmECSbyQFoqIFE+5Gcz+QZtLcx
	Djt/VFfBgZ9Z9KOK+Kt5sy4Ld9PfnVTM7DBVfQSUP1gznaJuyEygTd4hE0ubvkLV
	tMDqFvTinCd/9JEtBjD6pEIlpFu20QTtfHQkEtiZ6kv/55h7sInOkbaxpre8Snr4
	67P24aRTv0Jy//R76n3QrS+jXmY8Vxky/K4Wx6HmYkHx5dmdzwGsfrttZe7l/jMe
	5/Z9GWv/msY8WPAe60zAQ==
X-ME-Sender: <xms:9CVXainnxMtoA9WomfkvTWtGS0gs7bLSo00FlLyMY1H-JWdtdxrNhw>
    <xme:9CVXakoW4C3nQ9zyEuECqPuFxXYetF31e_FoGsrh6tB6lWfigrViHutFLvUHessFR
    piUbutdBQ-Th0L0YlgUUjLO99TO-3z4t7GIE2PZ5zOv0GyY84P61lk>
X-ME-Proxy-Cause: dmFkZTGkwoR0hlFQFm+73y1mguWnuh+qc3yybVVSFAuoDmPngFYjOIr0Zb9hX5c2qcCVvn
    sI1HXzG2bPbm7F/c+6YwzDUd5Ig/e1VsbxdAbFwgFKlMGi6ZWtvUVGPs4BD4qR21Gx2FgY
    EtkDPkZr2rPSNRzPvoEgLUgekSzaH0MaFl5YTqFpgdt7nbdd0Gr9D2hY5jjAVLBGjROutK
    3Te1HF7xnfK0lu7kPD/DEMvn0oDGfUjAou46olhYK2/TlIpolme0vRNz8fZXLnF+UFTqfA
    NrNuIYP+bMmZiOZ4/s235Gl05UEeW0+kr+DcX0HurL5HoblvsKRQW0en2vUrNDn/cfo8eM
    exj9pqaZGMevjLWoRPwN9dSbRRNGcxRkfpJT/FYjGh0L6fAUl6AQwMFen3HgF4pXyziFj5
    /S9FXxpGcks2/CkdMnCH3B76v2+TiHSLO+QchtDMmxtuw2ui7BdR5Glgc9xh9TAtT1ohxu
    MfBnF/qHM+b0mENiWUSBQbYQ3b9EZU+Kn1zB1QA8bKonaOqdvl96RV/Fo+8h99Z580HSaU
    rCtQOfLPHYRo7gxQPxYCOGfwJFFODA80tAc+IOlK9AzN5HVV/7ithUEhkK2Kafx3mlEywN
    TjGeOlAui3leqCQavfLsLa6Bdl0Ntd5Y70kbqbLghPHduKu5sNeG6daRUv7A
X-ME-Proxy: <xmx:9CVXamTS_Lhaint5DUHBdUZEtxYNB-HSfIXxjasq4DRxQ0ZzmiwQnQ>
    <xmx:9CVXai-ytlfd-5wXglShUGyU2nhzt-PPuvo1QSHSJm0YdKIH9BLuMw>
    <xmx:9CVXaoMOkyqoX4affuo8pkHyFPYU5s_-A1SBrmLhKQhJQn3FU_0hmw>
    <xmx:9CVXaqtJ7VQ4-VLSF9ISdlKWFfQyA29rjfU-TEE0Xb_61iMVCkr_pA>
    <xmx:9SVXatvjP514hx98-inUvTjSygpQ4_uDBf1DEi6JA-S80eWlqZCeXxVH>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B53161820086; Wed, 15 Jul 2026 02:17:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ASU80-mPZ9gg
Date: Wed, 15 Jul 2026 08:15:42 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yeoreum Yun" <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
 x86@kernel.org, linux-mm@kvack.org, kasan-dev@googlegroups.com,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 linux-m68k@lists.linux-m68k.org,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>,
 "Russell King" <linux@armlinux.org.uk>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Ankur Arora" <ankur.a.arora@oracle.com>,
 "Mike Rapoport" <rppt@kernel.org>, "Magnus Lindholm" <linmag7@gmail.com>,
 "Christophe Leroy" <chleroy@kernel.org>,
 "Klara Modin" <klarasmodin@gmail.com>,
 "Huacai Chen" <chenhuacai@kernel.org>, "WANG Xuerui" <kernel@xen0n.name>,
 "Kirill A. Shutemov" <kas@kernel.org>, zhangtianyang@loongson.cn,
 wangyuli@aosc.io, "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Lorenzo Stoakes" <ljs@kernel.org>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, "Ryan Roberts" <ryan.roberts@arm.com>,
 "Pasha Tatashin" <pasha.tatashin@soleen.com>,
 "Rohan McLure" <rmclure@linux.ibm.com>,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 "Tejun Heo" <tj@kernel.org>, "Kevin Brodsky" <kevin.brodsky@arm.com>,
 "Anup Patel" <anup@brainfault.org>, atish.patra@linux.dev,
 "Paul Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Andy Lutomirski" <luto@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 "Johannes Weiner" <hannes@cmpxchg.org>,
 "Michal Hocko" <mhocko@kernel.org>, qi.zheng@linux.dev,
 "Shakeel Butt" <shakeel.butt@linux.dev>,
 "Kairui Song" <kasong@tencent.com>, "Barry Song" <baohua@kernel.org>,
 "Axel Rasmussen" <axelrasmussen@google.com>,
 "Yuanchu Xie" <yuanchu@google.com>, "Wei Xu" <weixugc@google.com>,
 "Andrey Ryabinin" <ryabinin.a.a@gmail.com>,
 "Alexander Potapenko" <glider@google.com>,
 "Andrey Konovalov" <andreyknvl@gmail.com>,
 "Dmitry Vyukov" <dvyukov@google.com>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 "Anshuman Khandual" <anshuman.khandual@arm.com>,
 "Yang Shi" <yang@os.amperecomputing.com>, chaitanyas.prakash@arm.com,
 "Ard Biesheuvel" <ardb@kernel.org>, guoren <guoren@kernel.org>,
 yang.li85200@gmail.com, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Dinh Nguyen" <dinguyen@kernel.org>,
 "schuster.simon@siemens-energy.com" <schuster.simon@siemens-energy.com>,
 "Vivian Wang" <wangruikang@iscas.ac.cn>, junhui.liu@pigmoral.tech,
 "Muchun Song" <muchun.song@linux.dev>,
 "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
 "Nam Cao" <namcao@linutronix.de>, "Pavel Machek" <pavel@kernel.org>,
 djbw@kernel.org, yu-cheng.yu@intel.com,
 "Baolu Lu" <baolu.lu@linux.intel.com>,
 "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
 "Coiby Xu" <coxu@redhat.com>, "Andreas Larsson" <andreas@gaisler.com>,
 "Liam R. Howlett" <liam@infradead.org>,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 "Suren Baghdasaryan" <surenb@google.com>,
 "Michal Hocko" <mhocko@suse.com>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Stafford Horne" <shorne@gmail.com>, "Jonas Bonn" <jonas@southpole.se>,
 "Stefan Kristiansson" <stefan.kristiansson@saunalahti.fi>
Message-Id: <4a0f9161-961e-47f9-8672-9a06e52fefea@app.fastmail.com>
In-Reply-To: <20260713135614.1618183-3-yeoreum.yun@arm.com>
References: <20260713135614.1618183-1-yeoreum.yun@arm.com>
 <20260713135614.1618183-3-yeoreum.yun@arm.com>
Subject: Re: [RFC PATCH 02/34] ARM: mm: make 2-level pgd_t a scalar
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Jul 13, 2026, at 15:55, Yeoreum Yun wrote:

>  typedef pteval_t pte_t;
>  typedef pmdval_t pmd_t;
> -typedef pmdval_t pgd_t[2];
> +typedef pgdval_t pgd_t;
>  typedef pteval_t pgprot_t;
> 

Just noticed one more issue here, I think this will break these
two macros that now access four entries instead of two:

#define copy_pmd(pmdpd,pmdps)           \
        do {                            \
                pmdpd[0] = pmdps[0];    \
                pmdpd[1] = pmdps[1];    \
                flush_pmd_entry(pmdpd); \
        } while (0)

#define pmd_clear(pmdp)                 \
        do {                            \
                pmdp[0] = __pmd(0);     \
                pmdp[1] = __pmd(0);     \
                clean_pmd_entry(pmdp);  \
        } while (0)

    Arnd
