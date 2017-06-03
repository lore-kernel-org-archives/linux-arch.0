Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54800 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751163AbdFCONi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 3 Jun 2017 10:13:38 -0400
Subject: Re: [PATCH v3 1/2] tty: add compat_ioctl callbacks
References: <20170603135111.5444-1-asarai@suse.de>
 <20170603135111.5444-2-asarai@suse.de>
From: Aleksa Sarai <asarai@suse.de>
Message-ID: <7bd066af-bd37-5a66-74b7-1267b58a43f8@suse.de>
Date: Sun, 4 Jun 2017 00:13:27 +1000
MIME-Version: 1.0
In-Reply-To: <20170603135111.5444-2-asarai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Christian Brauner <christian.brauner@ubuntu.com>, Valentin Rothberg <vrothberg@suse.com>
Message-ID: <20170603141327.-tIQnDgWvT-UJRZC87vDYyobIGRvGtqZQZ7XJ2TovPs@z>

> diff --git a/Makefile b/Makefile
> index 470bd4d9513a..fb689286d83a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -401,6 +401,7 @@ KBUILD_CFLAGS   := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
>   		   -fno-strict-aliasing -fno-common \
>   		   -Werror-implicit-function-declaration \
>   		   -Wno-format-security \
> +		   -Wno-error=int-in-bool-context \
>   		   -std=gnu89 $(call cc-option,-fno-PIE)


Ah sorry, I committed that by accident. I'll send a fixed version.

-- 
Aleksa Sarai
Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/
