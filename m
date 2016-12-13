From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported
 from asm
Date: Tue, 13 Dec 2016 17:25:54 +1000
Message-ID: <20161213172554.66a7ceea@roar.ozlabs.ibm.com>
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
        <20161209160337.GA3061@kroah.com>
        <6c3ba78e-a858-2529-5428-e7750f2d2d97@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33488 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750801AbcLMH0K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Dec 2016 02:26:10 -0500
In-Reply-To: <6c3ba78e-a858-2529-5428-e7750f2d2d97@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stanislav Kozina <skozina@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Don Zickus <dzickus@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ben Hutchings <ben@decadent.org.uk>, Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, 12 Dec 2016 10:48:47 +0100
Stanislav Kozina <skozina@redhat.com> wrote:

> >>>> A runtime check is still done, with per-module vermagic which distros
> >>>> can change when they bump the ABI version. Is it really necessary to
> >>>> have more than that (i.e., per-symbol versioning)?  
> >>>   From my point of view, it is. We need to allow changing ABI for some
> >>> modules while maintaining it for others.
> >>> In fact I think that there should be version not only for every exported
> >>> symbol (in the EXPORT_SYMBOL() sense), but also for every public type
> >>> (in the sense of eg. structure defined in the public header file).  
> >> Well the distro can just append _v2, _v3 to the name of the function
> >> or type if it has to break compat for some reason. Would that be enough?  
> > There are other ways that distros can work around when upstream "breaks"
> > the ABI, sometimes they can rename functions, and others they can
> > "preload" structures with padding in anticipation for when/if fields get
> > added to them.  But that's all up to the distros, no need for us to
> > worry about that at all :)  
> 
> Currently, the ABI version (checksum) is stored outside of the actual 
> code in the __ksymtab section. That means that the distributions can 
> still apply upstream patches cleanly and only update the version 
> checksum if these break ABI.
> 
> With the _v2, _v3 suffixes (or similar solutions) we'd be effectively 
> storing the ABI versions directly in the code and that would cause 
> conflicts when pulling further patches from upstream.
> 
> My view is that it would be than easier to maintain out-of-tree 
> modversions (or similar tool) rather than to solve all these conflicts.

That kind of name clash should hardly be an issue, in comparison with the
care it requires to merge fixes on top of a backport which has already
changed ABI. It tends to be trivially fixable just by search/replace
in the patchfile before applying, if nothing else. But you probably *want*
to be flagged on those things and merge by hand anyway.

Backporting alone I don't think can justify symbol versioning, but I'd
like to hear from distro maintainers if any disagree.

Thanks,
Nick
