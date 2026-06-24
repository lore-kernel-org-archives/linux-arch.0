Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7F33DA5CF;
	Wed, 24 Jun 2026 15:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782314676; cv=none; b=bAkvl/FlaVbX+ZfViYwtV3Ovou/kVXx7MkTqUi1By1ZGMXfXIT97s8Wyuamk/gl2aR/8YuwGwsYwgHHaSWMnqdbavfH4uz1v39kTQf0wRlr2C70qaVq1f5duZga/N7tnSucT464NSfE/pOBebnunRg5crEwcdE53ekd8e32Ob2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782314676; c=relaxed/simple;
	bh=fsiytajv6eNJbyCkiukybDge6rLIme/uqRKFEf3Y1c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OblWcm9Ur9PYw6soIzKE7VdRSJGd3XxpUlnAZKoceBjiLIBQnQEJpLaB2sLhen4JmohOcx50A/jR7qZxCheJ9hxu6FdW7XufKApxGkbmVYTcD1DV7DZF3VbQEQeraCSAQLRGu4N5/SjK5A93y3PwCxZ+lSkYDbjsDCZLt5SYOrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ahUQRXee; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9tMnLg60; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ahUQRXee";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9tMnLg60"
Date: Wed, 24 Jun 2026 17:24:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782314673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fsiytajv6eNJbyCkiukybDge6rLIme/uqRKFEf3Y1c4=;
	b=ahUQRXeeeV84Rz5Yg77XzGuHhYAaoBCRdm1McRqx7y+mWDGflHSNa7lt6Q9OXNzXexrExU
	VdqrrgO/NyD4r6i2cals3J9t5QjZ3pLntOHSyn7S2mctc0HPlvZfKhVLt/VHjcMinP616T
	OHuE/0vVzLrKPVPjMTcPcNCOiZFeZ5KtRboW3TfX5LYotq6vNmzVOrLqNwy9m1tRX7OCB2
	du9oyIgY5AZjLZb5jvgtUzXlN/YEZ037dyAIssm/TsQXToDDfEbwZMdbua32cpkBL1Ilfk
	A4aByCqaqBPYgV7yDUzAgiNt1cStfQRsjFJFN8E3nYuK6i7/qoi+0ATslguL1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782314673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fsiytajv6eNJbyCkiukybDge6rLIme/uqRKFEf3Y1c4=;
	b=9tMnLg60JUqdRsMpQfN6XFvVhk1aA3iUFCE1d6X8zsBbvcQQgvkRHjg1RrF5Nkd+0UyHSB
	TDhCtq5F0ld7g9AA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Petr Mladek <pmladek@suse.com>
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
Message-ID: <20260624152431.Ufq0jT8r@linutronix.de>
References: <20260623142650.265721-1-bigeasy@linutronix.de>
 <20260623142650.265721-2-bigeasy@linutronix.de>
 <038a11a7-4ced-49ae-b605-2058733e841a@amd.com>
 <20260624062642.5DER6vrP@linutronix.de>
 <ajugq8VAciqtMx9F@pathway.suse.cz>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ajugq8VAciqtMx9F@pathway.suse.cz>

On 2026-06-24 11:17:31 [+0200], Petr Mladek wrote:
> For Linus, it was a no-go, definitely.
=E2=80=A6
> I would vote for adding the WARN_*DEFERRED() into the scheduler code
> at least until majority of console drivers are converted to nbcon API.

I see four nbcon serial console drivers (+netconsole, + drm_log). We
have at least four times that many console drivers. What is the
majority from your point of view? The 8250 should cover all of x86.

> Best Regards,
> Petr

Sebastian
