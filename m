Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8E12F9C37;
	Wed, 14 Oct 2026 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983318; cv=none; b=P6jDfO6gV0tHWk9ZoAxS8jgTkg9/RSJoOtMhBbBXENAuj4FZFXS33ufCQTYuKQnWV3IyJX1rgNGi12VjDl0OIs8kReXm2ODjx84mskV7QLQ3H3MWZuiJOpZyVOWShTWXQD5v1Wqga/CVtmOAi1aq97l5a1KzLbi+/NL6OPcJZyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983318; c=relaxed/simple;
	bh=qpDVtITf3q8Ifbj2iEUKwlnz+d7HVCX5OeHwbVW15bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8IMuRp6Dx2hjivTFFJi9/D8PWFMltS549AshIpD9W2O99TBw/+/UQdgWdOpiC6w+NC62amCx6hZfr8jiKFAYNW6oydCCZSshAMRuE8TQfvKowshc3wii46EvKi6fvHEZSTcFD+EMLfA42m2idBJOdYfiBAMXHXJHiHUqotHWxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UfOmPQFf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UfOmPQFf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qpDVtITf3q8Ifbj2iEUKwlnz+d7HVCX5OeHwbVW15bw=; b=UfOmPQFfXG9yQ7V+vbm7oiZOGW
	NkkZDTPdShRGr1WZwDjypGTA7zupgTteD6J1yBpVPpbVLHJTv0YV7Zl/Nabgk+fVnfYN4E58omPO1
	yf/zzdLKDeqzn7lKGFMsQ9OlIxVB6lipNntBqNlOK0FbScSBo8NoGe/qQBqnyZN8sfvTDo8+QlZ83
	rn9JWN0qxxqWnYagLnPikr7k8ZB1IeCiDBFZ+EOzfNVwhMAQqEBdYov75Y7E0BD8Gx6BY1zscNr3S
	DowBcc+dAVyNZTBi0iPpA4jytlU+03GZu34ZslvnXA4wVweNjUhWII+52gjtmFPlz8lwC2OlIncTd
	//Xt9exA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGydP-00000003mxp-317m;
	Wed, 14 Oct 2026 13:03:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6EC9C302FBC; Wed, 14 Oct 2026 15:03:06 +0200 (CEST)
Date: Wed, 14 Oct 2026 15:03:06 +0200
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
Message-ID: <20261014130306.GK2009045@noisy.programming.kicks-ass.net>
References: <20260831202251.305046-1-ankur.a.arora@oracle.com>
 <20260831202251.305046-13-ankur.a.arora@oracle.com>
 <178908146776.2725577.2613699832033292946.b4-review@b4>
 <878q58z2ej.fsf@oracle.com>
 <3e8bda45-0aa7-d0be-8aad-dab95902dcde@gentwo.org>
 <as9EospGcR2e1mpO@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as9EospGcR2e1mpO@arm.com>

On Wed, Oct 14, 2026 at 10:00:18AM +0100, Catalin Marinas wrote:
> It
> would also be nice to get some acks from the atomic infrastructure
> maintainers.

That'd be Mark and me I suppose. I don't see anything substantial
happening, just plumbing the new function.

Now, I really rather dislike timeout based schemes, but given we have
users, I suppose this does improve things. We should however be weary of
new ones I suppose.
