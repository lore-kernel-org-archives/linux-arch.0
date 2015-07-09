From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/3] atomic_or() related changes
Date: Thu, 9 Jul 2015 15:20:33 +0200
Message-ID: <20150709132033.GV19282@twins.programming.kicks-ass.net>
References: <1436429599-10762-1-git-send-email-vgupta@synopsys.com>
 <20150709123128.GT19282@twins.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA23075665AD06D@IN01WEMBXB.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:33911 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753319AbbGINUj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2015 09:20:39 -0400
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075665AD06D@IN01WEMBXB.internal.synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Jul 09, 2015 at 01:05:25PM +0000, Vineet Gupta wrote:
> On Thursday 09 July 2015 06:01 PM, Peter Zijlstra wrote:
> > I've just not managed to finish tile, but did do frv this time.
> 
> Not sure what you mean - are you also doing a similar series which extends
> atomic_or to other arches too which will probably we simpler now given ur earlier
> macro-fication of this code !

Yes, one I started a long time ago, I got two rounds of arch/* atomic
cleanups in already, but never got around to actually finishing it.

The next round is almost done, only tile is missing.

My current series is here:

  https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git/log/?h=locking/arch

And I just found there's a bisection fail in there, so let me go fix
that before posting.

Once I got this sorted, there's maybe one more round left.
