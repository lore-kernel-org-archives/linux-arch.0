Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B6036F429
	for <linux-arch@vger.kernel.org>; Tue, 24 Mar 2026 01:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316533; cv=pass; b=O605HysCr+JrWUQrb4yCuf7/cDPdotBLdGFjt2l+qGBDE9qRAgu8pj8yEzD/tiy/eKNIAUjA2XEiqEpOW9/eN2gSuNaScoJFYodItwR5KpWdyogc9MvtmIGRRRmACsWT7RIBIZt6HtHF6rFepaiQSCYBUmPILPr2wxS4eXsNRaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316533; c=relaxed/simple;
	bh=r7y211ubp3omMELp5KqhHWQhgFjAYpzJD+K9D8lTZVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aplernYo/LR65uajl3sH5vRm+Y805++ozVnGhmvVaC4oaVGRfLAXU3eXyLnFN3K7kz4HksuBGIWIXsrv6/5/UMjaHYV8uqD+YgAl0VxpfM2CmVrQjAoJfidufFkrQrzd/O0C9tfXA5rgfF/k/kd6wjAJOcqVdmP6Nbvi8r068f0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKs8pDCn; arc=pass smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKs8pDCn"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-43b41b545d9so819994f8f.2
        for <linux-arch@vger.kernel.org>; Mon, 23 Mar 2026 18:42:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774316529; cv=none;
        d=google.com; s=arc-20240605;
        b=du2GOrq6wlTBgg+8/BJTtSJYAJkJJww4lt4N3E1erkL7U9p184qhUXw8FX7i+QzZR9
         pKtT2H1SMMjDtNZLajhayO1+L0gSnh8ctHGgVty+oaCsiRZ8evUOrwvbDJs/oLljk7CX
         4gRZserfnOHxytqMMX88z63EZ5BLqt1lshRx4m7aGUl0FXuu2sUw25lHyPfzF/FlDkGM
         RLGXNCXFmqjOBi6kcBg95c3Ty5F/QQO9de/1qtu6KD1V0rqWuSFSZAGvFIs3S8wjtRLU
         lmCpZEcCtp/DYHcCo7UXj7IsQycLbresHzCeinZ7LLAQN1wHdkqPRbN7KPcVaMQGUEQT
         LVsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oczxcm+7nIYhSCAxtv8AlUWabW040X/K7A4VrdDatnY=;
        fh=CQDfzYC5976Uv+PpOQQOYk1ej22Mihj/sBwP+Qwz49g=;
        b=dzqpBfc+xFuvEPQPINn3FJCxPswbMbNlq7anJFzFj+Hhe5UkhB19LCLVFWp3iAQzHg
         0xeXm1UVxy8bxWi0bfdB9TN9U0zxigx9998Xmrhn4tDOTc5YJxpBYRMU++eG68jjXlOc
         +9tmgNaqUn0twe10e7+0Km8kA5C5+seyuop5u9ipp7cD8lr8FGBRdNJaZi/0UvJjOU1b
         6uIAEx2yKWcNitcoyj+74LsMVqtBw2At1s2QF6JMZk8KjAvUGhZaaE4S7W8wCgR1mTdr
         B4nOz3+NOue8PisRCtt9uUnqqnLFbv0g3nNP39fWlQ8H78Veb1um8uW+dD3/RFjjTUdV
         WuhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774316529; x=1774921329; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oczxcm+7nIYhSCAxtv8AlUWabW040X/K7A4VrdDatnY=;
        b=HKs8pDCnsqZbg+efqRElU/3hk6RLrt10qQMxA0BouX8bW2WiqL8v/8xhFzltMnQNA/
         EsD9dCLiUldsx+eUvYw6Z5eIlhOe0gtw+6qGIxgauhtJONqcqpyU2kJa/g8RDRVtQtY6
         9vj/mTdgeMLpAPr+spnh9AN+CQLdMklT784IMUbZAST9HZbfXCSbUjy+gPp3+T6msxwD
         87opeLCtObJYEKqRLDR/xi3rVnZ4rFQiL1j/AmA0dH7k4ygujsBuFnuGOunRkOoLlbRS
         2R6jkrDMryrb0uTEJq2rYcj98zFn6vxOqI8SpmL3aQ+xOGBL2g9iQMEkvIVVPz6ovjml
         r/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774316529; x=1774921329;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oczxcm+7nIYhSCAxtv8AlUWabW040X/K7A4VrdDatnY=;
        b=Gh9YnrH2H3XQThsWM3xRwpmS7ZQ0SD3WMxemKgTFAMMeRblGTJwZqWCB7pWngjlgfW
         2aO3SNe9vst331Ph3Hyjf7w7jmiMGmL0OdTTin0TTWx8CYh/FwBQHfzy3qt5HbEiZpRY
         eh2ms7WcTbI62mKDEZLpW6GInxwxsey7csNCEzdrkrjAU3c3N7XqH9kVZxTb1KOLAWRd
         B8js+meOLklLTHyNDgnLCHI2oTQCJgzMkf2MCOOq6FV0XCBgl841j4A08AVeRAbAfMot
         ALPDsw0bEFwNqN/NKwH2H024t8CeFMvIroUgC3G8bbs3iVYyYfEf1f6APyO+Il0+emoP
         Md7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVugiuKHb7lDb+ui+KOs4eBb0ZqEFYj1QexS9LsS6iy8ys7HjymSYqaXwTJ5L3v3wc+S8Taa3p1YEI8@vger.kernel.org
X-Gm-Message-State: AOJu0YwXYKfO+FmPQOlCCPEn9WPllbo6H1zWeJnIzO8JPFJPtzdluPDI
	hba3LTNcsjaX1mOzUfMFhR83+BRGLXaD5jE1tV9loxD++9qLal1o65kEMxEOLer1TRqAur09IeY
	JSGH7+GozoUjHiRFQyz4jY/T3gIKpHqS/UG3vy5w=
X-Gm-Gg: ATEYQzy4z1yMVGfOI8K8u4an+YfTc3km7I89L7iD+MGSV/RB5irZxASFvsTrPqpFTFy
	hzXPespiKRMZUWxNyFjk+MhQJylb5VMrK4rMZb/YYR4iiTWvzoc7QnOcJo2cbKsHS1rGaWSCl8D
	f1djWRgS2N84esuG5vwysDd7Co7MLGj1Jsu+lREzxPBwpPdSak9At05NCR5Ud1gpz4OmfwDpLJm
	D4X6gM1gIGI3OqQn0US4Pd1ezPHuSw+mLSRXQdl5lNBL7MH0ZwkbrCxtpumgvCFiL1xGr1Bzn1Y
	py+tH/fsN8WMk3jwotLCPK1O49evF56e+DEup5jmI0MLjr/2Nhv9fptXr5k=
X-Received: by 2002:a05:6000:25c1:b0:439:b3bb:2777 with SMTP id
 ffacd0b85a97d-43b6423bc5bmr22855250f8f.22.1774316529365; Mon, 23 Mar 2026
 18:42:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com> <20260316013651.3225328-6-ankur.a.arora@oracle.com>
In-Reply-To: <20260316013651.3225328-6-ankur.a.arora@oracle.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 24 Mar 2026 02:41:32 +0100
X-Gm-Features: AQROBzCFkof4eO3sQ5Mi_04Kqc10_skG3cyZZaVxF4JXZB25lRZil-hxigAR01M
Message-ID: <CAP01T75VaNGk+adULuX3q_8uxc0z78J5B_5ECLy2VR=i7pBi0g@mail.gmail.com>
Subject: Re: [PATCH v10 05/12] arm64: rqspinlock: Remove private copy of smp_cond_load_acquire_timewait()
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org, 
	peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com, 
	harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org, 
	daniel.lezcano@linaro.org, zhenglifeng1@huawei.com, 
	xueshuai@linux.alibaba.com, rdunlap@infradead.org, 
	david.laight.linux@gmail.com, joao.m.martins@oracle.com, 
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Mar 2026 at 02:37, Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
> In preparation for defining smp_cond_load_acquire_timeout(), remove
> the private copy. Lacking this, the rqspinlock code falls back to using
> smp_cond_load_acquire().

nit: This temporarily breaks bisection (or rather, leaves things
broken until later commits), but I don't care too much.

>
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: bpf@vger.kernel.org
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Haris Okanovic <harisokn@amazon.com>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  [...]
>
