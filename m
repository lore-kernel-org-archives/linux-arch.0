Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144C72BE05E
	for <linux-arch@vger.kernel.org>; Thu, 19 Mar 2026 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773928227; cv=none; b=meR0MSZ5hCg51gqsXO2B+iGI8+xGypHX3rwkFrCA6zMrCxE/27sc8f2rBBZZNpzWOv5rn44oVcPl4KqFC5rGja+Ee/jgnWBWhXyd+XIpkqm+HwW8svVTsBVcmh31oG1W8csRmjg9njbOk1a+XN803I0FHFWPnvVFDdcFLWz4e2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773928227; c=relaxed/simple;
	bh=j89Gvis/qGEGvr15cAgXc/XjTDM6TIyQH5z20F0XvZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djm/PaE+YcuitW817CGaN7aGnKFI59OsgLhokhZZWQeIJRuD1HCDB30Hk7w5f65ClrSa8/MRoxMZTaDNfplIQnYh2Ts8N7i/0dAPmOhX10mUxk58MYHKuctVP1I0d+4rCHkeQfNKQ7XC4krouPIyZSJH6iEpOBMBQa/k57Id88U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvVhDTnb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvVhDTnb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E1CC2BCC9
	for <linux-arch@vger.kernel.org>; Thu, 19 Mar 2026 13:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773928226;
	bh=j89Gvis/qGEGvr15cAgXc/XjTDM6TIyQH5z20F0XvZw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZvVhDTnbBJRhFYfSVYAon7ak9IaHBKWnN7MZO/kLi0ZIMEPNvlutWo89B/OAKDOCd
	 KtOHVMTLn2uFn9NGLroc+gay4SmnKBd+hWDSshAaBlteZ7Cmo5Hz59QSpJMJs/FIx8
	 zx3uNw4qVOafmaEnXlMruywFYprjiDjVx9fd9T8MKkGpGfB1SYfP8nXd5YUMNsFX7w
	 lYea6XoRK2/tarFTx9WxhWEUBovJq0dk49IYOnRawrd651lDVE1cjgKfJjvgH8jran
	 GWWMQ1e6N4H8vc0icLiWJLDp8c7hIvH5iiXKF4Nb7b0dg8IGlR1YteSzQqBGtTBGGk
	 UMtgLFXosyh7g==
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64ea73e7b60so277913d50.3
        for <linux-arch@vger.kernel.org>; Thu, 19 Mar 2026 06:50:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVyDS1Kr1raOyrscZ+wfk2yvnlvCDwne1sMvZle/voKRztCTwi+bQFCXVNyFu1/9h5nDNeTuV2EMr2h@vger.kernel.org
X-Gm-Message-State: AOJu0YxBu4oZtni02Dm9S+tn2GYHqFw7LzV0X4yZUU5YJIDvb1O5jyjM
	/21/6Z3VcYkwy24fae6JnnRqub2hTzk/L6gLbz/4yDzRfhtW3Uz53MrCzkduU1CR3rdLp4xzdCi
	w/H3s7FSBRLtTjdNR4TnLNVNvHSBYrYI=
X-Received: by 2002:a05:690c:e4f0:b0:799:266:83d3 with SMTP id
 00721157ae682-79a71c2b7bfmr64114747b3.47.1773928225862; Thu, 19 Mar 2026
 06:50:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317082020.737779-1-ruanjinjie@huawei.com> <20260317082020.737779-3-ruanjinjie@huawei.com>
In-Reply-To: <20260317082020.737779-3-ruanjinjie@huawei.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 19 Mar 2026 14:50:15 +0100
X-Gmail-Original-Message-ID: <CAD++jLmAxER7pR-eoJ4xs2EbGopsS4SWd+wo88xZbzkmPJp-Bw@mail.gmail.com>
X-Gm-Features: AaiRm50Qfp2UBllmGvff8saK2JFshZ6hIP4M5NvuPk-ZtFFI7-7AoZeXZeE62BY
Message-ID: <CAD++jLmAxER7pR-eoJ4xs2EbGopsS4SWd+wo88xZbzkmPJp-Bw@mail.gmail.com>
Subject: Re: [PATCH v13 RESEND 02/14] arm64/ptrace: Use syscall_get_nr()
 helper for syscall_trace_enter()
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oleg@redhat.com, 
	chenhuacai@kernel.org, kernel@xen0n.name, hca@linux.ibm.com, 
	gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, arnd@arndb.de, 
	peterz@infradead.org, luto@kernel.org, shuah@kernel.org, kees@kernel.org, 
	wad@chromium.org, kevin.brodsky@arm.com, deller@gmx.de, macro@orcam.me.uk, 
	akpm@linux-foundation.org, ldv@strace.io, anshuman.khandual@arm.com, 
	ryan.roberts@arm.com, mark.rutland@arm.com, thuth@redhat.com, song@kernel.org, 
	ada.coupriediaz@arm.com, broonie@kernel.org, pengcan@kylinos.cn, 
	liqiang01@kylinos.cn, ziyao@disroot.org, guanwentao@uniontech.com, 
	guoren@kernel.org, schuster.simon@siemens-energy.com, jremus@linux.ibm.com, 
	david@kernel.org, mathieu.desnoyers@efficios.com, edumazet@google.com, 
	kmal@cock.li, dvyukov@google.com, reddybalavignesh9979@gmail.com, 
	x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 9:20=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:

> Use syscall_get_nr() to get syscall number for syscall_trace_enter().
> This aligns arm64's internal tracing logic with the generic
> entry framework.
>
> [Changes]
> 1. Use syscall_get_nr() helper:
>    - Replace direct regs->syscallno access with
>      syscall_get_nr(current, regs).
>    - This helper is functionally equivalent to direct access on arm64.
>
> 2. Re-read syscall number after tracepoint:
>   - Re-fetch the syscall number after trace_sys_enter() as it may have
>     been modified by BPF or ftrace probes, matching generic entry behavio=
r.
>
> [Why this matters]
> - Aligns arm64 with the generic entry interface.
> - Makes future migration to generic entry framework.
> - Properly handles syscall number modifications by tracers.
> - Uses standard architecture-independent helpers.
>
> No functional changes intended.
>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
