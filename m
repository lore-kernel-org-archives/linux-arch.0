Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD3F4BEE48
	for <linux-arch@vger.kernel.org>; Fri, 11 Sep 2026 22:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164623; cv=none; b=QsqmqxyfXAV1HsAcVqRd3UEO+O2PgORfh2UF44V6uJLWnO3MaEO6IlBnaZX1ZVQycjgrpgAP0jqYaSLOwxdafwJ7zCq/rEc4vQ82LMnXCJAtHHLz4h3ba5m5Fl8fa9NRk5w3xNUXiECDAF2sV0bSLlLZzIXIfd+BMSQBtFTInmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164623; c=relaxed/simple;
	bh=wzOAT8P+HfggfOuW+tbV1rDr39BIeDu1f097JVhjors=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oq0Cs3kyYJAOYvqDNRJkOu0tex2d/6Q+bkrEHnYJAhju7S6ISxtXGx5eu6mwtbPF0+VIPCLUWn5AfGr2vyFvUUcC/oxrMqhF6JHzvP++en8wRycBOIfw/uwqTEmHPAlW9pl5Jf+OHq25+s3cEPp08qqUJNQRwXkWYeuyqhf0jIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8kPqdVL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8kPqdVL"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49b0d8bc2aaso16423465e9.0
        for <linux-arch@vger.kernel.org>; Fri, 11 Sep 2026 15:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789164619; x=1789769419; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1CitEInQG9IH8hFfkxw+Dy1+TcxOBHzYjUh6RK88Fgs=;
        b=V8kPqdVLxhbxYq/ndSOhh59EWr8wuK81XRGpgyG1cXj+UuOWKJMFJ2T2a2dgpFrdLa
         WkuVwWjHua6E0jDuliU9Xfih3FGXadW6+THWVrO6iOtCVXUCSCtYS+LVNXHxOpwM1s/Y
         /bOxgg+4FBx1y8MXDR1zhT3bH3ZKtN6CF8wJX8J7oMW/zGMtXic0VCWyi99/rWWjnfd/
         uuXLEKmMOpD1pjjTO6VRI6T6CUOYwvNYIghCxNP5Ys0xeNLSImT2vW7SH3c25q936lXU
         qUoUKrw/pjuOxzetQVpQHrvTyuVJAj49eK1mHFx/vB/wgw7+zJMHO9eiGbAO23VErWjb
         30HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789164619; x=1789769419;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1CitEInQG9IH8hFfkxw+Dy1+TcxOBHzYjUh6RK88Fgs=;
        b=kgi/4NzTiVdPxMkx6Wfa3NLuoGHX0uuv+VjAG4g9lIqWF5n9GoSC4dw6BMSXfO0Xak
         5IktIhvrrskYUbeTLnRmrIzrOn3pZA5mu4gvZosXlNMRdSII/jmSaZG2/4oGD/XuBBz8
         ri1CQsvi5wJiOKw9ZY6ogwapTTjlmyzK2iqhHAybsKUrEJzX3hiavB0fJ1Wuc4BHRjGu
         me61Iy7SxN/uQOc56nQg0VFiSYQ86Y/cjcHbZpVF4lDQJ8q4K8AwsOjSgho5UUPf5Sr1
         tn5coJMRgTtpSOssCyUfToudyg1ueqBkvw8QErrwUTyVPFABhW/6swdmPW+HsQysOB8D
         Semg==
X-Forwarded-Encrypted: i=1; AKwUvBww2QH7yGT36U7125HKf27cNZunA/1Sh1omRlh+KkES7RMamwL57JCiPTx1PcsMAb4PlE+zdXbMW7RI@vger.kernel.org
X-Gm-Message-State: AFuF++lqRlqutc6/NLNLCfruGQ6SykLctlfuaYF4uge8WvM1AeQJ7F4x
	MSUKiMnJmUace7JYAjOzP8NRKYtaTMjW9aK9J9Cv/8QOic6WRLVwKKi5
X-Gm-Gg: AYBFou1Br0EUyXJgqUtYRPJDUDMbg+tZTvIeSYRyb3pNiXXrOR//fgsOLexzEanDSjq
	kdYm1oayrDD7Xkes7fRnWoTDs7xcOyeVm7BywTK8vhvAj3fCCF9Ied9U67EzVOYtYTdtJFLfE7H
	aig0a6vRdIEdAZBqbrnbXsX7/HQYv7CmehwJZIh911duyP342Tn7UiZDRHRSRn9IuQvKk33Ce4C
	pT7ez8AEHvch8I1eyfJfT2Hm6dEqECsCV3cejeS8P6kSudiCIwQP97WcjG5SLASNXNeui+Un1+v
	DByrSm/DiKAfJrAv4LXyovkjVW405q2hkCJsQYh2td3x72zRPDZnCb7mSwdYLJC+77SzqGtZdZO
	nVlKGjfaC6W7ZSuZkOjCIzzS9ttuqyhGJR8pzsyTFWVVD5au7HcWR18ngUoRzPKTCjmR6uya2m7
	862TkrSTceVo5mU8QkbXfK0bSd+XOJatG4045QwS/s7Y0KMAiRlF7mZxg3QM/9uH4otzhffmmen
	ZTFJd/syTf3QP3tmhMYltnPu+HH4G/dryBN
X-Received: by 2002:a05:600c:8b41:b0:49b:d45:703e with SMTP id 5b1f17b1804b1-49e6198865dmr87033975e9.8.1789164618893;
        Fri, 11 Sep 2026 15:10:18 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e61a81943sm69553525e9.1.2026.09.11.15.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:10:18 -0700 (PDT)
Date: Fri, 11 Sep 2026 23:10:17 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Bradley Morgan <brads@mainlining.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, frederic@kernel.org,
 neeraj.upadhyay@kernel.org, boqun@kernel.org, joelagnelf@nvidia.com,
 rcu@vger.kernel.org, "Andrew Morton" <akpm@linux-foundation.org>, "Arnd
 Bergmann" <arnd@arndb.de>, linux-arch@vger.kernel.org, "Vineet Gupta"
 <vgupta@kernel.org>, linux-snps-arc@lists.infradead.org, "Russell King"
 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, "Guo Ren"
 <guoren@kernel.org>, linux-csky@vger.kernel.org, "Yoshinori Sato"
 <ysato@users.sourceforge.jp>, "Rich Felker" <dalias@libc.org>, "John Paul
 Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>, linux-sh@vger.kernel.org,
 "Chris Zankel" <chris@zankel.net>, "Max Filippov" <jcmvbkbc@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] lib: Add two-byte cmpxchg emulation function
Message-ID: <20260911231017.550f8cd1@pumpkin>
In-Reply-To: <20260911192540.20983-2-brads@mainlining.org>
References: <20260911192540.20983-1-brads@mainlining.org>
	<20260911192540.20983-2-brads@mainlining.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 19:25:34 +0000
Bradley Morgan <brads@mainlining.org> wrote:

> cmpxchg_emu_u8() emulates one-byte cmpxchg() in terms of four-byte
> cmpxchg() for the architectures lacking native one-byte atomics.
> The same architectures also lack native two-byte cmpxchg(), where
> such an operation is not supported and either fails to compile via
> BUILD_BUG() or fails to link, because the bad pointer sentinels
> these architectures declare are never defined.
> 
> Add cmpxchg_emu_u16(), the two-byte sibling. It reads the enclosing
> word with READ_ONCE(), splices the two target bytes through a union
> and loops on cmpxchg() of the full word until the compare succeeds.
> Like cmpxchg_emu_u8() it is fully ordered.
> 
> The Kconfig symbol gating this file is renamed from
> ARCH_NEED_CMPXCHG_1_EMU to ARCH_NEED_CMPXCHG_1_2_EMU, as it now
> selects both the one-byte and the two-byte emulation.
> 
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Bradley Morgan <brads@mainlining.org>
> ---
>  arch/Kconfig                |  2 +-
>  arch/arc/Kconfig            |  2 +-
>  arch/arm/Kconfig            |  2 +-
>  arch/csky/Kconfig           |  2 +-
>  arch/sh/Kconfig             |  2 +-
>  arch/xtensa/Kconfig         |  2 +-
>  include/linux/cmpxchg-emu.h |  1 +
>  lib/Makefile                |  2 +-
>  lib/cmpxchg-emu.c           | 35 ++++++++++++++++++++++++++++++++---
>  9 files changed, 40 insertions(+), 10 deletions(-)
> 
...
> diff --git a/include/linux/cmpxchg-emu.h b/include/linux/cmpxchg-emu.h
> index 998deec67740..fee8171fa05e 100644
> --- a/include/linux/cmpxchg-emu.h
> +++ b/include/linux/cmpxchg-emu.h
> @@ -11,5 +11,6 @@
>  #define __LINUX_CMPXCHG_EMU_H
>  
>  uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new);
> +uintptr_t cmpxchg_emu_u16(volatile u16 *p, uintptr_t old, uintptr_t new);

Why uintptr_t? Shouldn't it just be u16?
(Which probably means the code would better if it was just 'unsigned int')

David

