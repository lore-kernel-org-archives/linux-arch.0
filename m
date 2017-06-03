From: Aleksa Sarai <asarai@suse.de>
Subject: Re: [PATCH v3 1/2] tty: add compat_ioctl callbacks
Date: Sun, 4 Jun 2017 00:13:27 +1000
Message-ID: <7bd066af-bd37-5a66-74b7-1267b58a43f8@suse.de>
References: <20170603135111.5444-1-asarai@suse.de>
 <20170603135111.5444-2-asarai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <20170603135111.5444-2-asarai@suse.de>
Content-Language: en-US
Sender: linux-parisc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Christian Brauner <christian.brauner@ubuntu.com>, Valentin Rothberg <vrothberg@suse.com>
List-Id: linux-arch.vger.kernel.org

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
