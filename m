Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAB93A7F4E
	for <linux-arch@vger.kernel.org>; Mon,  4 May 2026 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777898605; cv=none; b=DvYmBV43Kx7qj2mZ6YgpjiBDIX54JdrddKbq5fo31lNqlGhrhoNYoqe9SfvPS3qChQVEqewG698lI3YpoEsIzMLgW437dhpKoaByvNjbJ0Z3klfvRsRjlzjUiZ02AT/K9+u5dF+HewXiEs47zUTTY643ivl6jk3lFQMcoJFn75o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777898605; c=relaxed/simple;
	bh=jWGoglP6jmcwlrHvt1gQ9/+zWIwt0vegzHr25BbK6cc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TS78XL6/qlxkjzp7ffmmRWonZHI0Tu4rkFuHeN/yiT8eXMdZVo8hx70rm84fpcuOfBorPhRoxWV5PyQmmuY9N27SeEYZzB8DvMDFQx2/IjppkaqrENt1OJCGXGNUrz32fv4DZm4PPtFEh4cFcAXy5LtmG/WTqNRWGgOJauUiajc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvLtTlsJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvLtTlsJ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so53650385e9.0
        for <linux-arch@vger.kernel.org>; Mon, 04 May 2026 05:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777898600; x=1778503400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ufm/8wyV7h2cWwxL5F4jbAArsiyVqXQndXIOjfMIX4=;
        b=XvLtTlsJ9uh3K33svRXL/rWcr2sD5q3Xga6b5UTIeCDK0LNib8hVKkfBTGtUmww0/M
         WoKK8s8TQdmUbdOxi8ywztkLLraGkG1nG+bUb5ZASV5SwteD8gFcQs8+2K6vDMXpOOok
         klki9QE/d2fWuF8JQcIHyyMjxdRdS4KTQB9gSrYmpvSc6o90dKvqDW584M/CjZxa+8xB
         LG2mgEB7bUGvJ3XUx2+cCKLgauyRDQyHHsq9HHlU+/63Klhep0rDOgo7cMrsuzP9ZAw9
         lHYItr+KtzOk/AQeaU6GxYZA4zLPGwN/BXSgogNGA51dQBxgN/F0YEykHtwtR7ygbykd
         hjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777898600; x=1778503400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+ufm/8wyV7h2cWwxL5F4jbAArsiyVqXQndXIOjfMIX4=;
        b=SYvjpg9Ka/4VNQU/8Gq2CIVHyOnbGIlVb4N+kwpo1Ga52eBdjc4XGVBnBinzFh1+iq
         E53Ie3XAYWpBDipf52uzA6rAYBvJ1KCqT+VPGRlyndnLOUHvO50PRhEzWD+QvarkPS2l
         7D9uRLnvwRWMLtF0iIJdWWz+6SOeRGA8xM5CjflzO4mtOGGvgAzYcfAwr01l3ehBujS7
         VpZjvif5tpgewIEyklT6a6szl45aAMHPDHUiSr1Hz+/z22obgmr+2F1PDP7r4ogtrbxZ
         cILQb+uvtI3lAzpKSH0urG6MW+23n4US+g6CGQWi4oZW2eCaARtZSs9LLivKJhoraE/3
         3c8Q==
X-Forwarded-Encrypted: i=1; AFNElJ9cwBn6351xgp3ucBxATf3lQhd30olDzi1HXpwTPmZ4CNQ4nNpBb4XTGhD0eR/HSjSFmUqu4/+xRRVW@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvn4FwDI3gwNaPvV6ryDOHFAt0TyCtngVoGLZddAhkZVzto/ir
	8AyfWiVRu3vGG80klAY62+ZaTcTP30WgIK1uDSkw4WSfeU9iWKapQmrf
X-Gm-Gg: AeBDievxt3Cg0+b49+27KT+Np8f/GCku8+sf46aA95AydnsP/BZbl8okREDQNu99Pco
	ImV2p2CO/Q+I11c9J8jSFqEwSSTBRCLmL/70Iv6RyjzH0fxZuE4nLgpZVN97/yOnXliU71Aiey8
	jdupJJQldLiOPQTzr+SJoGLgnHxIDiT1v9ZF0+g/2G4yrRU16KZgEdt+K7VHnJNxAb2cwUuzSHO
	sEmhY2jbkCmELerrdiyFbYM6emZmfpptn7ipm+3aJnSY5K/Euj5xCepJUzjSstSi6yZmCIqLIAz
	BbsxeO7RfT88jHUax+6UV3sP7HxbygAlFKTV7BJuPPgje2azvnbswvKhta3GYlCuthXlFDYQSe3
	+2rHFrLwolzk93zJtoYwVCG7z1GuxJVcIXwGCAHRQoru6ZxDSuzxq93wAlWpSQBTDJ5HZ9jFbKJ
	KjNNW1kiplGxqzB8MSZnXRQOqVWDw3Nh4cmm3QHg+lzwP+7WhyGc7b8oYlD1IuGZbuljx/eTFSU
	pQ=
X-Received: by 2002:a05:600c:a411:b0:48a:7b55:12a6 with SMTP id 5b1f17b1804b1-48a980fc3e7mr112517875e9.0.1777898600087;
        Mon, 04 May 2026 05:43:20 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fef2a67sm111207925e9.5.2026.05.04.05.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 05:43:19 -0700 (PDT)
Date: Mon, 4 May 2026 13:43:18 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Yury Norov" <ynorov@nvidia.com>, "Paul Walmsley" <pjw@kernel.org>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Alexandre Ghiti" <alex@ghiti.fr>, "Yury Norov" <yury.norov@gmail.com>,
 "Rasmus Villemoes" <linux@rasmusvillemoes.dk>, "Andrew Lunn"
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Jesper Dangaard Brouer" <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, "Ruan Jinjie" <ruanjinjie@huawei.com>,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Linux-Arch
 <linux-arch@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
 bpf@vger.kernel.org, "Nathan Chancellor" <nathan@kernel.org>
Subject: Re: [PATCH 1/6] lib: include crc32.h conditionally on CONFIG_CRC32
Message-ID: <20260504134318.6eae8193@pumpkin>
In-Reply-To: <ec4ed7f5-b1c8-49e4-b83d-e29c5414b9de@app.fastmail.com>
References: <20260430211351.658193-1-ynorov@nvidia.com>
	<20260430211351.658193-2-ynorov@nvidia.com>
	<ec4ed7f5-b1c8-49e4-b83d-e29c5414b9de@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 04 May 2026 10:03:10 +0200
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Thu, Apr 30, 2026, at 23:13, Yury Norov wrote:
> > Currently, bitreverse API is either declared based on
> > CONFIG_HAVE_ARCH_BITREVERSE, wired to arch implementation, or if the
> > arch has no bitreverse, based on generic implementation.
> >
> > So, regardless of CONFIG_BITREVERSE=n, the corresponding API is always
> > declared. If that happens, the functions become declared but not
> > implemented, which is an error.  
> 
> I'm not following that description. Why is it an error to declare
> a funtion that is not implemented? Isn't that how optional interfaces
> tend to work in general?
> 
> > The only header requiring the crc32 and bitreverse prototypes is
> > include/linux/etherdevice.h. Thus, protect inclusion of corresponding
> > headers in the etherdevice with CONFIG_CRC32, together with the only
> > function depending on it.  
> ...
> >  #include <linux/if_ether.h>
> >  #include <linux/netdevice.h>
> >  #include <linux/random.h>
> > +#ifdef CONFIG_CRC32
> >  #include <linux/crc32.h>
> > +#endif
> >  #include <linux/unaligned.h>
> >  #include <asm/bitsperlong.h>  
> 
> Don't add #ifdef blocks around headers. If the header cannot
> be included without side-effects, change the linux/crc32.h
> file instead of its users.
> 
> It looks like the problem is the check for CONFIG_GENERIC_BITREVERSE
> in include/asm-generic/bitops/__bitrev.h, which ends up
> hinding the generic___bitrev32() helper without need.
> 
> Simply removing the #ifdef there should avoid the build failure.
> 
> > +#ifdef CONFIG_CRC32
> >  /**
> >   * eth_hw_addr_crc - Calculate CRC from netdev_hw_addr
> >   * @ha: pointer to hardware address
> > @@ -291,6 +294,7 @@ static inline u32 eth_hw_addr_crc(struct netdev_hw_addr *ha)
> >  {
> >  	return ether_crc(ETH_ALEN, ha->addr);
> >  }
> > +#endif  
> 
> I see there are only user users of this function, neither of
> them are performance critical. So the other options would
> be to either open-code this function in the two callers
> and remove it entirely, or move it into net/ethernet/eth.c.

Or change to a #define so that only the users need to have the
required headers included.

But open-coding in the callers saves anyone trying to read the code
having to look at another file to see what is going on.

-- David

> 
>       Arnd
> 

