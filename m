Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11EB2F84F
	for <linux-arch@vger.kernel.org>; Tue, 19 May 2026 00:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.194
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779149651; cv=pass; b=KYpbdd/6wy74wSupRpbVf+gn2mYaBjVocGVnZS4ceb1ivCG+DLVYS7rTrwGp608lpjdEsEw6fWHtmUrX6n12tANCYh1dC2Uv6ygXGoH5LXXfbC3vMxdt0I/zE/aC9eEVfCERCseTqjSch94dgpaZZ1TFWfS4SnetktM9flOnLPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779149651; c=relaxed/simple;
	bh=LPwsRaL3/VhQKGJMHLIVfCwqYVCTUXR7opK9047JBWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TO4rv0ZmDgwtf/X3u+bgNYl8NnGyi2bM9eJNazdUgYTQrcnEFKOd+KIAWYUwEYjO6/FdSd9IuVTOvjLDJEq1GWKM/xXRXrozF8oYTAl/DZ3knFp4X/C1XvCpT3UIrFLyhvmdplXqc22W7Di5rLQVReHwaHZ/ejSnvYhg6W8wGhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d59lwcl8; arc=pass smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d59lwcl8"
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-5148cbdea08so25804181cf.2
        for <linux-arch@vger.kernel.org>; Mon, 18 May 2026 17:14:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779149649; cv=none;
        d=google.com; s=arc-20240605;
        b=cTpQugXtOvgbejEVoaB0Mtv5tdyp1U1cybCpTiL2mIEkX1jgsCtMdIITnTLkIFj3r2
         XuPA6bsIbpUISjzUbV30P4Fp6MmNicrYsd+x8v0Nff+yIzJdz6uBiAQtC+otCrCOjB3l
         DooIm5mrLrtnhk4UUkllNndC8FFXMNOT9rXRjFi6EufIlablcq8MrRANE9jjqQf98tac
         zhBMIj6p9b6m1Pf8Ano33pBpbCWTHCgs4V0/TWxz3mHKQTtFr22ELYVh9xFtohGjMu90
         EJWYUKt1o9Pxc2qQgESEYE6lhdcE6MfzcNDlnPrPhJv9z9oVi9jW3dqK5Zzx0hXpCuYO
         xwYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LPwsRaL3/VhQKGJMHLIVfCwqYVCTUXR7opK9047JBWk=;
        fh=A2MhY1NgmkEP2WzqOkCfkt4p/sC7OuC5sKG/gb4NVX8=;
        b=MasPG/+oeZjDcG16BSU4k/BmDXrtWRPnEGox/1ZaK3ZxUIzJPS7U3Xqc+KtdCxwBbS
         75/TCNdfBRq5jdE2f75R5g1Kdd+7ZHYZDEtEqu6M+jIqSaaWYmTmOZnZxDyqyoHFFBT1
         zpgaI9C71INjrmzFpUa/iPdtT1yvIz/mNr9DiAMG4EQLem7ck7cm/ulb6mZjDmqBd5kx
         qPfCsgsUFhbbM6HYuyx/ORHv5COtc5NGZr9d6t8mJzoOZBnFj6HWRkAWZNnIkItEbEig
         m2e+eEH6RtHe2n5EQWYgHHTbCOX5hdheJkTILZcJSJ+IE1M02bJBWR3sulT3JOZcSJfn
         fcEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779149649; x=1779754449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPwsRaL3/VhQKGJMHLIVfCwqYVCTUXR7opK9047JBWk=;
        b=d59lwcl8NvuOHlMwJ/jtLfvIVKwSl887jI0zUq+n+MokZhIz5kSNG+Q7m83cRRj++o
         7S3rzqts7N4yutIkInkFXV9kygWG7yxiMPc0JWryBnFhkU7pGX5375FZhqllLsu46QxD
         yqRXefPbKqpNqDqlvNkmKy9NH53MH/MzNhs5i0t6EGN/qbHwnG3z9w6y+vTpWbbm4ui8
         +Y/emkK8/ZzUeQNXSb3F20EcO2qGGKw0KLfo5yfAg9tQxjLb8ir1PQn5DJpL6n74Uv7I
         Kzy/KgWqFZU9F5z3/y0h3xh8lwac6mtJi6nFuR/ealUBmYZWKM9xgcZKuPtDs3lS0PL6
         E+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779149649; x=1779754449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LPwsRaL3/VhQKGJMHLIVfCwqYVCTUXR7opK9047JBWk=;
        b=YsLxXH0YxsgBOaX4b7OcEahEbbFvSDKZw4BHfwh+LNtS4VoGFoP22YPTi8wK6jggTj
         9pDWia1lgS1RZg7QGLrzq53ST8N9k454pUhhXSMxbC1gtSrrFpM0JBwJmcMTHILE/QT4
         uP5i/+XnMOLj6LCXyQvILheYw6gVAXQ7FzvJVTghFHKwwrNki228xXe8PmnHZeg31IZe
         WFEqJBtMpxrgE2lO3EibwXUtjVJbTZqmmWS3ZWJm/ick9ZnPuSE+HQKl0Tq+d1xAgvum
         NuDk0X1bIOky3vwexQyuaQ/yYKMVWjN+L8VxxAMqJ1yEYli2Qo2MMSyUhiEIksBhFJUV
         6Iiw==
X-Forwarded-Encrypted: i=1; AFNElJ8BvVKNHaOY2FaWHjDIz8vkaxZjeMVwdNicLUEnSZFTf3igmP/B8KTFyPP2ZrMT658CViOtC7iKr3zn@vger.kernel.org
X-Gm-Message-State: AOJu0YzhHMa/JCLFoFf0fZRmF9OqhuaMlJl2lBNvggjKjRoiID+pOpAV
	jtTllvAbXoiUab/03wB5xR84jtju1ZK2rHsVZnTepojFIscKzJvo8hMWwhPPxlGlyhs2f/Kl9Zx
	cRoR7cUm6mF+VYzgKtZd3XkbJi0IuVa0=
X-Gm-Gg: Acq92OGtQpx2a5KHAWXt9+1P7zE8R5uVlzBaBEFhHim2iOyEiAEmtZSqzFrsCgMGg6d
	hc+pUaRDjs1xlZ/Qy4Io7T7k2ooC1WmVTgtZ7c1SLArrXmT+mcXsWjBy6uz/yhH/+H8VbOB+F0o
	c8JsRUzo2mukO2xGaW7Iql+XY/wK/wSAqNQ2m23a1vZ9PtMXZa/RjLa1EukDqmM51ayRjCOS8FV
	0//eSPXE2lsMxZInRFJEtPkCiNzyDw+FkzDbVkwPYtJxJpKHrZ7qxUv692y4J7FQs5Q9SL+vRsb
	2FXqXmRFEBYohy97H8BB+/1xiueGxM+XnzlY5SsoAdWnmfBTpR0GmPJNOjQCOQSiCqFsu56cFiF
	i52Q=
X-Received: by 2002:a05:622a:d0e:b0:516:707a:cf8 with SMTP id
 d75a77b69052e-516707a0e9amr149948671cf.44.1779149648695; Mon, 18 May 2026
 17:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518042833.272221-1-enelsonmoore@gmail.com>
 <d40b1e80-37fc-4c88-9d7f-dae6458efe6c@app.fastmail.com> <20260518105735.GW3126523@noisy.programming.kicks-ass.net>
 <20260518172444.zyd47mcagrcwu7wt@dev-vm-schuster>
In-Reply-To: <20260518172444.zyd47mcagrcwu7wt@dev-vm-schuster>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 18 May 2026 17:13:58 -0700
X-Gm-Features: AVHnY4ICd7H9-70Xucdx9uJAfA9u6BhUaXyRyteuNE6Jo8mNtePRuTvmeSFjqyQ
Message-ID: <CADkSEUjhq6HSdg4ignzbuJiN5uXATsTdxFbRJ3BMxs5=WUWLDg@mail.gmail.com>
Subject: Re: [PATCH] nios2: remove the architecture
To: Simon Schuster <schuster.simon@siemens-energy.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dinh Nguyen <dinguyen@kernel.org>, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
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

Hi, Simon,

Thank you for notifying us of your continued use of the Nios II architectur=
e.

On Mon, May 18, 2026 at 10:24=E2=80=AFAM Simon Schuster
<schuster.simon@siemens-energy.com> wrote:
> Unfortunately, as we are an infrastructure provider for civil energy
> infrastructure, the refurbishment cycle is a bit slower than for
> traditional consumer systems. This implies that the traditional LTS
> support duration (max. Dec 2028 as of writing [1]) is rather short, and
> we would be glad if we could keep the architecture in mainline for at
> least 5 years and only then "decay" to LTS.

Your reasoning makes complete sense. However, there is an alternative
to maintaining the architecture in mainline.

The Civil Infrastructure Platform project maintains super-LTS kernels
(and a set of base Debian packages) for 10 years. They are intended to
be used for exactly these kinds of devices.
See here: https://wiki.linuxfoundation.org/civilinfrastructureplatform/star=
t#kernel_maintainership
and here: https://cip-project.org/about/linux-kernel-core-packages

CIP will maintain kernel 6.12 until 2035. Is this long enough for your
lifecycle? What kernel are you currently using? If it's newer than
6.12, we can easily wait until the next CIP SLTS release to remove
Nios II support to avoid a downgrade.

One important thing to note is that the default CIP kernel branches
are not equivalent to standard LTS branches and include new hardware
support, which has a higher likelihood of introducing regressions.
However, the -st branches do not include these changes and follow the
same patch acceptance rules as standard LTS, so they are likely a
better fit for your use case.

Also, CIP focuses on architectures used by CIP members - currently I
think they are x86 (32 and 64-bit), ARM (32 and 64-bit) and RISC-V.
Since Siemens is already a CIP member, you can simply ask them to add
Nios II to the list, and you can assist them with testing and directly
submit patches to them once the standard 6.12 LTS period ends.

I hope this information helps you decide on the best course of action.

Ethan
