From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] kbuild changes for v4.9-rc1
Date: Fri, 16 Dec 2016 11:57:02 -0800
Message-ID: <CA+55aFxjJbAXRq2HSxhfn2gWsGiLPTcqoRrrDLJrLd2vFLu9YQ@mail.gmail.com>
References: <20161017065131.GA27863@angband.pl> <20161017175951.31d8f4b7@roar.ozlabs.ibm.com>
 <20161017100130.GA16013@angband.pl> <7212667f-f508-2b41-a380-8f736814d8cc@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:33438 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753265AbcLPT5D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Dec 2016 14:57:03 -0500
In-Reply-To: <7212667f-f508-2b41-a380-8f736814d8cc@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: Adam Borowski <kilobyte@angband.pl>, Nicholas Piggin <npiggin@gmail.com>, Omar Sandoval <osandov@osandov.com>, Michal Marek <mmarek@suse.com>, Alexey Dobriyan <adobriyan@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Al Viro <viro@zeniv.linux.org.uk>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Fri, Dec 16, 2016 at 11:55 AM, Jiri Slaby <jslaby@suse.cz> wrote:
>
> what happened to this? I had to apply this to fix 4.9-pae kernel here.

Did you actually have to do that?

Because a missing CRC shouldn't be fatal in 4.9.

What was the failure mode?

                Linus
