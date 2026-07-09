Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958E14499A0
	for <linux-arch@vger.kernel.org>; Thu,  9 Jul 2026 18:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783623071; cv=none; b=Ld/rLdQX/zC3VBaOZoVrt3BrsfqRE/xV+EMhSFdjZl++KND9oxxcx3/92M49gnpb4mppDzWpXWVsf1+n0/RtU4S+DrJwXK0EZLKt4JtoGla85GBiCK3Co38dWERZaC7n81FTHFYvfjIG2e+pJTsbTtZw525ELBKZmlwihjJZlDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783623071; c=relaxed/simple;
	bh=lzP8p16U25+AihhB4pAY2jVwlzeYDWG3z6Eulu2pBWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLiQSWDfkzUaOY8TMeklhrtbR85WKaeXG5tqZZalK6xpEKcFeg84qF9PIXJri47mpCcC9rL7jRQ3XgiKH0sL/dbkWv7V5IbajzftRhezfI3uo14VtguAhv2U0OKosoOU3VSwvMH02JZ0irRpgZUIu7LDaZwM9p8J2bJ4VM6LVjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nN4Lxdbu; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nN4Lxdbu"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-388b404ea89so195427a91.0
        for <linux-arch@vger.kernel.org>; Thu, 09 Jul 2026 11:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783623067; x=1784227867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+EsurZOWBA/vTxJ4VlwckFkTmsLoBwFFgPdTWboTXPw=;
        b=nN4LxdbuQkIm1frIFQ2Xjm7NJy9RsZ9CPtSEjIprcsRUGu7BdvaAxFR8/rNHO8YA8a
         X1woSb1Nu/xrs8OHOa4JqGM5iSzdNhmHwQxKYmpIasulAW8/8O7le9XWzN1AFwp1WRj5
         8IP7olcUdeE+dttzz+QppekbyWD4pWzL2Y6Frw6JWKkXpOY6G3ZmgAuptd/imHU0UcG2
         CR6IUAA8Iz2OvsZLLSO59oKvCw2zeV/49J75QyROZlz9Qilh8bKGCQrp/MD5+HjNt3H0
         ViN6guEja5TuF6yY0NsB8cmMFWB7pXxfMLxJ2DIo48GamyBpm0M56vpJlJ55xZvSJAOJ
         LOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783623067; x=1784227867;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+EsurZOWBA/vTxJ4VlwckFkTmsLoBwFFgPdTWboTXPw=;
        b=GQqEIkDQ4hrgeh7vw2JoZgcaQtNrmf2YCN3+rPJtgK5JDR3eRcIdghzawqO3OVAc1x
         horwqSiQsMGCfWYJ2K7y/gX0jtmAn+LQ9/8yRMyb9Y3tZtqc+gGpW8J2j56KlhbPVIrM
         /+R9ygOLDuB1d52Zl2gqYwp2cPjYX/Moc5tDJpW0eBdD9xQZbzEZnaDVVRg5pQNiwAXV
         L4d5JkD61puV4r1wz8ASXDRpVOOzL+A6+s0iIl5rgLHgZKgJlpJB32pPThMSLzf5niZH
         VHA4g9jUiR8nWS98y6WNKeWlZT3bUH0DhI30tvtRZhiCwGMFqDhQXHycImr3cHzhQj87
         ttwA==
X-Forwarded-Encrypted: i=1; AHgh+RqJfyiEiMFVcRvfArbTTT0VLeUvw17QSOEwdGDJGFM2k9oiJWFh0xmqBlHd56TWvDMA7/BQd7KsePmu@vger.kernel.org
X-Gm-Message-State: AOJu0YwnZISNBwooHmgFRWUWci26SZUez0cD7Y1VeqOCMPEgus8OWsvu
	KTgZ4HUHGCOYp6PljGQAmI5dIL/p5L0asHM/m80vODFuPdqicF5yS3eJ
X-Gm-Gg: AfdE7cnR23+tR0FVysZC/mqtfVnhi3sVjir38lxi+L++qvenretQxym42zNVWAaZH39
	MlPX5AaijYnwTCdqtSeCUqMmz+4SwF9SeAUYoc7t/FsjpNGRt4apEuBxdUSAVtbf36F4k3wrr93
	jKxXXZpBee8XNyKnPLAaCpO8JxnGSUAB7bt0lh5AgFvlZMwKbxbsmDj0u3rP/LN1sGhYFCibcts
	luxCM2jsDWSrMcmjwEY5Ex/KC/0GRY6jEFr1jvVAPcWGNPjsR76pJCM4mvTQw9yFWHKt2APR/xD
	fmOjj1MtVzMBDS0xxGogv6TEX8uunR5aq00hykUDiGowcpzVHrNhlL3nqFy2NltBxKOI8Ek0Ccs
	5+hBy/1mT+OIAnCq4rSPOsa0d5tPTSjUvCZynLsBHvXG/23FXcQtEMK9+kVG5aNFDEy6GTB/sT7
	nat3VHRUB24ZXMVKKrqZNVRxcpFnnh3CfCLObbieNcUPvDA/pRSjo6qC2a6dpQ
X-Received: by 2002:a17:90b:3d86:b0:36a:caf2:3815 with SMTP id 98e67ed59e1d1-38d15876f4amr425299a91.15.1783623066680;
        Thu, 09 Jul 2026 11:51:06 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f596asm33415688eec.2.2026.07.09.11.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:51:05 -0700 (PDT)
Date: Fri, 10 Jul 2026 00:20:46 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
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
Subject: Re: [patch 10/18] entry: Use syscall number instead of rereading it
Message-ID: <ak_tgBEhNxX5m700@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260707181957.433213175@kernel.org>
 <20260707190254.181086755@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707190254.181086755@kernel.org>

On Tue, Jul 07, 2026 at 09:06:36PM +0200, Thomas Gleixner wrote:
> rseq_syscall_enter_work() is invoked before the syscall number can be
> modified. So there is no point in rereading it from pt_regs.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
>  include/linux/entry-common.h |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -70,9 +70,10 @@ static inline void syscall_enter_audit(s
>  	}
>  }
>  
> -static __always_inline long syscall_trace_enter(struct pt_regs *regs, unsigned long work)
> +static __always_inline long syscall_trace_enter(struct pt_regs *regs, unsigned long work,
> +						long syscall)
>  {
> -	long syscall, ret = 0;
> +	long ret = 0;
>  
>  	/*
>  	 * Handle Syscall User Dispatch.  This must comes first, since
> @@ -90,7 +91,7 @@ static __always_inline long syscall_trac
>  	 * through hrtimer_interrupt().
>  	 */
>  	if (work & SYSCALL_WORK_SYSCALL_RSEQ_SLICE)
> -		rseq_syscall_enter_work(syscall_get_nr(current, regs));
> +		rseq_syscall_enter_work(syscall);
>  
>  	/* Handle ptrace */
>  	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
> @@ -145,7 +146,7 @@ static __always_inline long syscall_ente
>  	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
>  
>  	if (work & SYSCALL_WORK_ENTER)
> -		syscall = syscall_trace_enter(regs, work);
> +		syscall = syscall_trace_enter(regs, work, syscall);
>  
>  	return syscall;
>  }
> 
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
