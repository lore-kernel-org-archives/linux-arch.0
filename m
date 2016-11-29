From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from asm
Date: Tue, 29 Nov 2016 08:17:35 -0800
Message-ID: <CA+55aFxOGw57Gm-QiNs13kfy5k=aRrn3+98415V0g73eGc66mg@mail.gmail.com>
References: <20161129131922.GA31466@angband.pl> <20161129135118.24696-1-kilobyte@angband.pl>
 <CA+55aFyZiB4YkwvqzrXO=HD8bcnc2xHkAYrek2QHVnhVvAi3Fw@mail.gmail.com> <30bb2db4-47bd-0c35-8328-ef032b551f06@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:33984 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754614AbcK2QRi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Nov 2016 11:17:38 -0500
In-Reply-To: <30bb2db4-47bd-0c35-8328-ef032b551f06@suse.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Marek <mmarek@suse.com>
Cc: Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Ben Hutchings <ben@decadent.org.uk>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Nov 29, 2016 at 8:03 AM, Michal Marek <mmarek@suse.com> wrote:
>
> The original and easily observable bug is that were are not generating
> symbol checksums for the asm-exported symbols, so they default to 0.
> This can be seen e.g. in the Module.symvers file. This seemed like a
> minor issue, because with the functions written in asm, the type
> checking is rather weak (this has been the case even before Al's
> patches). However, there is another bug that with _some_ toolchains /
> architectures, the checksums do not default to 0, but they are simply
> missing in the ___kcrctab* sections and the module loader complains. We
> can of course research into the details of the second bug, but we
> already know that we are not generating the checksums while we should be.

So let's just say that "toolchain is buggy" and make a missing kcrctab
entry mean zero (or mean "matches anything"). And just shut up the
warning.

I do *not* want to add random bandaids for something like a broken
toolchain issue when I'd really rather just delete the feature.

                     Linus
