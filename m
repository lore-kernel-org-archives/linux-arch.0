Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFBF4AA1CF;
	Thu, 15 Oct 2026 07:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792050766; cv=none; b=Ry8/5sHTYrTyL6Rr+iGYhFfSbCK0jAw5alBIwS2MaOf2YV03JcFavUonvEzlpW8JQGAhoQLL474Ne2EvRa7sB8l2vru1NoCF/UTh6Wq7wTquJwfF8go433Al3lr7ERA1m/9rofrxdskYKE7R6gHf7zOLQ9c1g37dGEWAOZBHqdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792050766; c=relaxed/simple;
	bh=ap9cJcw/BJOApFWzFN+z4P4RITJ2yvuwfW4aPNDU+58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNoRTjEWWpATY/RrmxhElNpeiheg6Sz3X5XGhwmTVpqj9I7mMVaoA+g3hpiDq3TY1NaN67QbjufWJrm25Y5oij9KH3Daz54bLyjoK38RiB8Kti9m5fdB865R3Jmwe72Jvkb58SosGUImf20A+b4xTAEM5XbIw6p4zPE+dvfwvf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=o2JbxUQy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o2JbxUQy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KcDkoczLZtkXZLmEqUsWfJpdm+QFtb7s3+UB08BN4c4=; b=o2JbxUQynwPIsa8krrwXrFIdmF
	4RElsF95/oQTSa/WYzPavhCHGYnwpzsg/Zx3PUGfkOAQkAJRAgkCEz2do9kjPhkOEnCbBmFaLUDBz
	UEclrll02K7dZzjTwni1nJyrlqmGlCDG3D2aA4kfCT06P4oiLXqhm13S/w6vRRLTGUXnuLG82PNk4
	GIHj+9A6JPGhGupcY33CPJllHA3bQwVeOelJJ4ckuhlH1tiGxdghJLsG7rO/aK69Ohewuqu6eAyJQ
	jYKNBzPbyVBs0Z6H67gwaM/O0l0ZeoRSsbd9MDW3/zZfGj0SWoPMfOFuowc05T3Rtna6nB082R+Yo
	KGfQPBGw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHGG3-0000000BteX-3Ak5;
	Thu, 15 Oct 2026 07:52:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 517013006DD; Thu, 15 Oct 2026 09:52:11 +0200 (CEST)
Date: Thu, 15 Oct 2026 09:52:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Haris Okanovic <harisokn@amazon.com>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de,
	will@kernel.org, akpm@linux-foundation.org, mark.rutland@arm.com,
	ast@kernel.org, rafael@kernel.org, daniel.lezcano@linaro.org,
	memxor@gmail.com, zhenglifeng1@huawei.com,
	xueshuai@linux.alibaba.com, rdunlap@infradead.org,
	david.laight.linux@gmail.com, broonie@kernel.org,
	joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com, ashok.bhat@arm.com
Subject: Re: [PATCH v15 12/16] cpuidle/poll_state: Wait for need-resched via
 tif_need_resched_relaxed_wait()
Message-ID: <20261015075211.GN2009045@noisy.programming.kicks-ass.net>
References: <20260831202251.305046-1-ankur.a.arora@oracle.com>
 <20260831202251.305046-13-ankur.a.arora@oracle.com>
 <178908146776.2725577.2613699832033292946.b4-review@b4>
 <878q58z2ej.fsf@oracle.com>
 <3e8bda45-0aa7-d0be-8aad-dab95902dcde@gentwo.org>
 <as9EospGcR2e1mpO@arm.com>
 <20261014130306.GK2009045@noisy.programming.kicks-ass.net>
 <as-eaNfjOAUnfvVF@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as-eaNfjOAUnfvVF@arm.com>

On Wed, Oct 14, 2026 at 04:23:20PM +0100, Catalin Marinas wrote:
> On Wed, Oct 14, 2026 at 03:03:06PM +0200, Peter Zijlstra wrote:
> > On Wed, Oct 14, 2026 at 10:00:18AM +0100, Catalin Marinas wrote:
> > > It
> > > would also be nice to get some acks from the atomic infrastructure
> > > maintainers.
> > 
> > That'd be Mark and me I suppose. I don't see anything substantial
> > happening, just plumbing the new function.
> 
> Thanks!
> 
> > Now, I really rather dislike timeout based schemes, but given we have
> > users, I suppose this does improve things. We should however be weary of
> > new ones I suppose.
> 
> There's some arm64 precedent in commit ebababcd0372 ("rqspinlock:
> Hardcode cond_acquire loops for arm64"). This one went in without any of
> the arm64 maintainers' ack and we've since been trying to come up with a
> generic interface instead of reverting it. It was fixing a bug where
> arm64 smp_cond_load_acquire() does not evaluate cond_expr unless the
> pointer is also written by another CPU. Arguably the bug was in the
> rqspinlock code for not using a plain cpu_relax() loop.
> 
> Anyway, we had several incarnations of this series, some with a default
> timeout but others objected to it (Arnd and Rafael IIRC), hence the
> proposal here that pleased most people (not all though ;)).

Yeah, I didn't mean to say I'm against this series -- just weary of
timeout based schemes in general.

So feel tree to pick up this series when it seems ready.
