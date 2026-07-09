Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9697A289367
	for <linux-arch@vger.kernel.org>; Thu,  9 Jul 2026 08:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586970; cv=none; b=UKH1p0c1ZU+6IWaImzRNutCv7J0amF9nYk6zYSLECX6FYAAhwkPSxf0Cg59RtsHO4vtsEDWYBbnWxCKe3QdK0y1FSzDSSZdo2e7P1OVNBuBvztr8ZqGRneZeSSCAb/+0eEYZ7/tyajZKtZhVJhwwXCzoqFpXFFXz3lTAeQHoyHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586970; c=relaxed/simple;
	bh=vcIYcFn8wOu64JToHCd3V3ghUBsco6aWxPDuriYHfZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PFvOltWztS6MmGWz6PaessYyBQeeDTWMN7MK8ifav2YIijbxiKcgkaIDT5TDdTKodigntSsqOo/nmcF1JHw5Tq6EeFkGKx6quSFq8XWCrImI6ubn05P4irmFFfsJ8zOAIRL3I/khMO7cGvW419UJCRQMEkybIzJEfIYPt143ZDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cad8076b01so18751965ad.2
        for <linux-arch@vger.kernel.org>; Thu, 09 Jul 2026 01:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783586967; x=1784191767;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=O3mkBNkViagFAJs3obyg41kBlrTMtmvpPUP/R2gZOPo=;
        b=ZKabslPk2kCoodmNmID9ZOpg3MpXmIUS39eYggLMWRHijW/LnbxKL7tGqdUUCbHNml
         w8oU9OgJic/KSvpeehOALvUG58W1mWiDr7RVxLk3yKpscrJLODL2EWc2D9Rh0KMy5nEB
         riCPItOu9f4fonkhkN7NgKs1zynC8P+NRZC8uWP12DR8ELvyTvqfRcHVT0zkJ8xr3YDo
         A3ute3uirKWkFgFtXp89mYBN2DFjRVo3S8pgXzP4A33g2kdnB7IxgonAipsRnHivCCsn
         XFgx7iJ0PEJH3Uu/d6h1MkFApJMOtF+ijQU9s859o4OsYyYG1EwYB5n9NNHtG5mElQHs
         u/Fg==
X-Forwarded-Encrypted: i=1; AHgh+RqZjsgkegv6UxYirffaMrEF4YTtLJC6ZUQiO4QU9PE4uqVsB2Pa5DfYp2f7YK00gITIVZH8Jb+1fV68@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5TV4boWimSo+LuUiukUkZiHjzah3IdaeiIgchJp0SJ0nGlN4A
	nBXs1NEC6jNSjmPYis7DG4+IngFOCfsEu9r5FQTsPDOz/ENPprx3DW3X6WF4iAJXJDc=
X-Gm-Gg: AfdE7cloBQ3NPloufSujS7J7s90DL0UUdf2VIxrhsXHqd5tiux1Gl133I7mY6h32agQ
	gID97p//93ItmfhSi4ALjI0H2t/1+ErbpFH4bKJah+VupUkl5wX3S9tcHThbh9ucgCPls4fAKFA
	BsLby0xTVeFjpY0eyWFxEpedwVgxu1w1V0jI40YSqYPgVpg/5qDilRU3GoQv7WgqpxjrJyJJffr
	qp3KszJUBWH0tR+Q6c/bhnbJQsu/sftfHJaWCNmvFlyvp1RM7XYCCyyOVFxl1gwJzQ08c7063vJ
	u+crC9eqcoBzQfScmB7wYxk3wXH5cHd0YW6cWMPjpsJveWcWgoneqMFKX34q9Ygnyt0GrT4NZRF
	nMCm0ZsJUQTEMZf3yctQlg2PA2Lln5ek4WE/sSk5iouJ+Gb6NSPuJM2lUkZP3jRS1y87At1iqpp
	xsaCUHHUX8owWrX1vClgZDfyQCxmJLDNF9e7Sr8n1egJCOdulOWTbL9w==
X-Received: by 2002:a17:902:ebd2:b0:2c6:a772:7e43 with SMTP id d9443c01a7336-2ccea39354fmr73212945ad.18.1783586966711;
        Thu, 09 Jul 2026 01:49:26 -0700 (PDT)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com. [209.85.215.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bcc0sm40243275ad.67.2026.07.09.01.49.26
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 01:49:26 -0700 (PDT)
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c999f162c9aso931790a12.3
        for <linux-arch@vger.kernel.org>; Thu, 09 Jul 2026 01:49:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqodyIb5TjgK2UvVk4Wvd3IhIwIBd5pA6gKJDY1YuhH9N4bZTwjESEmfi5Vl5Sn1VRActXTxyrnmDx0@vger.kernel.org
X-Received: by 2002:a05:6102:6895:b0:738:9dd5:9b03 with SMTP id
 ada2fe7eead31-744e03a337dmr3306957137.20.1783586528282; Thu, 09 Jul 2026
 01:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707181957.433213175@kernel.org> <20260707190254.280015701@kernel.org>
In-Reply-To: <20260707190254.280015701@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 9 Jul 2026 10:41:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWe1D0CZrav5h6EhDDbeJzgJcHvT89jrs6109Bdj-pdTw@mail.gmail.com>
X-Gm-Features: AUfX_mw8w2Kp5VuAYozzfDNS6gDbdKhQdYzfXsv-G72F3LS58UBytbGwOmplITc
Message-ID: <CAMuHMdWe1D0CZrav5h6EhDDbeJzgJcHvT89jrs6109Bdj-pdTw@mail.gmail.com>
Subject: Re: [patch 12/18] ptrace, treewide: Rename ptrace_report_syscall_entry()
 to ptrace_report_syscall_permit_entry()
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Vineet Gupta <vgupta@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Dinh Nguyen <dinguyen@kernel.org>, Helge Deller <deller@gmx.de>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Chris Zankel <chris@zankel.net>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Richard Weinberger <richard@nod.at>, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Jul 2026 at 21:06, Thomas Gleixner <tglx@kernel.org> wrote:
> The return value of that function is boolean and tells the caller whether
> to permit the syscall processing or not.
>
> Rename the function so the purpose is clear and make the return type bool.

>  arch/m68k/kernel/ptrace.c       |    2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
