Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FCA3B6346
	for <linux-arch@vger.kernel.org>; Thu, 30 Jul 2026 08:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785399307; cv=none; b=CpJRHVVQLEyXzM/yLcdeQjY7RL8TE1DCLsVzVVrxdd6DUQ0z2jAQFg3nQsNa15WrsQGv0g5EdE8zbuhMoZh+z37Sfm2FdGS5QTcW8BbPOY8vu5HO8f9LsrkS9yGG3+tw4PtUuhhEPF7ds39B2Q+RE6Y34PdXu6TtAptp0JUily8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785399307; c=relaxed/simple;
	bh=zIgGXFhPhcmCwRhLNlAk+r8l30LriLi3g1dxUs263rc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EZ4n+p1vEeXMsAbH0PtNQ7WAkMOWxyEmdKKs2krmwkaVgRTvhc+yfIllWWvhlCZPtr5vI6llX+yuiL0aVDcUwq4XsUirrXIfkbs4YTX/7yQKIIMiDgvJ3UbYnaZ571u/yM4Em1IysSSuIdeF+LJR2Scnr9xXrIi3l5ymoXovGrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q8f/YB4Q; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q8f/YB4Q"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f97d310caso1732557f8f.2
        for <linux-arch@vger.kernel.org>; Thu, 30 Jul 2026 01:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785399301; x=1786004101; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gU8t2nLiO6KyR9mHd5oQe5CKsSlNQJu7tk5IuJVGRSw=;
        b=q8f/YB4Q2BvmLLnS3Mo3pHYQEvh9tBDhwsK0NjUV7UF+2N/jm19XI8Z8ux+RHZcLAI
         8Z9AtOgv0EevMC7q+gL37iW236gJkxN0FKcKV1177/e6GsYjI0cnigY7OhoWb3cjMWZO
         b8rioRaWei4mf8lFVNN4PuzNC/aNFyx6wSlCtX6CiJj6FZnw8OxZZYLs9TzFMcMzBa6x
         0YTjyKo7GQMtEjAqUpXVubnpsJpPIHq7L+L8CZdfWFNSmlOwLHP4VeDeXE1JSB6yYIBY
         qlZNf2G2rvEyzr4r5vWqMRhTazEvUllBRLMUbKsBmQN//o+c09vmx6waEwmWXeKgYrf7
         yMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785399301; x=1786004101;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gU8t2nLiO6KyR9mHd5oQe5CKsSlNQJu7tk5IuJVGRSw=;
        b=KCzzS0CmmBlgloaL0SriO9bH59Cb0UnIoZibBKMn4SCzZr1EMgS5pKagAQJ0KsITFU
         UHUTdEPsBNbUcxVOxsV2UO8BNqEF2e2Sx36eBdRdCsNQV5DF5C1yFTWCQKyYWEcMzqmk
         2WdWa7cXB/j8P4OVrR46sXDrdoId9RcHL6UMePc3U8rJK/eEK4V7y7US0XF4ExnOqse3
         9AO2tlfmmowpTDP3ivtn0r5oaQShkk1JsC8R/7u6GlRwmBHf/MTsimfB2KKq9oYfduiW
         aFEyYVp8MIrHTkrHiHXs4tC4i+dcVdoheLg9ZE7BZaHvYcab0Ijl1kGQyJ6yfTyt/FFo
         7ldA==
X-Forwarded-Encrypted: i=1; AHgh+RoEJ89kvbMwjYKlsBtfDd7SJf2YLEqxp56dHs1/ep7p274pHtAYFtsZz+P0FnJzYjAgLa8ag3TqXjhO@vger.kernel.org
X-Gm-Message-State: AOJu0YwjLeSIr2Qsd2bdQmv99DEzgjOk9KQqzVzCSXJ7SPIq/9HvI4tb
	ZD4XBFTuF8ZIX9skqipREcUE9MixjJ6M3rmbsEhgTyzkjWZwWdbrVLsj
X-Gm-Gg: AR+sD111mpD/xWSvrqJqdhj/U8VKyobRTnkJ8NDkpQHxDSChmYfUi0vdRi08BbIM3zA
	5fmolZR1OweipdTWrcP9CD4kZRAp8oXp7XGqDSBIrXl24YEjtS/M5Qmrvv9/ts4JYv30j9gjqYH
	aSXF1C6JuvyPiM2KQVsh7IyhqlcJY70TFbIoZjEBwRhUtYRxTknpEsCjjf6YPP68QnTrPyo+Wng
	vomSH5OXyeDTff7vdGNiOV9EjVLgMt7hiWnn8HfwsUWLtkukdR9HQXhiRF3maE+4O/USuM0U+Ks
	F5L0HH+4NoXVxEZGDod4eiDQdsb3Xsfsl9j7rwBR3SZTy0uF1vebCN+R6G7Hpsj3/X2DRC9O1Rk
	oNPfdzJc1vEba+XkVP1leHNFs17ZYWWXhvYCWZgHGSOI15gpNb6vXxmlBBhs4XYawVSRVRFg9y8
	Gs5POrnV+KPkw6Epd9VzeiAUqgWHH5eJxhyM+PSUsXvFbVV4+15KWmZgZQzIQAjdqs2vTbOAr3U
	IfVcu4FX4a+miGf4FzZeD2ubA==
X-Received: by 2002:a05:600c:154b:b0:495:78ea:2687 with SMTP id 5b1f17b1804b1-49800eae778mr19575005e9.29.1785399300682;
        Thu, 30 Jul 2026 01:15:00 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49800f0ebfasm37683065e9.2.2026.07.30.01.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 01:14:59 -0700 (PDT)
Date: Thu, 30 Jul 2026 09:14:55 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Li Zhe <lizhe.67@bytedance.com>, akpm@linux-foundation.org,
 apopple@nvidia.com, arnd@arndb.de, balbirs@nvidia.com,
 dave.hansen@linux.intel.com, david@kernel.org, kees@kernel.org,
 mingo@redhat.com, muchun.song@linux.dev, rppt@kernel.org, tglx@kernel.org,
 linux-arch@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v8 7/9] x86/string: extend memcpy_flushcache()
 fixed-size fastpaths
Message-ID: <20260730091455.1242d01a@pumpkin>
In-Reply-To: <20260729234842.GFamqRWva8h7X59ccN@fat_crate.local>
References: <20260727123429.5673-1-lizhe.67@bytedance.com>
	<20260727123429.5673-8-lizhe.67@bytedance.com>
	<20260729234842.GFamqRWva8h7X59ccN@fat_crate.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jul 2026 16:48:42 -0700
Borislav Petkov <bp@alien8.de> wrote:

...
> at least the code is making a lot more sense now.
> 
> The fact that you had to axe off so much cruft off of it tells me that you
> haven't really measured it right.

Especially since if you do actually measure the clock counts (non-trivial)
you'll find that loops are often completely free.
The out-of-order execution unit will (effectively) execute the loop control
instructions to generate a list of instructions that get executed at a
later time.
So provided the loop control doesn't use more clocks than the loop body
(and there are spare ALU units - usually true) loops really make little
difference.

This also means that unrolling loops often doesn't make things faster.
You do need to minimise the loop control instructions (and gcc doesn't
like the best loop that uses negative offsets from the end), and
intel cpu can't execute single clock loops (amd ones can).

Inlining also increases the code size, the I-cache reads are actually
likely to be significant.
You need to time a single 'cold-cache' call not just loops for long
enough that the result is also skewed by timer ticks (etc).

	David 

> 
> So why do I really want your patch?
> 
> Thx.
> 

