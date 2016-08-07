From: Alan Modra <amodra@gmail.com>
Subject: Re: [PATCH 1/5] kbuild: allow architectures to use thin archives
 instead of ld -r
Date: Sun, 7 Aug 2016 13:04:59 +0930
Message-ID: <20160807033459.GT20904@bubble.grove.modra.org>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
 <1470399123-8455-2-git-send-email-npiggin@gmail.com>
 <20160806201045.GA25821@ravnborg.org>
 <20160807114946.41b682f3@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34680 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223AbcHGDfF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 6 Aug 2016 23:35:05 -0400
Content-Disposition: inline
In-Reply-To: <20160807114946.41b682f3@canb.auug.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Sam Ravnborg <sam@ravnborg.org>, Nicholas Piggin <npiggin@gmail.com>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>

On Sun, Aug 07, 2016 at 11:49:46AM +1000, Stephen Rothwell wrote:
> Hi Sam,
> 
> On Sat, 6 Aug 2016 22:10:45 +0200 Sam Ravnborg <sam@ravnborg.org> wrote:
> >
> > Did you by any chance evalue the use of INPUT in linker files.
> > Stephen back then (again based on proposal from Alan Modra),
> > also made an implementation using INPUT.
> 
> The problem with that idea was that (at least for some versions of
> binutils in use at the time) we hit a static limit to the number of
> object files and ld just stopped at that point. :-(
> 
> > See below for an updated simple patch on top of mainline.
> 
> So, I guess it was fixed, but do we know in what version?

I think the patch was
https://sourceware.org/ml/binutils/2012-06/msg00201.html

So, you need binutils 2.23 or later.

-- 
Alan Modra
Australia Development Lab, IBM
