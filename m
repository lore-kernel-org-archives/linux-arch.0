From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 1/1] mm: unify pmd_free() implementation
Date: Mon, 28 Jul 2008 11:17:32 -0500
Message-ID: <1217261852.3503.89.camel@localhost.localdomain>
References: <> <1217260287-13115-1-git-send-email-righi.andrea@gmail.com>
	 <alpine.LFD.1.10.0807280851130.3486@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from accolon.hansenpartnership.com ([76.243.235.52]:41723 "EHLO
	accolon.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756637AbYG1QSD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 28 Jul 2008 12:18:03 -0400
In-Reply-To: <alpine.LFD.1.10.0807280851130.3486@nehalem.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrea Righi <righi.andrea@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2008-07-28 at 08:53 -0700, Linus Torvalds wrote:
> But this is horrible, because it forces a totally unnecessary function 
> call for that empty function.
> 
> Yeah, the function will be cheap, but the call itself will not be (it's a 
> C language barrier and basically disables optimizations around it, causing 
> thigns like register spill/reload for no good reason).

Are you sure about this (the barrier)?  We've been struggling to find a
paradigm for our trace points but the consensus seemed to be that
compiler barriers were pretty tiny perturbations in the optimiser stream
(they affect calculation ordering, but not usually enough to be
noticed).  The register spills to get known locations for the tracepoint
variables seemed to be the much more expensive thing.

If this basic assumption is wrong, we need to know now ...

James
