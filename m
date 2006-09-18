Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from witte.sonytel.be ([80.88.33.193]:37361 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S965560AbWIRIRf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 18 Sep 2006 04:17:35 -0400
Date: Mon, 18 Sep 2006 10:15:14 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [patch 1/1] make PROT_WRITE imply PROT_READ
In-Reply-To: <20060918043100.GA15828@tuatara.stupidest.org>
Message-ID: <Pine.LNX.4.62.0609181014440.17583@pademelon.sonytel.be>
References: <200609150139.k8F1dl7Y014791@shell0.pdx.osdl.net>
 <20060917202408.GA10031@tuatara.stupidest.org> <1158527646.6069.67.camel@localhost.localdomain>
 <20060918005723.GB12662@tuatara.stupidest.org> <17677.65159.433214.4524@cargo.ozlabs.ibm.com>
 <20060918043100.GA15828@tuatara.stupidest.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Chris Wedgwood <cw@f00f.org>
Cc: Paul Mackerras <paulus@samba.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, jbaron@redhat.com, ak@muc.de, arjan@linux.intel.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, hugh@veritas.com, kkojima@rr.iij4u.or.jp, lethal@linux-sh.org, Russell King <rmk@arm.linux.org.uk>, spyro@f2s.com, tony.luck@intel.com, Roman Zippel <zippel@linux-m68k.org>
List-ID: <linux-arch.vger.kernel.org>

On Sun, 17 Sep 2006, Chris Wedgwood wrote:
> On Mon, Sep 18, 2006 at 12:03:51PM +1000, Paul Mackerras wrote:
> > I think the problem is that these applications break randomly,
> 
> which means they are broken surely?
> 
> > depending on exactly when page faults happen, and these patches make
> > the behaviour consistent and deterministic.
> 
> so would detecting PROT_WRITE w/o PROT_READ and returning -EINVAL
> surely then?
> 
> it would still be broken so no loss there and we wouldn't have to make
> such a long term change

That would break apps that use PROT_WRITE correctly (i.e. for writing only).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
