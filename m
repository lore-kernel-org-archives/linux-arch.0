Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935373A254D;
	Tue,  9 Jun 2026 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015722; cv=none; b=uolt6wB+tMqqIXFqKOQgoyB0M9CGIl44bTKUyZeuMAeN4zFv0sRUd5RSdkgxFH0bjyBy4oENUYhwrR+dQm4j0bfX38uNjSkmJOzNvqaXGfGVK/9fSwhxqEOkFMdFMmiYFqKfLi6BTaJK9ebBt+jw6emClAOmwjf0+RKHFnPdL0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015722; c=relaxed/simple;
	bh=pTosJoN0vxt8hJlIP4Ujd6s20gXCNR9h6aVdPOJnF0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbGuGBXbq55LMZjJ6R+yP51UJD89BM/HVbCpwhDB6+N4DfgsJ+u9K3sISa5q2BCht16uakxucFcy5ANUQvqOouB8bZnnhE+vY+YgbdSrQEFMASFo1oV3WuvvDbY0ON9WvnXMFA+Wic/s3YcsTH9XYjEQYVaBK1MdhrXzWPYkHSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fShlL7Im; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fShlL7Im"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pTosJoN0vxt8hJlIP4Ujd6s20gXCNR9h6aVdPOJnF0I=; b=fShlL7Im0NHgeJ6XPrfofitG2G
	xLxquEMO1yYsGKOxIuLw1hYNd/aexDJWBAa7RYcdLVvznx7sFRijSpmvq+a3SbZ0egD7rQRO8XCT0
	sFjeu++6dK6o6FCd2sdg4ZxO97qLT/W4spili35j2dxt3KFfB+HaeM+jDsiPbdzmjjSvkww7J7Nc/
	HogSFzIoDKQiQQ//ea0rnQyBozlO/wqwm/nHzkFhCh8N3rwNrKFQFNzfcuEM9K6USnmm0k8KEafhA
	/VaUo1oFYyoRaKJeOm50BIpX1eFDakq3QbOP6HNRhfxLUmCMVJpqMJHktPnFu2AmYKWeVxWB5JJ25
	FBHoUAFA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWxXv-0000000FrWA-1E4W;
	Tue, 09 Jun 2026 14:35:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 21CF330025D; Tue, 09 Jun 2026 16:35:15 +0200 (CEST)
Date: Tue, 9 Jun 2026 16:35:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] rqspinlock: Fix order in raw_res_spin_(un)lock_irq to
 allow schedule
Message-ID: <20260609143515.GA49951@noisy.programming.kicks-ass.net>
References: <20260609094941.56122-1-gmonaco@redhat.com>
 <d40ba64d-78d9-45f5-99b9-4bfb1fc27f6c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d40ba64d-78d9-45f5-99b9-4bfb1fc27f6c@app.fastmail.com>

On Tue, Jun 09, 2026 at 01:22:35PM +0200, Arnd Bergmann wrote:
> On Tue, Jun 9, 2026, at 11:49, Gabriele Monaco wrote:
> > raw_res_spin_unlock_irqrestore() calls raw_res_spin_unlock() and then
> > restores interrupts, this means preemption is enabled when interrupts
> > are still disabled (as part of raw_res_spin_unlock()) so this cannot
> > trigger an actual preemption.
> > This is inconsistent with other spinlock implementations
> > (raw_spin_unlock_irqrestore() and bpf_res_spin_unlock_irqrestore()
> > itself).
> >
> > Adjust the macro to ensure interrupts are enabled before enabling
> > preemption, allowing to schedule at that point. Make the same
> > modification in the error path of raw_res_spin_lock_irqsave().
> >
> > Fixes: 101acd2e78b1 ("rqspinlock: Add macros for rqspinlock usage")

Yeah, this is right. spinlocks always get one preempt_disable, in
addition they might also get irq or bh disable.
