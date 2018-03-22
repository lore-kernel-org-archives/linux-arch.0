Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:45917 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbeCVR53 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Mar 2018 13:57:29 -0400
MIME-Version: 1.0
In-Reply-To: <20180322102140.GA14294@light.dominikbrodowski.net>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
 <20180322090059.19361-23-linux@dominikbrodowski.net> <20180322102140.GA14294@light.dominikbrodowski.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Mar 2018 10:57:27 -0700
Message-ID: <CA+55aFx-Rn2F=yRftzdmu=zSzo5giNCEF7WP_=VNx8-d+OOBsQ@mail.gmail.com>
Subject: Re: Any chance that kernel/uid6.c can go? [Was: [PATCH 22/45] kernel:
 provide ksys_*() wrappers for syscalls called by kernel/uid16.c]
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, "Eric W . Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20180322175727.h6utugEufEnHshZMFihKsyPIC35ZYf4OTFLUO3l7v0Y@z>

On Thu, Mar 22, 2018 at 3:21 AM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> In its header, kernel/uid16.c says, since 2.3.39 was released in January
> 2000:
>
>  *      Wrapper functions for 16bit uid back compatibility. All nicely tied
>  *      together in the faint hope we can take the out in five years time.
>
> Are we any closer to removing these wrappers?

Honestly, I don't see any real upside to getting rid of them.

We used to still run some of the _original_ binaries from the old
floppy disk distributions just a few years ago. I honestly hope we
still do. And those old uid system calls would be very much part of
it.

Sadly, I don't know where those old binaries are. Anybody know where
the bash binary from 1991 is? There was a "bash.Z" as part of the 0.01
release.

(Ok, that one is almost certainly broken, but Alan Cox reported
running some really old binaries from the early times long ago before
he turned to even *older* retrocomputing and started concentrating on
the old 8-bit machines ;)

              Linus
