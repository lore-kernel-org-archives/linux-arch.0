From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from
 asm
Date: Sat, 10 Dec 2016 13:41:03 +0100
Message-ID: <20161210124103.GD21421@kroah.com>
References: <CA+55aFzMTrLMrr69ipdaKhz+RJhUu3BxB+kg0689qq_470qEcw@mail.gmail.com>
 <1480541581.16599.78.camel@decadent.org.uk>
 <20161201125545.406d092c@roar.ozlabs.ibm.com>
 <1480559754.16599.92.camel@decadent.org.uk>
 <20161201143928.07a08348@roar.ozlabs.ibm.com>
 <6e8cf20b-2d2f-ba1f-e02c-c757d5a25db7@suse.com>
 <20161209133308.0acbb57a@roar.ozlabs.ibm.com>
 <1481296893.4509.135.camel@hellion.org.uk>
 <20161210021529.4a6e684f@roar.ozlabs.ibm.com>
 <86vaus3eld.fsf@seketeli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <86vaus3eld.fsf@seketeli.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: Dodji Seketeli <dodji@seketeli.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Ian Campbell <ijc@hellion.org.uk>, Michal Marek <mmarek@suse.com>, Ben Hutchings <ben@decadent.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Adam Borowski <kilobyte@angband.pl>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Dec 09, 2016 at 11:46:54PM +0100, Dodji Seketeli wrote:
> Hello,
> 
> Nicholas Piggin <npiggin@gmail.com> a écrit:
> 
> [...]
> 
> > That said, a dwarf based checker tool should be able to do as good a job
> > (maybe a bit better because report is very informative and it may pick up
> > compiler alignments or padding options).
> 
> So, Nicholas was kind enough to send me the two Linux Kernel binaries
> that he built with the tiny little interface change that we were
> discussing earlier.  Here is what the abidiff[1] tools says about that
> interface change:
> 
>     $ time ~/git/libabigail/kabidiff/build/tools/abidiff vmlinux.abi1.abi vmlinux.abi2.abi
>     Functions changes summary: 0 Removed, 1 Changed, 0 Added function
>     Variables changes summary: 0 Removed, 0 Changed, 0 Added variable
> 
>     1 function with some indirect sub-type change:
> 
>       [C]'function int foo(blah*)' at memory.c:82:1 has some indirect sub-type changes:
>         parameter 1 of type 'blah*' has sub-type changes:
>           in pointed to type 'struct blah' at memory.c:78:1:
>             type size changed from 32 to 64 bits
>             1 data member insertion:
>               'int blah::y', at offset 0 (in bits) at memory.c:79:1
>             1 data member change:
>              'int blah::x' offset changed from 0 to 32 (in bits) (by +32 bits)
> 
> 
> 
>     real	0m2.595s
>     user	0m2.489s
>     sys	0m0.108s
>     $ 
> 
> I kept the timing information to give you an idea of the time it takes
> on a non-optimized build of abidiff.
> 
> One could for instance want that types that are not defined in header
> files be kept out of the change report.  In that case it's possible to
> write a little suppression specification file like this one:
> 
>     $ cat vmlinux.abignore 
>     [suppress_type]
>       source_location_not_regexp = .*\\.h
>     $
> 
> You can then pass that suppression file to the tool:
> 
>     $ ~/git/libabigail/kabidiff/build/tools/abidiff --suppr vmlinux.abignore vmlinux.abi1.abi vmlinux.abi2.abi
>     Functions changes summary: 0 Removed, 0 Changed (1 filtered out), 0 Added function
>     Variables changes summary: 0 Removed, 0 Changed, 0 Added variable
> 
> 
>     real	0m2.574s
>     user	0m2.473s
>     sys	0m0.102s
>     $
> 
> So this is the kind of interface change analysis tool we are working on
> at the moment.
> 
> One could also imagine a tool that would compute a CRC that takes the
> very same suppression specification files into account, letting people
> to decide that some interface changes are OK.  That CRC would thus be
> added to the special ELF sections we already have today.  We could keep
> the modversion machinery, but with a greater dose of flexibility.
> Whenever modversion detects a change, abidiff would tell people what the
> change is exactly.
> 
> What do you guys think?

YES YES YES!!!

Now I don't work on a distro anymore, but I would think that something
like this would be really useful, pointing out exactly what changed is
very important for distro maintainers to determine what they want to do
(either fix up the abi change with strange hacks, or ignore it due to
the change being in an area they don't care at all about, i.e. a random
driver subsystem.)

So yes, I think this is really good stuff.  But if the distro
maintainers correct me and think it's useless, then I need to revisit my
view of exactly what they do for their customers :)

thanks,

greg k-h
