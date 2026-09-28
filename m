Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C583FC5AE;
	Mon, 28 Sep 2026 23:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790636927; cv=none; b=BXBsWF/24t+EhpKKrKWwDQefUIPUGeJN2zGfbk/rpzJXi1k4cdzk8zqMxicRUG4Qg2nXOm010D6etBk6tIGi+rwgjmQmXbOyhNSccLOU5WE83WZAnEw++DePxvRFsxUPPe3t02VmC++NXIYd4bDWimdcm9VQ4CH9v9AUm8Dj1n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790636927; c=relaxed/simple;
	bh=KBIWzjGvGBYDOPtvw0F6mbVx/DXbgCJUaC62yKd2cCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9xfIiLceUDMcRNYsqD5+ONVnavQjeGo6UJ1SY5HdILBunlMRHIAUXki/ZclrkU/8krrDCbToUclpWtEudS7c4qM7v6+xjGtqdhnTHZAX+ZCwpA/ssi42/IXYh2BMvh2NPtpMytzmyTk41Q18+9nfclKikZfegISSL7uXNWtXyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ke7UcsGk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ke7UcsGk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E761F000FF;
	Mon, 28 Sep 2026 23:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790636925;
	bh=FJiVO1xFKoNP3L1n5Q0K7gyKgPYwYYjio8HDA9W0yec=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=Ke7UcsGkP28N7rE/l7MN+sL/r6ybN7Z4w30dfBlQWsy4Y0WhgzvAYOTMUorswLwnD
	 tyYPn94Nrzp6hDpeMa8jEr/2aI+gj9WVygWgD0y0uXQXgTGtSt8acRuttJdJ8pmeSE
	 AetqovlDJkZuiPhTpNi7h+bvEStZSCdKLXn9U4KBxs1GrhEVXlKIjUEqc8qqDMw/6W
	 HGjQK46AfwCH2JG9lhqTlfz8GMF1pOK2XO/GH8Os3QRdrDK29d+vN/qS3E1inKjy3r
	 pmYTePDExBPvqVPm9wvt02HsJk9assMTRMTbQ4zLMRcqPK4EKlCXXq/rhSCvq5oCgE
	 6koxdDJ6X7maQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6C41ECE10F4; Mon, 28 Sep 2026 16:08:45 -0700 (PDT)
Date: Mon, 28 Sep 2026 16:08:45 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: dlustig@nvidia.com, joelagnelf@nvidia.com, corbet@lwn.net,
	akiyks@gmail.com, luc.maranget@inria.fr, j.alglave@ucl.ac.uk,
	dhowells@redhat.com, npiggin@gmail.com, boqun@kernel.org,
	peterz@infradead.org, will@kernel.org, parri.andrea@gmail.com,
	stern@rowland.harvard.edu, linux-doc@vger.kernel.org,
	lkmm@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, rdunlap@infradead.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v4 0/2] Documentation/litmus-tests: Add SRCU fastpath
 litmus tests
Message-ID: <1c555323-fa67-4742-8959-0bb92f21b0d2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260916091613.78352-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916091613.78352-1-kunwu.chan@gmail.com>

On Wed, Sep 16, 2026 at 05:16:11PM +0800, Kunwu Chan wrote:
> This series moves the SRCU fastpath litmus tests from
> tools/memory-model/litmus-tests/ to Documentation/litmus-tests/srcu/,
> as suggested by Paul McKenney.
> 
> This series splits the two litmus-test patches from the earlier
> [PATCH 00/13] srcu: Round out atomic SRCU support series:
> https://lore.kernel.org/rcu/20260907075829.2073224-1-kunwu.chan@linux.dev/
> 
> The two tests verify the memory ordering required by the reader-free
> synchronize_srcu_atomic() fastpath: the grace-period anchor must be
> ordered before the per-CPU lock-counter scan.
> 
> Patch 1 verifies that the anchor-before-scan ordering forbids a reader
> from being missed by the scan, while patch 2 shows that reversing the
> ordering permits the problematic outcome.

Queued for testing and further review, thank you!

							Thanx, Paul

> Changes in v4:
> - Remove the smp_mb() and critical-section write from P1, 
>   keep litmus tests minimal, as pointed out by Akira Yokosawa.
> - v3: https://lore.kernel.org/all/20260912024225.2872265-1-kunwu.chan@gmail.com/
> 
> Changes in v3:
> - Add a critical-section write after the smp_mb() in P1 of both
>   litmus tests, so the barrier properly models the lock-increment
>   to critical-section ordering in __srcu_read_lock().  The smp_mb()
>   was previously vacuous because P1 had no subsequent memory access.
>   Suggested by Akira Yokosawa.
> - Adjust indentation of the SRCU entries in litmus-tests/README.
> -v2: https://lore.kernel.org/all/20260912024225.2872265-1-kunwu.chan@gmail.com/
> 
> Changes in v2:
> - Use a filter for the P0 scan result, as suggested by Paul McKenney.
> 
> Tested with herd7 7.58 using linux-kernel.cfg.
> 
> Kunwu Chan (2):
>   Documentation/litmus-tests: Add SRCU fastpath anchor-before-scan test
>   Documentation/litmus-tests: Add SRCU fastpath scan-before-anchor test
> 
>  Documentation/litmus-tests/README             | 19 +++++++
>  .../SRCU-fastpath-anchor-before-scan.litmus   | 55 +++++++++++++++++++
>  .../SRCU-fastpath-scan-before-anchor.litmus   | 52 ++++++++++++++++++
>  3 files changed, 126 insertions(+)
>  create mode 100644 Documentation/litmus-tests/srcu/SRCU-fastpath-anchor-before-scan.litmus
>  create mode 100644 Documentation/litmus-tests/srcu/SRCU-fastpath-scan-before-anchor.litmus
> 
> -- 
> 2.43.0
> 
