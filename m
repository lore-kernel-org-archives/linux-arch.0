From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 5/9] locking/qrwlock: remove redundant cmpxchg barriers
 on writer slow-path
Date: Wed, 8 Jul 2015 12:05:26 +0200
Message-ID: <20150708100526.GC3644@twins.programming.kicks-ass.net>
References: <1436289865-2331-1-git-send-email-will.deacon@arm.com>
 <1436289865-2331-6-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:55569 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933614AbbGHKFe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jul 2015 06:05:34 -0400
Content-Disposition: inline
In-Reply-To: <1436289865-2331-6-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Waiman.Long@hp.com, mingo@redhat.com

On Tue, Jul 07, 2015 at 06:24:21PM +0100, Will Deacon wrote:
> +#ifndef cmpxchg_relaxed
> +# define cmpxchg_relaxed	cmpxchg
> +#endif

Should we collate this _relaxed stuff and make it 'official' instead of
these ad-hoc/in-situ things?

There's more archs that can usefully implement them than seem to have
implemented them atm. Of course that means someone doing a full arch/*
sweep, but hey.. :-)
