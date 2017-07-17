Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:56546 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751306AbdGQNrw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Jul 2017 09:47:52 -0400
Date: Mon, 17 Jul 2017 15:47:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] [PING] Fix TIOCGPTPEER ioctl definition
Message-ID: <20170717134746.GA19574@kroah.com>
References: <20170717132946.GK21910@glebfm.cloud.tilaa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170717132946.GK21910@glebfm.cloud.tilaa.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
Cc: Aleksa Sarai <asarai@suse.de>, David Laight <David.Laight@ACULAB.COM>, James Hogan <james.hogan@imgtec.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, Valentin Rothberg <vrothberg@suse.com>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Dmitry V. Levin" <ldv@altlinux.org>, Jiri Slaby <jslaby@suse.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Christian Brauner <christian.brauner@ubuntu.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Message-ID: <20170717134746.IJaR-EkWrJjA7kw0FfBaT4-1veJ5bIxRMfagiWQasgw@z>

On Mon, Jul 17, 2017 at 04:29:46PM +0300, Gleb Fotengauer-Malinovskiy wrote:
> This ioctl does nothing to justify an _IOC_READ or _IOC_WRITE flag
> because it doesn't copy anything from/to userspace to access the
> argument.
> 
> Fixes: 54ebbfb16034 ("tty: add TIOCGPTPEER ioctl")
> Signed-off-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
> Acked-by: Aleksa Sarai <asarai@suse.de>
> Acked-by: Arnd Bergmann <arnd@arndb.de>


Why the PING?  -rc1 just happened, so I am only now able to apply the
patch to the tree.  Please relax, you are behind about 800+ other
patches in my queue...

thanks,

greg k-h
