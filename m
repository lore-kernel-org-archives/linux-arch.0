From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Do we use runtime patching of function calls somewhere?
Date: Mon, 14 May 2012 18:56:15 +0200
Message-ID: <20120514165615.GB14426@merkur.ravnborg.org>
References: <20120513121600.GA15708@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.snhosting.dk ([87.238.248.203]:52405 "EHLO
	smtp.domainteam.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755831Ab2ENQ4Q (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 May 2012 12:56:16 -0400
Content-Disposition: inline
In-Reply-To: <20120513121600.GA15708@merkur.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux arch <linux-arch@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>

On Sun, May 13, 2012 at 02:16:00PM +0200, Sam Ravnborg wrote:
> Do we have any archs that does runtime patching of function calls?
> 
> On sparc32 we have infrastructure to do so but this
> requires an additional step after the final link
> that I like to get rid of.
> 
> Basically what is required is to locate all
> call-sites that for example call:
> 
>      cache_flush_all();
> 
> and replace this with a
> 
>     srmmu_cache_flush_all();
> 
> sparc32 has ~30 calls that is eligble for runtime patching.
> sparc-next has seen some nice cleanup in this area,
> so your regular kernel has much more.
> 
> We know early on the what to patch with as the only
> paramters involved are platform and MMU type.
> 
> I could try to come up with something myself - but if we already
> have it somewhere maybe there is something to be inspired by.

Just a follow-up to all.
We decided to go for _ops structures for sparc32.

In one case we do runtime patching where we replace the
implementation depending on the platform.

It it 2 times 3 instructions - so nothing big and fancy.

Thanks for the feedback anyway!

	Sam
