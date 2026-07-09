Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095B943B48B
	for <linux-arch@vger.kernel.org>; Thu,  9 Jul 2026 18:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622635; cv=none; b=TX6S3/7ZWAs6L1LWP+gfAUXus6ls+7hAsba/DqxGnzaM+7SBNjF010uhJl7Mw96+JPjUoIVTjWEnUfGDXHWKigST/yp5YQu5eezbBxwN+0vr7o1JAULmt5Ev+EKTR/w9ti3rkP3Zw3VVDzFO/P18B7axTiSRuevDKns5VoCyQZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622635; c=relaxed/simple;
	bh=5522vd31FFvseMtFKZmNLN0MO3Bnoibk1qUMw3Ml4Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idoxr+so1pRJ8ga8WFKLskgQ4a3Zm9DoU3j67P3kaJQ61xg+J7xSJDmlm8wST5UdQlDdL5ihLeKEiCLswOLTJaNuGI7gz/bCtyEj9B+MT2hjZ4xJ19WaTUskTBM4pSCpe4dv5YPTUUZqHKAT3/H6f5UOOlzetN2vqQGGrXi6+wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=riRQKuR+; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="riRQKuR+"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3825c406ffeso223446a91.0
        for <linux-arch@vger.kernel.org>; Thu, 09 Jul 2026 11:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783622632; x=1784227432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0SnVDTLPnMBjkQSM4oCN+URozdUIH28ywJdKUrWn7bI=;
        b=riRQKuR+XX2MFtODdxhiHEdB6Za+0kzqtImMsil4VbDuA817S5zqgMg4uvu6P96FE7
         7JDwU6IFNZWY+m5inz7S1JRNEV0pJq1SuNE4iMk5XqvbhYLLkn0bjNBxwUf9qOUN2Riz
         HM0IH5hgCgsqi8gYgjgMP7Xd2SZ3DtTjvWBDs/srg8sOh/E+PRqxOd2wQwj3ckbekDbW
         BTHjh4M1wqSW8OSNoDIskaYzem2+TgNitTvM5S8O01RWbtvA2hWMp5LAUmO5AyghuAfb
         EFNNKlzrlZxq30FBfoVXPInHkqfdJZCaBlM7q8/aHgjUHzb/iYK8b0pMrmGC8qtLfb/p
         ekYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783622632; x=1784227432;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0SnVDTLPnMBjkQSM4oCN+URozdUIH28ywJdKUrWn7bI=;
        b=iw27E2RC+WKFdaKMx5V2MTUQGnr7N47IrsxK6s+uRxWsZKVYnRlAEtaCx3zjcDpuIW
         W3h7b9FdwIfTqjVcZWJFD3FsZ+AsHimC9EB41pJsGwwLjNQtP6mNQLvdydltACIT/5Zv
         4SU6AXJEMEFDW9Way5m+MatsEcqmUZZhitZAbR8d6Fyy+FQXGh28QmBMm39svaTqkSLN
         nWo3nXIz0qoczbJm63Q0qJjHm/iFlc6z13RClL3OFQkmoq1KXFCwtEEdLPXy6m5EYkyr
         ksYr1x5iKlJ77SlJU/sBxRpRrZDVJxG0Lg7jboom9s9sIK1hmUy7KzmSelNlbKKff++B
         yPAw==
X-Forwarded-Encrypted: i=1; AHgh+RqM8GBrUdD9sJQWRuHfcLqY2wmb69PGWn1+CYCroueiPxTlb4Kpsofzwu3HNmopChL4BG7GxWIrdoA3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9x9U4xM8VP3ReZPJ3UCSIDV/uLMiqtJHsOIQtQQ/LbA68m6Na
	svXYQhx5PTUIR/a8OcAI+p+5SI0YPzAyltJKhtRKJ51rcKcO9U/IzxIc
X-Gm-Gg: AfdE7ckddlTJEKFitaQdPUasIMCNaAIQE/FyQxW/8l3DpFW9WvPHEeVKQX0ZuZR5OB3
	ibiQq+XHcsvZboSjXBz1+Lgvy67/UTm5VB6xlb3S9BRwUrdGnxVwbKv+dKa2kgEgWpwqQdPC7C3
	Ws5faJWtB1h9/ii02LXYdts2tifagaP0qZk4sdZaNSxfqEXykeEDXBjzL/Agw8W265nVYRWchRd
	+rGHM8mdGQG4pJEqW/fnRLE4oVasHSTf29vb19pBlHqEFxcb1bZZsBnHFYIbCHBFHoO/ZJIwXz7
	aGleHgk773ACOFOkW6FvlV85zXvEWAU0rYzfvbj/86sWD+Cz2G0UU4oVY/EQOkq2a6UgaN0TkYk
	tuJly009d59vJahRdtUk0hKf6whDusn15SbDatXIdSmQoKcCMR6tvi2ZfpcqTVJ0wIYDGvp6eZP
	HQuii5K1RvHjs3wCMEdDv2cdAltWuGlFO0qX2uWYbIse6+HbKAyi2ohvs5xoPo
X-Received: by 2002:a17:90b:564d:b0:387:e0db:3d90 with SMTP id 98e67ed59e1d1-38943d404dfmr8538131a91.43.1783622632431;
        Thu, 09 Jul 2026 11:43:52 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174accb0esm35673867eec.30.2026.07.09.11.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:43:52 -0700 (PDT)
Date: Fri, 10 Jul 2026 00:13:32 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Helge Deller <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>, 
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, 
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 07/18] s390/syscall: Use
 enter_from_user_mode_randomize_stack()
Message-ID: <ak_rx2gFCLtG-Qpy@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.030598804@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707190254.030598804@kernel.org>

On Tue, Jul 07, 2026 at 09:06:23PM +0200, Thomas Gleixner wrote:
> enter_from_user_mode_randomize_stack() replaces enter_from_user_mode() and
> the subsequent invocation of add_random_kstack_offset_irqsoff().
> 
> As a bonus this avoids the overhead of get/put_cpu_var() in
> add_random_kstack_offset().
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> ---
>  arch/s390/kernel/syscall.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/arch/s390/kernel/syscall.c
> +++ b/arch/s390/kernel/syscall.c
> @@ -97,8 +97,8 @@ void noinstr __do_syscall(struct pt_regs
>  {
>  	unsigned long nr;
>  
> -	enter_from_user_mode(regs);
> -	add_random_kstack_offset();
> +	enter_from_user_mode_randomize_stack(regs);
> +
>  	regs->psw = get_lowcore()->svc_old_psw;
>  	regs->int_code = get_lowcore()->svc_int_code;
>  	update_timer_sys();
> 
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
