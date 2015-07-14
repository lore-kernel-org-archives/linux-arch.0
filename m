From: "acme@kernel.org" <acme@kernel.org>
Subject: Re: [PATCH] Revert "perf tools: Allow to specify custom linker
 command"
Date: Tue, 14 Jul 2015 11:45:22 -0300
Message-ID: <20150714144522.GK2885@kernel.org>
References: <1436785853-4260-1-git-send-email-abrodkin@synopsys.com>
 <20150713202406.GB5020@blackmetal.musicnaut.iki.fi>
 <20150714134623.GH2885@kernel.org>
 <1436882404.2839.28.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42065 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751644AbbGNOpX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 14 Jul 2015 10:45:23 -0400
Content-Disposition: inline
In-Reply-To: <1436882404.2839.28.camel@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "aaro.koskinen@nokia.com" <aaro.koskinen@nokia.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "jolsa@kernel.org" <jolsa@kernel.org>, "paulus@samba.org" <paulus@samba.org>, "a.p.zijlstra@chello.nl" <a.p.zijlstra@chello.nl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Em Tue, Jul 14, 2015 at 02:00:05PM +0000, Alexey Brodkin escreveu:
> On Tue, 2015-07-14 at 10:46 -0300, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Jul 13, 2015 at 11:24:06PM +0300, Aaro Koskinen escreveu:
> > > > But for now to fix cross-building of perf this revert is enough.

> > > Hmm. You are probably right, my build system always exports LD with
> > > correct linker for cross builds so perhaps that's why I this "worked"
> > > for me when testing. Sorry.

> > So, I think this is an "Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>"
> > for the revert, right?

> > > I guess the correct fix would be [1], i.e. there should be some new
> > > variable to pass flags to ld command.

> > > Or maybe [2], could we use make "origin" function? If LD is "default",
> > > then use "$(CROSS_COMPILE)ld", otherwise use what the user passed?

> > When you guys get to some conclusion, please submit a new patch, for now
> > I am taking the revert with the (implied) Acked-by Aaro, ok?

> Please find my patch that both reverts initial Aaro's patch and implements
> proper handling of CC, AR and LD substitution here - https://lkml.org/lkml/2015/7/14/149

I saw it, will do.

- Arnaldo
