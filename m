Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84383A960E
	for <linux-arch@vger.kernel.org>; Tue, 23 Jun 2026 05:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782192369; cv=none; b=Bs7ABRgZmdkTwXZuBOHoVyvsate02Jzd07ypioNDFATQ/YB7RHx4LAePJqLCPmKps5FzyrRNzKOnBUNplB/SG20ES8Xnhp+kwL+hxYPdQYxhhm17TUDXKGROJoZ5jJrTQnu56MfpRR34baz5b4TOGHCtDE2u8PeQcC7fylb5v9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782192369; c=relaxed/simple;
	bh=DjSs5oRw9rccbhTB4m6pdAGiet3QtdAO5qUM5zvUvsg=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=tKTpaenmtTtLGdeWh7gfrVzaXr+cipbDXrJ/0tVsOb4Hl0kkmmWNpxnE5FnE5u35dj6OZiqlOwuOgyb2nUd0al8HaPZgoz+hHatxAUg+qNiejChrRnaF8KxP7PIjaUQeiFUG0hZcH5l2uXSjfzek6JIbOcBFybGRJM64YONflOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=quAcfAc+; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="quAcfAc+"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-30bf132969bso6540340eec.0
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2026 22:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782192368; x=1782797168; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPvEzMllSbsUeGZyzSL2DVJCIDjlLydKz1PcX2CIArY=;
        b=quAcfAc+KwRbKomjlQ7OiNMV8QEi8jSn8Odt68rJIlULORthSyjOAwkegrYPyPZSq6
         hNf6IqAhMz0fcANJgjvfSnSAHnhgceyvvWnf7wyuKmSMgYyaHH2YqWX6ZhmbbHLRmqvr
         aKmBZTdtD/BANMu+hZghsaifUFfnGNhwX1TFrGRHih3MZ6O3P1qtDUlMx8FVFmHIe281
         rq9bqMojGlaogwe74714ZbAlhp7SST1U6jGkMiqC6ewdBTcDmASN8y/KV9NxUntnM+eb
         ShjHnLIYvBPb+SQP29yOuOOd4R7m9xXygN+EYVHWb8QHnjKIY+2iD5pB749zZcQeR2GA
         DJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782192368; x=1782797168;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FPvEzMllSbsUeGZyzSL2DVJCIDjlLydKz1PcX2CIArY=;
        b=R2zqJZt4B1NLeVxvsTDiBKRxhF7K1l6Ha1tXXBR/lJdPg90Y0hBSZR5wHM+0PZLZBb
         5kWsVaS4qS+IX0y7iXZm/B/2W1ebc2ac9pvUD30fhuwQ7ZOk/pltCBo1g7xd5htEl2Tk
         JjZMEdK7GpmUAizES5zbhGnOlyhFMiqHSIXDJzHKyYZGk7DQsuspVNsc2bC0XzAKn4xY
         ptVmlWEB2lRt/xWiyRp+D3t1f5UIfuhpFaWO6AfQrLILFKvTsw99Ss5zYatea6EDuPDG
         t3+V3qlERYIotX7H33K628AzYYP24oZOBVZL3YaOPb9/2nYY+bUoZqJV0pzjZaOTdbHK
         oIWA==
X-Forwarded-Encrypted: i=1; AHgh+RpmaaG9S+1/EJXNavCN8NwMGhaeIOZpNia5uJgDgejH2QFyqs0T1jjZhFSh8eTNgDEzfwNYKlKr1u41@vger.kernel.org
X-Gm-Message-State: AOJu0YysHFImyy5MMGohO2AeIAOAPVHlTatJXH/f0fwKd9AYXQeCLEuk
	+3jf9V/PchOp1g7FwgwPmnkMjUC/zhtdKjlO9/6yhC/xAU4MTs5fM8G9
X-Gm-Gg: AfdE7ckbOdaeKeCyK88jKoV+xXvzQEizDlLA0+7qso3zBOvsS5uWlQrUg2u/PfuaCto
	psiZg97SghOL9vIbJtgotYXOKbk5Ben2+AQNndwvl+CVYCK4NfXKz2HfAVcuynDEEWb5sf1qXud
	CEaCe9p3G4V+IQ7L/l0g8IP9LcqGpNi1G4zmmTQEQ8HraM1Cq8ZaxXwio58d+MLflkEgNBk8uC5
	m/AGL4SgsTI8fzG0eVDnKSc8CiKACqRKRBQfz62BjoTAJCdAh9u7AoyZu1eJ+uzBSjwHBh7Vy5G
	mHxZvFXSKnLipV/iv1GdGq3ycSx071AxYz8cHd/97vrayA24C4a7UCx0mlvT0XQkp15yojh/6Nn
	9+jHus6zZwQ1LbEfnctIDk7Kjffulm4jPylPw6yMT7zvYVgEclLqnM/TaOfV2CtHNaj337mWSPt
	dA3N/kpRs=
X-Received: by 2002:a05:7300:d507:b0:30c:1276:cdf7 with SMTP id 5a478bee46e88-30c5bc78138mr708393eec.25.1782192367703;
        Mon, 22 Jun 2026 22:26:07 -0700 (PDT)
Received: from [10.0.0.65] ([2601:647:6700:64d0::92d1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1be4967fsm13102455eec.26.2026.06.22.22.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 22:26:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 5/8] riscv/runtime-const: Introduce
 runtime_const_mask_32()
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Alexandre Ghiti <alex@ghiti.fr>, 
 Charlie Jenkins <charlie@rivosinc.com>, Jisheng Zhang <jszhang@kernel.org>, 
 Charles Mirabile <cmirabil@redhat.com>
In-Reply-To: <20260430094730.31624-6-kprateek.nayak@amd.com>
References: <20260430094730.31624-1-kprateek.nayak@amd.com>
 <20260430094730.31624-6-kprateek.nayak@amd.com>
Date: Mon, 22 Jun 2026 22:24:56 -0700
Message-Id: <178219229643.10927.7189200920480581019.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782192362; l=1456;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=DjSs5oRw9rccbhTB4m6pdAGiet3QtdAO5qUM5zvUvsg=;
 b=Q7gZYCRpUNaR0P6LCnsW2BKyT1zjAR9X/QtNq425aoOkO4GWUw2wE2DMsLI9hCenc1NtUPLh0
 LKuQabhh/3jCnBFxJDuU/QtOQWYl5v1MrRasvhVADGKiAdB5C5B53hi
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=

On Thu, 30 Apr 2026 09:47:27 +0000, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
> Futex hash computation requires a mask operation with read-only after
> init data that will be converted to a runtime constant in the subsequent
> commit.
> 
> Introduce runtime_const_mask_32 to further optimize the mask operation
> in the futex hash computation hot path. GCC generates a:
> 
>   lui   a0, 0x12346       # upper; +0x800 then >>12 for correct rounding
>   addi  a0, a0, 0x678     # lower 12 bits
>   and   a1, a1, a0        # a1 = a1 & a0
> 
> pattern to tackle arbitrary 32-bit masks and the same was also suggested
> by Claude which is implemented here. The final (__ret & val) operation
> is intentionally placed outside of asm block to allow compilers to
> further optimize it if possible.

If the mask fits in 12 bits, we can nop the lui and the addi and just
patch an "andi" instruction with the 12 bits of the mask. We already do
this with the lui+addi block and nop the lui if val fits in 12 bits. I
would be happy to help draft that optimization. 

But I think the better solution would be to take the power of 2
assumption since that will also benefit arm. We should still only emit
an andi if val fits in 12 bits, but if it doesn't we can patch in
shifts:

slli    a0,a0,x
srli    a0,a0,x

Where x is the constant (arch_size - _futex_shift - 1)

- Charlie

-- 
Charlie Jenkins <thecharlesjenkins@gmail.com>
