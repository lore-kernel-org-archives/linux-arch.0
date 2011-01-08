From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC] kbuild: generic support for asm-generic
Date: Sat, 8 Jan 2011 22:33:53 +0100
Message-ID: <20110108213353.GA24666@merkur.ravnborg.org>
References: <20110108130302.GA21698@merkur.ravnborg.org> <201101082153.31837.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201101082153.31837.arnd@arndb.de>
Sender: linux-kbuild-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, linux arch <linux-arch@vger.kernel.org>, Guan Xuetao <guanxuetao@mprc.pku.edu.cn>, Michal Marek <mmarek@suse.cz>
List-Id: linux-arch.vger.kernel.org

On Sat, Jan 08, 2011 at 09:53:31PM +0100, Arnd Bergmann wrote:
> On Saturday 08 January 2011, Sam Ravnborg wrote:
> > Hi Arnd et all.
> > 
> > This is my second attempt to provide generic support for
> > architectures that use existing headers from asm-generic.
> > 
> > With this kbuild will read the file: arch/$ARCH/include/asm-generic
> > 
> > For each file listed in this file a wrapper is generated in
> > arch/$ARCH/inclue/generated/asm/
> > 
> > The patch include support so headers_install works.
> > 
> > The inspiration came from the unicore32 patchset,
> > but I redid this to make it more general.
> > 
> > I will follow-up with two patches.
> > One that implment the functionality.
> > A second that convert two headers in x86 to use the
> > new asm-generic stuff (only as an example).
> 
> Very nice patch!
> 
> This is something I'd certainly like to see upstream, and you made
> a good point about keeping it seperate from the unicore32 submission.
> 
> One detail I don't like too much is that you now have two different
> formats for specifying lists of headers to do something with.
> 
> Instead of the new arch/*/include/asm-generic file, how about listing
> all files that are actually provided by the architecture as "header-y"
> in arch/*/include/asm/Kbuild, and listing all files as something
> else in include/asm-generic/Kbuild and include/asm-generic/Kbuild.asm?

Good point.
I will try to address this together with the comments from Guang.

If we use Kbuild syntax then I think we shall name the file
something like
 
    Kbuild.asm-generic

I need to think about the naming of the variables...

We need a variables to express:
In include/asm-generic/Kbuild.asm
- This file exists in a generic variant and it is exported.
  The arch may use it verbatim or may have a local variant

In arch/$(ARCH)/include/Kbuild.asm-generic
- This file is provided verbatim by asm-generic


Something like:

export-y - for files listed in Kbuild.asm
generic-y - for files listed in Kbuild.asm-generic

I will try to come up with a patch that uses this - or something
similar.

	Sam
