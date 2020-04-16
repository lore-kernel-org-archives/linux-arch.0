From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 00/12] Rework READ_ONCE() to improve codegen
Date: Thu, 16 Apr 2020 13:48:59 +0100
Message-ID: <20200416124858.GA32685@willie-the-truck>
References: <20200415165218.20251-1-will@kernel.org>
 <809e006e-6641-c252-53a1-cc4479d2ca89@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2894515AbgDPMtF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Apr 2020 08:49:05 -0400
Content-Disposition: inline
In-Reply-To: <809e006e-6641-c252-53a1-cc4479d2ca89@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kernel-team@android.com, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>

On Thu, Apr 16, 2020 at 02:30:36PM +0200, Christian Borntraeger wrote:
> 
> On 15.04.20 18:52, Will Deacon wrote:
> > Hi everyone,
> > 
> > This is version three of the patches I previously posted for improving
> > the code generation of READ_ONCE() and moving the minimum GCC version
> > to 4.8:
> > 
> > RFC: https://lore.kernel.org/lkml/20200110165636.28035-1-will@kernel.org
> > v2:  https://lore.kernel.org/lkml/20200123153341.19947-1-will@kernel.org
> > 
> > Although v2 was queued up by Peter in -tip, it was found to break the
> > build for m68k and sparc32. We fixed m68k during the merge window and
> > I've since posted patches to fix sparc32 here:
> > 
> >   https://lore.kernel.org/lkml/20200414214011.2699-1-will@kernel.org
> > 
> > This series is a refresh on top of 5.7-rc1, the main changes being:
> > 
> >   * Fix another issue where 'const' is assigned to non-const via
> >     WRITE_ONCE(), this time in the tls code
> > 
> >   * Fix READ_ONCE_NOCHECK() abuse in arm64 checksum code
> > 
> >   * Added Reviewed-bys and Acks from v2
> > 
> > Hopefully this can be considered for 5.8, along with the sparc32 changes.
> > 
> > Cheers,
> > 
> > Will
> > 
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Segher Boessenkool <segher@kernel.crashing.org>
> > Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> > Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > 
> 
> I gave this series a try and s390 seems to compile fine and it also seems to
> properly compile the the ipte_unlock_siif function in arch/s390/kvm/gaccess.c
> This function was miscompiled with gcc4.6 and the trigger for replacing
> ACCESS_ONCE with READ_ONCE

That's good to hear, thanks Christian!

Will
