From: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch] powerpc: implement optimised mutex fastpaths
Date: Thu, 6 Nov 2008 15:09:08 +1100
Message-ID: <18706.28132.850598.687949@cargo.ozlabs.ibm.com>
References: <20081012054634.GA12535@wotan.suse.de>
	<20081012054732.GB12535@wotan.suse.de>
	<20081013011827.GA1299@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:41023 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753060AbYKFEPX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 5 Nov 2008 23:15:23 -0500
In-Reply-To: <20081013011827.GA1299@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org, benh@kernel.crashing.org

Nick Piggin writes:

> On Sun, Oct 12, 2008 at 07:47:32AM +0200, Nick Piggin wrote:
> > 
> > Implement a more optimal mutex fastpath for powerpc, making use of acquire
> > and release barrier semantics. This takes the mutex lock+unlock benchmark
> > from 203 to 173 cycles on a G5.
> > 
> > +static inline int
> > +__mutex_fastpath_trylock(atomic_t *count, int (*fail_fn)(atomic_t *))
> > +{
> > +	if (likely(__mutex_cmpxchg_lock(count, 1, 0) == 1))
> > +		return 1;
> 
> Oops, I must have sent the wrong version. This needs a return 0 here.

Are you going to send the right version?  (or did you send it and I
missed it?)

Also I note that the comment you added just before that routine says:

+ * Change the count from 1 to a value lower than 1, and return 0 (failure)
+ * if it wasn't 1 originally, or return 1 (success) otherwise. This function
+ * MUST leave the value lower than 1 even when the "1" assertion wasn't true.

yet just doing a __mutex_cmpxchg_lock isn't going to do that.  So
please fix either the comment or the code (or both :).

Paul.
