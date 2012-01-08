From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 2/2] msm: DMAEngine: Add DMAEngine driver based on
	old MSM DMA APIs
Date: Sun, 8 Jan 2012 00:21:04 +0000
Message-ID: <20120108002104.GC13181@n2100.arm.linux.org.uk>
References: <1325854052-21402-1-git-send-email-kumarrav@codeaurora.org> <1325854052-21402-3-git-send-email-kumarrav@codeaurora.org> <1325901569.10425.14.camel@m0nster> <20120107185443.GA19216@codeaurora.org> <20120107192112.GB13181@n2100.arm.linux.org.uk> <1325981636.16037.6.camel@m0nster>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35541 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451Ab2AHAVy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 7 Jan 2012 19:21:54 -0500
Content-Disposition: inline
In-Reply-To: <1325981636.16037.6.camel@m0nster>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Daniel Walker <dwalker@fifo99.com>
Cc: David Brown <davidb@codeaurora.org>, Ravi Kumar V <kumarrav@codeaurora.org>, vinod.koul@intel.com, dan.j.williams@intel.com, arnd@arndb.de, linux-arch@vger.kernel.org, bryanh@codeaurora.org, tsoni@qualcomm.com, johlstei@qualcomm.com, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>

On Sat, Jan 07, 2012 at 04:13:56PM -0800, Daniel Walker wrote:
> On Sat, 2012-01-07 at 19:21 +0000, Russell King - ARM Linux wrote:
> > Please refer to the DMA engine documentation, found here:
> > 
> > Documentation/dmaengine.txt
> > 
> > section 3:
> > 
> >    Note:
> >         Although the async_tx API specifies that completion callback
> >         routines cannot submit any new operations, this is not the
> >         case for slave/cyclic DMA.
> > 
> >         For slave DMA, the subsequent transaction may not be available
> >         for submission prior to callback function being invoked, so
> >         slave DMA callbacks are permitted to prepare and submit a new
> >         transaction.
> > 
> >         For cyclic DMA, a callback function may wish to terminate the
> >         DMA via dmaengine_terminate_all().
> > 
> > *       Therefore, it is important that DMA engine drivers drop any
> > *       locks before calling the callback function which may cause a
> > *       deadlock.
> 
> Here's the comment from at_hdmac.c .
> 
>                 /*
>                  * The API requires that no submissions are done from a
>                  * callback, so we don't need to drop the lock here
>                  */
>                 if (callback)
>                         callback(param);
> 
> I don't know much about the DMA engine, but maybe there is some special
> case here that makes this ok.. (CC'ed Nicolas Ferre)

If you read the note fully, you'll notice that there's a difference
between the async_tx API and the slave/cyclic DMA API (it's covered
in the first paragraph.)

Plus that documentation was written by me, reviewed by Dan and Vinod
and accepted.  You can treat it as authoritive, and take from it that
at_hdmac.c is buggy.
