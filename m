Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8343EF0A1
	for <linux-arch@vger.kernel.org>; Tue, 19 May 2026 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779180508; cv=none; b=NgUNFST4HGMn4LQCd8pe+Cvlga2yDn9M4urP1DYGpdy8+aAfCTfsNB9ubHog/s4ocghuH8/fNly9LAI8dWTd6XkePcN1FAGk7EV4qyB5JVn5bQ12hEUAEmbRwoiqoMcPFcEKE1IKoGftt6Q5wePnj5ZK0jGP/ZM6MJC+TqyjawI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779180508; c=relaxed/simple;
	bh=Hyx9uiXztVttxLdo9VjcbHUiP6qvqHfhOZr9vbJAYdk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FPCkjq0sOZWh9QhdrmK9J/GyBRxd20kmg30P3lJxhSn8tuHgj7/xxF3e0CB+xjiqxkUkrDd/WNbydq1L2SNMXtRiaj9JBBa4J8U50x4F5nMnLktn/RZKLbsZGSEkxnBCYjNzaVWWEaqRtC+4Cm0ml7oOtcD25kD8xAd+7xtirog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKm0WEKT; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKm0WEKT"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488b0046078so29359655e9.1
        for <linux-arch@vger.kernel.org>; Tue, 19 May 2026 01:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779180503; x=1779785303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8U8k5KUlWmxiDre3dDf6j/8PHyhhwOqohUrC9tjzC3Y=;
        b=eKm0WEKT3mVDrwy7IMshOn0GT2kwmWUNussjaxGEyv482mBKvskG0hs7pJ5k+AfXcN
         l7Rjpy9iZzrpocdayWNqfQdXtH/nwyhXHiZOuGC5I7B98fO16ELapo992aMvVW7NErxJ
         Dom6oCaQBG4n0rJrkSsLMhnHP63zTKUiw5KuKnT6p7IvYNK+2mRBlfzqpifVUT/esNd3
         vlhe3vAPa4t8awQvJiHD5JpieSz9o9c/NHG55x2xnbEgyrkqQ4UwvMthmyx0XIjO0dD8
         Ds9+nZuBWp3o5j4Qfh95443MbvDyxxMyRCOg8xUEL3EtMFxko1g7WSrXeeWqy5p4Vy/L
         m4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779180503; x=1779785303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8U8k5KUlWmxiDre3dDf6j/8PHyhhwOqohUrC9tjzC3Y=;
        b=jVcaniRInYs2ALyTSpZz+unINCghA2iUoZjFNmSYIn4rcA3vt1JVGOVOrsnhrOjbDF
         Pugu2xi/lFzv6xr6HI5scMJKxSv4qAryRwEH+WcjhQSjLkVSkpRl7D+IssrpNkEDrJ7j
         REHaj9JAuKHOfwO1jWFXdvdMCOPBEZF4vjhZX84fv2PPOBUZdZQ+cAZDV4qqpKcHEnv2
         ditC9lNLvlv78qy+Gli8NokIjC1oYbImxgboZHUVQ+685OFIkQ57NnHx8vi1s58JH+zh
         W5/pJGO+yVRoT7eNEzEmckYNnCgkLFOPPaJT2xtdv1Fg/wO3M0u/x6/RuPUEzsGbK8lN
         np/w==
X-Forwarded-Encrypted: i=1; AFNElJ/j4vh6JqTrumzr9mrQGcSbDnAruYlgLPfGmOUSw5x2dk8iBvbcbA9LWf0JZo4tF4yUk9HR/Hfq4XmA@vger.kernel.org
X-Gm-Message-State: AOJu0YxVj4rbP3IuQAHgi+fpVEMiUSmns3KYfbV8x3GjJrzjQzl5Kj5u
	zlmbjE4unKaDeLoZdZKTuQ3j/5etvKnXAkR0Y16Xk3ogU553CBDeUbal
X-Gm-Gg: Acq92OGNk1j4Xcf8N6RanBfiLt1Y+9H3gsLMPRZLFUdemPMoKTpjuAS4Ss98SB/6cLZ
	EDuaWbykUMvTLc3GSK1wqqaffpFMUN7lUfw4/phsgFbHQ5s8MZYRg5OqrbFg80I3ezuOzaMwwZK
	FNtRgJb49538ZoAVgA/vSG/Av4bfXOHIXXMFmrM4RVgi4o9ZcRCXgMfwg+ad/5TLrmyU7RH81e1
	WH6/AZPShxFdCzBgmKp8gwM6bicGyf48XR72ERKRHPSfy8W/c6TD+brxpmcBMdjcS74zKy9sMYc
	MnpYOWbvC8fKinyKODZ+fOSz5XVaHNJuVk3ajCoh/P26NQtVwr+MMqvXJlLRYEiITGAjNE3iL35
	1jUVwYzrt2LXKbg8cJuRYFxpOIR/tMisTJ5IQSVP/0SZFkJvtqImPeRRXTLZ8CVfl4AkXE59vKd
	ZW1Cll40EI8+hmQWXTahbdbNIFd7hSn9P1XD9PX7EWe2Wd9vo6Valkjblds4xWOMvD
X-Received: by 2002:a05:600c:3e1b:b0:48a:8905:a500 with SMTP id 5b1f17b1804b1-48fe60da647mr311906705e9.12.1779180502860;
        Tue, 19 May 2026 01:48:22 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c8344asm530004325e9.1.2026.05.19.01.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 01:48:22 -0700 (PDT)
Date: Tue, 19 May 2026 09:48:20 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
 workflows@vger.kernel.org, linux-arch@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-iio@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-csky@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Daniel
 Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, Dongliang
 Mu <dzm91@hust.edu.cn>, Hu Haowen <2023002089@link.tyut.edu.cn>, Dinh
 Nguyen <dinguyen@kernel.org>, Kees Cook <kees@kernel.org>, Oleg Nesterov
 <oleg@redhat.com>, Will Deacon <will@kernel.org>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Nick
 Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Vinod
 Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Dave Penkler
 <dpenkler@gmail.com>, Andi Shyti <andi.shyti@kernel.org>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?=
 <kwilczynski@kernel.org>
Subject: Re: [PATCH] nios2: remove the architecture
Message-ID: <20260519094820.1f05ab8e@pumpkin>
In-Reply-To: <20260518042833.272221-1-enelsonmoore@gmail.com>
References: <20260518042833.272221-1-enelsonmoore@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 May 2026 21:28:33 -0700
Ethan Nelson-Moore <enelsonmoore@gmail.com> wrote:

> The Nios II architecture is a soft-core architecture developed by
> Altera (since acquired by Intel) and intended to run on their FPGAs.
> 
> Licenses for the architecture have not been available for purchase
> since 2024 [1],

Except I think they got 'beaten up' by some telcos.
The Nios II gets used inside fpga for small cpu doing things that it would
be far to difficult to do in VHDL.
(I believe some mobile base stations fgpa embed a lot of them.)
These will have a small amount of code (maybe 4k - 64k) and a similarly
small amount of data memory along with access to fpga peripheral registers
and (optionally) host memory vie PCIe. No MMU, no cache (or rather the code/data
is in the cache memory but it isn't backed by anything), no branch predictor
(guaranteed cycle times), etc.
Intel suggested that RISCV could be used instead, but it isn't the same beast.
They didn't document the instruction timings nor how to add custom instructions.

The company I used to work for used 4 NIOS II inside an fpga.
The instruction timing for one is pretty critical, it has some code that
has to complete in 122 clocks (worst case).
Our solution was to spend a few man-weeks writing a compatible cpu!
I think it came out with fewer pipeline stalls (in particular it 'lost'
the one for a (predicted) taken branch).
The maximum clock frequency might be lower; but it is ok at 62.5MHz and the
higher 125MHz in just impossible for all sorts of reasons.

OTOH I really wouldn't run Linux on it!

-- David

> and support for it has been removed from GCC 15 [2],
> Buildroot [3], and QEMU [4].
> 
> Given all of these factors, it is time to remove Nios II support from
> the kernel. The maintainer stated in 2024 that they were planning to do
> so soon [5], but this did not come to pass.
> 
> Remove Nios II support from the kernel and move the former maintainer
> to CREDITS. Thank you, Dinh Nguyen, for maintaining Nios II support!
> 
> References:
> [1] https://docs.altera.com/v/u/docs/781327/is-discontinuing-ip-ordering-codes-listed-in-pdn2312-for-nios-ii-ip
> [2] https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=e876acab6cdd84bb2b32c98fc69fb0ba29c81153
> [3] https://github.com/buildroot/buildroot/commit/6775ccc5a199d574ad70b5f79ec58cce97a07c6f
> [4] https://github.com/qemu/qemu/commit/6c3014858c4c0024dd0560f08a6eda0f92f658d6
> [5] https://sourceware.org/pipermail/newlib/2024/021083.html
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

