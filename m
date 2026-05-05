Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0C325A2BB;
	Tue,  5 May 2026 06:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777962852; cv=none; b=sDWyK/UWWkr89mhict/HiMesFfUaBRFxziCMjthhF5TgiPVZbN8im9oLsgRB3b4eIpN3S/ig+a5e/mWo0dc0EXOCAKvIAiK0jf3f+6RgGHPKfnU+34KBCqLl28JnplF6p6SAs7rohqC1yl3El3p3IrRcRyxuRsxRFR4PhuYg2x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777962852; c=relaxed/simple;
	bh=8rTZRRKXctVdIweleOee7CPkZZL8SqlWUIGqOF+HSqU=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=e2CAdiyeznddZUU+CjZOfd2mYxvfCOhSrDlmgTqSK5+DnAkMsgNy0cab9RGclcqp4Nbcf9IotHcBWDQ7esLk/jY/fVDru/TA5z4VFxLblPzoTJCLPmoRdvIqgIi72u1nO+szoz0kZYsHQ8gkyWwdJ9Q34tIXnlbXF+sR8Xj0WxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=u1R7aGqI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ajkXX1nP; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="u1R7aGqI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ajkXX1nP"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id B09DF130028C;
	Tue,  5 May 2026 02:34:03 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 05 May 2026 02:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777962843;
	 x=1777970043; bh=mSzVT7Fb6Q1GJvMmXV4hAtUQgAfzR7myXYKHCqT7Zp4=; b=
	u1R7aGqIUCFHM+/QbYGpsFVEKiZeLoCsSxD6etpr4TI1UhmqIl6UT+oFHi8hc05w
	0Kh9aq4ttEtsryomzEJEv9kPB8Fftb1JtIP+uWtc9es/UdFJvjtmfZByxSRQdISj
	hKwz24Zmre1KLPUOkI0Hn/wASeAoPUQh12qShGm7UZNKBBQ4FfTdc/jHMpYZui62
	mzIdz6iBI/24IO3jpBXC55Edd6Px2sYtlBrDGRQblJjdavx2QnZCA9BgMQkeBB7u
	l5yQ4GsAKfjqk0an+lys1CTVV83c9xbtX2TyR/r17pep5BV10h9nr1XzvPWxNOEw
	sTQbBCVBg+MY6GIg4QycmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1777962843; x=1777970043; bh=m
	SzVT7Fb6Q1GJvMmXV4hAtUQgAfzR7myXYKHCqT7Zp4=; b=ajkXX1nP6snZdVKF3
	j0gwvAj5S9cREUzuND2pMdCFhf3YMYp37T1kxU4Gsk48v/h7/ose5qJRMEIzdGgs
	fe8yA5TFh4XHKm4b76NQUwZ48xElDEi9fmTKyKk4KYtJrSRjs+Vmc8yOGCPcY317
	4ju7HH81ucPovlqXA79zHL+ulbK8niU69ZTg0Yxq1QCqk48a7+hgSkv7Inl2WBi9
	vCclUolYb4Cc7GXKp7lbbXxwCu0c8xFvQl+TPgiEqPmp5bQAU+kLKBTvSvtXZMhF
	bIz6HbPn4psmb/MbWw7iG7uOE5/SBBx/d19Wbh7PwW3mWspWrXXtMKqj2yg+Fwpa
	roBXw==
X-ME-Sender: <xms:WY_5aTmdaM4OKhG8xWdJ49xyodp-nrw4qj7CQ51RPQU42f9CPTX39A>
    <xme:WY_5aRr75hktxD3-avGWlXJ-Zw0-igJgXhKy1Xing9OPwcM_Omr4mn_bAo1ux33Fz
    SSGlHbI-bwj8TbyQ53wq3ZCUlq1_DIpB8GW-6iicUhEU7YsOm-mOKc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutddutdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhkeeltdfffefhgffhteetheeuhffgteeghfdtueefudeuleetgfehtdejieffhfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeegjedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheptghuihihuhhnhhhuihessgihthgvuggrnhgtvgdrtghomhdprhgtph
    htthhopegsvghnrdguohhokhhssegtohguvghthhhinhhkrdgtohdruhhkpdhrtghpthht
    ohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtoheprghouhesvggvtg
    hsrdgsvghrkhgvlhgvhidrvgguuhdprhgtphhtthhopegtlhesghgvnhhtfihordhorhhg
    pdhrtghpthhtoheprghlvgigsehghhhithhirdhfrhdprhgtphhtthhopegrnhguhigsnh
    grtgesghhmrghilhdrtghomhdprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepmhgvmhigohhrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:WY_5aRP-G1AZF66xxJHwKdzzA4REx0aM98VL9jtjTc-7cNqSRC2JrQ>
    <xmx:WY_5afupNhAomgYOUp9eRs5fIzdUV3vo78FkWK8Y5wILvs0fjAzaHQ>
    <xmx:WY_5aY1hkGHq06h0lw9neBCLRVCRbvSxiX7tdKxyRk5szccY56SvQA>
    <xmx:WY_5ae1sqHKpt2devCX1YzTH1h8JSb6XlF2sb-7RTsitxUPltD_8BA>
    <xmx:W4_5aafHexNRNA4nUj3kE13hAfhlWJDQLkDJihm9sNYAgzDk-Kj8TeiD>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 10624700065; Tue,  5 May 2026 02:34:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A7c2EfDQgAZJ
Date: Tue, 05 May 2026 08:33:04 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yunhui Cui" <cuiyunhui@bytedance.com>, "Paul Walmsley" <pjw@kernel.org>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>,
 "Dennis Zhou" <dennis@kernel.org>, "Tejun Heo" <tj@kernel.org>,
 "Christoph Lameter (Ampere)" <cl@gentwo.org>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "Jiri Olsa" <jolsa@kernel.org>,
 =?UTF-8?Q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, pulehui@huawei.com,
 puranjay@kernel.org, "Thomas Huth" <thuth@redhat.com>,
 "Andrew Jones" <ajones@ventanamicro.com>,
 "Ben Dooks" <ben.dooks@codethink.co.uk>,
 =?UTF-8?Q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>,
 "Samuel Holland" <samuel.holland@sifive.com>,
 "Zong Li" <zong.li@sifive.com>,
 "Conor.Dooley" <conor.dooley@microchip.com>,
 "Thomas Gleixner" <tglx@kernel.org>, "Deepak Gupta" <debug@rivosinc.com>,
 seanwascoding@gmail.com, "Andy Chiu" <andybnac@gmail.com>,
 menglong8.dong@gmail.com, cyrilbur@tenstorrent.com,
 wangruikang@iscas.ac.cn, "Atish Patra" <atishp@rivosinc.com>,
 "Anup Patel" <apatel@ventanamicro.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Bill Wendling" <morbo@google.com>,
 "Justin Stitt" <justinstitt@google.com>, qingfang.deng@siflower.com.cn,
 Linux-Arch <linux-arch@vger.kernel.org>, llvm@lists.linux.dev
Message-Id: <3720c3a4-cc0d-4ba8-97ae-35def0189e2e@app.fastmail.com>
In-Reply-To: <20260505062026.91724-2-cuiyunhui@bytedance.com>
References: <20260505062026.91724-1-cuiyunhui@bytedance.com>
 <20260505062026.91724-2-cuiyunhui@bytedance.com>
Subject: Re: [PATCH v4 1/3] riscv: io: avoid null-pointer arithmetic in PIO helpers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, May 5, 2026, at 08:20, Yunhui Cui wrote:
> The RISC-V PIO helpers derive I/O addresses from PCI_IOBASE in ins*(),
> outs*(), and ioport_map().
>
> Under configurations where I/O port support is not available, these
> expressions can still be formed during compilation and trigger
> -Wnull-pointer-arithmetic warnings from clang.

If a driver attempts to use ISA port operations in a configuration
without CONFIG_HAS_IOPORT, there is a NULL pointer warning because
this is actually a NULL pointer access that will crash the
kernel if the driver is ever loaded. You should not attempt
to shut up the useful warning here but instead make sure every
such code has a proper 'depends on HAS_IOPORT' dependency.

> 
> +#ifdef CONFIG_HAS_IOPORT
>  __io_reads_ins(ins,  u8, b, __io_pbr(), __io_par(addr))
>  __io_reads_ins(ins, u16, w, __io_pbr(), __io_par(addr))
>  __io_reads_ins(ins, u32, l, __io_pbr(), __io_par(addr))
> -#define insb(addr, buffer, count) __insb(PCI_IOBASE + (addr), buffer, count)
> -#define insw(addr, buffer, count) __insw(PCI_IOBASE + (addr), buffer, count)
> -#define insl(addr, buffer, count) __insl(PCI_IOBASE + (addr), buffer, count)
> +#define insb(addr, buffer, count) __insb(PCI_IO_ADDR(addr), buffer, count)
> +#define insw(addr, buffer, count) __insw(PCI_IO_ADDR(addr), buffer, count)
> +#define insl(addr, buffer, count) __insl(PCI_IO_ADDR(addr), buffer, count)
> +#endif

Can you try to remove the custom accessors altogether and
use the ones from asm-generic instead? These should already
have the correct behavior all the time, in particular they
already come with the correct #ifdef check that is apparently
missing in the riscv version.

> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index ca5a1ce6f0f89..d799e5ccc9437 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -1205,8 +1205,12 @@ static inline void __iomem 
> *ioremap_np(phys_addr_t offset, size_t size)
>  #define ioport_map ioport_map
>  static inline void __iomem *ioport_map(unsigned long port, unsigned 
> int nr)
>  {
> +#ifdef CONFIG_HAS_IOPORT
>  	port &= IO_SPACE_LIMIT;
>  	return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
> +#else
> +	return NULL;
> +#endif
>  }

The function definition here is guarded by the #ifdef CONFIG_HAS_IOPORT_MAP
check, which should already prevent it from being visible when
CONFIG_HAS_IOPORT is disabled.

     Arnd
