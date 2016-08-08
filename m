Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34837 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbcHHDaK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 7 Aug 2016 23:30:10 -0400
Date: Mon, 8 Aug 2016 13:30:01 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 3/5] kbuild: add arch specific post-module-link pass
Message-ID: <20160808133001.3ccf2153@roar.ozlabs.ibm.com>
In-Reply-To: <20160806201629.GC25821@ravnborg.org>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
	<1470399123-8455-4-git-send-email-npiggin@gmail.com>
	<20160806201629.GC25821@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>
Message-ID: <20160808033001.B9own9ckqwkCIYBilLbJGCExrJN4xNd40WVfEOVfVXc@z>

On Sat, 6 Aug 2016 22:16:29 +0200
Sam Ravnborg <sam@ravnborg.org> wrote:

> On Fri, Aug 05, 2016 at 10:12:01PM +1000, Nicholas Piggin wrote:
> > Add an option for architectures to pass over modules after they are
> > linked. powerpc will use this to fix up alternate instruction patch
> > relocations.
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  Documentation/kbuild/makefiles.txt | 6 ++++++
> >  Makefile                           | 1 +
> >  scripts/Makefile.modpost           | 8 ++++++++
> >  3 files changed, 15 insertions(+)
> > 
> > diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
> > index 13f888a..f6c065b 100644
> > --- a/Documentation/kbuild/makefiles.txt
> > +++ b/Documentation/kbuild/makefiles.txt
> > @@ -952,6 +952,12 @@ When kbuild executes, the following steps are followed (roughly):
> >  	$(KBUILD_ARFLAGS) set by the top level Makefile to "D" (deterministic
> >  	mode) if this option is supported by $(AR).
> >  
> > +    KBUILD_MODPOST_TOOL   Arch-specific command to run after module link
> > +
> > +        $(KBUILD_MODPOST_TOOL) is used to add an arch-specific pass over
> > +        modules after their final link. E.g., powerpc uses this to adjust
> > +        relative branches of "alternate code patching" sections.
> > +  
> 
> This needs documentation in kbuild.txt, where there is a
> nearly full lst of KBUILD_ variables.

Thanks, I missed that.

Thanks,
Nick
