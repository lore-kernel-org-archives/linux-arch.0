From: Ingo Molnar <mingo@elte.hu>
Subject: Re: + allow-rwlocks-to-re-enable-interrupts.patch added to -mm tree
Date: Wed, 3 Dec 2008 08:38:02 +0100
Message-ID: <20081203073802.GA21006@elte.hu>
References: <200812030013.mB30DSJU032317@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:36673 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754143AbYLCHiV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 3 Dec 2008 02:38:21 -0500
Content-Disposition: inline
In-Reply-To: <200812030013.mB30DSJU032317@imap1.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: mm-commits@vger.kernel.org, holt@sgi.com, a.p.zijlstra@chello.nl, linux-arch@vger.kernel.org, ptesarik@suse.cz, tony.luck@intel.com


* akpm@linux-foundation.org <akpm@linux-foundation.org> wrote:

> 
> The patch titled
>      Allow rwlocks to re-enable interrupts
> has been added to the -mm tree.  Its filename is
>      allow-rwlocks-to-re-enable-interrupts.patch
> 
> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
> 
> *** Remember to use Documentation/SubmitChecklist when testing your code ***
> 
> See http://userweb.kernel.org/~akpm/stuff/added-to-mm.txt to find
> out what to do about this
> 
> The current -mm tree may be found at http://userweb.kernel.org/~akpm/mmotm/
> 
> ------------------------------------------------------
> Subject: Allow rwlocks to re-enable interrupts
> From: Robin Holt <holt@sgi.com>
> 
> Pass the original flags to rwlock arch-code, so that it can re-enable
> interrupts if implemented for that architecture.
> 
> Initially, make __raw_read_lock_flags and __raw_write_lock_flags stubs
> which just do the same thing as non-flags variants.
> 
> Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
> Signed-off-by: Robin Holt <holt@sgi.com>
> Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: <linux-arch@vger.kernel.org>
> Cc: Ingo Molnar <mingo@elte.hu>

Acked-by: Ingo Molnar <mingo@elte.hu>

thanks,

	Ingo
