Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:32939 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753030AbcK2EI7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Nov 2016 23:08:59 -0500
MIME-Version: 1.0
In-Reply-To: <1480382148.16599.61.camel@decadent.org.uk>
References: <CA+55aFwXqv6uYmW0kC=c+yyumO_T0CJrz6m+MQCQX6bR5gRBQw@mail.gmail.com>
 <1480382148.16599.61.camel@decadent.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 28 Nov 2016 20:08:57 -0800
Message-ID: <CA+55aFwDJ8=LQ6jKYuFGZHqbbRoX+Odvnm5BXobNVojqesF1gw@mail.gmail.com>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from asm
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Nicholas Piggin <npiggin@gmail.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michal Marek <mmarek@suse.com>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Adam Borowski <kilobyte@angband.pl>, Debian kernel maintainers <debian-kernel@lists.debian.org>
Message-ID: <20161129040857.lwBZ5_VpIEg0iCnVScs-pAhhslA7RKU4rFEi0j0Q7B8@z>

On Mon, Nov 28, 2016 at 5:15 PM, Ben Hutchings <ben@decadent.org.uk> wrote:
>>
>> The modversions stuff may just be too painful to bother with. Very few
>> people probably use it, and the ones that do likely don't have any
>> overriding reason why.
> [...]
>
> Debian has some strong reasons:

Honestly, I'd just like to see actual real patches from people who
care about this.

The reason I disabled it entirely was simply that the discussions had
been going on forever, but nobody actually seemed to care enough to
just fix the damn thing. There was all the _noise_ about "look, here's
a patch", but nothing got sent to maintainers and actually actively
pushed as a "this fixes a regression".

At some point I just get fed up and say "this isn't worth the hot air
and endless pointless blathering".

What is the actual exact failure with MODVERSIONS today? IOW, if you
just remove the "broken", is it actually broken, and why? Because it
does work for me, I just got really tired of hearing about it, and
assuming it's just some broken toolchain or other case that I just
don't hit.

So somebody send me a minimal patch that is

 (a) tested
 (b) explains it
 (c) obvious

and I'll happily re-enable modversions.

                    Linus
