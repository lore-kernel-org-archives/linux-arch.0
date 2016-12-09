From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported
 from asm
Date: Sat, 10 Dec 2016 02:15:29 +1000
Message-ID: <20161210021529.4a6e684f@roar.ozlabs.ibm.com>
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
        <20161201143928.07a08348@roar.ozlabs.ibm.com>
        <6e8cf20b-2d2f-ba1f-e02c-c757d5a25db7@suse.com>
        <20161209133308.0acbb57a@roar.ozlabs.ibm.com>
        <1481296893.4509.135.camel@hellion.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1481296893.4509.135.camel@hellion.org.uk>
Sender: linux-kbuild-owner@vger.kernel.org
To: Ian Campbell <ijc@hellion.org.uk>
Cc: Michal Marek <mmarek@suse.com>, Ben Hutchings <ben@decadent.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dodji Seketeli <dodji@seketeli.org>
List-Id: linux-arch.vger.kernel.org

On Fri, 09 Dec 2016 15:21:33 +0000
Ian Campbell <ijc@hellion.org.uk> wrote:

> On Fri, 2016-12-09 at 13:33 +1000, Nicholas Piggin wrote:
> > 
> > Well I simply tested the outcome. If you have:
> > 
> > struct blah {
> >   int x;
> > };
> > int foo(struct blah *blah)
> > {
> >   return blah->x;
> > }
> > EXPORT(foo);
> > 
> > $ nm vmlinux | grep __crc_foo
> > 00000000a0cf13a0 A __crc_foo
> > 
> > Now change to
> > 
> > struct blah {
> >   int y;
> >   int x;
> > };
> > 
> > $ nm vmlinux | grep __crc_foo
> > 00000000a0cf13a0 A __crc_foo
> > 
> > It just doesn't catch these things.  
> 
> I found the same when I just added your snippet to init/main.c.
> 
> _But_ when I moved the struct into include/types.h (which happened to
> be included by init/main.c) then, with just x in the struct:
> 
>     $ make -s init/main.{o,symtypes} && grep -E foo\|blah init/main.symtypes && nm init/main.o  | grep __crc_foo
>     s#blah struct blah { int x ; } 
>     foo int foo ( s#blah * ) 
>     000000000cd0312e A __crc_foo
> 
> but adding y:
> 
>     $ make -s init/main.{o,symtypes} && grep -E foo\|blah init/main.symtypes && nm init/main.o  | grep __crc_foo
>     s#blah struct blah { int x ; int y ; } 
>     foo int foo ( s#blah * ) 
>     00000000eda220c6 A __crc_foo
> 
> So it does catch things in that case.
> 
> With struct blah inline in main.c it was:
> 
>     $ make -s init/main.{o,symtypes} && grep -E foo\|blah init/main.symtypes && nm init/main.o  | grep __crc_foo
>     s#blah struct blah { UNKNOWN } 
>     foo int foo ( s#blah * ) 
>     00000000a0cf13a0 A __crc_foo
> 
> So I suppose it only cares about structs which are in headers, which I
> guess makes sense. I think it is working in at least one of the
> important cases.

Aha thanks, well that's my mistake. Clever little bugger, isn't it? Okay
it's not so useless as I first thought!

That said, a dwarf based checker tool should be able to do as good a job
(maybe a bit better because report is very informative and it may pick up
compiler alignments or padding options). So I still think it's worth
looking at those if we can remove modversions.

Thanks,
Nick
