Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.183]:52481 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598AbXI1XyI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Sep 2007 19:54:08 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [COMPAT] Add compat_merge64 helper
Date: Sat, 29 Sep 2007 01:38:23 +0200
References: <1191018832-18069-1-git-send-email-kyle@mcmartin.ca>
In-Reply-To: <1191018832-18069-1-git-send-email-kyle@mcmartin.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200709290138.24562.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: Kyle McMartin <kyle@mcmartin.ca>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Saturday 29 September 2007, you wrote:
> +static inline u64 compat_merge64(u32 left, u32 right)
> +{
> +#if defined(__BIG_ENDIAN)
> +       return ((u64)left << 32) | right;
> +#else /* defined (__LITTLE_ENDIAN) */
> +       return ((u64)right << 32) | left;
> +#endif
> +}

Looks good, if we can guarantee that

1. Byte order matches the order in which 64 bit arguments are split
   in system call conventions on all platforms.
2. Every user of compat_merge64() includes asm/byteorder.h

Both should be easy to prove, but I'm not convinced until someone
actually does it.

	Arnd <><
