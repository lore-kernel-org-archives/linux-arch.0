Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33816 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753178AbdGKHaV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jul 2017 03:30:21 -0400
MIME-Version: 1.0
In-Reply-To: <20170711001207.GA11642@glebfm.cloud.tilaa.com>
References: <20170711001207.GA11642@glebfm.cloud.tilaa.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 11 Jul 2017 09:30:14 +0200
Message-ID: <CAK8P3a1uJc0dNoELw1KWKnc9Lme3HDxR2Coj0-snuCmO4n-81A@mail.gmail.com>
Subject: Re: [PATCH] tty: Fix TIOCGPTPEER ioctl definition
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
Cc: Aleksa Sarai <asarai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Christian Brauner <christian.brauner@ubuntu.com>, Valentin Rothberg <vrothberg@suse.com>, "Dmitry V. Levin" <ldv@altlinux.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-alpha@vger.kernel.org, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-sh@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>, linux-xtensa@linux-xtensa.org, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20170711073014.iERWt62GpLnxXvpoYRIChYNLFnp6kJCJh2LX1MedUWE@z>

On Tue, Jul 11, 2017 at 2:12 AM, Gleb Fotengauer-Malinovskiy
<glebfm@altlinux.org> wrote:
> This ioctl does nothing to justify an _IOC_READ or _IOC_WRITE flag
> because it doesn't copy anything from/to userspace to access the
> argument.
>
> Fixes: 54ebbfb1 ("tty: add TIOCGPTPEER ioctl")
> Signed-off-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
