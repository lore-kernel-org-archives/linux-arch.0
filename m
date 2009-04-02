From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 1/3] Factor out #ifdefs from kernel/spinlock.c to
	LOCK_CONTENDED_FLAGS
Date: Fri, 3 Apr 2009 00:30:56 +0200
Message-ID: <20090402223056.GA19007@elte.hu>
References: <200904022220.n32MKX4b026291@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:43905 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752363AbZDBWbX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 2 Apr 2009 18:31:23 -0400
Content-Disposition: inline
In-Reply-To: <200904022220.n32MKX4b026291@imap1.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: holt@sgi.com, a.p.zijlstra@chello.nl, linux-arch@vger.kernel.org, ptesarik@suse.cz, tony.luck@intel.com


Isnt this an old patchset with a sizable -mm track record?

In that case i'd suggest sending this to Linus now. The only arch it 
affects non-trivially is ia64 and that bit has been acked by Tony. 

And if it breaks lockdep everyone will notice quickly ;-)

	Ingo
