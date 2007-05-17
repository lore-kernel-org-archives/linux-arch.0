Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:51964 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758457AbXEQAVL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 May 2007 20:21:11 -0400
Subject: Re: [RFC] Explicitly mark global functions with vmlinux with
	__global
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <20070516191039.GA31164@uranus.ravnborg.org>
References: <1179333273.2859.282.camel@shinybook.infradead.org>
	 <20070516191039.GA31164@uranus.ravnborg.org>
Content-Type: text/plain
Date: Thu, 17 May 2007 08:21:04 +0800
Message-Id: <1179361264.2859.337.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-arch@vger.kernel.org, Marcelo Tosatti <marcelo.tosatti@cyclades.com>
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2007-05-16 at 21:10 +0200, Sam Ravnborg wrote:
> On Thu, May 17, 2007 at 12:34:33AM +0800, David Woodhouse wrote:
> > A while ago, I played with using '-fwhole-program --combine' for
> > building kernel objects -- http://lwn.net/Articles/197097/
> 
> To save binary size the approach used by Marcelo Tosatti
> should be considered.
> See http://lkml.org/lkml/2006/6/4/169

Yeah, I know about that -- I was the one who pointed him at it :)

> But that also rely on newer toolchain and I do not
> know if this has been added since then.

Does it? I've been doing --gc-sections in the kernel for years. I
thought the only thing we wanted a toolchain patch for was to _print_
the symbols which got discarded. Just throwing them away is something
we've been able to do for ever.

--gc-sections doesn't achieve as much as --combine does -- it can only
throw away functions which are _entirely_ unused; it can't do any
cross-unit optimising and inlining.

-- 
dwmw2

