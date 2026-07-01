Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17892BCF4C;
	Wed,  1 Jul 2026 15:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782919920; cv=none; b=oyAtEqoL0DfHI9FTHeGOdO4JDFuZ+ZerbnCVbkCuTNwU7pdKZ74JFTmp7KfKofsV1kfNUrWbuu4VB1ogMzPsZpbt4DvuCaYMKEMAlZFncNa/R9xWaebZh2NqlXvWfkJbxPwG63A0TrctMJmbC+TK6HwrgwMCk5x9sv9M2oxgj28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782919920; c=relaxed/simple;
	bh=bsHkWhmSkDsG3oqGlKhSSDNE7xRPYEaMsNYqqPV5vi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGsbFnQI0biq6IzcejumokrYDDwD/6wXc783V2h27SVsN4QL6VIcXPMNgziROHIFw99o2sfQml3NLrvBnwqYXKSV/xTJseQvngIyltRnySwFNQok4xqSO+/9+kNZwdhSRuiw5CSVjn6dK28y9eujDSdibR3PuMwswc6LZG1guSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ForHa2zc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yxarkfhc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ForHa2zc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yxarkfhc"
Date: Wed, 1 Jul 2026 17:31:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782919916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bsHkWhmSkDsG3oqGlKhSSDNE7xRPYEaMsNYqqPV5vi0=;
	b=ForHa2zcTmyUo0NV17RYDMzuFMMEm+LyJtdYFeTm9s7E0cAEVlo623vHcwdu9Ot1NFdmj0
	SrDiQ7uqSnp1SAkcZjLSJsEiit3w9sDAwyX/opS7WDn3HA4gKEwD5GKicHAqviC9C2TGXR
	HdPQQqSCBZb/Q0IX2tWaRjF9FzXV6X+FLisEeWPU4BLOXhKgnv/xbQ0vHRchbYKML+3Fqv
	EWwwE9xosigvGnED+hOD7sygLx/ro+ZZEFVF4/aaQu4ExpaYyjXIjFVUXVuYxP0ky0iGGX
	b7SKe6GNBsnEG70VWTN+wZMEwwlxAN439aPTCP/oH/fvtSWC7YETJS3DqAcojA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782919916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bsHkWhmSkDsG3oqGlKhSSDNE7xRPYEaMsNYqqPV5vi0=;
	b=Yxarkfhc7yYk2weoKQYOe679AGIbI4iJVdhSqBujP7ll1wXxG2G2SpG8BronG5TcteS+J9
	PZ0YyNWe8dMbV1Bg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>,
	Vlad Poenaru <vlad.wing@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
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
	Juri Lelli <juri.lelli@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Paolo Abeni <pabeni@redhat.com>, Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Simon Horman <horms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 0/2] sched: Introduce and use deferred WARNs in sched
Message-ID: <20260701153154.a-n6eXNF@linutronix.de>
References: <20260623142650.265721-1-bigeasy@linutronix.de>
 <20260624093329.GZ48970@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260624093329.GZ48970@noisy.programming.kicks-ass.net>

On 2026-06-24 11:33:29 [+0200], Peter Zijlstra wrote:
> So I really don't see why we should do this. This has been a 'problem'
> forever, and printk() is actually being fixed.

I just prepared v2 and apparently missed this. So let me postpone it=E2=80=
=A6

A user triggered a warning under the rq lock so it is not a theoretical
problem which happens during development. printk is fixed it is just the
console driver that are lagging behind. The 8250 is probably the role
model that everyone is waiting for and once it becomes a NBCON it is no
longer affected by the "deferred" requirement here.
The problem was reproduced on netconsole which is a NBCON, too.

So we just ignore the problem because it is well known? I was hoping for
some duct tape until we have NBCON and threaded-legacy consoles.

Vlad: Were you doing something special to trigger the warning in
question or did it randomly trigger?

Sebastian
