Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B740B3EF0D0;
	Mon,  4 May 2026 19:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777921557; cv=none; b=GgvF+4IkxBAkazwaV4a/OTxIRuGl7FvSbyuhpu3K2vxuz7t1wb3BotQi0BZDhozX4DIhH4WJxPjy17sYO/n17ZVAvz/nxpdis1jCqp+W1agJuuYs5XVh2R+HgkfmbgHxlW8UgU7C3UVtVOODZirCWqRXFapnjjncPtpUUQ9ZFJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777921557; c=relaxed/simple;
	bh=5wu3ZqkjPvTfVjp3z80Q7450MQ06D/chbyoitbHSOI4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UR7OXtGemTlzoOJaQUfhJHg6vguvs8oZlGTsD/WlkCSaLhb/ZZEQ6KNSafePXm9ENzWTj6bUm3xk7BH0N3p7sF+XYy/R6K0Bzq2zLPEDZnwToQCJJZ5EVk1hhwy3XPhu6oZ/s4pcMKrEkZPOrYFFlsYJMrSjp+V+/X8IQxkQznw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=a0Iinxvv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RmVGq3QM; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="a0Iinxvv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RmVGq3QM"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B8FDD7A00D1;
	Mon,  4 May 2026 15:05:52 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 04 May 2026 15:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777921552;
	 x=1778007952; bh=1LQnbToEHrPoOfl2g/PxEQZpeTfQhJj3qIDyqk5cnEI=; b=
	a0IinxvvdoK8EFEijvR6HfQxxv+bDUxqXGi/EB5YQyzO+S6tdGAC0ncajJXgZ8ZO
	Asb1FTutvnSPs21Vuaj9lwnb8Pyhjj2udQ3GgYgG94wT/EjB/TdLf+RHXpUNTinp
	l6uNThX8yJGz+Cy21D/CHf3MTRmWQftwoI5tEEc/M85McRh5PDHYs/ZKhcF9dF1r
	GCuFVvsBur/sda6CqfCTQfrJ87Xpscqz1MdzctIlycpfoZP21cLQ3RUUxxchXUo7
	ed/JbewoFKEnQhlXZbsD4ulALNu9TihG6fJmwLS0/fAPGutLQUeWdIZWugcGchm4
	eDeZkErZPgufJiX+LS9OOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777921552; x=
	1778007952; bh=1LQnbToEHrPoOfl2g/PxEQZpeTfQhJj3qIDyqk5cnEI=; b=R
	mVGq3QM4P2J49KJ/2W/JkSh24bhqE2ujufRo+bMrTXeeM/0m71goO+ltkni0PTSa
	QJ0GplStOf9LinTWBL1T01csFE6rTeLduKoU4nhqsFabv1Eis2hiYoujDKisLPcg
	RmXFBHrxffoaiPBzvPoWLKuo7Pj0iiHxRb7xu9IQfdcEI1KsGuBJGmh5lDA/cbyB
	lkq5cyTm68xHVrv70VGskIKoCqLYzjyY9RfdsROwtnJBSFAkUBvJOl0dckynT71V
	AK4Q1K3Yx16aa+pWDS6L5Eh7kVzE7AOo6yyjmZ2HWZnJAJ8DiVcPrdM4H+wlk0sS
	yVEGGJ6wXPcbv5lR8Wjpw==
X-ME-Sender: <xms:Du74aUD_O_mxB3ckow7YSXdZMabHQh_VP9hyK8puuRazpQMvPxRWKQ>
    <xme:Du74aRUCbrDM73y9hOQL4Mjc-KgbjYb7pjz4LeABBGRhgaHkC-Mrv2_KbZJIrhz6M
    vKUjP_sNJJTBpfPP7bLRPZcJ8Kjp7L54S0mbXIaojtGTyDIYt7qkkEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelleeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeefhfehteffuddvgfeigefhjeetvdekteekjeefkeekleffjeetvedvgefhhfeihfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghp
    thhtohepvdehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprghlmhgvrhesug
    grsggsvghlthdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhn
    vghtpdhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidrvgguuhdprhgtph
    htthhopehsughfsehfohhmihgthhgvvhdrmhgvpdhrtghpthhtoheprghlvgigsehghhhi
    thhirdhfrhdprhgtphhtthhopehjohhhnhdrfhgrshhtrggsvghnugesghhmrghilhdrtg
    homhdprhgtphhtthhopeihuhhrhidrnhhorhhovhesghhmrghilhdrtghomhdprhgtphht
    thhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprhhurghnjh
    hinhhjihgvsehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:Du74aeZMh9v9cdoij1HMj1riYaqIZQYCh22bGoo2FUwhXdhnhMSZkA>
    <xmx:Du74aRThnIAM3MKouBt4eQVBKuI1_AdO3WgTzvSbW_T5vKnKD_c3rw>
    <xmx:Du74aWTUS-L5C8Sbdsbcp7YLjPCr_z3TMkS4Xm432XGAnnRMETdYTQ>
    <xmx:Du74ac39--YTA3Uh5flzyCuHXgGQF0iuUFFmeQMdRoq-Vh7VI0L56w>
    <xmx:EO74aQOAj7DNRjoA53HnmTNGpOCdaYUxtM323Axm1czS8pgTOPOg7p2C>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 805FE700069; Mon,  4 May 2026 15:05:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AduvTQsiZ6dJ
Date: Mon, 04 May 2026 21:05:30 +0200
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
Message-Id: <abf4a586-b675-4e29-9570-fd3ed4158f58@app.fastmail.com>
In-Reply-To: <afjmIK4mlCWeywuS@yury>
References: <20260430211351.658193-1-ynorov@nvidia.com>
 <20260430211351.658193-2-ynorov@nvidia.com>
 <ec4ed7f5-b1c8-49e4-b83d-e29c5414b9de@app.fastmail.com>
 <afjNaToyptiMogV4@yury>
 <9d45acd1-667b-4acf-9e2e-bcd79630d726@app.fastmail.com>
 <afjmIK4mlCWeywuS@yury>
Subject: Re: [PATCH 1/6] lib: include crc32.h conditionally on CONFIG_CRC32
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, May 4, 2026, at 20:32, Yury Norov wrote:
> On Mon, May 04, 2026 at 07:18:49PM +0200, Arnd Bergmann wrote:
>> On Mon, May 4, 2026, at 18:46, Yury Norov wrote:
>> > Never heard about such a thing like "optional interface". And git grep
>> > tends to second that...
>> 
>> I meant any library interface that can be turned on or off
>
> So? If I disable CRC32, can I use the either_crc()? In case of that
> networking header, the answer is yes. In some other piece of code
> the answer is no. Is that correct?

Since it's a macro defiend in terms of both bitref32 and
crc32_le, you can only call it from dead code, such as an
inline function that is not itself used, or from inside of
a block that is protected with IS_ENABLED(CONFIG_CRC32) etc.
  
>> >> 
>> >> Don't add #ifdef blocks around headers. If the header cannot
>> >> be included without side-effects, change the linux/crc32.h
>> >> file instead of its users.
>> >
>> > linux/acpi.h does that like many othes. What exactly is wrong with
>> > protecting headers inclusion?
>> 
>> There is no "protecting" here, you just add complexity to the
>> build when headers are sometimes included indirectly and but
>> other times are not, depending on kernel configuration.
>
> Sorry, don't understand... I use the 'protecting' term with the meaning:
> the functionality that is explicitly disabled should be never used.
> Otherwise, what for we disable it?

Arguably, both configuration symbols are at the point of not actually
saving enough object code size to actually be worth the Kconfig
dependencies.

As long as we have CONFIG_CRC32 and CONFIG_BITREVERSE, the
point of having the Kconfig symbols is to let drivers request
the inclusion of the library helpers.

>> It's unlikely to cause problems for the crc32.h header, but
>> the acpi example definitely risks running into circular
>> inclusions when you end up with some other header that depending
>> on configuration ends up including linux/acpi.h while also
>> bring included indirectly from that one.
>> 
>> >> It looks like the problem is the check for CONFIG_GENERIC_BITREVERSE
>> >> in include/asm-generic/bitops/__bitrev.h, which ends up
>> >> hinding the generic___bitrev32() helper without need.
>> >> 
>> >> Simply removing the #ifdef there should avoid the build failure.
>> >
>> > OK, it seems like this is what I don't understand.
>> >
>> > We've got an optional feature, like CRC32, which is enabled by
>> > CONFIG_CRC32. The most conservative way is to declare everything
>> > CRC32-related in the corresponding header, and then protect the header
>> > with IS_ENABLED(CONFIG_CRC32).
>> >
>> > I understand that from practical perspective, we can declare some simple
>> > macros, like header size, unprotected. But what we've got now is a sort
>> > of mess: all CRC32-related functions are declared unprotected, and
>> > generic headers are good to use them. Compiler is happy while those
>> > functions are actually unused. Next, CRC32 depends on BITREVERSE, which
>> > is again unprotected, and it may optionally have an arch implementation.
>> >
>> > So if arch bitrev() is implemented, you can use part of bitreverse and
>> > crc32 APIs despite that they are explicitly disabled - just because they
>> > are implemented as macros in unprotected headers. And you cannot use some
>> > others - because they are implemented differently, as a real functions.
>> 
>> I think you trying to solve a non-problem here.
>
> This was reported by Nathan for tinyconfig. At least x86 and s390 are
> affected.
>
> https://lore.kernel.org/all/20260429202922.GA3575295@ax162/
>
> Is tinyconfig important?

Nathan reported a build regression caused by a small mistake
in 596a9ea9015b ("bitops: Define generic __bitrev8/16/32 for reuse"),
which is of course needs to be fixed.

What I meant is that there is no reason to not use the obvious
fix and do

--- a/include/asm-generic/bitops/__bitrev.h
+++ b/include/asm-generic/bitops/__bitrev.h
@@ -2,7 +2,6 @@
 #ifndef _ASM_GENERIC_BITOPS___BITREV_H_
 #define _ASM_GENERIC_BITOPS___BITREV_H_
 
-#ifdef CONFIG_GENERIC_BITREVERSE
 #include <asm/types.h>
 
 extern u8 const byte_rev_table[256];
@@ -20,6 +19,5 @@ static __always_inline __attribute_const__ u32 generic___bitrev32(u32 x)
 {
        return (generic___bitrev16(x & 0xffff) << 16) | generic___bitrev16(x >> 16);
 }
-#endif /* CONFIG_GENERIC_BITREVERSE */
 
 #endif /* _ASM_GENERIC_BITOPS___BITREV_H_ */

> Right now half CRC32 is available if CONFIG_CRC32 is on, and half is
> not available. The bitreverse is the same. If HAVE_ARCH_BITREVERSE is
> enabled, one can use the API, bypassing the BITREVERSE. This doesn't
> sound right to me long-term.
>
> Whatever this ends up, let's figure out a consistent solution please?

I really don't think we need any sort of solution here, aside from
the trivial regression fix that returns it to the previous working
state.

      Arnd
