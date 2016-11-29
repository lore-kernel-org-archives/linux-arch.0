From: Michal Marek <mmarek@suse.com>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from
 asm
Date: Tue, 29 Nov 2016 17:03:01 +0100
Message-ID: <30bb2db4-47bd-0c35-8328-ef032b551f06@suse.com>
References: <20161129131922.GA31466@angband.pl>
 <20161129135118.24696-1-kilobyte@angband.pl>
 <CA+55aFyZiB4YkwvqzrXO=HD8bcnc2xHkAYrek2QHVnhVvAi3Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48569 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757697AbcK2QDK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 29 Nov 2016 11:03:10 -0500
In-Reply-To: <CA+55aFyZiB4YkwvqzrXO=HD8bcnc2xHkAYrek2QHVnhVvAi3Fw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Adam Borowski <kilobyte@angband.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Ben Hutchings <ben@decadent.org.uk>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Dne 29.11.2016 v 16:27 Linus Torvalds napsal(a):
> On Nov 29, 2016 5:51 AM, "Adam Borowski" <kilobyte@angband.pl
> <mailto:kilobyte@angband.pl>> wrote:
>>
> 
>> >
>> >  (a) tested
>>
>> By many people.
> 
> No.
> 
> I've tested the build *without* this, and it works fine.
> 
>> >  (b) explains it
>>
>> The actual logic is in 4efca4ed0.  It wants C prototypes defined in
>> asm/asm-prototypes.h that lists symbols defined in assembly -- genksyms
>> knows only how to read C code.
> 
> See above. I'm not taking more random patches that "fix" this when it's
> not broken for me. Not without very explicit explanations of why that
> patch is still needed for others.

The original and easily observable bug is that were are not generating
symbol checksums for the asm-exported symbols, so they default to 0.
This can be seen e.g. in the Module.symvers file. This seemed like a
minor issue, because with the functions written in asm, the type
checking is rather weak (this has been the case even before Al's
patches). However, there is another bug that with _some_ toolchains /
architectures, the checksums do not default to 0, but they are simply
missing in the ___kcrctab* sections and the module loader complains. We
can of course research into the details of the second bug, but we
already know that we are not generating the checksums while we should be.

Michal
