From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/5] kbuild: allow architectures to use thin archives
 instead of ld -r
Date: Mon, 8 Aug 2016 13:25:32 +1000
Message-ID: <20160808132532.3ce8c0b6@roar.ozlabs.ibm.com>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
	<1470399123-8455-2-git-send-email-npiggin@gmail.com>
	<20160806201045.GA25821@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34344 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997AbcHHDZn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 7 Aug 2016 23:25:43 -0400
In-Reply-To: <20160806201045.GA25821@ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>

On Sat, 6 Aug 2016 22:10:45 +0200
Sam Ravnborg <sam@ravnborg.org> wrote:

> Hi Nicholas.
> 
> On Fri, Aug 05, 2016 at 10:11:59PM +1000, Nicholas Piggin wrote:
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > 
> > ld -r is an incremental link used to create built-in.o files in build
> > subdirectories. It produces relocatable object files containing all
> > its input files, and these are are then pulled together and relocated
> > in the final link. Aside from the bloat, this constrains the final
> > link relocations, which has bitten large powerpc builds with
> > unresolvable relocations in the final link.
> > 
> > Alan Modra has recommended the kernel use thin archives for linking.
> > This is an alternative and means that the linker has more information
> > available to it when it links the kernel.
> > 
> > This patch enables a config option architectures can select,  
> If we want to do this, then I suggest to make the logic reverse.
> Architectures that for some reasons cannot use this should
> have the possibility to avoid it. But let it be enabled by default.

I was thinking the build matrix (architectures x build options x toolchains)
is a bit too large to switch it for everybody. I've far from even tested it
for a fraction of powerpc builds. I would prefer arch maintainers to switch
it themselves, but I do hope we can move everybody and just remove the old
method within a few releases.

But I'm happy to go with whatever arch and kbuild maintainers prefer, so I
appreciate any discussion on it.

Thanks,
Nick
