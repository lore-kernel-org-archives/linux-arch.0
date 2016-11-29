From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from asm
Date: Tue, 29 Nov 2016 09:14:46 -0800
Message-ID: <CA+55aFw7G1QJ0dwMXJKJqFVhVsWGsAdxZTOsmcCD7POUde2+dA@mail.gmail.com>
References: <20161129131922.GA31466@angband.pl> <20161129135118.24696-1-kilobyte@angband.pl>
 <CA+55aFyZiB4YkwvqzrXO=HD8bcnc2xHkAYrek2QHVnhVvAi3Fw@mail.gmail.com>
 <20161129170522.GA3441@angband.pl> <CA+55aFxCKgTrh1gS-cMyhBa0QoLW2DL2+DYxOAcA-Bd15H15vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:35323 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753347AbcK2ROr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Nov 2016 12:14:47 -0500
In-Reply-To: <CA+55aFxCKgTrh1gS-cMyhBa0QoLW2DL2+DYxOAcA-Bd15H15vg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Adam Borowski <kilobyte@angband.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Ben Hutchings <ben@decadent.org.uk>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Nov 29, 2016 at 9:10 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So quite frankly, I don't want to make our kernel sources worse due to
> broken shit tools getting something wrong that we shouldn't even care
> about.

And yes, I'm on binutils 2.26 (with no issues), so it could be that
it's 2.27 that triggers this.

We could make the pr_warn_once() mention "broken binutils?" so that
people know why the warning happens.

           Linus
