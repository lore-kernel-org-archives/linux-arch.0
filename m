From: Michal Marek <mmarek@suse.com>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from
 asm
Date: Thu, 1 Dec 2016 17:12:41 +0100
Message-ID: <6e8cf20b-2d2f-ba1f-e02c-c757d5a25db7@suse.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49951 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752008AbcLAQMp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 1 Dec 2016 11:12:45 -0500
In-Reply-To: <20161201143928.07a08348@roar.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>, Ben Hutchings <ben@decadent.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dodji Seketeli <dodji@seketeli.org>

On 2016-12-01 04:39, Nicholas Piggin wrote:
> On Thu, 01 Dec 2016 02:35:54 +0000
> Ben Hutchings <ben@decadent.org.uk> wrote:
>> As I understand it, genksyms incorporates the definitions of a
>> function's parameter and return types - not just their names - and all
>> the types they refer to, recursively.  So a structure size change
>> should change the version of all functions where the function and its
>> caller pass that structure between them, however indirectly.  It finds
>> such indirect ABI breakage for me fairly regularly, though of course I
>> don't know that it finds everything.
> 
> It is only the type name.
> 
> Not only that but even if you did extend it further to structure type
> arrangement then you still have to deal with other structures followed
> via pointers. Or (rarer but not unheard of):
> 
> - changes to structures without changes of the types of their members
> - changes to arguments without changes of their type

This is already covered by genksyms. Try make V=1 with
CONFIG_MODVERSIONS=y and add the -D option to one of the genksyms
command. I wanted to paste the expanded signature for
register_filesystem() as an example, but vger would probably drop the
mail for being too big :).


> - changes to semantics of functions
> - data structures derived in ways other than exported symbols, e.g.,
>   fixed register for `current` on some archs

Right, this is something that genksyms has no idea about.

Michal
