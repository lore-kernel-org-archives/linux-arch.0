Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F705363C45;
	Fri, 24 Jul 2026 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784907102; cv=none; b=irFtR8Zy7J469VcK9BqzI/R04d2K14EVgLCfbB2c2Wqgb2MekrGS7vHGNCJzHIIjbbx/g5mZidI3+l5oIVLQhTXaHVODFd+NXKEPFuF47bkGg0WpwSuk7OX4BKn/ScgJkcoZBbqPt4jW0UtoTs3iilvzlcZA1MJfMQGJVJ2YsHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784907102; c=relaxed/simple;
	bh=3vfJjZVPSChpqj5TExkyw5xP8q/mwEg+7w0xWD/COsU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oABiI2nY+k1TfRSIWMlG3TKh8axIzGMFG0c6tsyijsEYV2h+jinLDm0Arkjrb4J02wIDczgrj+7oW5EQWKorXPcF2KPS2vCWhbEbBKiLX4gwSpeEP0BqPDHhFtOJKtyzCiLBqxLco9CdJdYcyU9aw2ZyuZlylMKwMEekp46ymZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ErvYL8qo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RRJp8/GZ; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ErvYL8qo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RRJp8/GZ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 04CE67A01AA;
	Fri, 24 Jul 2026 11:31:38 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Fri, 24 Jul 2026 11:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784907098;
	 x=1784993498; bh=3vfJjZVPSChpqj5TExkyw5xP8q/mwEg+7w0xWD/COsU=; b=
	ErvYL8qoP8oUDTFaDLU8tI3pwp2fbfDBmOI4VztEaLQ2QEHjFNdZU+SUUDjULhEY
	am5EzSSG7baefA3tcpfyYreZ/F8vIT86jP+sFehceUqy2SJHWdt4/oTVthiS2GGy
	UEGFiDKBRIkzzIPLgkY810PeJXknmDhLhV5ZKYAZKorkGu/C+IQwMh98dwNNwGKj
	hZWwdqPjir3RJbtr/DV4n7alrGfvXO3U3rqSKD8dbw2NahJjOs0lgCnks2/aN577
	cB/1Sh3EEEEt9MEvD5z/C0rNgfg53+zhcH1nlLEyGNVB48WT12cA56V548fQ8dKd
	YFGuCDdt9PPAsiGLKEbHNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784907098; x=
	1784993498; bh=3vfJjZVPSChpqj5TExkyw5xP8q/mwEg+7w0xWD/COsU=; b=R
	RJp8/GZGpTp8w5KGbl4v5px2xtj2cmz2P+h2s2Au5oTVxJ/q212tDX7NhwwDJ85H
	+5K0LDmGiiNZIxdIkpsfk5GFWRpUNVCS4l3+XbgdVQzrjm3zigMn1iOIQaVYHrBa
	28d+irOOCQsbvvknCSO+zQYX+Kt3cKS2wOdAEJP3wpT9zKI/hoTwHgnaZQFy3XWw
	uVT8/RiWXDMOAnf0i3yEJVLgf/8YaIve783hEdtpVAVbj5UaimDx4Ru1DTTw7odf
	QabDeh63KP6pzDxfoQO6XMHzYL2gY5wNEh4mGcW+uURCUF3qbV4lZrCziOurnLgR
	RF5jmWR95MjI+PF1a1/zw==
X-ME-Sender: <xms:WIVjaoMeZRxjY5bhFBOBWmlHG6ryjne8vXF0q78JviE_k_Yzh_bTEQ>
    <xme:WIVjapyDyoatqQ2ELfinOdCF8oWERE1mjL2qje7VysX1YPs5FYApJ5gD1L79LDYcE
    VPHkdVKHtFJzS2aGc8Q2ZCjab2_GgQsVL1tmVzaybl3Rq-rqEK22Kw>
X-ME-Proxy-Cause: dmFkZTGUoMZeRv1CErRkfeBPbMV1zTc4GCIEyN8fVdYFXLX60g5GMZlj3zKIzYphbBR61q
    t12qx/D8MHIqsVPkvVWyYh31aaALiE0u8vWrXr3FD/ltDH0kAyzwfIOHjyijKSArzUVtZY
    8nIJtPxuiL402lrYG0fbV5jkyL/xXphaUUUVTxJWW7Q4z75gpXX2BDtYWisCQttVAkD1Xx
    f6iLRkLRISTpO6qoDClrKGA6L27Rafr7YecBtVsSxjv8BWlfEQ1AL7wICbnhlw8GFrex6j
    Pcu6KqOK9tctCyP89uFpxQ3QJJXPYnX1oBgJweECfBLVNr34uoNyU2f7gKPM1c/KbasAW+
    N4UAJ+fbN3tlEi5CP6DDGfFT3fa825G87A0wC9N6w7BTkNFWwcW0s6fLeUsGSI7tw8vC+e
    G8uGD8qGYwFQ2Kg80V8/0xpLLtMyUfsFelWKgx8561DU8K2YmVkuLVIOYwLfJWiVrUCymH
    SflXW0VnNAoNzyuQPkabsLyUQYh/nl9FHzRhUPR0Y408txF6bCZTgVe51ibpgIXpM/5S5U
    Dj4qBlXRfs/r+98TiVA7NosVQFMTrd/jp77FE8u6CIyZI2BAdHNY7NFktn7TfNd4aG653p
    SCNzy38nvbPemWoQAPz/OEk5xqiGY2TGyHlY1uj3SbsgVnBKjbnUpqNp/kdA
X-ME-Proxy: <xmx:WIVjalFRGj7JxirhjZDe9KLcu5Xn5ivxide2IRo0GkVjaxBVjy4xZQ>
    <xmx:WIVjameUkaNJUflcOuiwAcVQmXH135bqC2lfXK2LtN5tRm1HNIPRLg>
    <xmx:WIVjai8Gj7l17gQgdOatrbcI06coU86J5NzJ9_9C9C1-W-pwBcnEnQ>
    <xmx:WIVjakZ3JIrX6CeyjtVXveFoTCXzizBWVjL41Rr8I7OBf_fe9ik0Lg>
    <xmx:WoVjarG3AdLWIsoF6n_Q4ZDtrbtteDWbEnfdoMgyaA4VEcS7cRxMLh_p>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D2B38182007E; Fri, 24 Jul 2026 11:31:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ALwDRP4astFJ
Date: Fri, 24 Jul 2026 17:31:16 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Andy Lutomirski" <luto@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 "Nathan Chancellor" <nathan@kernel.org>, "Nicolas Schier" <nsc@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Daniel Lezcano" <daniel.lezcano@kernel.org>,
 "Mark Rutland" <mark.rutland@arm.com>, "Marc Zyngier" <maz@kernel.org>,
 "Paul Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>,
 "Huacai Chen" <chenhuacai@kernel.org>, "WANG Xuerui" <kernel@xen0n.name>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 loongarch@lists.linux.dev
Message-Id: <180dc66e-f755-4b50-a6ab-65398850890c@app.fastmail.com>
In-Reply-To: <20260724-vdso-arch-clockmodes-v4-2-ddbe447be860@linutronix.de>
References: <20260724-vdso-arch-clockmodes-v4-0-ddbe447be860@linutronix.de>
 <20260724-vdso-arch-clockmodes-v4-2-ddbe447be860@linutronix.de>
Subject: Re: [PATCH v4 2/7] vDSO: Make clockmode constants available without
 CONFIG_GENERIC_GETTIMEOFDAY
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026, at 15:36, Thomas Wei=C3=9Fschuh wrote:
> Some code, for example clocksource drivers, may want to use the vDSO
> clockmode constants even when CONFIG_GENERIC_GETTIMEOFDAY=3Dn.
> But the symbols are completely hidden in that case, making ugly
> ifdeffery necessary.
>
> Always provide the enum definitions.
>
> As not all architectures provide asm/vdso/clocksource.h,
> provide an empty stub in asm-generic for it.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>
