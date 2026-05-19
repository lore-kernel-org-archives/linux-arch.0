Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C363FADE2
	for <linux-arch@vger.kernel.org>; Tue, 19 May 2026 11:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188882; cv=pass; b=CNvJyFA7s+OFrq7xPjOzcZC3yitL1Hg/0SH+nXAt3jNCKOZ+cDFfNfLgodezuy6Ai8IlyOowHN8+wfkZwBU+moFe4/hXN5C37q9JSB/fLTv3OD38iouKD/i18NdDfkWtZ45BDNYfabZi8MJct4BY+OKDCOWZaGfe88y9qMiYxHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188882; c=relaxed/simple;
	bh=nhTmhA7EtvBhVzOtpkjubbcdCBekT90z9FnlkG56Nt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJx5MlhHfBSkXLWTKL7ijyMk0UCVz0wXrZhLAdoS5GvW96IM8hwpNRp/yloWdxYYVNxq2ksSQ5daxuGt+MJL5Z2IR5zemuz3IsB6101k31Q39pFxVqT4UJNG91Q+z/fDmxRhMau7OUWxqCDbmtbXL5Z09chLOtDkyhdhoL188P0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkzOT8mX; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkzOT8mX"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2f16c892babso172318eec.0
        for <linux-arch@vger.kernel.org>; Tue, 19 May 2026 04:08:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779188879; cv=none;
        d=google.com; s=arc-20240605;
        b=QzbtYQKnc+x5kbSLC+dusP3qIoihDGDj3IZhSDm5YYBmFlOSizyzsKOfPIQBcxAOS7
         F9qE9jXRZZDl8RAMpk4Wwj4pu/ud6RKN6RxvWziV1gArZdpmPON/fGlRBJDJW6QQERaC
         EXs+e/nNc+kcxTDS5Wb0H+mUuou42GcEW5U8Q9iAC1Fq/8xVcZbyCWKTTLzjMvMEykq1
         2P/HzYvKrwanBs+FHopJyOpu3lTbR+adzhNVujYDBpGKLWKbmQWJwIcK5XPZP6VIqPU9
         5zAlUgANS34k3lJKgQZMQ0vLLcDhBBuA1n5f90+GRPDCH/RGm1DzPg0WR5QPfNAlyf+f
         WQHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nhTmhA7EtvBhVzOtpkjubbcdCBekT90z9FnlkG56Nt4=;
        fh=1OGxJGAH/6SDp8MBcKKjMi9yG3+l/DZ0pwfXvawjudo=;
        b=XE9INek+KQDp8t8962YBD+nhVJYL904oPFyWt3mFn2RUOLKhN1Vrc/9hg7xiXjj61n
         1spp+K2UVG6CNCST4LNd3tLyE69fzxyAnV1ORZt9B3N9jhohUgNV7hHbuS0xQ5HPzKTq
         CTraer192gOlSHE4FOQmqxthaLPwrfSMjd/MfpVAyLVE9/CwEbXJ6fFzfzWA/1F1POHS
         tT3DO5KIfiLtUTFoYoqw14b2LSJcUtG/RQmZr94mlz7OC4qpx5QQqhgB35BEev7Aip3U
         4QtDfDZpxJq4IoOb0Dh1H2dmkdAv2VVxTvidMNib75mc4Zq1wSadNWZLE1g61CFL8SjB
         RXQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779188879; x=1779793679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhTmhA7EtvBhVzOtpkjubbcdCBekT90z9FnlkG56Nt4=;
        b=NkzOT8mXh6bXhnJvqEtApaE4S4veNhy2u4ev1hghBlqH6x0n92yVBDsJ2dVI/ZJivu
         9A8hpggl+UV+EG+gZ3coLNVauocffm06kPS6Vsilr4oCfGSd+pU0V/7UWBN7MJ69Qwj4
         R1O1gypG77mvtOgIEZmtoiOoxIxx/0pznmMVmWyQ4agGZcSLDIFoxyo9RDUI+MxRlN+5
         IdgW+epOIw+p0gT6dT9gkmNG7DD8Tr7Gq7TAph8w2yFKfIgDr2gJ4ppcyT6UkCIFCNyf
         8Jw0CWqYMJEIAQUcdMZMca1DkDroniAfLQjNSAqdcZYDK/d8nqv1CAJ1GQZJXX93ZFJ9
         eCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779188879; x=1779793679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nhTmhA7EtvBhVzOtpkjubbcdCBekT90z9FnlkG56Nt4=;
        b=n4vUs6/5gLjhMMJOxOy2zR2BMVJ/arnM5S6smjsyuqI4lIqHHOQnTVs0PpMZp1n2Hb
         +o59rTWEDBlN/D1wv87mDPmWmfaoDSSCPLnfq4snpKA8n+kYaaWoIxU/u/TotUkjFftB
         RvSrigXrsR9Mug2+Ca+UKCJzhjFyGDHpyE3T2RpKz4NF4qV8tHNHEF92xIdGyN9pLeRP
         1fqrxR5qZFK4cXokRayyDfCmxW2N20WM9VM7jDSViL4mDUQhVIolUHKS2U9JbNHh9zLr
         A6J7Iv/jdxmVa0Bo0xHCBdMLL34KKlNVF3/udFSQEjWlh86XfKudh5/L6XJycBt5c6G7
         aobg==
X-Forwarded-Encrypted: i=1; AFNElJ9F2KldSPypFngreC1Oo9B68OGv+Ig1ipfyADnX3qBoP3CcKdTiDKWBuFXHHEELJEsGbW+FUqiqdTay@vger.kernel.org
X-Gm-Message-State: AOJu0YyEfmdSd8ZWy/NKbsB1YkJD8T9D9PfpCpYBNEU1EA4HlUcwWWfm
	byWfxczZRHj12LdM9AawEvTw7EKkYR92P8mw4tuPNo4bNyauyl1QNqRUpFo3fGFPPVJcvVs47T6
	7edNXqWGav1SB73U6atZsIKcLsXnCxac=
X-Gm-Gg: Acq92OFzZeosOOqQSFDS5ttzL0o+6Sy2b4WutseRMco4yWBzMD9S4zqqFhej8jzMJ6g
	waUxVLmbtDDuEtx5q8a9vYm0/64GAQfvIRiwJRDV1fO5kRzS6Ttqa4qccfQTydgsO/G8inwLXI1
	yJYaLRsjD9Esok20Xsfk2EX6EZ5ZSNNesxraOGhTqu5pNiV1JZ14bQdgqiy2p7EPgPD/V3u1Uae
	0dzNmk2149bwENtfyrSEY3c7koEpdbOWWz10H+HNbcgc065Ptjf6MT/X9AgE+w62f8JyuMJyPVk
	rgzagyycntnCBnAQ1NZKBWhUzNNhu2zEcFjjLcCtuGnGU/rcb4nCtV2qL6PVyKlu3ScCLc4M7pa
	u1Va+uaWEX76rkDPgUKCbNb0=
X-Received: by 2002:a05:7301:6785:b0:2f3:3835:2010 with SMTP id
 5a478bee46e88-3039870650cmr4323491eec.6.1779188879399; Tue, 19 May 2026
 04:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518042833.272221-1-enelsonmoore@gmail.com>
 <d40b1e80-37fc-4c88-9d7f-dae6458efe6c@app.fastmail.com> <20260518105735.GW3126523@noisy.programming.kicks-ass.net>
 <20260518172444.zyd47mcagrcwu7wt@dev-vm-schuster> <CADkSEUjhq6HSdg4ignzbuJiN5uXATsTdxFbRJ3BMxs5=WUWLDg@mail.gmail.com>
 <20260519103012.blot4bssgiqfer6p@dev-vm-schuster>
In-Reply-To: <20260519103012.blot4bssgiqfer6p@dev-vm-schuster>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 19 May 2026 13:07:46 +0200
X-Gm-Features: AVHnY4KWOiWEY77zuE66kq3xKsBRyVSkUGj1e6jCXaPb6QA3ygej9CY3aqSmM8c
Message-ID: <CANiq72=6oYtHf0Q1NaLXZ+25uQyYbej2xnvUhtgpHyvozhP7_Q@mail.gmail.com>
Subject: Re: [PATCH] nios2: remove the architecture
To: Simon Schuster <schuster.simon@siemens-energy.com>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Dinh Nguyen <dinguyen@kernel.org>, 
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
	workflows@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
	dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-iio@vger.kernel.org, Netdev <netdev@vger.kernel.org>, 
	linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
	Hu Haowen <2023002089@link.tyut.edu.cn>, Kees Cook <kees@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nicholas Piggin <npiggin@gmail.com>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Dave Penkler <dpenkler@gmail.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof WilczyDski <kwilczynski@kernel.org>, 
	Andreas Oetken <andreas.oetken@siemens-energy.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 12:41=E2=80=AFPM Simon Schuster
<schuster.simon@siemens-energy.com> wrote:
>
> Sure, I'd be glad to do so, but so far I refrained from it as I was a bit
> unsure about the netiquette (can I simply do so by self-proclamation? At
> least the git history seems to suggest so...).

Up to the existing maintainer, in general.

I would also suggest changing the support level to "Supported",
instead of "Maintained" -- that would help justify keeping it in
mainline.

I hope that helps a bit...

Cheers,
Miguel
