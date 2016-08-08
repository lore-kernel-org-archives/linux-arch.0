From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/5] kbuild: allow architectures to use thin archives
 instead of ld -r
Date: Mon, 8 Aug 2016 13:19:41 +1000
Message-ID: <20160808131941.27541a33@roar.ozlabs.ibm.com>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
	<1470399123-8455-2-git-send-email-npiggin@gmail.com>
	<20160806201045.GA25821@ravnborg.org>
	<20160807114946.41b682f3@canb.auug.org.au>
	<20160807144054.GA14682@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32812 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997AbcHHDTu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 7 Aug 2016 23:19:50 -0400
In-Reply-To: <20160807144054.GA14682@ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>

On Sun, 7 Aug 2016 16:40:54 +0200
Sam Ravnborg <sam@ravnborg.org> wrote:

> On Sun, Aug 07, 2016 at 11:49:46AM +1000, Stephen Rothwell wrote:
> > Hi Sam,
> > 
> > On Sat, 6 Aug 2016 22:10:45 +0200 Sam Ravnborg <sam@ravnborg.org> wrote:  
> > >
> > > Did you by any chance evalue the use of INPUT in linker files.
> > > Stephen back then (again based on proposal from Alan Modra),
> > > also made an implementation using INPUT.  
> > 
> > The problem with that idea was that (at least for some versions of
> > binutils in use at the time) we hit a static limit to the number of
> > object files and ld just stopped at that point. :-(  
> 
> The ld bug was caused by opening too many linked definitions files.
> We can workaround this by expanding the files.
> I gave this a quick spin - see below.
> 
> Note - I have no idea if using thin archived or this method is better.
> But it seems just wrong to me that we convert to thin archives when
> we really do not need to do so.
> 
> Note - this was a quick spin. It build fine here and thats it.

Is there a reason to prefer using linker scripts rather than thin
archives? I thought the former was possibly a bit less robust, and
the latter a smaller change for scripts and toolchain in terms
of "almost behaving like an object file".

I don't have a strong preference although do have a couple of
(out of tree) scripts that expect objdump to work on built-in.o

Thanks,
Nick
