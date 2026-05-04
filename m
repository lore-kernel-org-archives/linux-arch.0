Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3813F3090D7;
	Mon,  4 May 2026 08:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777881815; cv=none; b=GRAEZrve5PKYcc7AcBQqCpLkG74N64ayGIqCf82EvEKh5zdXaAIpTQil5++CeiMkKpQZUMAmPgaLykn8nuxhawKiS3pjDs57XKVpqVcAi8T9GMcSTZcD7q7tmu7zVzKk54BKReCUXGm21YXnQByc22kGlyeFv73snmd35WGmZs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777881815; c=relaxed/simple;
	bh=85KGlEIKITdOlWoiiVxvYUZbQ1nS1XmOFsk2A93rDas=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=q9pB6kjPcvVB4KXX8hcMxDybmM7bKfwl7k60BEZ7cx20Uq2Q51BQaPbtsMj00nu+VCggrVZNfcIEkY5clD20sTVcZ3o6TM1J1DNi9rETgievdxkCOWdW9h63FsR572VWjNmMDWPAtk7D5Fy91gML4wZYmDcFkAqPuE42ehJL84E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=lKIQozwE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WjdGsF4l; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="lKIQozwE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WjdGsF4l"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 6C2D7EC011A;
	Mon,  4 May 2026 04:03:32 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 04 May 2026 04:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777881812;
	 x=1777968212; bh=lRsobUL6Yqd5naNkEfLWDCbqmttFKUBjkDP0RSCMYno=; b=
	lKIQozwEzFcnuVHJBHQ8r+b5oT97obr68Nf8luMuM3L6O5raCOhhUY7Gctoc1Tp8
	629KHqe8wadhboVSnp1pfYRpNmc+pZFNyYU2mpbW7M44o6VsakgiDSDF58QBnZ/3
	Dd9pzdJUeabis3j6EQvltT0CjZH22hQT5XhkNdF8dWHnvjTSZ5VfKpv8fFimENov
	y2OBPInLOxFUOFKOPP23zqPiM6Xvy5WtUk1iqfX92udoVLSVv+/NSGC8fBHcdL34
	kNewsRgHuStBFHX0paWLj+tG4PMjqZpZnThCSW9mR0nkKphUBaakjPL3G6X4XzOR
	sxsvI2tnrlNp4u4Y/z/Uvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777881812; x=
	1777968212; bh=lRsobUL6Yqd5naNkEfLWDCbqmttFKUBjkDP0RSCMYno=; b=W
	jdGsF4ltkHFNmq4MXhLG7F9XwWgGquAASSnmd6Fq8+oajRxrbhR3fa1qAIKOUp6W
	dz7xegS3ZIzYHyXjL/vCt6mOhMYDrDuAeDbXahTA2ce6HwaHuXFChrssQdGXTdxg
	ASXkoguUZsTFwE5CuZfGLN4oZchI1xBKCYhv6yyMWLFHhoPk8GQ4LJ5j4JaAfNqg
	z7I+qjcYP9OcdQESVckBq+8S86XCu0Awvx1iamWM3zqhSeIYTlj4VSN2gHrxbps0
	1Ms2cGh4aVk79gTiXDdVzyKDoiA721QeovwvOxsqhSeNFyjNsk734G/FtEoFNW94
	jEaf2B4dgR/JL3witKL4Q==
X-ME-Sender: <xms:0lL4aR2L0rD3fWiyNVDOAkvHSrIlIVgK7WgBt5qGs_zUs8aj_oHPMw>
    <xme:0lL4aS4d7LLhmWZPmmqNI-uWQTdk3frrl8Hg52cxJA3YYwV50unHO5OE1dJewfCJI
    Ko-eGJUCsgRPHN7n1uj2hZUa5YYdBsN4955qUHj3NcpB41Loa17Uh0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelkeefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedvhedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtohepug
    grvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrohhusegvvggtshdr
    sggvrhhkvghlvgihrdgvughupdhrtghpthhtohepshgufhesfhhomhhitghhvghvrdhmvg
    dprhgtphhtthhopegrlhgvgiesghhhihhtihdrfhhrpdhrtghpthhtohepjhhohhhnrdhf
    rghsthgrsggvnhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohephihurhihrdhnohhroh
    hvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdr
    tghomhdprhgtphhtthhopehruhgrnhhjihhnjhhivgeshhhurgifvghirdgtohhm
X-ME-Proxy: <xmx:0lL4aRNeIpiqXc5fB1MHgBXrEJ9lZQQEpD-B8lPFp6wgoeLl-5ZA4Q>
    <xmx:0lL4aT2fjft0esTMjzTU1zcrFbzA-_AFE7_VP8BpUHgzkmYgKHRnUg>
    <xmx:0lL4admhcWGT28uCEY5xSJDz_pBSgWnQV3r2LytJJkg8HARZKaDyFg>
    <xmx:0lL4aZ6Wh97kTjE3ydg7__JVwDupqwjhpu_1wCpVBBAEliM3JtcswQ>
    <xmx:1FL4afDExJRXBh0UiKSRKS_WkzSEFtnYN1B_2siySxbqJTYh84FcyA8z>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B4B35700069; Mon,  4 May 2026 04:03:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AduvTQsiZ6dJ
Date: Mon, 04 May 2026 10:03:10 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yury Norov" <ynorov@nvidia.com>, "Paul Walmsley" <pjw@kernel.org>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Alexandre Ghiti" <alex@ghiti.fr>, "Yury Norov" <yury.norov@gmail.com>,
 "Rasmus Villemoes" <linux@rasmusvillemoes.dk>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>,
 "Stanislav Fomichev" <sdf@fomichev.me>,
 "Ruan Jinjie" <ruanjinjie@huawei.com>, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Linux-Arch <linux-arch@vger.kernel.org>,
 Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org
Cc: "Nathan Chancellor" <nathan@kernel.org>
Message-Id: <ec4ed7f5-b1c8-49e4-b83d-e29c5414b9de@app.fastmail.com>
In-Reply-To: <20260430211351.658193-2-ynorov@nvidia.com>
References: <20260430211351.658193-1-ynorov@nvidia.com>
 <20260430211351.658193-2-ynorov@nvidia.com>
Subject: Re: [PATCH 1/6] lib: include crc32.h conditionally on CONFIG_CRC32
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Apr 30, 2026, at 23:13, Yury Norov wrote:
> Currently, bitreverse API is either declared based on
> CONFIG_HAVE_ARCH_BITREVERSE, wired to arch implementation, or if the
> arch has no bitreverse, based on generic implementation.
>
> So, regardless of CONFIG_BITREVERSE=n, the corresponding API is always
> declared. If that happens, the functions become declared but not
> implemented, which is an error.

I'm not following that description. Why is it an error to declare
a funtion that is not implemented? Isn't that how optional interfaces
tend to work in general?

> The only header requiring the crc32 and bitreverse prototypes is
> include/linux/etherdevice.h. Thus, protect inclusion of corresponding
> headers in the etherdevice with CONFIG_CRC32, together with the only
> function depending on it.
...
>  #include <linux/if_ether.h>
>  #include <linux/netdevice.h>
>  #include <linux/random.h>
> +#ifdef CONFIG_CRC32
>  #include <linux/crc32.h>
> +#endif
>  #include <linux/unaligned.h>
>  #include <asm/bitsperlong.h>

Don't add #ifdef blocks around headers. If the header cannot
be included without side-effects, change the linux/crc32.h
file instead of its users.

It looks like the problem is the check for CONFIG_GENERIC_BITREVERSE
in include/asm-generic/bitops/__bitrev.h, which ends up
hinding the generic___bitrev32() helper without need.

Simply removing the #ifdef there should avoid the build failure.

> +#ifdef CONFIG_CRC32
>  /**
>   * eth_hw_addr_crc - Calculate CRC from netdev_hw_addr
>   * @ha: pointer to hardware address
> @@ -291,6 +294,7 @@ static inline u32 eth_hw_addr_crc(struct netdev_hw_addr *ha)
>  {
>  	return ether_crc(ETH_ALEN, ha->addr);
>  }
> +#endif

I see there are only user users of this function, neither of
them are performance critical. So the other options would
be to either open-code this function in the two callers
and remove it entirely, or move it into net/ethernet/eth.c.

      Arnd
