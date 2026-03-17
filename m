Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BF83603E5
	for <linux-arch@vger.kernel.org>; Tue, 17 Mar 2026 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773739033; cv=none; b=EEqqMXDYt1SrbNji1+ASclcbsruj7o7ahM7o7HE63pq+/X83iDiIg6Nsl7jBZ4CZjvds70STLbLGmm5tR+Sh9CXlgaCrXTdQVvIsw0e2bPW/OR7rmxsA6jOIjn49GhWB/01DkafPYnRdA7N8rRgmiVze36xIXiuDG2h1zoxJruU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773739033; c=relaxed/simple;
	bh=dtTlCI41aozPTprXi9NLFL5XTO3EzPdQWfOwuMTboPk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hPyVzQ2Bw61gHhPPETywTfyghFEFsOwKBQh2xiyK32ZDMlPAul+NJkYxli2ytagEp6YppFplbFb3m9DWroZEt5fxNukDF5B9oBXTuQKL7pUzKAj3EpND2Xy3LOlk8hdzabXAv/YQIpxtzot3BxRj7ubQkRvwu/BxeXV23XaemCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fG2q/vtu; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fG2q/vtu"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-485409ab264so3362875e9.1
        for <linux-arch@vger.kernel.org>; Tue, 17 Mar 2026 02:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773739028; x=1774343828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6M98aQTjWa8T+7ERPNFsSGl3sVEntJ3KUS4g5D7crqo=;
        b=fG2q/vtuNbzuklQBCk2lkDj0WVbhIZEBgPNCSNifvBQFx+XepfFhvU3S6Hw+SMsd+T
         ZvPleBcQ8goyWn52ywY8+Xn4wnaQ0aPqoJQbwSyChKxm30GW1zEAkFPRDUsSRjKemlIC
         CiwrE3HNmyCiEOvqwjXybVFxYyDPkCP81Fpc6dM/mYhDUgRx8lmFyo3X+3F52mSro0/2
         9QoivY6AcT1W6GtEugGJcPJHbOZkMH8dlotwx7lO9ZsPn/wh58IK1zRhuKDCcv10uQ+i
         xswq97GzXF0Pb7+PCRlEoqcD46RDvTQ3vphxeN5U2YMCl1JR/qYquwNwrjj/mDl9TDKw
         WJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773739028; x=1774343828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6M98aQTjWa8T+7ERPNFsSGl3sVEntJ3KUS4g5D7crqo=;
        b=FNu9sXdaC5XK4+8CtJs+H8HMtMAUI+M7m1EnbMTZsfM+R9cjj+RSrWdGYHMoqlUpJb
         Ughw75VzN5Jfx90wmsrmymB6QyRGmPlttkgjoH3+jG+B9Ltg1FcKl2ByTHuGRFgtr/I0
         2JPAzBtxJ3QDlSznqXj6chCQxKG4nvELwcny3lcwiw75PF9b1rK0PLzqAoYFGjwtEOVI
         GQ1xkcbZfDAA6ooHGeifhHPVU3JfLv4skmcXnRJm0AuJVfOSnYunE4B127PNEcWBEksu
         aWU6lF73zr/tyFtfw/haJi6ewUoN88gg2WAxpDfOqR+Lr9zcTwvN8S9xWXtVMO3XjJ1J
         lNsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdeDczFooHi0afq3LLUjl8asY+fFL6xqUPlKDXqBfWsiNq82x9XcTMWwVKSoAOJaGe3GC/mhgk/vIf@vger.kernel.org
X-Gm-Message-State: AOJu0Yze5u5UoZLDeKHhSldHAU+NdfkKrunYIczuODhLpg+s/1wg8UCA
	WLNmNAGMqS3StE2xItRQtONEN1Cw2xrdUahYWetdpCurYTvlcrFif6/N
X-Gm-Gg: ATEYQzz4Pmb9tvF1hxJZYQsJ+zTM2Ahn4HM6VyMniEcst6goPHNkpEy0so+oQLKzj1D
	qRlCSJpUt/HbU+bJcS5VE892dzzYaDIvPcP2anwvjxrrcCPn03HUJB+lcqOzpdF6yOrBAhzgeKZ
	fHA1CdF35MiqtFEiBdjEUmAlIaTl5PLW1W1NLa7YBe0lHuLAY8CyR+SY/UHR5R0QPeIA5k4VNKw
	1N2ZBVZPwl+5cwcWhD1OMlHRF8ozJzAWV1n9qotFAdxOiFhvoP9l4z+iZSZaOLOzkTJKXfaprnS
	L9nRACswGfvlIblvXyzxFSQDD5BshifofXE3ymxRHRt+JgHr5vHO91SXnDuVXrrcYhE8reCuROA
	MlV2iqoPZkG8gDXFIRE7gTB2slPEwoYLTWQzDiiXAlHzlNpKtJRF7otmrR+8/LtzLi+H4+nu0cl
	5NKe+lnVaOoYw809nXpUlKyH2zLRvMI1tf0g8p6Q4ioKtWP5Q7Is+Pz0nUeoipIrcY
X-Received: by 2002:a05:600c:5249:b0:485:38f1:5cec with SMTP id 5b1f17b1804b1-4856eac2b35mr44375555e9.7.1773739027522;
        Tue, 17 Mar 2026 02:17:07 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8fb0dsm99153105e9.3.2026.03.17.02.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 02:17:07 -0700 (PDT)
Date: Tue, 17 Mar 2026 09:17:05 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de,
 catalin.marinas@arm.com, will@kernel.org, peterz@infradead.org,
 mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org, ast@kernel.org,
 rafael@kernel.org, daniel.lezcano@linaro.org, memxor@gmail.com,
 zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com, rdunlap@infradead.org,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 konrad.wilk@oracle.com
Subject: Re: [PATCH v10 00/12] barrier: Add
 smp_cond_load_{relaxed,acquire}_timeout()
Message-ID: <20260317091705.5a64fc56@pumpkin>
In-Reply-To: <87ms07rlp9.fsf@oracle.com>
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com>
	<20260315184925.b6f93386e918ca79614843e3@linux-foundation.org>
	<874imftol4.fsf@oracle.com>
	<20260316233712.7cbfac27@pumpkin>
	<87ms07rlp9.fsf@oracle.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 23:53:22 -0700
Ankur Arora <ankur.a.arora@oracle.com> wrote:

> David Laight <david.laight.linux@gmail.com> writes:
...
> > On arm64 I think you could use explicit sev and wfe - but that will wake all
> > 'sleeping' cpu; and you may not want the 'thundering herd'.  
> 
> Wouldn't we still have the same narrow window where the CPU disregards the IPI?

You need a 'sevl' in the interrupt exit path.
(Or, more specifically, the ISR needs to exit with the flag set.)
Actually I think you need one anyway, if the ISR clears the flag
then the existing code will sleep until the following IRQ if an
interrupt happens between the ldx and wfe.
I've not looked at the ISR exit code.

Ignoring the vcu check (which is fairly broken anyway), I think osq_lock()
would be ok if the 'osq node' were in the right cache line.
I've some patches pending (I need to sort out lots of comments) that reduce
the osq_node down to two cpu numbers; 8 bytes but possibly only 4
although that is harder without 16bit atomics.
That would work for arm32 (ldx uses a cache-line resolution) but I'm not
sure about similar functionality on other cpu.

	David

> 
> --
> ankur

