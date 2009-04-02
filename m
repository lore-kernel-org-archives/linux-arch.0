From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 1/3] Factor out #ifdefs from kernel/spinlock.c to
 LOCK_CONTENDED_FLAGS
Date: Thu, 2 Apr 2009 15:37:35 -0700
Message-ID: <20090402153735.cdf6f124.akpm@linux-foundation.org>
References: <200904022220.n32MKX4b026291@imap1.linux-foundation.org>
	<20090402223056.GA19007@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33673 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756070AbZDBWlo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 2 Apr 2009 18:41:44 -0400
In-Reply-To: <20090402223056.GA19007@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: holt@sgi.com, a.p.zijlstra@chello.nl, linux-arch@vger.kernel.org, ptesarik@suse.cz, tony.luck@intel.com

On Fri, 3 Apr 2009 00:30:56 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> Isnt this an old patchset with a sizable -mm track record?

It is.

> In that case i'd suggest sending this to Linus now. The only arch it 
> affects non-trivially is ia64 and that bit has been acked by Tony. 
> 
> And if it breaks lockdep everyone will notice quickly ;-)

OK.
