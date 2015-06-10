From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 22/28] ARCv2: STAR 9000837815 workaround hardware
 exclusive transactions livelock
Date: Wed, 10 Jun 2015 13:02:34 +0200
Message-ID: <20150610110234.GH3644@twins.programming.kicks-ass.net>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
 <1433850508-26317-23-git-send-email-vgupta@synopsys.com>
 <20150609123548.GZ3644@twins.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA23075665A5041@IN01WEMBXB.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:58348 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814AbbFJLCi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 10 Jun 2015 07:02:38 -0400
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075665A5041@IN01WEMBXB.internal.synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>

On Wed, Jun 10, 2015 at 10:01:01AM +0000, Vineet Gupta wrote:
> OK - I need some more time to rehash the exact details with our
> hardware folks. But AFAIKR, this was hardware livelock in llock/scond
> when 2 cores were doing r-m-w to two different words in the same cache
> line - adding prefetchw (prefetch with a write intent) would get the
> line in exclusive state and break the livelock.
> 
> The test itself was one from EEMBC Multibench but I'll have to look it
> up.
> 
> Wasn't there something similar in ARM world too - they have some sort
> of snoop-delayed exclusive handling in hardware to mitigate something
> similar although as Will later remarked it involved llock/scond with
> vanilla ld/st to same line/word ?

> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/254142.html

Cute, I was not aware of that.

Sounds reasonable (unfortunate but understandable). Speaking as someone
who at times does full arch sweeps on code like this it really helps
understanding if such things are explained a wee bit better than not at
all :-)
