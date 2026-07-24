Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C7236A364;
	Fri, 24 Jul 2026 15:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784907379; cv=none; b=OBou+SGWKm7zQnfoGzbXXW0xZBhRf3+N+S31IDiq8Nhpnk/4hmjVGwgPBuK/TKq1qxn9Dn/1G6EME11/T7A4GMiXLIJkBFHfU+8OoIgeWNCQPSSR3Yc28ChG35QeMo/NkWe5sww6KlJCfuxD6N3dP+8XgOIjIjpkcdQYWIU4HL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784907379; c=relaxed/simple;
	bh=m9886DTZxZUmgzBG7IAktqA66LvQHvEdg6xLD1umT1o=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PEotCy6UbvQSe96Wz0Ej9mNVANAcgr+cDVCdWBRDHvJHdxB3yNxFiCAMNkFu1CVhpUhW/zT1BadmnACUpKWnFKoFD2AITQKirVL+0hpI1EsEQiYdgy92k2YTae5ys5dq9vZyuGMF0iVjv6VbE4a+4R3WMbMvccTPHSQEzQB1YD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=IqYInc+V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PnX28sV0; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="IqYInc+V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PnX28sV0"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B7E187A0124;
	Fri, 24 Jul 2026 11:36:15 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Fri, 24 Jul 2026 11:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784907375;
	 x=1784993775; bh=nJx9erbMI6Umeum9I7sz5pMb7h4Dd2cP8Kh6+htAYmc=; b=
	IqYInc+VxQ766NPYg/XaDaMJzGKlJmaIWoLUR+x3Bd7IA0JLH+i8moUqwVoxAvqp
	6JJQisOedh+nB5wtVOD+WDF/JEe4QlhAZEvaf0203lkVLnEGX1KLwL5f7lecs2ni
	e9gt8rnJukHQg8tnrBzbq6gwjJHE6VWewj6kLp+fOrwLwLAAXIa6ccINSOlX2QFC
	zTBSlhmUzNc+Z+qMvr++xnXinYytV0HZNUOcaPoIMbInvEKvR7OIyR8EvXXk/tH1
	3hJV3PXaXw5/9k1xKxcU1zta8GbatDbtm/NqaacO04/s1A36Cireiy6nqh2G1mdb
	LsY2sga2OWidN0y41GdaFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784907375; x=
	1784993775; bh=nJx9erbMI6Umeum9I7sz5pMb7h4Dd2cP8Kh6+htAYmc=; b=P
	nX28sV0YAlcP4slQGYCswfWSq1q4Rk8zYcqv/5b8KpIyhdQEAF/AL9dPOFHuAu+1
	Wi0/vbNiMSEhleGd4N0k94b76W7UaJjllnXLq1wkzt29vFf1n5wffRHLYAfmjE9J
	dBYncr9weIaKLwBEZEN+xwxTqTvYEFQ3QZzX5e+6r0DGZBdpy78oUUFm2XZGlkOR
	zRVdmM8qGHb4Thl6+pEtT4nn+l+nGP1OM0jEhiRz3dwuFl4SKEs3qQqRDp3hIt1u
	AEK90L+KuUhe+k6hpeagiOKtXzQqvW4qS7oXT08aHqUU43Yl9i8VxYLcpfxxw9pI
	q+L+9fzkeJ+QN5vfYDJ7w==
X-ME-Sender: <xms:boZjat0837C9CMVbGwKZTVI0ArNKZwZlwxUK9VNCnlcZMhyUAP6tyA>
    <xme:boZjau5LBn2wIAOhzwJIA_GAe1u-QHANQYNOERVeWmoBbpgLHxop2IhJ6aBMId-lC
    S5BniKUW9ZKnh7qu0twWNv8wUKGfQi5iMnDS0T3nAB0buTgSpEaw6X9>
X-ME-Proxy-Cause: dmFkZTEMfEHYIgpoA/3PlruiwgrIPcgD1hPvJjO7FyUK5BNxWPNY9Z8orahmII+bn0MUMr
    2tC5a7ntxzpEwq03Wul786vQTKZT3T0LAkwqBudqNkRkhQiTVoTAWcabgU7yEGRMLGz7fF
    Em+pcNi6WifywFD01fxTU4RioOdXDkF4VXR2ArGtqlpPywnjtA+ksdn8PPpvyaF5ZGkLn2
    KoXm8e38Kn1K3oqr6Z0M06jXJtCxeSVlHBTj+H2Q1RcdgSkr1NACuMnAXM6nsIdBvz/ubX
    Fr5j+jdGFBXnb3RpYJLNj6jkjuHBHTlaxFgMLCDQYQ4eeIW0LZVBswrRIDQ4Ixts2Lidr/
    V/WNF/VC2wmyOMIxXmG85ksS9tA8S6Qn9NBllz5FVYqck92wyhKuF1mAHf2wzP2huUsehY
    71iYYjWo01BNQDqXI7IfonqBznsP3fOqpb4gJNCSCHFcGEoWzhv31B/sXjCv0Mr8pZOOj6
    6+bbcBhTt0erOVbcnSy3FGj7dDQuurmSO9GU9A3Y/CTnz/ELPo2FzMzRUU/qmRYkBw9DJR
    CzpZVaUW6+F0tOXXfvvBxnhrPkl3BDkclOaT8Wyd6EdWUEOcuj6nocBURz42zquF5JGtSH
    JLZWz30eMmDGhqo/pVaRXnxBRW1TQr/wj9+0lIi2aKjJGwLj/CKuvh7cR6bA
X-ME-Proxy: <xmx:b4ZjapuukwjKXzCDykq3LodqXHHO6QJ7ZqhryNRUjreKAhl0x50_oQ>
    <xmx:b4ZjaunIRg-qFbZY73kz1cMrE9kaDS-hrglqnvslFjLT0vTU5YruVg>
    <xmx:b4Zjaoktu4a8E93z0ESwdd61S3-5iKiIoL8dPLlU51MNGWLcaMfBQw>
    <xmx:b4ZjapgUROQRKAb6ljG6iiIWduvN1Owhz_42HQIy8ybqxkzVeDkKZA>
    <xmx:b4ZjamtbVxKnjR5gnU4eKqtoVaowYZ30qW4XSuzEXH6NelKvjocsYkDJ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E52E5182007E; Fri, 24 Jul 2026 11:36:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ADo26MvqZlrJ
Date: Fri, 24 Jul 2026 17:35:54 +0200
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
Message-Id: <6f0ed8d4-42ed-4ad8-9667-11f9bedee06a@app.fastmail.com>
In-Reply-To: <20260724-vdso-arch-clockmodes-v4-0-ddbe447be860@linutronix.de>
References: <20260724-vdso-arch-clockmodes-v4-0-ddbe447be860@linutronix.de>
Subject: Re: [PATCH v4 0/7] vDSO: Remove CONFIG_GENERIC_GETTIMEOFDAY ifdeffery
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026, at 15:36, Thomas Wei=C3=9Fschuh wrote:
> Always provide the definitions of the VDSO_CLOCKMODE_* constants and
> remove some ifdeffery from the clocksource drivers.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---

Looks all good to me. I assume you'll merge this through the
tip/timers/vdso branch, but let me know if I should pick it
up into the asm-generic tree instead.

     Arnd
