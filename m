From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] tty: Fix TIOCGPTPEER ioctl definition
Date: Tue, 11 Jul 2017 09:30:14 +0200
Message-ID: <CAK8P3a1uJc0dNoELw1KWKnc9Lme3HDxR2Coj0-snuCmO4n-81A@mail.gmail.com>
References: <20170711001207.GA11642@glebfm.cloud.tilaa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170711001207.GA11642@glebfm.cloud.tilaa.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
Cc: Aleksa Sarai <asarai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Christian Brauner <christian.brauner@ubuntu.com>, Valentin Rothberg <vrothberg@suse.com>, "Dmitry V. Levin" <ldv@altlinux.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-alpha@vger.kernel.org, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-sh@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>, linux-xtensa@linux-xtensa.org, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 11, 2017 at 2:12 AM, Gleb Fotengauer-Malinovskiy
<glebfm@altlinux.org> wrote:
> This ioctl does nothing to justify an _IOC_READ or _IOC_WRITE flag
> because it doesn't copy anything from/to userspace to access the
> argument.
>
> Fixes: 54ebbfb1 ("tty: add TIOCGPTPEER ioctl")
> Signed-off-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
