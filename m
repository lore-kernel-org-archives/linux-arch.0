Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268329AbUJSLpv@vger.kernel.org>
Received: from p508B7611.dip.t-dialin.net ([80.139.118.17]:46879 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S268207AbUJSLnJ
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 19 Oct 2004 07:43:09 -0400
Date: Tue, 19 Oct 2004 13:42:53 +0200
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: All archs: NO_IRQ definition
Message-ID: <20041019114253.GC28236@linux-mips.org>
References: <1098169077.11400.51.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098169077.11400.51.camel@gaston>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Tue, Oct 19, 2004 at 04:57:57PM +1000, Benjamin Herrenschmidt wrote:

> I need to fix a few wrong cases where driver assume that irq = 0 means
> no interrupt. This is wrong, some arch have pefectly valid IRQ 0. We
> started defining NO_IRQ a while ago for that reason, but it seems lot
> of archs didn't catch up. I plan to collect a patch fixing them all but
> you guys will have to tell me what value to use for NO_IRQ (0 ? -1 ?).
> 
> Currently, only ppc64, arm and mips add it, and I know what to do for
> ppc, that leaves me with request for the proper value to use for those
> archs:

I guess your grep must have picked up SGI_VINO_IRQ by accident - MIPS
doesn't define NO_IRQ.  0 is used as a normal interrupt number on MIPS,
so -1 is the prefered value for NO_IRQ.

  Ralf
