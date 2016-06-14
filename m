Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56185 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751371AbcFNS2L (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 14 Jun 2016 14:28:11 -0400
Date: Tue, 14 Jun 2016 11:27:57 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [RFC PATCH-tip 2/6] locking/rwsem: Enable optional count-based
 spinning on reader
Message-ID: <20160614182757.GA15903@linux-80c1.suse>
References: <1465927959-39719-1-git-send-email-Waiman.Long@hpe.com>
 <1465927959-39719-3-git-send-email-Waiman.Long@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1465927959-39719-3-git-send-email-Waiman.Long@hpe.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <Waiman.Long@hpe.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, xfs@oss.sgi.com, Jason Low <jason.low2@hp.com>, Dave Chinner <david@fromorbit.com>, Scott J Norton <scott.norton@hpe.com>, Douglas Hatch <doug.hatch@hpe.com>
Message-ID: <20160614182757.9QIQ9VrLgc3h1FeS5oXrChRBPxilmUCzVTWRK4S9-Uk@z>

On Tue, 14 Jun 2016, Waiman Long wrote:

>This patch provides a way for the kernel code to designate specific
>rwsems to be more aggressive in term of optimistic spinning that the
>writers will continue to spin for some additional count-based time to
>see if it can get the lock before sleeping. This aggressive spinning
>mode should only be used on rwsems where the readers are unlikely to
>go to sleep.

Yikes, exposing this sort of thing makes me _very_ uneasy, not to mention
the ad-hoc nature and its easiness to mess up. I'm not really for this, even
if it shows extraordinary performance boosts on benchmarks.

Thanks,
Davidlohr
