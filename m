Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79958125A0
	for <linux-arch@vger.kernel.org>; Sun,  1 Feb 2026 22:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769983305; cv=pass; b=uwJzYvmKMfDfiUcF/p5vaKUgBjvzIcJMt+ioZIuyFduAJcleykm982v80qv7lNGI0EzFZNTJz+ow+4XmyNreZzHYnhsXdF6BzOjTFmz2AVkC+4xckEV+KX0slswrs2kLqcZk3sO0S6Vk7FXqB47HFppqSmz5Or2X/gVogGGKt5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769983305; c=relaxed/simple;
	bh=wl7Jk6JsU5yKG4duQoEsXxxYC+OIwiJhzlKIg8HfxyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MsMc6oZA8MqTkv/AdA8BOEGynhKoLzgs5jNt1dE//ORQajjBo2Jzd9QzZmn5hxBYWuQFy3ubTB8+XFyqQeUaxiWhK8FQJdjhzJs64Vv//3NFKUxW+9fhzo1UqDHwD4oMtOlCiocntf2wgMqoZoMt2x91EPrLD8HCBC+WyPL9vqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUP16xwB; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUP16xwB"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-65808d08423so5662557a12.1
        for <linux-arch@vger.kernel.org>; Sun, 01 Feb 2026 14:01:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769983302; cv=none;
        d=google.com; s=arc-20240605;
        b=acfJuyNiyBaUiNkEp5E7IlUgVFTs0KpX1Lh5cparZNmGn7yvKoyEXJCWz20QdO+VpU
         PpvkfSmWztoPbnjPh7YVnPIKn88bC1jG5cUqHhCNPNI4rwbj/nWPbskAu9wyi1w9iIdC
         Nlrv5+zhWdwRlk+8/JQIPvtmG9gQ4e7LEZXOyU/9k1LIGB+hneS+ISB9MVn32W5HrC9l
         Orwfc0wng2LnezDvlB396S7qP3tNpsGnM/L7aotICm4WmnzAQZD2IudimLVAxwNYeB9Q
         amJKY0jN0UfhWvKBG2xMUshwuVmdmjr3e//V77Fa//ExsBMIb0aWbESXvUEC02MQHkN6
         CTaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nxxXeMZ2Mj2NhEcakAGevZjWJ8Zk/OwUaMBA61xjWow=;
        fh=UOaL/IYvKU8blJVq9yLXI+8gTEVd0hOCjueoHAFez4g=;
        b=NRl6knbCoNoo7bfw0u9EwU4kKVi4hVe08k/m73h1AWxboEQuEAZYtGbgpgFUimjvjg
         XIl2eZqrby0cHi/tIfZnw4GOWnor1W4yRGsEdQwZWrzVUW9OjRB2tyRLKjDEjIeplcH0
         2drOamWPvR1TTyMGwZni3UiWauuMFU8I9IJ7xqdQuzCgmBkXrWXqtO6SqUX7xbRqnKo1
         czx6wN1LOtYvtLXzL8B9EEZW2MOttT52ZiS38Aap5TVJxIvTmz9YbmNKcI/PIbRd2mW/
         U3tBxVz4+WFIk/E16zXKfcirwqqsyC1ZoGWi3xhndLSL8RLuH6UBwJMfpd+rsducTrYS
         xU6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769983302; x=1770588102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxxXeMZ2Mj2NhEcakAGevZjWJ8Zk/OwUaMBA61xjWow=;
        b=YUP16xwBByuCeANUpL+tqGPZtwW0ekBJQXjxvYHrQ+BVuJhzXlLPUbdngsjT9o0vf6
         uYUmzrEUKPWDyYwqImODBU03rkq/5q2r1ZRse77/5jbzZ2ZbdPfRWoEgDFXi7tvZQDib
         KKiwOMyTyPNTlE6DbDFUXbRkge9P5LbCelPWFufvSIQsld51sSM4Eb+aQDvPUDu+HqZ5
         c/EuzGYP26bua1tM6AhlMjxuishxSbB0C/tRmJtMEllP01kG1m4La3rFduj7FChnHhy9
         DMXci+K0JH5BarH9OsbnSb+egVIt1mbKSHqf6Rg3thvWSqfOWPIJWg6A+uJuZWSkOoYT
         3FYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769983302; x=1770588102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nxxXeMZ2Mj2NhEcakAGevZjWJ8Zk/OwUaMBA61xjWow=;
        b=f4+SsWc13XokHi20EYAcVyyA8aR8+KwZ+DEzQpSPJQfQsEXC4UcRh6fiAC72bauFy+
         fPGurxYaygZgwC5gyDUy98iwh6onSncHddwB9bArhfT1uB0zEUJ5Mf9OqV+Qpgbq6im6
         KSgWsr8x2zPb/E/d4T3vqlEE6BEtN2vc5sKoVIJYXfDloR2hhUS6ldEaOTqNslNp1bUl
         6waiok8zqX1pay1yYQQNOgg+CYAdYW5YQoLxX2coKElVdKj4zDUZ7r0T4aW8+8ZAfOo3
         cdtGTxdbqVhy5ZiphGNB9FOwltF7w3NsEB+fj2/zPujOSb5yewZX9svjDXSLM514trkM
         mUTw==
X-Forwarded-Encrypted: i=1; AJvYcCUmlklOezjxOCYRpCd+GjoMK/M3d7k6IzItvPoACKikhy7PwHjCOOewL6/GB381odmy7PGqlsRW5nZm@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2PySJedrCEhfL8gpMpW4iySIAFQa7tbAqFT0hBTbe/nic+/D/
	8Y1jOl5CA3o4ze7jidoa3r8yepBSsEmayNUgAKlxzUxMUoDkdE2TxDo09S+l2xF5MbF2P+L30l/
	bZVD+w0uxqaIhCj2cFNXC6VrF6C2W6Gw=
X-Gm-Gg: AZuq6aJ0d7Qb772C/VAgv6ax7bTUjvsW9YaxboTEFwRJmfHpa/VBBtz6q1HN50GpHyh
	uC7+jK4dmyntAfc66DMDDHTdPN9ZFsrQTHZo4n7EFU5/0JtXl8wWAn1XhGJ9zZJfddNp6ozPQBQ
	nAnrFiNPjbxoA0GMSqm4ohUzUfRSbdDfyzrVeWGpnBqyyXfqrHoVeXDeeUZZYfmlmQNAb8XhJAn
	Un1JUOeOV4CAr7MvxwQJQL2UM8GfQ+2XLOYTYMV0/MT3iI2HzT7aoWlAoFBCY3Yqgf7V5qtUYzT
	P0lU8orXz7dHemNP5w/HWL4HbZXZ
X-Received: by 2002:a05:6402:90b:b0:64c:9e19:9858 with SMTP id
 4fb4d7f45d1cf-658de58d61fmr5598076a12.22.1769983301701; Sun, 01 Feb 2026
 14:01:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769515122.git.zhengqi.arch@bytedance.com> <3380f40a89b73c488202c85f9a8abf99fb08543b.1769515122.git.zhengqi.arch@bytedance.com>
In-Reply-To: <3380f40a89b73c488202c85f9a8abf99fb08543b.1769515122.git.zhengqi.arch@bytedance.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 1 Feb 2026 23:01:30 +0100
X-Gm-Features: AZwV_Qj9VNkT5OuGD6ka3IvGbnZ780_iMCZkDjCZeudKZ-RrGhxplhYBmunMjcY
Message-ID: <CA+=Fv5RhxvyxKr2t+pHd1tbGrK57P-+b3pGe1nVaK_OLiFt2wg@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] alpha: mm: enable MMU_GATHER_RCU_TABLE_FREE
To: Qi Zheng <qi.zheng@linux.dev>
Cc: david@kernel.org, andreas@gaisler.com, richard.weiyang@gmail.com, 
	will@kernel.org, peterz@infradead.org, aneesh.kumar@kernel.org, 
	npiggin@gmail.com, dev.jain@arm.com, ioworker0@gmail.com, 
	akpm@linux-foundation.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-alpha@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-um@lists.infradead.org, 
	sparclinux@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 1:16=E2=80=AFPM Qi Zheng <qi.zheng@linux.dev> wrote=
:
>
> From: Qi Zheng <zhengqi.arch@bytedance.com>
>
> On a 64-bit system, madvise(MADV_DONTNEED) may cause a large number of
> empty PTE page table pages (such as 100GB+). To resolve this problem,
> first enable MMU_GATHER_RCU_TABLE_FREE to prepare for enabling the
> PT_RECLAIM feature, which resolves this problem.
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Matt Turner <mattst88@gmail.com>
> ---
>  arch/alpha/Kconfig           | 1 +
>  arch/alpha/include/asm/tlb.h | 6 +++---
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
> index 80367f2cf821c..6c7dbf0adad62 100644
> --- a/arch/alpha/Kconfig
> +++ b/arch/alpha/Kconfig
> @@ -38,6 +38,7 @@ config ALPHA
>         select OLD_SIGSUSPEND
>         select CPU_NO_EFFICIENT_FFS if !ALPHA_EV67
>         select MMU_GATHER_NO_RANGE
> +       select MMU_GATHER_RCU_TABLE_FREE
>         select SPARSEMEM_EXTREME if SPARSEMEM
>         select ZONE_DMA
>         help
> diff --git a/arch/alpha/include/asm/tlb.h b/arch/alpha/include/asm/tlb.h
> index 4f79e331af5ea..ad586b898fd6b 100644
> --- a/arch/alpha/include/asm/tlb.h
> +++ b/arch/alpha/include/asm/tlb.h
> @@ -4,7 +4,7 @@
>
>  #include <asm-generic/tlb.h>
>
> -#define __pte_free_tlb(tlb, pte, address)              pte_free((tlb)->m=
m, pte)
> -#define __pmd_free_tlb(tlb, pmd, address)              pmd_free((tlb)->m=
m, pmd)
> -
> +#define __pte_free_tlb(tlb, pte, address)      tlb_remove_ptdesc((tlb), =
page_ptdesc(pte))
> +#define __pmd_free_tlb(tlb, pmd, address)      tlb_remove_ptdesc((tlb), =
virt_to_ptdesc(pmd))
> +
>  #endif
> --
> 2.20.1
>

Looks good from an Alpha perspective.

Acked-by: Magnus Lindholm <linmag7@gmail.com>
