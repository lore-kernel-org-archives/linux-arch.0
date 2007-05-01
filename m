Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hoefnix.telenet-ops.be ([195.130.132.54]:39708 "EHLO
	hoefnix.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754537AbXEAPHl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 1 May 2007 11:07:41 -0400
Received: from hoboe1bl1.telenet-ops.be (hoboe1bl1.telenet-ops.be [195.130.137.72])
	by hoefnix.telenet-ops.be (Postfix) with ESMTP id EB9E99F222
	for <linux-arch@vger.kernel.org>; Tue,  1 May 2007 17:07:39 +0200 (CEST)
Date: Tue, 1 May 2007 17:07:15 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: condingstyle, was Re: utrace comments
In-Reply-To: <1178028973.2875.78.camel@pmac.infradead.org>
Message-ID: <Pine.LNX.4.64.0705011706350.27246@anakin>
References: <20061127165138.GA2991@lst.de> <20070430040213.BF9901801A4@magilla.sf.frob.com>
 <20070430091121.GC31397@infradead.org> <20070430100917.439ebfc8.akpm@linux-foundation.org>
 <a781481a0704301142sfec317cu8213750c9ab84416@mail.gmail.com>
 <Pine.LNX.4.64.0705011058330.27246@anakin> <1178028973.2875.78.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Satyam Sharma <satyam.sharma@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>, Roland McGrath <roland@redhat.com>, Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 1 May 2007, David Woodhouse wrote:
> On Tue, 2007-05-01 at 11:00 +0200, Geert Uytterhoeven wrote:
> > 
> >         if (veryverylengthycondition1 &&
> >             smallcond2 &&
> >             (conditionnumber3a ||
> >              condition3b)) {
> >                 ...
> >         }
> 
> It's horrid. I'd much rather see
> 
>         if (veryverylengthycondition1 &&
>             smallcond2 &&
>             (conditionnumber3a || condition3b)) {
>                 ...
>         }

For clarity, if it fits, I prefer that one, too.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
