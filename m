From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from
 asm
Date: Fri, 9 Dec 2016 17:03:37 +0100
Message-ID: <20161209160337.GA3061@kroah.com>
References: <20161201051852.28dc335f@roar.ozlabs.ibm.com>
 <CA+55aFzMTrLMrr69ipdaKhz+RJhUu3BxB+kg0689qq_470qEcw@mail.gmail.com>
 <20161201041325.GX35881@redhat.com>
 <20161201153215.43b6cec7@roar.ozlabs.ibm.com>
 <20161201152039.GB35881@redhat.com>
 <20161209135041.5ff12770@roar.ozlabs.ibm.com>
 <0937c184-1946-c494-56b6-c38fd0b632c2@redhat.com>
 <20161209181459.1f0a4fed@roar.ozlabs.ibm.com>
 <249321c0-bcb1-f9d8-50f4-c083b656d02e@redhat.com>
 <20161210015653.5b0dc872@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:54424 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932461AbcLIQDa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Dec 2016 11:03:30 -0500
Content-Disposition: inline
In-Reply-To: <20161210015653.5b0dc872@roar.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Stanislav Kozina <skozina@redhat.com>, Don Zickus <dzickus@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ben Hutchings <ben@decadent.org.uk>, Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, Dec 10, 2016 at 01:56:53AM +1000, Nicholas Piggin wrote:
> On Fri, 9 Dec 2016 15:36:04 +0100
> Stanislav Kozina <skozina@redhat.com> wrote:
> 
> > >>>> The question is how to provide a similar guarantee if a different way?  
> > >>> As a tool to aid distro reviewers, modversions has some value, but the
> > >>> debug info parsing tools that have been mentioned in this thread seem
> > >>> superior (not that I've tested them).  
> > >> On the other hand the big advantage of modversions is that it also
> > >> verifies the checksum during runtime (module loading). In other words, I
> > >> believe that any other solution should still generate some form of
> > >> checksum/watermark which can be easily checked for compatibility on
> > >> module load.
> > >> It should not be hard to add to the DWARF based tools though. We'd just
> > >> parse DWARF data instead of the C code.  
> > > A runtime check is still done, with per-module vermagic which distros
> > > can change when they bump the ABI version. Is it really necessary to
> > > have more than that (i.e., per-symbol versioning)?  
> > 
> >  From my point of view, it is. We need to allow changing ABI for some 
> > modules while maintaining it for others.
> > In fact I think that there should be version not only for every exported 
> > symbol (in the EXPORT_SYMBOL() sense), but also for every public type 
> > (in the sense of eg. structure defined in the public header file).
> 
> Well the distro can just append _v2, _v3 to the name of the function
> or type if it has to break compat for some reason. Would that be enough?

There are other ways that distros can work around when upstream "breaks"
the ABI, sometimes they can rename functions, and others they can
"preload" structures with padding in anticipation for when/if fields get
added to them.  But that's all up to the distros, no need for us to
worry about that at all :)

thanks,

greg k-h
