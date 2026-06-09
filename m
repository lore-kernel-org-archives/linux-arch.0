Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBA835AC16
	for <linux-arch@vger.kernel.org>; Tue,  9 Jun 2026 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016144; cv=none; b=Vl5F6pOuUR7tH0S4jQjoTMTIsHz+OfnjVg5Wh5zpeNuZG/+TNK34lE0s6P97pMpMI7kTIIUXcg+TqFwVSpfxyIAykqFapLVRnfW3SdZXgtoIXizYd6aD1lCwlDuVW/eJ1SLdvvkUDd1zmABSP5jpJFoGsZl3Q97NRTyxsOwFD38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016144; c=relaxed/simple;
	bh=+04bwyjE59zhSDG+fvdICNtxEHVAugytviQ6oWJLXKc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=azdErWTYdrgeXP5dHDn5hhX1YiXHkPhAy2pd8J2CYZKDF0VWzPwDlvWbIZOS+3ImBRQ0rWD9ebrhLzHLyvBzf7wIcSW2PEYGjcekkgb/7mvelnRapvAHNn4WWDhuBa29sP/Ih2nK6CH5LEbQbE3QjUK8kcbr2/zT3HPuPIY9+WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pQIODig5; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQIODig5"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-45eee266c6cso4567551f8f.1
        for <linux-arch@vger.kernel.org>; Tue, 09 Jun 2026 07:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781016142; x=1781620942; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+04bwyjE59zhSDG+fvdICNtxEHVAugytviQ6oWJLXKc=;
        b=pQIODig5W52q6oHb0R48LpLaHZtIHj6c5j7qXWYQVuJumgWSuGyNazwklkKytMENbN
         /lOvyooVVCXzGMhLsvT2QGWX92C+9zthiEIjB4LGjsosCoYp2WqtgqcVYMglV5KGa9T2
         036L7696fcowVQ7h8irAIU/zpH+J8Ux3ddbzZkQ76VGp1pnxLi1q8NiAfLlpJk2MuI8S
         vRsubMkMrRzIKS8/ikhq5lf25tV6ZWQfD1NZZH6JiKueUMACTZJHBPnN8fGfBEg97EkZ
         2c15UDagCZ4JKwc6wZY8OaXuLAX7ni47RFHKQYxYTXOm2aS02By9XR8fkUZ413PKhrbO
         BUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781016142; x=1781620942;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+04bwyjE59zhSDG+fvdICNtxEHVAugytviQ6oWJLXKc=;
        b=DT4Zd3HYXQkPvNTzXYM7n65w3JE/Th46WTwg/ZX6vGG3vR/uB1ugT4Ai7SUFHjJrJ+
         5YewGv0nYT9u5N/Omb+tQSkcO7iyb9WQWxjNpKPrQc6SkQ6X64TwKXHVMFNMoynwLCKc
         gKEdJmDm9ThqShH+7eSRo/+NtVFPosFU/erYIYwvRCCKNWVFvoiHM4BM5g2G2Duj6OaI
         yWSI1+V2vcmpTzxA73nh5ihEKehLS9/voKVSoOHEemytpAdRFO5Z7ozegECG2rweyWAC
         bYQHiErdMajy9ZBg1dC0ZPCPGlloOMXUCOzzeSESB24zTkezq8r9tYpAEfvTYN5F4wih
         8kVA==
X-Forwarded-Encrypted: i=1; AFNElJ+nUbtBFNC4Swy9zDKBuM9MniUYNaXVw23tfl6BCtnoum60zQFsC4OULj5nsSb10Dd59PMdRFPWJf3e@vger.kernel.org
X-Gm-Message-State: AOJu0Yygs6al7YHakLz3+2YQFUw4RhnVoTGZjoYIyksKSJbRzab5zJbM
	Ii5wMZWOba1pFANDJG5NnBRIZrHO8aJBVEpA6hl8fFr+PgAa0xCwYKUk
X-Gm-Gg: Acq92OFgIOsNGMLrFHiC0jai8GtN9oPFxPv54Iy4RZMR5rzQi9WdaU56/gTS+q0rI9l
	az0h/fM0bh3GNq1jBIGPovezHopgCW2hOkHlWWPtavaEpgz1LE3l8pBrkkYvZOHtZhdr0AQtB4S
	UBiB20kZaOZ5aaFMe7iNtWdp7oQ+OyNDGTSU98e31XdMbfWNaVSLNdg9rgp5DJUFps0VraDgyyi
	1JFy7vXu95KBfDglj1ijWJB5UWSgcWUVDaZhvpJQv3Z8xOd2bJ/T3meBD8YSvFXOJXdBRN8yJWF
	FypRoVRnP1OH9q7q6Bg8rXKY5yg3tKeGS/BoXcak22wBTPatfEXP8N3I6IwRSIpxapuVTp5q8rA
	PTSkFSBDELrz+DNmr7IzvrU4vlAgaCpxTmSjxdv2Q02+FORzGuFeIk3FTGRHvxz++eRE4IrlHZ7
	roqcSc/4UTv+TaVAoZ48/cd8K1NK7ohUMoXzRTJyDgDPQQ5CbXpE8pIqy1DBK5pKxHoU4lHfOgb
	U6KRgVyT4qH8xt+vfw/Z0IMF/Pdfsx+HuxlnXaVFkrFV+tgPLQpDbYeU9zql9EEimLYR56bj3aY
	gAuAwHfOuIo=
X-Received: by 2002:a05:600c:3f0e:b0:490:d38c:7836 with SMTP id 5b1f17b1804b1-490d38c7867mr90281595e9.3.1781016141502;
        Tue, 09 Jun 2026 07:42:21 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c183asm491606205e9.6.2026.06.09.07.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 07:42:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 16:42:20 +0200
Message-Id: <DJ4LJ3T8PYRG.3TG272FHH78RM@gmail.com>
Cc: "Peter Zijlstra" <peterz@infradead.org>, "Ingo Molnar"
 <mingo@redhat.com>, "Will Deacon" <will@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Waiman Long" <longman@redhat.com>
Subject: Re: [PATCH] rqspinlock: Fix order in raw_res_spin_(un)lock_irq to
 allow schedule
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Gabriele Monaco" <gmonaco@redhat.com>, "Arnd Bergmann" <arnd@arndb.de>,
 "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, <bpf@vger.kernel.org>, "Linux-Arch"
 <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260609094941.56122-1-gmonaco@redhat.com>
 <d40ba64d-78d9-45f5-99b9-4bfb1fc27f6c@app.fastmail.com>
 <defc6b1339dea2f64f936902dd6e1f850cff9f4e.camel@redhat.com>
In-Reply-To: <defc6b1339dea2f64f936902dd6e1f850cff9f4e.camel@redhat.com>

On Tue Jun 9, 2026 at 3:04 PM CEST, Gabriele Monaco wrote:
> On Tue, 2026-06-09 at 13:22 +0200, Arnd Bergmann wrote:
>> Should this be Cc:stable@vger.kernel.org=C2=A0to get backported?
>
> Not sure if the Fixes: is enough to trigger the automation, I rarely
> remember to Cc:stable@vger.kernel.org and they're usually picked.
>
> In case I guess I'd need to re-submit the patch right?
>
>> Did you see this cause measurable performance problems,
>> or did you find it through inspection?
>
> I noticed it while debugging an ENOMEM issue in the test_maps BPF
> selftest on PREEMPT_RT and this was an obvious cuplrit (irq_work not
> scheduled during a stress run). Turns out the problem is still there
> after this fix though.

I would imagine this to be the least of your problems, I think there's a bu=
nch
of blockers for complete selftests passing with PREEMPT_RT support in BPF.

>
>>
>> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
>>
>> Acked-by: Arnd Bergmann <arnd@arndb.de> # asm-generic

The patch makes sense to me as well.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
