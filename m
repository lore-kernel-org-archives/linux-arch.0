From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 1/5] kbuild: allow architectures to use thin archives
 instead of ld -r
Date: Sun, 7 Aug 2016 00:17:18 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1608070008310.17623@knanqh.ubzr>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com> <1470399123-8455-2-git-send-email-npiggin@gmail.com> <20160806201045.GA25821@ravnborg.org> <20160807114946.41b682f3@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:35383 "EHLO
	mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbcHGERV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 7 Aug 2016 00:17:21 -0400
Received: by mail-qt0-f181.google.com with SMTP id x25so191016488qtx.2
        for <linux-arch@vger.kernel.org>; Sat, 06 Aug 2016 21:17:21 -0700 (PDT)
In-Reply-To: <20160807114946.41b682f3@canb.auug.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Sam Ravnborg <sam@ravnborg.org>, Nicholas Piggin <npiggin@gmail.com>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>

On Sun, 7 Aug 2016, Stephen Rothwell wrote:

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

I played with a nearly identical patch to work around the inability to 
do LTO and 'ld -r' with mainline binutils.  However this also requires 
major changes to modpost otherwise it becomes ineffective.


Nicolas
