From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] kbuild: provide include/asm/asm-prototypes.h for ARM
Date: Wed, 19 Oct 2016 16:32:00 +0100
Message-ID: <20161019153159.GQ1041@n2100.armlinux.org.uk>
References: <20161017065131.GA27863@angband.pl>
 <6556201.qTG4Pa4aHk@wuerfel>
 <fafba13a-c64c-2578-534c-c344f18d0fc5@suse.com>
 <3114442.xCAy34UQCk@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3114442.xCAy34UQCk@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Michal Marek <mmarek@suse.com>, Nicholas Piggin <npiggin@gmail.com>, Adam Borowski <kilobyte@angband.pl>, Omar Sandoval <osandov@osandov.com>, Linus Torvalds <torvalds@linux-foundation.org>, adobriyan@gmail.com, sfr@canb.auug.org.au, viro@zeniv.linux.org.uk, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Oct 19, 2016 at 05:02:55PM +0200, Arnd Bergmann wrote:
> On Wednesday, October 19, 2016 4:52:06 PM CEST Michal Marek wrote:
> > Dne 17.10.2016 v 14:26 Arnd Bergmann napsal(a):
> > > This adds an asm/asm-prototypes.h header for ARM to fix the
> > > broken symbol versioning for symbols exported from assembler
> > > files.
> > > 
> > > In addition to the header, we have to do these other small
> > > changes:
> > > 
> > > - move the 'extern' declarations out of memset_io/memcpy_io
> > >   to make them visible to the symbol version generator
> > > - move the exports from bitops.h to {change,clear,set,...}bit.S
> > > - move the exports from csumpartialgeneric.S into the files
> > >   including it
> > > 
> > > I couldn't find the correct prototypes for the compiler builtins,
> > > so I went with the fake 'void f(void)' prototypes that we had
> > > before.
> > > 
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > Hi Arnd,
> > 
> > just to make sure I'm looking at the right code - is this based on the
> > patch by Nick here: https://patchwork.kernel.org/patch/9377783/?
> > 
> 
> (adding Russell to Cc, I missed him during my earlier mail, which
> is now archived at https://lkml.org/lkml/2016/10/17/356)

I'm not in favour of this.

   +extern void mmioset(void *, unsigned int, size_t);
   +extern void mmiocpy(void *, const void *, size_t);
   +
    #ifndef __ARMBE__
    static inline void memset_io(volatile void __iomem *dst, unsigned c,
           size_t count)
    {
   -       extern void mmioset(void *, unsigned int, size_t);
           mmioset((void __force *)dst, c, count);
    }

The reason they're declared _within_ memset_io() is to prevent people
from using them by hiding their declaration.  Moving them outside is
an open invitation to stupid people starting to use them as an "oh it
must be an official API".

We know this happens, there's been a long history of this kind of stupid
in the ARM community, not only with cache flushing APIs, but also the
DMA APIs.

The way the existing code is written is a completely valid way to hide
declarations from outside the intended caller's scope.

We've been here many times, we've had many people doing this crap, so
I'm now at the point of NAKing changes which result in an increased
visibility to the rest of the kernel of symbols that should not be
used by stupid driver authors.

Now, why do we have these extra functions when they're just aliased to
memset()/memcpy() - to avoid GCC optimising them because it thinks that
they're standard memset()/memcpy().

So overall this gets a NAK from me.

Now, it would have _ALSO_ been nice to have been at least COPIED on the
original set of changes that caused the need for this change.  I wasn't.
So I want to see the original set of changes reverted, because they're
clearly causing breakage.  Let's revert them and then go through the
proper process of maintainer review, rather than bypassing maintainers
and screwing up architectures in the process.  There really is no
excuse for this crap.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
