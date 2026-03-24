Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630C03750A2
	for <linux-arch@vger.kernel.org>; Tue, 24 Mar 2026 01:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316661; cv=pass; b=V5U+y0ohwSbDMQY+/L0h7RIzQPQQw/742x6BnTaiQkT/DyOiJmfDfNQTUy230P/MCXomNKOxOn6E/CvGYS0UW9WY/nEE+iRwvxpryfnbjozuYovQM3Qwdny7TUZAgC9YagQL557Q1JrziaZVA4FNGBd8qEsc+sGRONY2wo5FM5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316661; c=relaxed/simple;
	bh=eN9OIG5xOOm08psjunbqUmZwhSjm3/YrUhUY73RH+vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U8cSqp4vqJiCEKj1fUn6KDCv+wZjQMXYQPZ2TPFASwSRRk/IMNTnrTnpNvgM9AUXphuctpvewGoxzG9+PV+GRLrgovo8lsvqhxkgjyR+Ryu1LAE1y4M0LH+LOtKnDin/R5Aivy4IYxTP7iV3PMqzauo2/jSw0TaJMfDT3HXVyjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPb4eVII; arc=pass smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPb4eVII"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-486507134e4so8444245e9.0
        for <linux-arch@vger.kernel.org>; Mon, 23 Mar 2026 18:44:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774316658; cv=none;
        d=google.com; s=arc-20240605;
        b=LN1C7Zwv2N5GC/lv8/v+Tsd+a5A4OxOpG8kYv3h9R0pY1pkSCs1sswrBYE8v1EzacA
         709c5IqUi00zb3FI1Cakiv6giXYdZTCoQjx/L4USBG/BA7RpIa6J8CP/SF2JWA8NXj0w
         z7Osy9Obg2bCC+Z1fXTyIfndHXUDgUD9C2vuArhSRILw4k8jAUPwbbAYpncHXq2YOkGO
         nis0jhwxjz/wzZ8XYFwvgr7eeHDS9eCxhOOeWtkLg6PQe0durDz8gpLi5xKpomfhj+ZI
         kFwiMFAKhI9b/V9AplEK4S8lPkGCFNVDobVoqyOZZfLbxcvMZEwTnFBBN1DtefdM0/u0
         uKpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oA/BMSG0lIaU8QmGTi1RddZfsLsTkE9mU/q8AbqzqiU=;
        fh=FE+Q79PqukDOibxXgR+yWLDKQuPR0cdFdW3/SppwpSM=;
        b=kFJksyZXzMaTLjGFsB5jXnSWNSsVtR44bjo7fDaRBUawpXT2Zww7gcVn37Xq44k6CV
         seGZhP5dan5O8wPWtdMuILMcznENPFkgYGfbzs4nbC/qW8uIzZ40/BtTJ5upucokJ7H9
         e4mz71trVl+DdQ4cVLHqxqHOqnO0zjcpI2LUzZ+yhYW7x+E1c1O5MtK3H4EXhB+HFEYJ
         N8RHm8qvFF1a/lT4BcMxzj2bP4Nit/xSEAzdDmhekHOd9VhXGZGe4nCssDHEas41bvbC
         qQEjerf9ciktfX8DElz47aqn9nVYz97qEKBOCHMlQmwleUpsi7P9beGP+GvcavtdHlv2
         ZjxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774316658; x=1774921458; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oA/BMSG0lIaU8QmGTi1RddZfsLsTkE9mU/q8AbqzqiU=;
        b=jPb4eVIIHRjE9jzQDGBueykIWAA9HXpF4HGgKP2q1MMiPx7xyajGSko3S+C8DucWls
         RqW3SYLm0yE3Gyrzx9Qw3ert3hXL6JE7KpWpFmxONN5ojo/46Dpg4aGbRGHDZpgxk00C
         YutgLpox23Nxm9XuRP/cmF9PIt7sBekAEuX6IbgBOsZX4sO2em8TX6bhKkivkg+evviR
         m2lKnrJm+7d6GXvn3Ry4bs6pF3NjxYNg1JXaKIZiwTE9Jdaz4ayQKMhOck2dO+40Bwei
         bZ+0iqW/mNgXU0sBKOI4Gqc4dy69+pOORiWiaoTg+PB5yVX56r097PjAdoI64zMquA9E
         aXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774316658; x=1774921458;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oA/BMSG0lIaU8QmGTi1RddZfsLsTkE9mU/q8AbqzqiU=;
        b=MpvhmpJ+LUYMWgH+KQUAvjONjYCsNJ0WGpicR8W7DUqXgzLS1r4K4XtiTYUw0lUMDO
         K4rjPVE/eGVLvzxdH2sWVmH46tKsRJAEt8HTOe9LKvzbUZRO3VhtX0U7G3ZZCQRnroqE
         7qtYotVdJwtYec6cFLeYDBgen2h5SjYjlMUA1XT+7K6rCIOimyfJyRhdVqvnvYNJ7MrA
         CdJb9V2hpf5fChWRAf/dPChduFzYVoq9c2lZ7d1EofTpAVkEDlNsHJC1M+CO4hpDXXz9
         QX8FT7N3d5036CDtU7GZ3kOJOOU3//i11bwXXXXPlF48dJT2Kw2odJULRD4nV9lYJw1O
         ckuw==
X-Forwarded-Encrypted: i=1; AJvYcCUdkbTgeTXB2l9jzMRDrFPe6Is8cIRVwKge+kTkUTgkRQv7HVuCobXodTSBGreY96DC96bUnF1X7Sml@vger.kernel.org
X-Gm-Message-State: AOJu0YyaPSWwRH41jubYjH7kNwpHXRg3iXYSYf+Jm5WguROZ/HR9b9X/
	sgD3wEKZTjdz4sYLQjEQwFOQ9jdYgOqX++j3cFjeLbvo9R3tQY4LfVISH8buPalheS1kuVD0hHn
	2IKaFb9X+M/N8GTep3oZQH936BE+64Z8=
X-Gm-Gg: ATEYQzz/QPy1+EsUqH+j6ccASd3DH3Bkqzzq9H9LhDzij5vtVHlXGnE+5jdyDY5FNqY
	BxG7KZSbkGnAfkI6cYzAk8wHn8P9vZOfGOiiSRYH4DqffGQxkv3Cs1FEsF18k57zuyb5t9+G+R0
	aM1RXpMHw+rd5GikJ+ZoCrHA2GYM/otKOJFDphmoldWZ+9CXruZbp/PmpN6UWSPpXw1LFh9Xg+p
	qmBjUcEgmO0Rx1/QkH5/yNfTqPb6UM7MbnXBzJgpjUjzaJH4kvh7FX0Z3w9F+nVp4Qilw0M5vZe
	MOAIIISH5AHqzVa+QYHrlwUQHg3ljr2qH1K2/XNcXGHE3sbXe4kItjyBtwc=
X-Received: by 2002:a05:600c:3554:b0:485:3ee1:eba5 with SMTP id
 5b1f17b1804b1-486ff01cc5bmr205204065e9.27.1774316657635; Mon, 23 Mar 2026
 18:44:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316013651.3225328-1-ankur.a.arora@oracle.com> <20260316013651.3225328-10-ankur.a.arora@oracle.com>
In-Reply-To: <20260316013651.3225328-10-ankur.a.arora@oracle.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 24 Mar 2026 02:43:41 +0100
X-Gm-Features: AQROBzB_vyabm8gMFgwrt-FFA5yFnsEMVMsPubU3mf_XijBG48EgQr58mCqMhFo
Message-ID: <CAP01T76iJAtfovOAhm+9-QwtbVJRbiQgUPWLBZZXYFozLFK=uw@mail.gmail.com>
Subject: Re: [PATCH v10 09/12] bpf/rqspinlock: switch check_timeout() to a
 clock interface
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
> check_timeout() gets the current time value and depending on how
> much time has passed, checks for deadlock or times out, returning 0
> or -errno on deadlock or timeout.
>
> Switch this out to a clock style interface, where it functions as a
> clock in the "lock-domain", returning the current time until a
> deadlock or timeout occurs. Once a deadlock or timeout has occurred,
> it stops functioning as a clock and returns error.
>
> Also adjust the RES_CHECK_TIMEOUT macro to discard the clock value
> when updating the explicit return status.
>
> Cc: bpf@vger.kernel.org
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> --

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  [...]
>
