Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E4E13790B
	for <linux-arch@vger.kernel.org>; Tue, 23 Jun 2026 05:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782192366; cv=none; b=JhO2EZlZuxnA5qJdGGcdCW0A5SJ9q2tjx5rZJaQhB8CTZfG2dDqmhTtC32imMmdt6MLR4R0eD4oVkDL2S/cTriDNax09uX0L+XE7JwhuiZdNdS60RQ3/AkwfQvMCsDw3p+/e1xzSlE6Gc7EHczOZh1ZF/PnAUMOxdJYYDWvORAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782192366; c=relaxed/simple;
	bh=zWdKKKHIRtfVkf/fFEjrVdv3jvJPJQtdRvuIlBkFkhk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Gs1Y7Tqp4lD/bAn52KgX6bOFy37s7Ve/t1DE2bk1FOa/PcbKkViVLq+/oZPwgpktcam36XJvOk8saFr4r1zADLOJ4Ab40kPPC1M669GygmStpm2JFcWXf5NbxlWBcchctLnvL5O41o48ghCIQ3idt25APk+NnPN0wjkFhGdro08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpkGsgiY; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpkGsgiY"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-30bc871ecdfso6164230eec.1
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2026 22:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782192364; x=1782797164; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9P+/X0AgS9w9pvMplF3SoP81B1eDd+b9FueSg0/UkAs=;
        b=fpkGsgiYTuT33XwJK6vBndFtBq3BnK+gYXsqdqkQ5M5Dmtzb//vqRW+nLE+VVLax0z
         GSf/RdVDwMujApK6MQb7bBKhurWXk9EwBoburqVSvPCcQqZMf/EI0BNCJeKZRj8z8OHr
         F8PafNHCVMkFrje/cEYMU1elBDXJaW5yprLLf5QsCNt1en6NgoTrrpWhIZuIVIZyFTAc
         0eShmLfxF5JZ+SOJyVko+LXLQvcGpre+hsbilB9bKwBsBi9b3AGOgM0omkIJCID91K5l
         5MF5VkRnlVKt7XUP7eTP1n5RpCaPv222/T2d5BeX8BFZCETr1aS9iPWoKdwlpiZbuIWH
         i2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782192364; x=1782797164;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9P+/X0AgS9w9pvMplF3SoP81B1eDd+b9FueSg0/UkAs=;
        b=JqXFkz/XtlHCmiq18GHaU9Rm7aDSI5OXAHB52YCM/KfQwIzal12kOP7qu5cQNuxRZW
         vfBID7FRORS/kEn2f01bezRlmU+MgbIL+fdpJP7784cSE5wdQCAUlJ/4D7M5QQUk+t3i
         V8EyKrzEWS48ungmzXkO0NA+Ag8fg6qiV6IJd5f0PWR9b+YY2k5hAXuHZ7yzCfEE2D0v
         d7HUh+R7h+KIyx5U73L9mMAlviAZUeGpiAez/ncYzzJI9UO1ISrDDH3/IDPvo9qu+yO1
         hkloz8ulf8fXzDLnkE4keE2wM/ls/L0FIk6Zt0JO/GoyqQY5EHquel8xWzmSZF27gSUU
         qohg==
X-Forwarded-Encrypted: i=1; AHgh+RrSMnUu3SUEISW31zPro39yUtQzsfkRz1xkOfvzOUGeGXzAoJquPjIuonMKnA6zTTFHNWeaUDWPivdg@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+aiCHeV7THqwFWFbaihaDbAwj+JsWnrf2cWmCy1ZiZ1Z0EJKx
	2U+bZR8/z+yRQagAj/0h2fvIss+sGiz6mktSkjbe1lPvNlqlNMXTJjmGdUv8bjX+
X-Gm-Gg: AfdE7cnEDhTCqyzjhQ8aROdhHhp0j/Il2Wy8z2JnjWYu5eMDd72KbESz0ksXLyJlgzZ
	GQEuIWHgX4VOpNYht6WUZWdNiDNPOSbE5TKTc7ttGdfxaeCjzsRtrrlIJXDccBiA86a5QHUj3yv
	CpwYX8JEyk+3w/eO0oJB32ZZnWMaCTM/UTCW0k7kSJ6wrUvw3RRYMA8nWW3geGyYHaq+mz8RhE0
	3BxdZNoJDiFkxKSitZsspJVXKj3xlD/Xt4V/fIYUREQ+yvy/OvEhvXDLOLKBGueVnvcsHM6Q0Uy
	3SRiWaOYzN6pJxokHxU4mjr3eODozkpTCvsomHjCd0neg6IiSMoKZfBT2xmibqv6eQgbXiiCrhY
	QJWmPNDM/uoorhH50nNgKMxuoJmvNbN1PKnyXKfFWuWgPud1sR41X/V7bCRLKJ8tKrC2MBHVfci
	zStk/1x+wW7MXYaTBF4Q==
X-Received: by 2002:a05:7301:3c8d:b0:2ef:83d4:647f with SMTP id 5a478bee46e88-30c07035e2fmr11143910eec.25.1782192363998;
        Mon, 22 Jun 2026 22:26:03 -0700 (PDT)
Received: from [10.0.0.65] ([2601:647:6700:64d0::92d1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1be4967fsm13102455eec.26.2026.06.22.22.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 22:26:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 3/8] arm64/runtime-const: Introduce
 runtime_const_mask_32()
From: Charlie Jenkins <thecharlesjenkins@gmail.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Jisheng Zhang <jszhang@kernel.org>
In-Reply-To: <20260430094730.31624-4-kprateek.nayak@amd.com>
References: <20260430094730.31624-1-kprateek.nayak@amd.com>
 <20260430094730.31624-4-kprateek.nayak@amd.com>
Date: Mon, 22 Jun 2026 22:24:56 -0700
Message-Id: <178219229641.10927.2049980053557313152.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782192362; l=1037;
 i=thecharlesjenkins@gmail.com; s=20260605; h=from:subject:message-id;
 bh=zWdKKKHIRtfVkf/fFEjrVdv3jvJPJQtdRvuIlBkFkhk=;
 b=khN498z1aQ+psInrw6bQE5qRH/XIMR5tlYyp2iaj4Ympn7B3JrTIKQzNY2a80lC+XUaqLeiEQ
 hj75XonHxMsDBmZroa63UpdTmgS+Vn0VIF2BvLYDbWtudqioAYh6PlP
X-Developer-Key: i=thecharlesjenkins@gmail.com; a=ed25519;
 pk=ajnnRQ98PIdwKp4HeMkq9U32okYbnh6Zb4G3o5XXvkg=

On Thu, 30 Apr 2026 09:47:25 +0000, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
> [...]
> is intentiaonally placed outside of asm block to allow compilers to
> further optimize it if possible.
> 
> __runtime_fixup_ptr() already patches a "movz, + movk lsl #16" sequence
> which has been reused to patch the same sequence for
> __runtime_fixup_mask().

I think we should opt to do power of 2 masks instead of arbitrary masks
since that is what the usecase is and we can reduce these three
instructions into a single instruction for arm (and benefit riscv as
well). It is convenient to have this function as arbitrary masks, but
since we are going down the route of hyper optimizations already with
runtime constants here (and we can always add an arbitrary mask later if
there becomes a usecase), I feel like we should go all the way :)

The and immediate instruction for arm supports all power of 2 masks so
you can do:

and     w0, w0, #0xMASK

- Charlie

-- 
Charlie Jenkins <thecharlesjenkins@gmail.com>
