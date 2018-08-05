Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:55376 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbeHESiM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Aug 2018 14:38:12 -0400
Date: Sun, 5 Aug 2018 12:32:34 -0400
From: Rich Felker <dalias@libc.org>
Subject: Re: [PATCH] sh: remove unneeded constructor.
Message-ID: <20180805163234.GR1392@brightrain.aerifal.cx>
References: <20180731051519.101249-1-ysato@users.sourceforge.jp>
 <CAMuHMdUQReuzR=x54gnC1XdP77RrT1TaWoFFXUhUQ02A+giPqQ@mail.gmail.com>
 <87600us5k9.wl-ysato@users.sourceforge.jp>
 <20180804103550.GA3183@bombadil.infradead.org>
 <CAMuHMdXsz-+zsxouaLP5tTKA46G34iAACSce+RXrD8AiiQc2+A@mail.gmail.com>
 <20180804105149.GB3183@bombadil.infradead.org>
 <4e9e1599-9dbf-75dc-561e-77d5cb063714@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e9e1599-9dbf-75dc-561e-77d5cb063714@landley.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rob Landley <rob@landley.net>
Cc: Matthew Wilcox <willy@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

On Sun, Aug 05, 2018 at 10:54:56AM -0500, Rob Landley wrote:
> On 08/04/2018 05:51 AM, Matthew Wilcox wrote:
> > On Sat, Aug 04, 2018 at 12:47:08PM +0200, Geert Uytterhoeven wrote:
> >> You do want to readd the __GFP_ZERO flag to the second user of PGALLOC_GFP,
> >> don't you?
> > 
> > I missed that!  Probably only relevant for SH-64.  But yes ... probably better
> > to make this explicit then:
> 
> As far as I know sh5/sh-64 never shipped, it was just some prototype hardware
> that didn't go to production?

I'm not sure about the details, but GCC has removed support and it's
effectively dead. I would be happy to merge patches removing the
existing SH-64 stuff in the kernel too. I'm not sure if generality to
support LP64 should be left in the arch/sh tree for future or if the
eventual 64-bit j-core should just be done as a separate arch tree; I
suspect the latter might be cleaner.

Rich
