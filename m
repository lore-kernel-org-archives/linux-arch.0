From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Software prefetching considered harmful
Date: Fri, 20 May 2011 01:34:00 +0200
Message-ID: <20110519233400.GA1954@elte.hu>
References: <BANLkTi=428+KWmDcHoFYs5gO_C9wyhxJnQ@mail.gmail.com>
 <20110519.153259.1670240855485459381.davem@davemloft.net>
 <BANLkTi=0N55+mQjE1gq8DHdoQ0GU0A7kLw@mail.gmail.com>
 <20110519.154700.1253349185128359804.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:58212 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933298Ab1ESXeM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 19 May 2011 19:34:12 -0400
Content-Disposition: inline
In-Reply-To: <20110519.154700.1253349185128359804.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: torvalds@linux-foundation.org, linux-arch@vger.kernel.org, benh@kernel.crashing.org, rmk@arm.linux.org.uk


* David Miller <davem@davemloft.net> wrote:

> So, to reiterate, I think you should kill all the list handling
> prefetches off.

Agreed.

> What we can do is say "for this specific list use, prefetch does
> in fact help".  And provide an interface for that.  I imagine there
> are things like inode dirty writeback or some dcache stuff that
> walks large lists and for which prefetch might be appropriate.

I think the best 'interface' for that is to open-code the prefetch()
right into the loop. This way it becomes well documented and very
visible as well.

Thanks,

	Ingo
