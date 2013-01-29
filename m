From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v3 02/71] ARC: Build system: Makefiles, Kconfig, Linker
	script
Date: Tue, 29 Jan 2013 18:52:47 +0100
Message-ID: <20130129175246.GA25081@merkur.ravnborg.org>
References: <1359024639-21915-1-git-send-email-vgupta@synopsys.com> <1359024639-21915-3-git-send-email-vgupta@synopsys.com> <51061AD0.4020200@synopsys.com> <20130128184419.GA24853@merkur.ravnborg.org> <5107D263.4090606@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.snhosting.dk ([87.238.248.203]:27921 "EHLO
	smtp.domainteam.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586Ab3A2Rwt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 29 Jan 2013 12:52:49 -0500
Content-Disposition: inline
In-Reply-To: <5107D263.4090606@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de

On Tue, Jan 29, 2013 at 07:15:07PM +0530, Vineet Gupta wrote:
> On Tuesday 29 January 2013 12:14 AM, Sam Ravnborg wrote:
> > On Mon, Jan 28, 2013 at 11:59:36AM +0530, Vineet Gupta wrote:
> >> Hi Sam,
> >>
> >> On Thursday 24 January 2013 04:20 PM, Vineet Gupta wrote:
> >>> Arnd in his review pointed out that arch Kconfig organisation has several
> >>> deficiencies:
> >>>
> >>> * Build time entries for things which can be runtime extracted from DT
> >>>   (e.g. SDRAM size, core clk frequency..)
> >>> * Not multi-platform-image-build friendly (choice .. endchoice constructs)
> >>> * cpu variants support (750/770) is exclusive.
> >>>
> >>> The first 2 have been fixed in subsequent patches.
> >>> Due to the nature of the 750 and 770, it is not possible to build for
> >>> both together, w/o special runtime glue code which would hurt
> >>> performance.
> >>>
> >>> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> >>> Cc: Arnd Bergmann <arnd@arndb.de>
> >>> Cc: Sam Ravnborg <sam@ravnborg.org>
> > Looks good - all former comments addressed, and nothing were jumping
> > into my eyes now.
> > Many existing architectures looks worse from the build stuff perspective...
> >
> > Acked-by: Sam Ravnborg <sam@ravnborg.org>
> >
> > 	Sam
> 
> Thx Sam. I have a following one liner change to the version you reviewed. Will it
> be OK to add your ACK despite that or do I need to send the updated patch for you
> to take a look again.
OK
