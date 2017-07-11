From: Aleksa Sarai <asarai@suse.de>
Subject: Re: [PATCH] tty: Fix TIOCGPTPEER ioctl definition
Date: Tue, 11 Jul 2017 12:07:43 +1000
Message-ID: <f1cac5bf-d34f-9684-b27b-20e973f454a0@suse.de>
References: <20170711001207.GA11642@glebfm.cloud.tilaa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46538 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755190AbdGKCIB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 Jul 2017 22:08:01 -0400
In-Reply-To: <20170711001207.GA11642@glebfm.cloud.tilaa.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>, Christian Brauner <christian.brauner@ubuntu.com>, Valentin Rothberg <vrothberg@suse.com>, "Dmitry V. Levin" <ldv@altlinux.org>, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org

> This ioctl does nothing to justify an _IOC_READ or _IOC_WRITE flag
> because it doesn't copy anything from/to userspace to access the
> argument.

   Acked-by: Aleksa Sarai <asarai@suse.de>

Oops, I misunderstood what _IOR means semantically. TIL -- thanks!

-- 
Aleksa Sarai
Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/
