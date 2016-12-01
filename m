From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported
 from asm
Date: Thu, 1 Dec 2016 23:39:42 +1100
Message-ID: <20161201233942.0453b759@roar.ozlabs.ibm.com>
References: <20161129131922.GA31466@angband.pl>
        <20161129135118.24696-1-kilobyte@angband.pl>
        <CA+55aFyZiB4YkwvqzrXO=HD8bcnc2xHkAYrek2QHVnhVvAi3Fw@mail.gmail.com>
        <30bb2db4-47bd-0c35-8328-ef032b551f06@suse.com>
        <CA+55aFxOGw57Gm-QiNs13kfy5k=aRrn3+98415V0g73eGc66mg@mail.gmail.com>
        <20161129195721.GI2697@decadent.org.uk>
        <CA+55aFyQko0t8oMZjhnwhWHrmBUyWjGhsnT=oUOU-W7_04xdzw@mail.gmail.com>
        <20161201051852.28dc335f@roar.ozlabs.ibm.com>
        <CA+55aFzMTrLMrr69ipdaKhz+RJhUu3BxB+kg0689qq_470qEcw@mail.gmail.com>
        <20161201041325.GX35881@redhat.com>
        <830d2864-ab52-27c8-8178-ec86f3267079@redhat.com>
        <20161201220907.60375b4f@roar.ozlabs.ibm.com>
        <e91d972c-bf6d-8465-50b0-13db4645eed5@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e91d972c-bf6d-8465-50b0-13db4645eed5@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stanislav Kozina <skozina@redhat.com>
Cc: Don Zickus <dzickus@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ben Hutchings <ben@decadent.org.uk>, Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, 1 Dec 2016 12:33:02 +0100
Stanislav Kozina <skozina@redhat.com> wrote:

> On 12/01/2016 12:09 PM, Nicholas Piggin wrote:
> > On Thu, 1 Dec 2016 11:48:09 +0100
> > Stanislav Kozina <skozina@redhat.com> wrote:
> >  
> >> On 12/01/2016 05:13 AM, Don Zickus wrote:
> >>
> >> ...
> >>  
> >>> I think GregKH pointed to one such tool, libabigail?  We are working on
> >>> others too.  
> >> I should mention one of the others here:
> >> https://github.com/skozina/kabi-dw
> >>
> >> It's quite comparable to libabigail in the way it works, the main
> >> differences are:
> >>    - written in pure C
> >>    - depends only on elf-utils and flex/yacc
> >>    - it's much simpler (4k LOC)
> >>    - stores the type information in the text files and compares those
> >> instead of directly comparing two sets of DWARF data  
> > Now this seems much better for distro ABI checking.
> >
> > The next question is, do they need any kernel support for rare cases
> > where they do have to break the ABI of an export? Simple rename of the
> > function with a _v2 postfix might be enough. We could retain some per
> > symbol versioning in the kernel if needed, but how much would it
> > actually help?  
> 
> The biggest pain point AFAICT is to identify what types (functions, 
> structs, enums, ...) should be considered a part of the stable ABI.

Sure. This is something an automated checker can't solve completely.
Any changes would have to be considered in terms of their impact to
the ABI. It's not just data but also instruction changes involved.

This is policy that should not be mandated by the kernel. Which is
why I'm in favor of using tools like this and just providing mechanism
so distros can implement their own polices.

> And 
> the problem with modversions is that it pulls in just everything which 
> gets (accidentally?) #included in the source file.

I think that's SRCVERSION which is something else. But modversions
has problems too.

> The actual ABI maintenance is a different problem, but there are many 
> possible approaches, the _v2 suffix being one of them.

Would be good to get a consensus on that too.

Thanks,
Nick
