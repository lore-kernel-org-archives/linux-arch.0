Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from witte.sonytel.be ([80.88.33.193]:5275 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1751342AbWJWI3X (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 23 Oct 2006 04:29:23 -0400
Date: Mon, 23 Oct 2006 10:29:12 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: dealing with excessive includes
In-Reply-To: <200610230059.23806.ak@suse.de>
Message-ID: <Pine.LNX.4.62.0610231027130.1272@pademelon.sonytel.be>
References: <20061017005025.GF29920@ftp.linux.org.uk>
 <20061020091302.a2a85fb1.rdunlap@xenotime.net>
 <Pine.LNX.4.62.0610221956380.29899@pademelon.sonytel.be> <200610230059.23806.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>, Alexey Dobriyan <adobriyan@gmail.com>, Linux Kernel Development <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 23 Oct 2006, Andi Kleen wrote:
> On Sunday 22 October 2006 19:58, Geert Uytterhoeven wrote:
> > On Fri, 20 Oct 2006, Randy Dunlap wrote:
> > > Yes, we have lots of header include indirection going on.
> > > I don't know of a good tool to detect/fix it.
> > 
> > BTW, what about making sure all header files are self-contained (i.e. all
> > header files include all stuff they need)? This would make it easier for the
> > users to know which files to include.
> 
> Would be a worthy goal imho. Can it be done with scripts? 

Making them self-contained or checking whether they are? :-)

The latter is simple, just compile each of them into dummy object files, which
should give no compile errors.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
