Return-Path: <ralf@linux-mips.org>
Received: from p508B7B47.dip.t-dialin.net ([80.139.123.71]:3621 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S261202AbUCPLSC
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 16 Mar 2004 06:18:02 -0500
Date: Tue, 16 Mar 2004 12:17:47 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: More DMA API junk
Message-ID: <20040316111747.GA1592@linux-mips.org>
References: <1079398383.1968.205.camel@gaston> <1079399555.1804.232.camel@mulgrave> <1079400742.1968.209.camel@gaston> <1079407473.2069.383.camel@mulgrave> <1079407959.2348.226.camel@gaston> <1079408930.2158.408.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079408930.2158.408.camel@mulgrave>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Mon, Mar 15, 2004 at 10:48:48PM -0500, James Bottomley wrote:

> You're confused about what it's used for.  It's designed only to be
> called on memory allocated by dma_alloc_noncoherent() and tells you if
> that API actually returned coherent memory or not.  This was designed

... but what is coherent?  The API's function naming is completly confusing
at least from a MIPS perspective.  MIPS calls something coherent if
cache coherency is maintained by hardware and that's (hey, what caches?!?)
not the case for uncached memory.

So I would like to rename functions to something less confusing.  Where
did the original terminology come from?  Would anybody object simply
swapping the coherent and noncoherent parts of the function names?

  Ralf
