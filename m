Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pasmtpa.tele.dk ([80.160.77.114]:59687 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756579AbXEPTJo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 16 May 2007 15:09:44 -0400
Date: Wed, 16 May 2007 21:10:39 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC] Explicitly mark global functions with vmlinux with __global
Message-ID: <20070516191039.GA31164@uranus.ravnborg.org>
References: <1179333273.2859.282.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1179333273.2859.282.camel@shinybook.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-arch@vger.kernel.org, Marcelo Tosatti <marcelo.tosatti@cyclades.com>
List-ID: <linux-arch.vger.kernel.org>

On Thu, May 17, 2007 at 12:34:33AM +0800, David Woodhouse wrote:
> A while ago, I played with using '-fwhole-program --combine' for
> building kernel objects -- http://lwn.net/Articles/197097/

To save binary size the approach used by Marcelo Tosatti
should be considered.
See http://lkml.org/lkml/2006/6/4/169

But that also rely on newer toolchain and I do not
know if this has been added since then.

Googling for 'print-gc-section' says that -M has been enhanced 
to give same info.

This is on my TODO list to look into but buried somewhere deep.

	Sam
