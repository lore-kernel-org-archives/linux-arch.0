From: Michal Marek <mmarek@suse.com>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from
 asm
Date: Tue, 13 Dec 2016 23:51:00 +0100
Message-ID: <f7c5d50d-8930-7ab1-62bb-8a5d0aead988@suse.com>
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
 <20161210021529.4a6e684f@roar.ozlabs.ibm.com> <86vaus3eld.fsf@seketeli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <86vaus3eld.fsf@seketeli.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dodji Seketeli <dodji@seketeli.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: Ian Campbell <ijc@hellion.org.uk>, Ben Hutchings <ben@decadent.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Dne 9.12.2016 v 23:46 Dodji Seketeli napsal(a):
> Hello,
> 
> Nicholas Piggin <npiggin@gmail.com> a écrit:
> 
> [...]
> 
>> That said, a dwarf based checker tool should be able to do as good a job
>> (maybe a bit better because report is very informative and it may pick up
>> compiler alignments or padding options).
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

For completeness, with a foo.symref file in the tree, genksyms would print

foo.c: warning: foo: modversion changed because of changes in struct blah

So there is some sort of diagnostics already. Does the abidiff tool
handle the case when an exported symbol is moved between .c files? This
is always a mess with genksyms, because the two .c files have different
includes and thus the type expansion stops at different points. So
typically the move needs to be reverted as a workaround.

Michal
