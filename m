Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:35075 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751070AbcLDUos (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 4 Dec 2016 15:44:48 -0500
MIME-Version: 1.0
In-Reply-To: <20161204074435.GQ4829@bubble.grove.modra.org>
References: <20161129131922.GA31466@angband.pl> <2899250.iZaPagXLk8@wuerfel>
 <CA+55aFxg_s8k1LBmsXjpVYw=BKh8sNEuL3n6MhzZGTuUPKMOwg@mail.gmail.com>
 <14455987.OWjnZpEEup@wuerfel> <20161204074435.GQ4829@bubble.grove.modra.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 4 Dec 2016 12:44:41 -0800
Message-ID: <CA+55aFzsnWi0oHu+0rgShaGWEnURw1fXLaAxLe+gF21GdxMWoA@mail.gmail.com>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from asm
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Modra <amodra@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Ben Hutchings <ben@decadent.org.uk>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20161204204441.Zjp2WsMZs9RvkVgO2lUmgA-cQ36Nbi2opIKhj82tPq4@z>

On Sat, Dec 3, 2016 at 11:44 PM, Alan Modra <amodra@gmail.com> wrote:
>
> As far as reverting the binutils commit goes, I'm quite willing to do
> that if necessary

I think we have the proper fix in the kernel now, witht he "mark weak
asm symbols with value 0". Or if not "proper", then at least
acceptable. So I think the ship has sailed on the binutils change, and
there's no point in reverting it any more.

          Linus
