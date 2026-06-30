Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D69395AEA
	for <linux-arch@vger.kernel.org>; Tue, 30 Jun 2026 09:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782811319; cv=none; b=d2qSePEgHvotz/FiyQLeaX6PKHE3kvYSYMrA/apgUnIPsRu11jnPcZiQ/6K9TOEVoabFHo2nw9r6HsTDmu93mk6VBjS8NU8eel0J/mvPL6rprxLsvhDy3NUC21MI5JG/ElgiuJFhgR+lguu3jgfX1H8JCmyfVZP+FU4na+hG9Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782811319; c=relaxed/simple;
	bh=ZsgfwaWQ/k/9S7dCTq9cmP+83fNx4+hdg55zwZq3nX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5/Q+a4JVDwgAtdTAy1tC88a5L0BITcIZpp9ZZy+/00UX85Lwxnlu+M3EeQM+gIDKnyHcouzwm4eqkF7uMwpmbV0ZiIAW9oxMpBfAw2sev7vsGeQDdxZtAyo51gwK1WplfBwIdOWIRRiJlH41aKgJPr26oBKvSyNf4EG9mIf/uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Rv6B8YEB; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Rv6B8YEB"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47231f1f8f3so3569641f8f.1
        for <linux-arch@vger.kernel.org>; Tue, 30 Jun 2026 02:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782811317; x=1783416117; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lNTfDa2UJEPkdFDHQ+TrUrTOUtTro7Mdn22skuoNakY=;
        b=Rv6B8YEBJ5YtDrk2luKaz+nZvi38TVRnvCBjWQfFCXqHhR0lakEtuvpqNrDuGLLXrf
         5eYLgpo/n/uto5OjHVFOrPI2/SICLYmSPJ5jotp1QfVO+toMHKKFYOXb5k8EfnoJ+y9M
         a+LCRZ6bMQLMaSEhO+NftsGisUSnhxsRtWCykPKFTq0TJ+NvHqUl03WqKKhAaapN6XWy
         MZqjhuTuxL58hhIsLLFd6vebZchxps/3zrodvApf4ia5Tf1j8txgU6EVvdILIbKzlya7
         3Btf/t9ZGsFpQnnqhwhsYA+w+lnlGApfXZTSFlZp0+ymEGKC1s0c97GCeU18CiLuuQuz
         iTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782811317; x=1783416117;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lNTfDa2UJEPkdFDHQ+TrUrTOUtTro7Mdn22skuoNakY=;
        b=KU0/sUERliF44pUHefPwK68g0D1OeruNhGochbO7W1sb0OBBBkqDUFamBTZZxJWRvk
         5qG2LjA04xrffs49lxsTak6W9FD51qdRqyPzBRQ2cZ2GMxp7j2PlfN26VFTiLyMuemuI
         PrTLpgoIl/Qaaj00c04bjmMX44BPn0nrcUQl4IdLv4I+2cLC58njEQLjX1fKlfe7Tlmm
         pzvV83FsYTlZM525fjXN/vfD2qmMqgaYLhYPZ/MotjBQTNv+jSQAlw1P1UMtaSm6I01D
         2mdyIFOrm1GEVUUglP98d4kyBkHIC8LbzY0DRM+J42veqrqon8BBhfhNu+WUM8zAes0b
         UOiw==
X-Forwarded-Encrypted: i=1; AHgh+RokyrPOMrJhSsxTv4E+3/RlJGITR59Dg0fO3PGXiIZiHwip37zCsgAo1MRkn6Z2UKX9TGIjVYbuyLbu@vger.kernel.org
X-Gm-Message-State: AOJu0YyWgAPZ6fTyuw7JUqVBeafZLyYqXSE/zDHQ0C5IYEL1OGHtTNtp
	tmH2cOiOR4carShOTNnEmiutZcEnvvSjGbAY3SJYaSUqyBa6iZTFobYi5ZSCmVBL5wY=
X-Gm-Gg: AfdE7cnBSB4rtSuY0Pi4MA2NqXaZ0250DrQIPw142YhIDDa6AL0wAl3hgwGunYeNlPl
	k/eGV4urA2VIxPkfVyNo87nMinz0S9gdB5d9h7Yzm6L15wyj0CIPLFEsFOcZXVclstRlyO8M/vd
	rlKHqYXOpblwIXw6TCm1ES7dPDwIipeSiAw+YgKbQbSa3p6QbWjv7BvY364AugTfXu7kO+sOjB+
	dQlsDbl7ozsnkfPvKimKO2K+6WL1vJw3uVzYmlK+rGvU+SccbOW9HxPCtIrLnxupzqw9twDceYI
	szqRGOSk9mxNqcHa2iZ5aDNxEOj6jTYuM9Ioi2G2Zv4SfpnGGEZWdCZs8CvNlwiiaL2GXTG9YaH
	ijiC7LsF2U5n+V6Ggfmrjxn0ZvAVUalyxOygUcuO2g0Gb2IQwMe4xi/zX1x3Nced6hhfgakM6Jq
	eR/DBAUSuZCtVMgko=
X-Received: by 2002:a05:6000:240c:b0:475:f100:35f9 with SMTP id ffacd0b85a97d-475f10036efmr1371196f8f.54.1782811316975;
        Tue, 30 Jun 2026 02:21:56 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47566743895sm5924944f8f.25.2026.06.30.02.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 02:21:56 -0700 (PDT)
Date: Tue, 30 Jun 2026 11:21:53 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Andrea Righi <arighi@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Ben Segall <bsegall@google.com>,
	Breno Leitao <leitao@debian.org>,
	Changwoo Min <changwoo@igalia.com>,
	David Vernet <void@manifault.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Eric Dumazet <edumazet@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Simon Horman <horms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vlad Poenaru <vlad.wing@gmail.com>
Subject: Re: [PATCH 1/2] bug: Provide WARN_ON.*DEFERRED() macros for console
 deferred output
Message-ID: <akOKsdOhfBBqVUhI@pathway.suse.cz>
References: <20260623142650.265721-1-bigeasy@linutronix.de>
 <20260623142650.265721-2-bigeasy@linutronix.de>
 <038a11a7-4ced-49ae-b605-2058733e841a@amd.com>
 <20260624062642.5DER6vrP@linutronix.de>
 <ajugq8VAciqtMx9F@pathway.suse.cz>
 <20260624152431.Ufq0jT8r@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260624152431.Ufq0jT8r@linutronix.de>

On Wed 2026-06-24 17:24:31, Sebastian Andrzej Siewior wrote:
> On 2026-06-24 11:17:31 [+0200], Petr Mladek wrote:
> > For Linus, it was a no-go, definitely.
> …
> > I would vote for adding the WARN_*DEFERRED() into the scheduler code
> > at least until majority of console drivers are converted to nbcon API.
> 
> I see four nbcon serial console drivers (+netconsole, + drm_log). We
> have at least four times that many console drivers. What is the
> majority from your point of view? The 8250 should cover all of x86.

Good question. IMHO, there are about 100 console drivers:

$> git grep "struct console.*= {" | wc -l
107

But I guess that many of them are some old rarely used ones.

I tried to google amount of market share from various architectures
and it seems that most spread are: arm, x86_64, and risc-v.

Arm might already be mostly covered by pl011.
x86_64 will be covered by 8250.

I am not sure about risc-v. It seems that it might use 8250 as well
at least in virtual machines. Also there is drivers/tty/hvc/hvc_riscv_sbi.c.

Hmm, 8250 might the breakpoint. Maybe, we could leave the rest as a
motivation to convert the console driver instead of adding workarounds
using the printk_deferred() mechanism.

That said, AFAIK, the netconsole is often used when the device does
not have a serial console. And it is pity that it does not have
the .write_atomic callbacks implemented.

Best Regards,
Petr
