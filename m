From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported
 from asm
Date: Thu, 1 Dec 2016 14:39:28 +1100
Message-ID: <20161201143928.07a08348@roar.ozlabs.ibm.com>
References: <20161129131922.GA31466@angband.pl>
        <20161129135118.24696-1-kilobyte@angband.pl>
        <CA+55aFyZiB4YkwvqzrXO=HD8bcnc2xHkAYrek2QHVnhVvAi3Fw@mail.gmail.com>
        <30bb2db4-47bd-0c35-8328-ef032b551f06@suse.com>
        <CA+55aFxOGw57Gm-QiNs13kfy5k=aRrn3+98415V0g73eGc66mg@mail.gmail.com>
        <20161129195721.GI2697@decadent.org.uk>
        <CA+55aFyQko0t8oMZjhnwhWHrmBUyWjGhsnT=oUOU-W7_04xdzw@mail.gmail.com>
        <20161201051852.28dc335f@roar.ozlabs.ibm.com>
        <CA+55aFzMTrLMrr69ipdaKhz+RJhUu3BxB+kg0689qq_470qEcw@mail.gmail.com>
        <1480541581.16599.78.camel@decadent.org.uk>
        <20161201125545.406d092c@roar.ozlabs.ibm.com>
        <1480559754.16599.92.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1480559754.16599.92.camel@decadent.org.uk>
Sender: linux-kbuild-owner@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dodji Seketeli <dodji@seketeli.org>
List-Id: linux-arch.vger.kernel.org

On Thu, 01 Dec 2016 02:35:54 +0000
Ben Hutchings <ben@decadent.org.uk> wrote:

> On Thu, 2016-12-01 at 12:55 +1100, Nicholas Piggin wrote:
> > On Wed, 30 Nov 2016 21:33:01 +0000  
> > > Ben Hutchings <ben@decadent.org.uk> wrote:  
> >   
> > > On Wed, 2016-11-30 at 10:40 -0800, Linus Torvalds wrote:  
> > > > > On Wed, Nov 30, 2016 at 10:18 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
> > > > > 
> > > > > Here's an initial rough hack at removing modversions. It gives an idea
> > > > > of the complexity we're carrying for this feature (keeping in mind most
> > > > > of the lines removed are generated parser).    
> > > > 
> > > > You definitely don't have to try to convince me. We've had many issues
> > > > with modversions over the years. This was just the "last drop" as far
> > > > as I'm concerned, we've had random odd crc generation failures due to
> > > > some build races too.
> > > >     
> > > > > In its place I just added a simple config option to override vermagic
> > > > > so distros can manage it entirely themselves.    
> > > > 
> > > > So at least Fedora doesn't even enable CONFIG_MODVERSIONS as-is. I'm
> > > > _hoping_ it's just Debian that wants this,    
> > > 
> > > The last time I looked, RHEL and SLE did.  They change the release
> > > string for each new kernel version, but they will copy/link old out-of-
> > > tree modules into the new version's "weak-updates" module subdirectory
> > > if the symbol versions still match.
> > >   
> > > > and we'd need to get some
> > > > input from the Debian people whether that "control vermagic" is
> > > > sufficient? I suspect it isn't, but I can't come up with any simple
> > > > alternate model either..    
> > > 
> > > Allowing the vermagic to be changed separately doesn't help us, as we
> > > already control the release string.  If we were to change some of the
> > > module tools to consider vermagic then it would allow us to report the
> > > full version in the release string while not forcing rebuilds on every
> > > kernel upgrade - but that's not a pressing problem.  
> > 
> > Okay, but existing modversions AFAIKS does not solve your problems described
> > in yor your earlier mail either. Modversions hardly catches ABI breakage at
> > all, you can't rely on it that way. It's far more likely that some structure
> > size changes deep in the kernel than an exported function type signature
> > changes.  
> 
> As I understand it, genksyms incorporates the definitions of a
> function's parameter and return types - not just their names - and all
> the types they refer to, recursively.  So a structure size change
> should change the version of all functions where the function and its
> caller pass that structure between them, however indirectly.  It finds
> such indirect ABI breakage for me fairly regularly, though of course I
> don't know that it finds everything.

It is only the type name.

Not only that but even if you did extend it further to structure type
arrangement then you still have to deal with other structures followed
via pointers. Or (rarer but not unheard of):

- changes to structures without changes of the types of their members
- changes to arguments without changes of their type
- changes to semantics of functions
- data structures derived in ways other than exported symbols, e.g.,
  fixed register for `current` on some archs

This is actually a big problem with it, that it provides a false sense
of security. It simply can't be used to verify your ABI stability.

 [Aside: something like the tool Greg linked earlier,

 https://kernel-recipes.org/en/2016/talks/would-an-abi-changes-visualization-tool-be-useful-to-linux-kernel-maintenance/

 Would be great if that worked with the kernel. Not necessarily as part
 of the build system, but at least a tool that distros could use to
 analyze ABI changes. It wouldn't catch everything, but it would be far
 better than modversions.]

> > I'm not sure how you know which exports are used only by in-tree modules
> > and which are used out of tree, but if you know that then you can version
> > them manually as we said by adding _v2 in the rare case you need to change
> > a behaviour.  
> 
> That's fine for individual functions.
> 
> > So I'm still having trouble understanding what modversions is giving you.  
> 
> Where there is a family of driver modules (e.g. foo-core, foo-pci, foo-
> usb), a structure change can change all exports from foo-core.  That
> ABI is of no use to out-of-tree drivers so we don't care about keeping
> it stable, but we do care about preventing an accidental mismatch.

I still don't think modversions helps there. And how much burden is it
to change the export function names occasionally? I thought it was *very*
rare that an ABI change was required in distros.

> 
> > > One thing that could work for us would be:
> > > 
> > > - Stricter version matching for in-tree modules (maybe some extra
> > >   part in vermagic that is skipped for out-of-tree modules)
> > > - Ability to blacklist use of a symbol, or all symbols in a module,
> > >   by out-of-tree modules
> > > 
> > > where the blacklist would be a matter of distribution policy.  But this
> > > would still require a fair amount of work by someone, and I doubt you'd
> > > want this upstream.  
> > 
> > I don't think people are adverse to carrying some upstream complexity for
> > ditsros. Although for this fancy blacklist case, can it just be done in
> > userspace?  
> 
> Since the kernel does the symbol lookup and version matching, I'm not
> sure what userland can do about it.

I just didn't realize what you wanted the blacklist for. It sounded like
you wanted to be able to just wholesale prevent a module's symbols from
being exported.

Thanks,
Nick
