Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:36144 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751499AbdFFMtR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jun 2017 08:49:17 -0400
MIME-Version: 1.0
In-Reply-To: <20170603141515.9529-2-asarai@suse.de>
References: <20170603141515.9529-1-asarai@suse.de> <20170603141515.9529-2-asarai@suse.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 6 Jun 2017 14:49:15 +0200
Message-ID: <CAK8P3a2Y2U58dfAxRYPKQL2-o8ufpkvxxF07c_LCr5DOuQ4=vw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] tty: add compat_ioctl callbacks
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Aleksa Sarai <asarai@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-alpha@vger.kernel.org, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-sh@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>, linux-xtensa@linux-xtensa.org, linux-arch <linux-arch@vger.kernel.org>, Christian Brauner <christian.brauner@ubuntu.com>, Valentin Rothberg <vrothberg@suse.com>
Message-ID: <20170606124915.WFwABOapEE1YmpWeWqFLNmJM7hwxxmEy4h0jOuRElYM@z>

On Sat, Jun 3, 2017 at 4:15 PM, Aleksa Sarai <asarai@suse.de> wrote:
> In order to avoid future diversions between fs/compat_ioctl.c and
> drivers/tty/pty.c, define .compat_ioctl callbacks for the relevant
> tty_operations structs. Since both pty_unix98_ioctl() and
> pty_bsd_ioctl() are compatible between 32-bit and 64-bit userspace no
> special translation is required.
>
> Signed-off-by: Aleksa Sarai <asarai@suse.de>

Looks good,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
