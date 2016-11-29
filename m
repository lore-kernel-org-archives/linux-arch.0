From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from asm
Date: Tue, 29 Nov 2016 12:35:57 -0800
Message-ID: <CA+55aFyQko0t8oMZjhnwhWHrmBUyWjGhsnT=oUOU-W7_04xdzw@mail.gmail.com>
References: <20161129131922.GA31466@angband.pl> <20161129135118.24696-1-kilobyte@angband.pl>
 <CA+55aFyZiB4YkwvqzrXO=HD8bcnc2xHkAYrek2QHVnhVvAi3Fw@mail.gmail.com>
 <30bb2db4-47bd-0c35-8328-ef032b551f06@suse.com> <CA+55aFxOGw57Gm-QiNs13kfy5k=aRrn3+98415V0g73eGc66mg@mail.gmail.com>
 <20161129195721.GI2697@decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:35679 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752771AbcK2Uf6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Nov 2016 15:35:58 -0500
In-Reply-To: <20161129195721.GI2697@decadent.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Nov 29, 2016 at 11:57 AM, Ben Hutchings <ben@decadent.org.uk> wrote:
>
> If the modversion is missing then the fallback should be to a full
> vermagic match, i.e. including the release string.  Something like
> this (untested):

This really seems way too complicated for this situation.

And it's wrong too. The whole point of modversions was that you didn't
want to do the full version check.

We already know there were *some* crc's (we checked that at the top of
check_version(), but we've also checked it in "same_magic()" - it's
what makes us ignore the exact version number), but this particular
symbol doesn't have a crc. Just let it through, because we have bugs
in binutils.

So your extra complexity logic seems actively wrong. It makes
MODVERSIONS not work at all, rather than limp along. You're better off
just not having MODVERSIONS.

               Linus
