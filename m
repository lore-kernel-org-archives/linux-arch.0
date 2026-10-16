Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AE837E5D9
	for <linux-arch@vger.kernel.org>; Fri, 16 Oct 2026 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792168579; cv=none; b=KHb6pPUlKA+kbfGF0YaNFSw7FQ4Eq26/U4zCVRyD9rg2/OvQ5uCx1LH5cuhSJAtPk1k3OzRlBWaKwK2+qqVqlwq7zyFlXD3/lQB8WtNhzeE4g+fU+z6RUwO79q7ipMp7M3swLxcAxbusUoBn8gCjHLo2qQQJeTe4Wl2Z0vjZfHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792168579; c=relaxed/simple;
	bh=StqHeobwjbZoCDJcYG0T9/0ZBnyql/5JqI+bM4v70Kg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jpOyspO1otpfElQ77sLRjADyzizpswHnnMYd+oRkYX26ojmevg/uHp3j3ygnxF7YJLYfAFGSzfbC1FSZPASZEUmVFJvFyjNUgVXG1SbZXkwa1qQwIn4Oow6mYgGikWRg8ovbjjacqkXpvU0DSoH/M3xIb/YKv0rDGY1//LeOx6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbGxzRbB; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbGxzRbB"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd6028ff33fso109389a12.0
        for <linux-arch@vger.kernel.org>; Fri, 16 Oct 2026 09:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792168578; x=1792773378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=StqHeobwjbZoCDJcYG0T9/0ZBnyql/5JqI+bM4v70Kg=;
        b=kbGxzRbB01/HFxgSCslnEMSCvlZZRVvSOkt5CeSsr1Xg40Bp0XMcPWYIYNKca6dTB7
         NyFvH/1Q0b0Yd7hZu55+90O5Au6jCOjeH2zWz01ut8cpyZdKwlrpbpseu4nrzANjzGXD
         L+0YhifhKSJvwxeU5RMC0kGJUrKMX+WGEGiI10nK3mN8lmpoLzpdqObkbRhyCAsMu/0T
         Pju0oz7bbLswpCY1nCiW3QcpKHdpti5lSzivfNT3wJOhpdB8t2JjuPE6WZqDyI/+OWP2
         go1Hm8ATug0a43gvOxrTwJ0avIQNCky5t7Mzc3oBn0FFW80D6EKUXbDGZcnfM1vp/6Tj
         8JlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792168578; x=1792773378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=StqHeobwjbZoCDJcYG0T9/0ZBnyql/5JqI+bM4v70Kg=;
        b=DAknIOCj45OXev9WO24Ynf4MmRsm6nKkvCXo3GvMVopwo4UJ+NGblGDelJIXX9S47o
         m64ePDk61wnKYegBb+Aym+vntljXHVY18DyCXzkCE1QWdZCUoXaW4JnP70xIH2DjwtzU
         jNUs+Ijll/+PgFm8DeyWqtxzA2O2R7gZqtxcQNL2EiVMUDbXRzXMnRdXJn6KzoSw/J5i
         VopqLOaD/vI6p1tnWyprbCwi3eOTBwt8U/UYJ22NO7ikmgrU6ymy9ko7V7rEj1+k272J
         zWhnYTGRTf0Pojd495sq7h66kxovhVnWIC+yhMsI+u6n6lKi20kMrp8oZLimGHtHTEOP
         fUlQ==
X-Forwarded-Encrypted: i=1; AKwUvByYGdv9z356lGI47wNI2KS79BjwfaHF1lqJ1KYF7CtcGbzQTrS2XDdR8T0O0iwANTABGYCTGIUOOCUS@vger.kernel.org
X-Gm-Message-State: AFq9FYJtV843+PgJwugE1LLTDn+CXBAvW+Is9jvtpqeg/bHNvn4G79Pi
	sJzH4d7LzOInXd5z4NZI+zXoI5kErGntIWNJpZ8t3NBpwkPYE1ZiTXBkAUqbnarDsXs=
X-Gm-Gg: AYBFou38A/q/j+wz2EynZeyGtf6hLBGNmHq52RBX5CKIHFnxOirtA6TtMF79Db2lIQj
	SuLZYEyoCE5sFyEiv3l5ZLCKh6pOhngYt9rDBB0wXnMJEss5JvKgTKWGjwclGVsHbJTHhRBwuBw
	tE5pS4ucjv7NVl10dmsUT3P0l8zvRnSmM3NzSa64oYGIPyTKzL/D0czUuu/L42/AaB6oDKAO4yD
	W/xWYC5cyjaE1y5dLjF4jD/ZFPQKZwR7Nh5H3rVhHbaCHT4KcBxxpoAbP0Hytdg6P57IgYxHnUB
	/y/J9eP7QYYQeMSlO30UhyvF1Lh4UuBrRT29ChQgLDdHj4hSr34OOQvdav1sdzwDQDMAZxZJH4v
	fBmBAcDaBz9oTNr+EPc45VFN03KkUvtRrRDgJLIq/5YttRZtp+vdZEhYfttdnRyXYHOufDnLmp8
	y1dWTFzpvh3oLEXuyLBufkdhB/mzHDCuprA8dd9HV7WgyFHHxZB4K5fTr3Ey4ciW11XCgWcARhC
	O0=
X-Received: by 2002:a17:90b:582f:b0:3a6:f1d2:57f3 with SMTP id 98e67ed59e1d1-3acef542fa9mr339539a91.58.1792168577746;
        Fri, 16 Oct 2026 09:36:17 -0700 (PDT)
Received: from arm-a100.. ([140.112.28.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc492fa54sm4797470a91.13.2026.10.16.09.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 09:36:17 -0700 (PDT)
From: Tzu-Ching Yang <shingekinocore@gmail.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitops: Share the generic ffs()/fls() binary search via UNROLL()
Date: Sat, 17 Oct 2026 00:35:49 +0800
Message-Id: <20261016163549.636471-1-shingekinocore@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <atJN_MOFxvqOM9h2@yury>
References: <20261016025634.2690862-1-shingekinocore@gmail.com> <atJN_MOFxvqOM9h2@yury>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Oct 16, 2026 at 12:17:00PM -0400, Yury Norov wrote:
> Alright, so the basic idea is to hide the exact implementation behind
> the macro magic. This is highly unfavorable unless it brings substantial
> improvement i.e. in code generation. In kernel we're drifting toward the
> exactly opposite direction: getting rid of those macro tricks folded one
> into another in favor of the plain human-readable code.

Thanks for having a look and for the pointers, understood, and sorry
about the length of the description. I'm dropping this one and will
follow Arnd's suggestion instead, replacing custom arch helpers with
the builtins where that simplifies the code.

Thanks,
Tzu-Ching
