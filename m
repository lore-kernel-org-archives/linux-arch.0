Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4DB34CFDD;
	Mon,  4 May 2026 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777915191; cv=none; b=lYn01yCMyyP2ohqK++/4jPcSfesyZ1jMSHr8hJwq6Oc7E6z6dZunGPaNsvpTf+CUVjWy04gZmKX/EDNu8OShVsyRUfyv31xse8pyC3Z0XMyx5XHWwfLZdVG9vFUZskt98mtvuLvZFW8E6yuV70vZQYYfmN07359+ubS7LuFxiyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777915191; c=relaxed/simple;
	bh=lICNTNrFPr4USG5uODYfiY/UKX7d8HIgK8u4F6i4kbs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=AzxLlhR7zfS7W5vrRmoHpE19kyw3wyJuxJQUDO1/Ci7NwsD0HkBPUQL5GBhy5Gz7nKTk6fr85Ge5zUaGFQ82lyz6n+Oi1uYcXfBPEWKNxVSXBEQFF8aAOis9qgVcE70IvlkFG4r0nDVTR2XInc52C7MPZSBe42YRNSx5Tnl0VPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=HLg1jwQv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UDtc9tn6; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="HLg1jwQv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UDtc9tn6"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 332E21400147;
	Mon,  4 May 2026 13:19:48 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 04 May 2026 13:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777915188;
	 x=1778001588; bh=WGiGQOyaGwv7FZl7+rlUdXd7BeeldqbKfQtj/iAX1Jk=; b=
	HLg1jwQvS7ZqlJFtylk993phBsLKxPz1nfazf6HxZeaWoWl/6knObNVwP2eHZJ40
	EVfvcYQTzYsoKDJ/p88ljBbm7QgQdUOotOOh8jFnGmwTZ0ef6BA+P+7sDTOIAsli
	S+TfshxGfBYO1Bzw0Rbsvh8ZsvgYwNhWGkyfGsuJCQteQiZealS4+2tYNY6Hibwv
	+F7qZ0wjYeIeeDZY75zVqlgrt5D9QSlNxj5u7hQx8kAL5qzh0KXwQvHIouGz0KiA
	1Wty3n+RBqCtH7whK2b2GJB+Xzx06v8P4xNBo9Nfp5umtQFUPcSjq+SGmKAqn/af
	SJAq62TWugmGb3Y35H8TUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777915188; x=
	1778001588; bh=WGiGQOyaGwv7FZl7+rlUdXd7BeeldqbKfQtj/iAX1Jk=; b=U
	Dtc9tn6Jt4JrSgcx2thtneOxZKhtGBS7DLH+qF+Ons3aXAJzunC6LTZkYPS3Cg9Y
	t2VqqdEgb+8zUgQENZL3mwdzYQ4cZDMu5Zr04CJ+oSCdjEW9/VZScV1BLpEps58z
	lleLsjqjrKscIzFCWRMOg2w85AhaUlBXiYjHWudNrQ8HyPqJ6Ht3419uPKronioz
	GP5yQYqme8aAItTqYlz5qjmunTWoESF4Ix+6g7zlczXIKT9ZZeDRWXLWOWhEuDjn
	jX2sBuFVh+jxAYt5ML7Lcu0GzdLK8AMLHi1gJw0vjPnMirk5BzznumjCI66Lfs+L
	w1bi66cb5PAaMhb4hnLug==
X-ME-Sender: <xms:MdX4afa1pBs5uEG_t3f12Z-gE9HTxgmzMUZycLEed8FWRbVzrWLicQ>
    <xme:MdX4aZNR866_s47xDdRjNjZVK1LgNhJm-z3o2QH-xJ7qzzUn8VAxXdnR0MfZwB7fi
    pkRJeLANLJJBDdvCQumEy3VqJNiQQ3S9QCadfgAOfSwfj8SsxLpz2OV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelleegvdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:MdX4afzHdMEtgThUZaAWI6SFPmBNRmeC1NRAxO4cXWsioEaIeremRA>
    <xmx:MdX4aXINmE_2brig3dXmo6YXPUC02VALRoMOVz6BP2wKMlZyJoF9WQ>
    <xmx:MdX4aWoswhdJLUXWit56efNJntJjmZMcBrEvsiFN9rA5dPuiAecUCQ>
    <xmx:MdX4aVvc_FbpGTK9ef68zBUtvGYiu-uzO1xgMmjMDNfjpVvSmayyEg>
    <xmx:NNX4adZkAFqLSMqD_KSGzTMioWXpn0lYpHN-tV27TAbnGDgwhv0TrZv8>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D122270006A; Mon,  4 May 2026 13:19:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AduvTQsiZ6dJ
Date: Mon, 04 May 2026 19:18:49 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yury Norov" <ynorov@nvidia.com>
Cc: "Paul Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>,
 "Yury Norov" <yury.norov@gmail.com>,
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
 Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
 "Nathan Chancellor" <nathan@kernel.org>
Message-Id: <9d45acd1-667b-4acf-9e2e-bcd79630d726@app.fastmail.com>
In-Reply-To: <afjNaToyptiMogV4@yury>
References: <20260430211351.658193-1-ynorov@nvidia.com>
 <20260430211351.658193-2-ynorov@nvidia.com>
 <ec4ed7f5-b1c8-49e4-b83d-e29c5414b9de@app.fastmail.com>
 <afjNaToyptiMogV4@yury>
Subject: Re: [PATCH 1/6] lib: include crc32.h conditionally on CONFIG_CRC32
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, May 4, 2026, at 18:46, Yury Norov wrote:
> On Mon, May 04, 2026 at 10:03:10AM +0200, Arnd Bergmann wrote:
>> On Thu, Apr 30, 2026, at 23:13, Yury Norov wrote:
>> I'm not following that description. Why is it an error to declare
>> a funtion that is not implemented? Isn't that how optional interfaces
>> tend to work in general?
>
> Never heard about such a thing like "optional interface". And git grep
> tends to second that...

I meant any library interface that can be turned on or off
 
>> > The only header requiring the crc32 and bitreverse prototypes is
>> > include/linux/etherdevice.h. Thus, protect inclusion of corresponding
>> > headers in the etherdevice with CONFIG_CRC32, together with the only
>> > function depending on it.
>> ...
>> >  #include <linux/if_ether.h>
>> >  #include <linux/netdevice.h>
>> >  #include <linux/random.h>
>> > +#ifdef CONFIG_CRC32
>> >  #include <linux/crc32.h>
>> > +#endif
>> >  #include <linux/unaligned.h>
>> >  #include <asm/bitsperlong.h>
>> 
>> Don't add #ifdef blocks around headers. If the header cannot
>> be included without side-effects, change the linux/crc32.h
>> file instead of its users.
>
> linux/acpi.h does that like many othes. What exactly is wrong with
> protecting headers inclusion?

There is no "protecting" here, you just add complexity to the
build when headers are sometimes included indirectly and but
other times are not, depending on kernel configuration.

It's unlikely to cause problems for the crc32.h header, but
the acpi example definitely risks running into circular
inclusions when you end up with some other header that depending
on configuration ends up including linux/acpi.h while also
bring included indirectly from that one.

>> It looks like the problem is the check for CONFIG_GENERIC_BITREVERSE
>> in include/asm-generic/bitops/__bitrev.h, which ends up
>> hinding the generic___bitrev32() helper without need.
>> 
>> Simply removing the #ifdef there should avoid the build failure.
>
> OK, it seems like this is what I don't understand.
>
> We've got an optional feature, like CRC32, which is enabled by
> CONFIG_CRC32. The most conservative way is to declare everything
> CRC32-related in the corresponding header, and then protect the header
> with IS_ENABLED(CONFIG_CRC32).
>
> I understand that from practical perspective, we can declare some simple
> macros, like header size, unprotected. But what we've got now is a sort
> of mess: all CRC32-related functions are declared unprotected, and
> generic headers are good to use them. Compiler is happy while those
> functions are actually unused. Next, CRC32 depends on BITREVERSE, which
> is again unprotected, and it may optionally have an arch implementation.
>
> So if arch bitrev() is implemented, you can use part of bitreverse and
> crc32 APIs despite that they are explicitly disabled - just because they
> are implemented as macros in unprotected headers. And you cannot use some
> others - because they are implemented differently, as a real functions.

I think you trying to solve a non-problem here. It is extremely rare
for any kernel to be built without crc32 or bitrev. Even in randconfig
builds, both are usually selected by some driver. The behavior
we've always had here is that in the rare one randconfig in 10000
that hits the one driver missing 'select BITREVERSE', we get a link
failure with an obvious fix. If you add the extra #ifdef, it gets
a little more likely to actually run into the bug, and it shows
up a little earlier as a compile failure instead of a link failure,
but otherwise, nothing changes.

       Arnd
