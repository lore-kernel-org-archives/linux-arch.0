Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA9E37DAA2
	for <linux-arch@vger.kernel.org>; Tue, 12 May 2026 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592817; cv=pass; b=qJiTpTf5oh7V4yIzHVd6NPA0d9jtsjkIj0yOk04D0VAB8jEniy9VyYtoOlSCV06RG0pNfRJuPn1773MG3Sqm8ubZF0UHnfZHJA2ZRfFLNonm1/y7q00ERe97GaoSSVpsFV0pHKju/UMzdh/EdyjvOQxJHs6mX4aEfRJEc6eeUnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592817; c=relaxed/simple;
	bh=D1jJ/gf21v5jTsHW/66Kz9VjA9WYKFK/yu8KnI8oy8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LP2ksnFd0I4MoeXyU8cF2p7MsTK8dAfRAUTOsbGy8BY7MngMFdsNTKKhyrKtFR2ZKDp5dAlmetXn37fN+Qabjgp5kaKzm8MM1/IBBpuVO08ulhWQEzdvyVfG0dkOJwTOaHy+oBzx8r1mWIiLNbDKbMZxHR6dqwkeqk9CRSmIVa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TUlH5wNP; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TUlH5wNP"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-67c1eea6b4dso69a12.1
        for <linux-arch@vger.kernel.org>; Tue, 12 May 2026 06:33:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778592814; cv=none;
        d=google.com; s=arc-20240605;
        b=bVZNGFYE9skKCr/Rd6iZ1tBQqbHUDOYzY+XRZjZwKN2ahh8vRNn8wtLe3EluMISm+b
         j9ATxNq8oSCuwGzHmJ/SJ39adY16fHvpqEwDKwYznDbAOBbz2M9vVYMmEaOLuzlJWK2c
         QrOR6uAJppdE9B+fuyyA/8JkJ48xScHnfjasKALei4ZqhZ3Bm3WbuQ3GPOK1IMCPHiVX
         g20gHaUR1VLv456V7p0AMTdoQB8bpWPLEZfV5lSnEs+p/rg4VoGoQrmdIoX7lB5iWTkK
         0u7F6om3no0wKkg9GYCWbOsWvseaRTY5FbQk9cQWgUCqTsgOupUFd/0Rq9wCTFSKhrUB
         g3WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D1jJ/gf21v5jTsHW/66Kz9VjA9WYKFK/yu8KnI8oy8w=;
        fh=wA23w+aPR5vm5B0+f7P+3/D/WqOFmcumvSIzmMsTS/w=;
        b=PyDR0dNs5yGFI5o71K6HkqodBUdvaQ6c/zmEfBRIu1G5Q9PvtCPpdDULmiyjxN2Zzt
         zu6ppAXBRlNU2pqBe6N44bbggOerCbV6M31/bEvHSoXggC4qnOY8qdJVDseQ8g6UxGcl
         oZJw/BqcCv0kLb+jdr6azf5sdW8mycDtBzgg1ejJNIhbIOvyNKSQE8P4rYz+GxmPOE57
         rhSVPO/SLqGj6YT9idQJra2EVLBb/vb8Got7aDPcp8oR6E1ssv/A4iTGV0a5BXwoUmIg
         08wz+rq8zVWt7ejIiSE3NJBD1QCHJ3KveXWHqnmjeV+ZZIShEbC2m9QvyfNkW/zX6DYU
         IgfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778592814; x=1779197614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1jJ/gf21v5jTsHW/66Kz9VjA9WYKFK/yu8KnI8oy8w=;
        b=TUlH5wNPt1KuAvCb2XvjvGXYO0xegmgsGy9/LBtY2bMfHKropXada3cCuP6UAYt8JR
         376IMimuyXpzEJcw7UI3pdynXcSnDM0yTpNuWamxPkjgrZp0YQnfzGelWuR/jwv+g6lR
         gL1/ll9qjsPQmInkNh0N35e/CD4UViO1fKn/teaXrAjyUvwzZhs8MxM/WKBSuVel97Ne
         BmCcF4xR7/2NJ7IY1tY7cGkoh0dnnHQZ4UwLEP12e0P+yr9y9eURNQ4uuJmT9jz8bKqc
         6RMuQM3rru9x+S+Vknzu79ImoKfm2b7SOnNyO8DsDTZqJ/9I1fUkFLkI9gKALPLMqqHZ
         LClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778592814; x=1779197614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D1jJ/gf21v5jTsHW/66Kz9VjA9WYKFK/yu8KnI8oy8w=;
        b=ofqSTvY4UBIyRLMWGWJ/kzBXjykmHjVT/PDkvt4uIgTusSy0jxjD4ljOb4yai631LA
         1Uz2o1g5zZlRxg3rJMuGhNa5ICk8klzlhUEGcNFg+PLUhffQGG1K+cXns2nAGt+tdVuS
         S/hQRCXVbeE7Ak6/HJPO0UNZBrzvRvB+9F/8JthN2HoOn/2zkcf5D/QQFhP7s/foMuAH
         wiTLJE/C7OGoZztYIqqP1usVsh/ICItkoVvrD27NW/WO0f+wWiHrcFhABj5toTMUqGU0
         +wYypmIy8xblKjviC3ix+jhVD9tHyFdkYELoeJIEpQgTRAAkU01aioKP/ildyY8sGwNs
         zBYw==
X-Forwarded-Encrypted: i=1; AFNElJ951pwY/32FNWxa8YDyuGXey2eFSlPFl5zih4yyy0gNkPTWWWD0Y/JvfOQ+LHbepswW8VqRfXxWNLUD@vger.kernel.org
X-Gm-Message-State: AOJu0YxRuyzlSLDAHKL/v9WW5Pc8fUne2a2uBVp59gzpWdgGave3dexT
	9mseTujNbAtrseZtnX+vN14FP9PhGBb08c3URQUffuVj0B+fJtGZb6thMgjbWWhXe8QtW+3draF
	IODmk6DrAljFPhuWCBR72MMFFgWEpSgjXaq7sOI/6
X-Gm-Gg: Acq92OHNBm43LfO/Ii8rlmwzhLKMqZ6wZV1I+83sr13jYJ7tz0Y2bxe1cSBfZdltIm+
	Y/VeV/DdSlaYvgBjg3f4W4gzBq6O7kH4rJ/6omR8TIM7AKgsn7qQjU+tLJAtXEpUMFbyPBbJ5E0
	7sOVLj0fFxCHBJKM9c27WpHfZavQrQL98yIsUHsRxXlFd3aFA7sTAYsEQYJyDknwCoPAgt5gyz4
	w7lTZtt6Ac3SQDQUDhXpNKoCM0BqPIENqFzwofjunRS3n6WgJDX88wOR2jGyBvUu5nzW3K5lFgo
	0m+ZYIemWlFz8DNXGU7JwAZrwJHLZASaOZ92zRAauUjJ/tBw
X-Received: by 2002:aa7:c7cd:0:b0:67b:8283:6240 with SMTP id
 4fb4d7f45d1cf-680dab0c7c9mr39195a12.7.1778592813829; Tue, 12 May 2026
 06:33:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG48ez2ed44M=-qsZO7gwcz5L2njdRdk54d47jEg48MhWTkaew@mail.gmail.com>
 <20260512023129.44966-1-lance.yang@linux.dev>
In-Reply-To: <20260512023129.44966-1-lance.yang@linux.dev>
From: Jann Horn <jannh@google.com>
Date: Tue, 12 May 2026 15:32:57 +0200
X-Gm-Features: AVHnY4LZwF_WYCVPXafYsLmjKwF1Trc0n8j0sGJfDYhW6dPI4yRtQ6ztFmHrTkM
Message-ID: <CAG48ez1xdO1wkqS+eAcnAV9QJ25=t1o0-Qz4qTZdg1Mo+en2QA@mail.gmail.com>
Subject: Re: [PATCH] mm: make zeropage read-only
To: Lance Yang <lance.yang@linux.dev>
Cc: rppt@kernel.org, akpm@linux-foundation.org, arnd@arndb.de, 
	linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, ardb@kernel.org, sethjenkins@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 4:31=E2=80=AFAM Lance Yang <lance.yang@linux.dev> w=
rote:
> Would it makes sense to apply a similar treatment to huge_zero_folio
> as well?
>
> with CONFIG_PERSISTENT_HUGE_ZERO_FOLIO=3Dy, it is allocated at boot and
> never freed, so it should never be written after initialization either :)

Oh, neat, I didn't realize that that feature exists.

I guess there are two aspects of making the huge zero folio RO that
could be problematic:

1. If the huge zero folio comes from the page allocator, making it
read-only might require splitting a huge PUD, which could have
performance implications.
2. I vaguely remember arm64 has rules about how PUD/PMD entries in the
linear mapping can't be split at runtime at all depending on hardware
capabilities, meaning the entire linear mapping may need to be mapped
without any huge PUD/PMD entries - IDK if thp_shrinker_init() runs
early enough to be excepted from that. See can_set_direct_map() and
force_pte_mapping() in arch/arm64/.

So making the huge zero folio RO in the linear map would probably
require adding a new config flag, connecting that to
ARCH_HAS_SET_DIRECT_MAP, and changing one or two places in arm64
memory management.
