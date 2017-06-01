Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:35972 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbdFASqb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jun 2017 14:46:31 -0400
MIME-Version: 1.0
In-Reply-To: <20170601173803.8698-1-asarai@suse.de>
References: <20170601173803.8698-1-asarai@suse.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 1 Jun 2017 20:46:29 +0200
Message-ID: <CAMuHMdXkaWg70OidDi0_xALbzwZ+o0eEVEzT5U_6HdewBs4WwA@mail.gmail.com>
Subject: Re: [PATCH] tty: add TIOCGPTPEER ioctl
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Aleksa Sarai <asarai@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, alpha <linux-alpha@vger.kernel.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, Parisc List <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, Linux-Arch <linux-arch@vger.kernel.org>, Christian Brauner <christian.brauner@ubuntu.com>, Valentin Rothberg <vrothberg@suse.com>
Message-ID: <20170601184629.ZQ8wvKYmNA0q_QYb2reDe2-76JG5EMmnLsmlniwKNZY@z>

Hi Aleksa,

On Thu, Jun 1, 2017 at 7:38 PM, Aleksa Sarai <asarai@suse.de> wrote:
> --- a/arch/alpha/include/uapi/asm/ioctls.h
> +++ b/arch/alpha/include/uapi/asm/ioctls.h
> @@ -94,6 +94,7 @@
>  #define TIOCSRS485     _IOWR('T', 0x2F, struct serial_rs485)
>  #define TIOCGPTN       _IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
>  #define TIOCSPTLCK     _IOW('T',0x31, int)  /* Lock/unlock Pty */
> +#define TIOCGPTPEER    _IOR('T', 0x41, int) /* Safely open the slave */

Shouldn't the list of definitions be kept sorted, by hex number?
(everywhere)

>  #define TIOCGDEV       _IOR('T',0x32, unsigned int) /* Get primary device node of /dev/console */
>  #define TIOCSIG                _IOW('T',0x36, int)  /* Generate signal on Pty slave */
>  #define TIOCVHANGUP    0x5437

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
