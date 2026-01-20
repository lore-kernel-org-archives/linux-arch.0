Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EAE126BF7
	for <linux-arch@vger.kernel.org>; Tue, 20 Jan 2026 11:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768908969; cv=none; b=KDol3fgdwirnHtzbpLwot5QD72o/D7ptvfgQsL1SFayBDI6krXrFAVh+PA1DFv2hi+LC4spcrdQfsd6VKHnHEtMwYgYWaTbiBEntmODx0nTiF2ymHbqyXJyzMoVz+6oV6nPEG8OHMBubh2LjEVw+MRR2ynyZg/B7LRinC6UWGuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768908969; c=relaxed/simple;
	bh=rOd9yTpdEpOmqr8gV3Zvtz93VcNjmSVSiEIE/dTz7Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EupVCKDhonk79SO8WOiT6EQl8OCjTN45t3kwjtPS5aAQ9XtBw53R2/raWbm+86Eb0ZH/H8frRfAcIMzZh/fDv5ubvK7tm87UF8U/KeayaC5dO3xI3oNRxz1udE3T+KF1PbmylaK8dMmoYfJUeLVnN0X6v8AwuhsCFeWPezkWS90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLeugcUZ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLeugcUZ"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64d4d8b3ad7so8480184a12.2
        for <linux-arch@vger.kernel.org>; Tue, 20 Jan 2026 03:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768908962; x=1769513762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGTA45Ofysyie+s0KKre7pJ1MVbPnUxT25h6KktO9Bs=;
        b=kLeugcUZ8QwBBW/zOVfScYr+OJ5W/iNwCZpWCWb6ELDK3BihoRzVUuWlviXajVzucs
         Th8f4n+R33UUJibsySMSttykMMGOfMrH6GUVol/o0K6RHV3tnb/SP4Le31d9FEh9h+zd
         CbxLwNRghHGDkeYxgYkBrbg6V+VSbaKOWSTdPBk/OFHCvKcHq2ByRg0bn1O1g0VQWrPy
         2B7wfH4wpThZbj3shCx6tP6ctvPIeYsyp4SazuxsFD6LCL67pt8wgAcqrirMDs/EazpU
         hKfJva2NPy2OR0heypaTvrox4DtR7nb6ZqoPEFnZsYIvHzowDpilst/dfOsNH8x7qmn9
         Nkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768908962; x=1769513762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pGTA45Ofysyie+s0KKre7pJ1MVbPnUxT25h6KktO9Bs=;
        b=fvKOwZBpD/gZbP1zqhUPsxszNu1YIUP+8oZV79ZUYTKU2JP1qth4BQbKHOq20Sf7NJ
         BescPMqiEP9o/BrBbppocIs+CLdxkTdL8kwY3VpwRF25juMTOEvlJkqiLSbjx3zUrphN
         t5kpbZsmPkR1OpuKbzmHQwZ5jNbJ18vC2NGbeKNw0G/tYbnJAuWJmbN31CQsI7OY5IsI
         zWjw010uE30dCzyzFoHH456NNVHYOQiKBuz/lTWqwHknMwUnc2/2UI0ya5/v3xCmQoTl
         SgFWwd/xKm5Ur2Vtq/L+42p6WP4bEbbOQg+Dw6+lMbB4W69dQGqzMT+tVQNc3knM03uf
         7E/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU85LtnhDrn8mNYSPyDAc25rFZfl3NwIAsWSI2PBd3utGFmrHm8oh5yL6IWVMCmPtzwM/c85utnVbzO@vger.kernel.org
X-Gm-Message-State: AOJu0YzI2MN2Nf66LCsJ0H922+STd7BtIuqWJ9pSbdXl1H93cQYhgnqE
	x1UKH9ri43OrXJ6taR2JVyWQn12S4s5lqcz773LvZdqZ0PHg5O4yCUrt3SHUyg==
X-Gm-Gg: AZuq6aLZghegsR5ANIN2dI9G4DsAMwsiq3TsiqQNVFMFhIebF+uN47RxZjo9dpzH1bL
	84BWmXjm4e3Ht5lzdzKBhJLYzG5oZ5cvjHeQINOkmYvL/5EzmFQVTvfnL7D6HLtgSbktWbrmkd3
	EW5YiYUHRIVJbIA+NbWyNKQ6gSQi5qzVTUXS/y1Yj8mYkf3RdRoU9nNoXeY3n891HsZqDitFldR
	SaIpC7diEScevTr/DXgOpHNegPeqURKyzu/zHKFkXlW92zzIs7fUkSUSC4P/csmqk/rZsGQ6cOa
	2c9Y/TDyNFgC042JDksd0p4thZ/AzlsgZmAHwb6xSCLezZTyr800fO9J9au96hexJ98ofKUDMIR
	evrUtcLNUBjqLbhkbc4L+TlHWhkJZF6kksSGBxGOGMNofEyA5lGcf3GUh9FQSmGvrcFLfFrswdN
	Pft//Gjljzc+TJj9SxWLIop3IC2uBL0rpO72ymzfOqXxkQyN3sf0YIXVEhOK4Qw5M=
X-Received: by 2002:a05:6000:4202:b0:432:a9fb:68f8 with SMTP id ffacd0b85a97d-4356a02643dmr16216419f8f.1.1768903412929;
        Tue, 20 Jan 2026 02:03:32 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569997f41sm27420500f8f.38.2026.01.20.02.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 02:03:32 -0800 (PST)
Date: Tue, 20 Jan 2026 10:03:31 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?=
 <thomas.weissschuh@linutronix.de>, "David S . Miller"
 <davem@davemloft.net>, "Andreas Larsson" <andreas@gaisler.com>, "Andy
 Lutomirski" <luto@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, x86@kernel.org, "Heiko Carstens"
 <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger"
 <borntraeger@linux.ibm.com>, "Sven Schnelle" <svens@linux.ibm.com>,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Linux-Arch
 <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 4/4] asm-generic/bitsperlong.h: Add sanity checks for
 __BITS_PER_LONG
Message-ID: <20260120100331.1f57aa99@pumpkin>
In-Reply-To: <7b10344c-bb71-44fb-a391-32f7784db0e6@app.fastmail.com>
References: <20260116-vdso-compat-checkflags-v1-0-4a83b4fbb0d3@linutronix.de>
	<20260116-vdso-compat-checkflags-v1-4-4a83b4fbb0d3@linutronix.de>
	<1a77fda4-3cf6-4c19-aa36-b5f0e305b313@zytor.com>
	<20260119163559-b20b14d7-56ca-4f17-8800-83f618d778b8@linutronix.de>
	<f3bd8bfd-d66c-45fe-a634-9ac418806f40@zytor.com>
	<7b10344c-bb71-44fb-a391-32f7784db0e6@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Jan 2026 22:39:53 +0100
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Mon, Jan 19, 2026, at 22:12, H. Peter Anvin wrote:
> > On 2026-01-19 07:39, Thomas Wei=C3=9Fschuh wrote: =20
> >>>
> >>> Do we actually support any compilers which *don't* define __SIZEOF_LO=
NG__? =20
> >>=20
> >> When building the kernel not. I used this pattern because it is used
> >> further up in the file. There it makes sense as it is actually a users=
pace
> >> header which needs to support all kinds of compilers.
> >> But this new check is gated behind __KERNEL__ anyways...
> >> For the next revision I will move it into the regular kernel-internal
> >> bitsperlong.h. That will be less confusing and still handle the vDSO b=
uild,
> >> due to the way our header hierarchy works.
> >>  =20
> >
> > The point is that we can simply do:
> >
> > #define __BITS_PER_LONG (__SIZEOF_LONG__ << 3)
> >
> > ... and it will always be consistent. =20
>=20
> We have discussed this before, but decided it was too early to
> assume that userspace compilers are recent enough for that.
> According to godbolt.org, gcc-4.1 lacks __SIZEOF_LONG__ while
> gcc-4.4 has it, as do all versions of clang. Not sure what other
> compilers one may encounter using Linux kernel headers.

For instance MSVC doesn't define __SIZEOF_LONG__ or __x86_64__.
Unlikely to be used, but...

So you can use __SIZEOF_LONG__ if it is defined, if not hunt for
something else (possible just fixed in the installed headers).
But in the latter case (at least) a compile-time check that the
value is correct makes sense.
And that can be done portably - probable with a negative array size.

	David

>=20
>      Arnd
>=20

