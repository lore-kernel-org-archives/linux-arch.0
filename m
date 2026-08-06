Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B39391E4E
	for <linux-arch@vger.kernel.org>; Thu,  6 Aug 2026 15:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030115; cv=none; b=ez7t0Z07czl8iAB+hmeudX7FNQafVP9Junic0yKxjXHylfQhLsYL4sbDjcwGyES3tx87NKfrx76GR5LmqZjIvgEVPTuGjwCcI7k1Vr2pfgWV4kNRd6C0xcp9G9BwxvReIeYwXmmD6ytJOK3GgajW0l4G+V10uINIPUT7giijkEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030115; c=relaxed/simple;
	bh=sSOMPBG4fiWze6IAdyKEgJOvNuDwNVHf2DlIvHsEtKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tuUPr9vS92gYpw9Oia9X4qKMdF6YsvdyzV5+mZfpZLV3nnTTDR5/D4ldpoLPt0Ku0TDrJEOcwKQbNJ01ba0zkgQdf0tUHN9WnaVt9d14Xc9lShHUjGsMl3tZoXo0Bt70cUNrmg/hQOgyrFZ6baxfeeG5bZ4PXPL3zBDveqcrkIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8201447e8cdso38599597b3.3
        for <linux-arch@vger.kernel.org>; Thu, 06 Aug 2026 08:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786030113; x=1786634913;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ohZ39jK4R7nHBsxWJDOlT0sMAW4jJSovzDHcfJTHmAg=;
        b=A3b0YDxzV+j7ERZ+Jk4/b5M0REirirL2YNtV+4JE7lPtR+Zwyn4TPEEFj3Rj1xfd7X
         a6IZurrovnER9oeFsMWYil3hisNWIE8ZjLuz8nQDmRcWnS/xLDc1qhfNrCTZ2k0+jFq0
         DAx9lOdPvhT1s7BC/pxLFb4nHuHX0Gptl3//xlL6LExM7QJ0gzlS50eZL4Haz7KYuMlK
         DUdhyLGOzlvM9UPu5kn+Gt5vN8NyO14eV+2B+myf1cbNgSblfPnv0Mo+mc08bl6CLfwl
         zO0VFM3hMPSGyhBxE2m7xSIgOZe8UBgFNRWURotBPiZ+WgVQL9qf9uuCk3q/f1SWwMxc
         bB6Q==
X-Forwarded-Encrypted: i=1; AHgh+RqBYGLzyctTAEd4prAkPT0jPgls0cI2iUADZPBREDTRR+LkKStS9KTSJnOfU4t0HWpqkzx8hDf5TRH+@vger.kernel.org
X-Gm-Message-State: AOJu0YxFQr0F8RneKiGSGHsyUu3pYLIzg4WhF+74/HXNdWplBe9TgOYQ
	7/ye79NAvfA6+hA8QnN/6+3qy5tzW68tNsTUFuARSko2PI/5lCvEuybWvT/UlkVH
X-Gm-Gg: AR+sD12niXpb0UPu+AVHVX5znp6D5xrEytnBPKtVDYYeE6b78iVzqH7uvjxMHHX5Klv
	dCPYQLTjePBYFwRyEFLRKP+DCD4uBX+VwLbiJhfbib6b814m9MdgbylttKuxmBW/N2U5sefQVEt
	PNNL6hutk+wMqsP2C4mbIukVXM2CRVF4GYC4C/qNhy59haEs75T/BCx3c8mBQbuvNpPWny7ycxC
	8we4aANz6QEFR47wYyWKFoj8AJJ0M1B88SyugPavVcO9XlgVIwn+yB/X6FDFxE5RimQE9aa3TME
	OOu4UZm2n/ROZBX7BEB99Pb0SQLr/mtzjZJ/OUdvrHmw39ZXaKvacvuppUXGRBDPAL8ROn6KSYT
	ITOxd59j/rQHLlReOUFf4cxjiVT4B5HJoaocMSz96H3XV6cKK9E4MWstM5QGYIKXqwpwRq6i8Nw
	aTqg6hhOEu8/VSQcqr6spmDrCyUGr5t+DpmWy4+7Me9Znn8pxQvdiqSBdEyiRkg5GwNXLPjZ8OF
	4ngYDfDHpsmno3rOiy1tfyRMA==
X-Received: by 2002:a05:690c:6209:b0:81e:7d90:5673 with SMTP id 00721157ae682-820224ace00mr97912237b3.26.1786030113148;
        Thu, 06 Aug 2026 08:28:33 -0700 (PDT)
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com. [74.125.224.45])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8218964f981sm9971657b3.19.2026.08.06.08.28.32
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 08:28:32 -0700 (PDT)
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-664a09bc459so3747763d50.1
        for <linux-arch@vger.kernel.org>; Thu, 06 Aug 2026 08:28:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoBx6f+PqfD/lMzo/PvCv++e+3HOyNCOwvXAPnyH2cIiOJNjRiDJC7+1v53paM2KbYiiNlC2A+yS2gX@vger.kernel.org
X-Received: by 2002:a05:6102:2b83:b0:738:133f:8d5e with SMTP id
 ada2fe7eead31-760ea747b4emr4930162137.12.1786029696259; Thu, 06 Aug 2026
 08:21:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803180931.97202-1-ojeda@kernel.org> <fb2daae7-4eba-4ca1-95a5-60f8157eb66b@app.fastmail.com>
 <DKFKXA6YWW8R.1NDZ44Q13XFQH@kernel.org> <20260804071330.24760Aaf-hca@linux.ibm.com>
 <33ecacea-ed2a-409c-ab1c-a136e06b1b7a@app.fastmail.com> <1aac654b8d333cc058a345b03ae0f798f1724ced.camel@linux.ibm.com>
 <57ac7553-4034-49e2-b686-b7272591da00@app.fastmail.com> <94c3ebc645e80feae1044a57b8b5c82d4d4ff408.camel@linux.ibm.com>
 <f2002ee7-00a4-4a3f-a516-409886b724ab@app.fastmail.com> <2aaf01a4417cea313ce0cce7cfdbec65d350a41f.camel@linux.ibm.com>
 <f85a48cb-4ad9-412c-be00-a8227d6c8fb1@app.fastmail.com>
In-Reply-To: <f85a48cb-4ad9-412c-be00-a8227d6c8fb1@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Aug 2026 17:21:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWBiCA6+SWatmbB5bVdFd7_9CPNgR_eaTcOUpqAEA5J4w@mail.gmail.com>
X-Gm-Features: AUfX_mytiRYZjGYX1aobVkgoZ5obof2d1lrRV5Gr1cwx_C_pvGoMLWUjStMFMZU
Message-ID: <CAMuHMdWBiCA6+SWatmbB5bVdFd7_9CPNgR_eaTcOUpqAEA5J4w@mail.gmail.com>
Subject: Re: `io{re,un}map()` build error in s390 under `!CONFIG_HAS_IOMEM`
To: Arnd Bergmann <arnd@arndb.de>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Danilo Krummrich <dakr@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, driver-core@lists.linux.dev, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	linux-s390@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Arnd,

On Thu, 6 Aug 2026 at 15:51, Arnd Bergmann <arnd@arndb.de> wrote:
> I think the reason is that there are a couple of architectures
> (including non-MIO s390) that take a shortcut for normal
> ioremap() that avoids actually mapping anything, e.g. mips
> and related architectures have a fixed uncached mapping
> of all MMIO space visible to kernel, while some alpha, m68k
> powerpc, and s390 do something other than a pointer dereference
> for MMIO.

FTR, several m68k platforms use the transparent translation registers
to set up a mapping to the main system's MMIO space (like MIPS,
but programmable), and thus just need to add an offset.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
