From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: ipc64_perm - generic
Date: Mon, 25 May 2009 22:21:43 +0000
Message-ID: <200905252221.44082.arnd@arndb.de>
References: <4A1AE972.9010905@monstr.eu>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:53548 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715AbZEYWVz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 May 2009 18:21:55 -0400
In-Reply-To: <4A1AE972.9010905@monstr.eu>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@monstr.eu, linux-arch@vger.kernel.org
Cc: John Williams <john.williams@petalogix.com>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On Monday 25 May 2009 18:54:42 Michal Simek wrote:
> 
> Hi Arnd, cc: John
> 
> From asm-generic/posix_types.h
> 
> 17 #ifndef __kernel_mode_t
> 18 typedef unsigned int    __kernel_mode_t;
> 19 #endif
> 
> This structure is not aligned properly because of pad2.
> 
> 19 struct ipc64_perm {
> 20         __kernel_key_t          key;
> 21         __kernel_uid32_t        uid;
> 22         __kernel_gid32_t        gid;
> 23         __kernel_uid32_t        cuid;
> 24         __kernel_gid32_t        cgid;
> 25         __kernel_mode_t         mode;
> 26         unsigned short          __pad1;
> 27         unsigned short          seq;
> 28         unsigned short          __pad2;
> 29         unsigned long           __unused1;
> 30         unsigned long           __unused2;
> 31 };
> 
> I think we should remove __pad1.
> What do you think?

Right, well spotted.

I'd like to keep the struct ipc64_perm compatible with most architectures, so
maybe we can play a little trick here:

> Here is proposed struct.
>  struct ipc64_perm {
>          __kernel_key_t          key;
>          __kernel_uid32_t        uid;
>          __kernel_gid32_t        gid;
>          __kernel_uid32_t        cuid;
>          __kernel_gid32_t        cgid;
>          __kernel_mode_t         mode;

+	unsigned char __pad1[4 - sizeof(__kernel_mode_t)];

>          unsigned short          seq;
>          unsigned short          __pad2;
>          unsigned long           __unused1;
>          unsigned long           __unused2;
>  };

If that's too much of a hack, we could also change the default __kernel_mode_t
in asm-generic/posix_types.h to unsigned short, which it is on all 32-bit architectures
except mips and xtensa. For some reason, all 64 bit architechtures use unsigned
int for mode_t, but I couldn't find out why. Glibc uses unsigned int externally.

	Arnd <><
