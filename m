From: Dodji Seketeli <dodji@seketeli.org>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from asm
Date: Fri, 09 Dec 2016 23:46:54 +0100
Message-ID: <86vaus3eld.fsf@seketeli.org>
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
        <20161210021529.4a6e684f@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from seketeli.net ([94.23.218.202]:36597 "EHLO ms.seketeli.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753541AbcLIWz7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Dec 2016 17:55:59 -0500
In-Reply-To: <20161210021529.4a6e684f@roar.ozlabs.ibm.com> (Nicholas Piggin's
        message of "Sat, 10 Dec 2016 02:15:29 +1000")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Ian Campbell <ijc@hellion.org.uk>, Michal Marek <mmarek@suse.com>, Ben Hutchings <ben@decadent.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hello,

Nicholas Piggin <npiggin@gmail.com> a écrit:

[...]

> That said, a dwarf based checker tool should be able to do as good a job
> (maybe a bit better because report is very informative and it may pick up
> compiler alignments or padding options).

So, Nicholas was kind enough to send me the two Linux Kernel binaries
that he built with the tiny little interface change that we were
discussing earlier.  Here is what the abidiff[1] tools says about that
interface change:

    $ time ~/git/libabigail/kabidiff/build/tools/abidiff vmlinux.abi1.abi vmlinux.abi2.abi
    Functions changes summary: 0 Removed, 1 Changed, 0 Added function
    Variables changes summary: 0 Removed, 0 Changed, 0 Added variable

    1 function with some indirect sub-type change:

      [C]'function int foo(blah*)' at memory.c:82:1 has some indirect sub-type changes:
        parameter 1 of type 'blah*' has sub-type changes:
          in pointed to type 'struct blah' at memory.c:78:1:
            type size changed from 32 to 64 bits
            1 data member insertion:
              'int blah::y', at offset 0 (in bits) at memory.c:79:1
            1 data member change:
             'int blah::x' offset changed from 0 to 32 (in bits) (by +32 bits)



    real	0m2.595s
    user	0m2.489s
    sys	0m0.108s
    $ 

I kept the timing information to give you an idea of the time it takes
on a non-optimized build of abidiff.

One could for instance want that types that are not defined in header
files be kept out of the change report.  In that case it's possible to
write a little suppression specification file like this one:

    $ cat vmlinux.abignore 
    [suppress_type]
      source_location_not_regexp = .*\\.h
    $

You can then pass that suppression file to the tool:

    $ ~/git/libabigail/kabidiff/build/tools/abidiff --suppr vmlinux.abignore vmlinux.abi1.abi vmlinux.abi2.abi
    Functions changes summary: 0 Removed, 0 Changed (1 filtered out), 0 Added function
    Variables changes summary: 0 Removed, 0 Changed, 0 Added variable


    real	0m2.574s
    user	0m2.473s
    sys	0m0.102s
    $

So this is the kind of interface change analysis tool we are working on
at the moment.

One could also imagine a tool that would compute a CRC that takes the
very same suppression specification files into account, letting people
to decide that some interface changes are OK.  That CRC would thus be
added to the special ELF sections we already have today.  We could keep
the modversion machinery, but with a greater dose of flexibility.
Whenever modversion detects a change, abidiff would tell people what the
change is exactly.

What do you guys think?

[1]: https://sourceware.org/libabigail/manual/abidiff.html
     Okay, the abidiff I used in this message is one that is not yet
     released.  It's source code is in the dodji/kabidiff branch of the
     Git repository at https://sourceware.org/git/?p=libabigail.git;a=summary


Cheers,

-- 
		Dodji
