Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB211643B
	for <linux-arch@vger.kernel.org>; Sat, 14 Feb 2026 11:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771068688; cv=none; b=LbLeRW2WVf4Tbm959l9V07YxaqBgXvY0Mcn98PdpMZvPBQ5vck5sgcWtqgmhLmfk14raP9Y43FOhizlZnFddfE+xDb61RNkBLvsE8EzSj220hhgMEFTzjjiekEBM877OrYAfcHJvt1swo4YJfpC6jG7ClVuuWk5Dr8Gf8kVcCBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771068688; c=relaxed/simple;
	bh=jgsb6aSE7WPnfxKv5PMCEz/G0xsKQZzyhcPwhL0OMgo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W+VaA9rrOSM5vPljnxr4ZoqmW1YMc6VUsibLBtZNo4BAXPQWY1rmdhe8Fe+qpOzyzdIadlm+vqtWDLrNnRbDk3y0BvC55EZvyYpGk8f+Z4hynuCHXhw53o3vHJkNjEqWEW9txGMEv6R+Y37i5/t/Ta1N8whISxeBRBZDdNF8R/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+veXALJ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+veXALJ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4806e0f6b69so13545005e9.3
        for <linux-arch@vger.kernel.org>; Sat, 14 Feb 2026 03:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771068685; x=1771673485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiZwlgtBXqE7LEsN2nlgf0AbHOoRJSUt9gOPy7eO3jU=;
        b=j+veXALJDkt8Dv94RwJ93S6+z5F1N3shcNGHNyUGucVq6CEWAt8DHu6S4lCZzFvwLN
         hR36fbgT0F38L58OaU67n1bpI62qdMJkrbm98OSKNS+TenaUriw14dWxiKYbvtE34ILh
         03oT6oLRRE9jab/l2tDf0WgiTkheAxO9dAYTczezqhuREFn+nNFIG7cqWiM6KVFgBHcr
         Iw5DfMM8WHEB9mFkDLtfJsNYbivZJ829JVUBGmLUVpXI5T3gFFz+jM7v41Jdvkmuk5Dy
         0Ikenfn7STop8Q0TC+1Tf0CzUmfAq2K9AJIZ5SBZT7TDxk+SmfwrkJjcRnwVe8RwOZYK
         kX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771068685; x=1771673485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OiZwlgtBXqE7LEsN2nlgf0AbHOoRJSUt9gOPy7eO3jU=;
        b=Vp6Ilb755lITpTxVG9jRxcwV5qW5N2mJVTMP9X5L1tSHT3voyPq0lgVs9h5bFmjE8O
         Fubk2+NOJfK11RoljXvZv0E5r5vs4285wmIhoaej5uQ6gRml+WPd5KbKC+wsDOyamkeF
         x9ZK7ZXJy0Z0lKRcCNySLkyewYzWxMqfRDbQ+TLAc0u24xIFoGbwEcWfOW1bP3WpbZa5
         HKaU3hQjPxzCdIr7Q4AeSlXyIQgSvqk19+tP/N02wESFUB9wsmvKRdX/wvZsr3s+3D+V
         uQb/QQnHRmsw/fggC8cxsQb7ONbcFSEghHXzR4rUkozA0P0hbn5tG+UU1NmZ73REuiWb
         yDoQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6O3NbRYrKFf35wsYTBP1rIganBu0FI6Q1qu/eGYCYd6Lc7dIiuEK28+kVBkO0WDITJX5ypZ/OHDy7@vger.kernel.org
X-Gm-Message-State: AOJu0YwGq3302qPDf03OM3cgeThLf9zTV1l7XO3ZaAYXzeOxJaCCQ+ZE
	Dy/5F2qxjuM67z5EQXmjXEicepsRQmlGG5PJR/DCv6WfK/oRV4OE8Nr2
X-Gm-Gg: AZuq6aKISff6OuCOKozQutmJDXwTjGSG9s+5/J7clo+0EF3PLYtwUJjX9Fw2cRMVxJn
	i2yLKJSSaM/O5//B+YjGlEmIerNivYejKprSud+K4+sJa9tjbH64OijkkHIrjHOxW5kaytgBQ9T
	3aZvUW+GyINPTUY7pWKOmAY6Y+VahRVZN/nnBWC0Jtw47OaxM9snAxaXyLLXfLyWxJiB0GHkEBZ
	oLcVwo0JyZKVg6B1jEDdryQHK/qSSg4EL9XvaLPxddvtNtTy7Ujr5H5Gs02qR5jHkM+L8Tu7Aeh
	alIlQ3Vv9jVmgYlo8Nj7Q5qeesNw3GeBCx4fUdB/zVPyUnd/iRV7eVcsYgntpBoASh+xTmPZpvi
	Dvg8mCISDIx8triQQje1FvwyDqqMtyIvITc0Xrg2OYZix5Ir3WMLVDOhS0xs26k9n4cL+FtqMEc
	ixb+0ZAIDfgCc8TKcyAslvfX/Sdk0K9veVxY7Lg6qTFqVxYF+KfrNYpp9Yj1Ig2v0D
X-Received: by 2002:a05:600c:3f1b:b0:480:68ed:1e70 with SMTP id 5b1f17b1804b1-48371096d3amr84223035e9.35.1771068685196;
        Sat, 14 Feb 2026 03:31:25 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4836aa0847asm237182465e9.3.2026.02.14.03.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 03:31:24 -0800 (PST)
Date: Sat, 14 Feb 2026 11:31:22 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
 will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
 mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org, ast@kernel.org,
 rafael@kernel.org, daniel.lezcano@linaro.org, memxor@gmail.com,
 zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 konrad.wilk@oracle.com
Subject: Re: [PATCH v9 01/12] asm-generic: barrier: Add
 smp_cond_load_relaxed_timeout()
Message-ID: <20260214113122.70627a8b@pumpkin>
In-Reply-To: <87tsvj6hwf.fsf@oracle.com>
References: <20260209023153.2661784-1-ankur.a.arora@oracle.com>
	<20260209023153.2661784-2-ankur.a.arora@oracle.com>
	<20260212095621.4d99317b@pumpkin>
	<87tsvj6hwf.fsf@oracle.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Feb 2026 20:58:08 -0800
Ankur Arora <ankur.a.arora@oracle.com> wrote:

> David Laight <david.laight.linux@gmail.com> writes:
...
> > Plus the cost of evaluating cond_expr 200 times.
> > I guess that isn't expected to contain a PCIe read :-)  
> 
> :). Good point. I'll see if I can add something like "when polling on
> a memory address".

I've only timed PCIe reads into an fpga (Cyclone V) target, but those
are about 1 micro-second - which is a lot of clocks.
Hard logic will be somewhat faster - but still slow.

There might be other places where 200 isn't a good value.
Perhaps add an extra #define that drops in the loop count?

	David
