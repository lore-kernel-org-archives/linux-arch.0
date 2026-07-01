Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0283AFD1B;
	Wed,  1 Jul 2026 06:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782887135; cv=none; b=b2TyRtnUtoIWQMlInmEVjeXgz1s+7wtg5OE4WJcd36bDOh5K0Q41v5MmuDSFAG0isd+Swe5pq6kYd1PO3U0L68dRsRtXik+bRG2W+VlSMXqjqMJ+kUosj4RiO/FMd5tdkvWYeCq9Zv/X+9k1xWzHJ4DqlAQjd3QVw0kiYwcM//E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782887135; c=relaxed/simple;
	bh=pF/rjHiAr/zdI8E9ZhuLz/uX+1p5q007BELgMZ5YKpU=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RUzrfz8jeZLMk4yDI/8cXMRmxcX0qbkuRmAMPJHid6kRlnwTreYjm05I7HkHquX5VHIIPD7fhqGwkNz7OfzMEnU98mHMg9VD/u+DcUlqZ/V3kS0JzbA8r6PL7f8HMFIF/Od4tby4towDhXy3TOZ/z5FzyV5cCtSy+6mG6+tm9bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ZAEo/ZNk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KH4gK04V; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ZAEo/ZNk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KH4gK04V"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 35EDA1380326;
	Wed,  1 Jul 2026 02:25:32 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Wed, 01 Jul 2026 02:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782887132;
	 x=1782894332; bh=b44fp/Xs200vmVmERTgFd09AZSIVEJbxoZ/zLTkjWAs=; b=
	ZAEo/ZNklCq7HmQEk3ZyRkEqqp0NAs1NuYnrrERijClIWx+s19L6FuvIXKdtFruy
	4V89DusI3RY+PWxVDApjhWzHTyjpdA2xSUWFPAsFdcFupvmlqwaUhmnKBG1Qj+A3
	aGgtYpFNkgAjsd/I4/5LLU/QklAxLdmIa7rQMcIiR6atyFIFZJTE5nOy6AMIH0RE
	lyvdf1uqqx8qwClvFZS3mWbrktvGFtDL2wj+5vdLJTyzu++JTDl0jY/qaQFuTovj
	gDaDaoC/5siXjVCoY0jI7GyPsU8yQM2K39vtKFpR3GQQ9wMuIymhBSRBRIY9A719
	BH0I0QP55BkqHPusExFKyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1782887132; x=1782894332; bh=b
	44fp/Xs200vmVmERTgFd09AZSIVEJbxoZ/zLTkjWAs=; b=KH4gK04VMYiP2pLwR
	0x9WgN+0wkRQBW+gE0J4ZyalbyvhKPaSGAr1c3UqG2YKkiW5B8ELH3HIr9CXBe3N
	UQjjBRP6whm1/bfbFFamkf4sAOD7pGrqQWvYJPBn3NSiserEHozBs2EjA5I3GFBI
	VEvaP+gNWAudrlx9py8bakkizoWWV+qi7NNPJIWMEBk7/6izbZ1iOUtQwcnCZIFB
	/aqQlRI74LOsotM8lwcmH1Yw0Tv8CSz9W6J+X1v+9uiliFFPg2VX5AFAPiuJMez6
	Vd8bxd1c+PO36W6Zj5kUkNluLwp8Z4iQh1ooHvEo1wZpOs0IwOtaj8czVZu2nQ3P
	dtpXg==
X-ME-Sender: <xms:2bJEajJRWO8kVZq70X044fUeLf0f76XltHggeVJX48t491vhArm9TQ>
    <xme:2bJEah9SNFNYnnAb1J_vkZotnw3X4i1g3o8fu7TssuHiXQo5W2VjJZRgP8swVnGlz
    X4CymXicSA7ZWVxw69O8AjpeWLmZVDRxDX1oNv7x3h18SxceiNAVCYW>
X-ME-Proxy-Cause: dmFkZTF1VoUsxJAijmmlORYiQyK9Goe4LUYUDFLRIryl+jqUeZtZW3yO5gJDbpHv3EB9xX
    0aLPbAIfQieGYioCKK3co9wXz8U+shxephSBq5+VUjtIdlQEq07P/ElJPcfp3rEbsUbCW0
    l7whtRe1Yr3PnTNdRTBIZQJ9PcaK+K3csO1DgQcA8BLFNtW7cyHVxo3P2rmNk7SW0lVEt2
    /RD362A2qa/XvfS2m7DMJyFC7DMueziHirYypDh/c0u2a+Kc3xajINpZ1UwB7QSvGTZlii
    DLQiMQRnSTgxvgcLUTQzuPJ9XiTQP+uKdmA5s/je+k6H6aL16kXT8Ijk8X2Rcg/HGr+zpz
    7z/ssG2wd3dId5yDIhYXpEsbZGkwAzg/SZ2S3SltFeOeO49dDXuOHe8OVHJKD39gonqLBy
    gd2qKEm93sQu8V2hKL8wI1iRJbtjdBfWO7F9O82etnW+ff4w0qCiuMHKqZ509jgwm0ezaO
    yq2/pUblQLEf8lwgpKPFSyILpZHZRKofIJQfR5QP9emF7ID+ha6kqUuJDgzwO39OCs14te
    lNXcHj/U0d7hEDTA+yLc6mK6Os+/wuLZLhWF/Qxfba4P9Hiz42uRyERz+mVNyvqJ7pYzaM
    0WVqv/7cFLaZAEqmqZTNoBwuzXvL8ZbM9Sz3uNVKGMexSSDT9buVIexiEfkw
X-ME-Proxy: <xmx:2bJEauRPKsD8riqousolZE0WI0zXAE_JCKfx1UY3IMK9PKky9lP7vw>
    <xmx:2bJEavhFfU4kCmHPJrS1vVPtAVbhvCWvwICQzm9xJwnom6erP6Z9Dg>
    <xmx:2bJEakYaAolbEk3jQRR1gnJNxKPYk9wJisr8ue5-6jmqz4Di0prDYA>
    <xmx:2bJEarJJliJWNzjwLDjDG-UZUmdP2JUvsmN5H-BMD1reGuBdz3PGLA>
    <xmx:3LJEamxytfe7H_axgE5obOZ_MbiIy8MkZAEWJzfhzKF5EIjf7S7IGDjZ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5CAE8182007E; Wed,  1 Jul 2026 02:25:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AFAd_idRoH9R
Date: Wed, 01 Jul 2026 08:24:35 +0200
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
 "Vivian Wang" <wangruikang@iscas.ac.cn>,
 "Atish Patra" <atishp@rivosinc.com>,
 "Anup Patel" <apatel@ventanamicro.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Bill Wendling" <morbo@google.com>,
 "Justin Stitt" <justinstitt@google.com>, qingfang.deng@siflower.com.cn,
 Linux-Arch <linux-arch@vger.kernel.org>, llvm@lists.linux.dev
Message-Id: <ea525a80-1e6f-4304-a371-3ec17d91ee96@app.fastmail.com>
In-Reply-To: 
 <7988df83f6341ea045ebd7294af2e8907dbd5ee7.1782877663.git.cuiyunhui@bytedance.com>
References: <cover.1782877663.git.cuiyunhui@bytedance.com>
 <7988df83f6341ea045ebd7294af2e8907dbd5ee7.1782877663.git.cuiyunhui@bytedance.com>
Subject: Re: [PATCH v5 1/3] riscv: io: avoid null-pointer arithmetic in PIO helpers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jul 1, 2026, at 06:20, Yunhui Cui wrote:
> @@ -56,6 +56,8 @@
>  #define __io_pbw()	RISCV_FENCE(iow, o)
>  #define __io_paw()	RISCV_FENCE(o, io)
> 
> +#define PCI_IO_ADDR(addr)	((void __iomem *)((unsigned long)PCI_IOBASE 
> + (addr)))

This does not seem to have any purpose, is this just left over
from the previous version?

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
 
As far as I can tell, just adding the #ifdef here should be sufficient.

      Arnd
