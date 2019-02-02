Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164]:25275 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfBBR2O (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Feb 2019 12:28:14 -0500
Subject: Re: [PATCH net-next v5 12/12] sock: Add SO_RCVTIMEO_NEW and
 SO_SNDTIMEO_NEW
References: <20190202153454.7121-1-deepa.kernel@gmail.com>
 <20190202153454.7121-13-deepa.kernel@gmail.com>
From: Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <0fad3f4d-4c0e-d9f2-1af0-7890d40c19c0@hartkopp.net>
Date: Sat, 2 Feb 2019 18:15:41 +0100
MIME-Version: 1.0
In-Reply-To: <20190202153454.7121-13-deepa.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Deepa Dinamani <deepa.kernel@gmail.com>, davem@davemloft.net, linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org, ccaulfie@redhat.com, deller@gmx.de, paulus@samba.org, ralf@linux-mips.org, rth@twiddle.net, cluster-devel@redhat.com, linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org
Message-ID: <20190202171541.391rWQNdE_r-V8pw6mHNQh9YIgZWPl_g54EffUkf5OE@z>

Hi all,

On 02.02.19 16:34, Deepa Dinamani wrote:
> Add new socket timeout options that are y2038 safe.
(..)
> 
> diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
> index 9826d1db71d0..0d0fddb7e738 100644
> --- a/arch/alpha/include/uapi/asm/socket.h
> +++ b/arch/alpha/include/uapi/asm/socket.h
> @@ -119,19 +119,25 @@
>   #define SO_TIMESTAMPNS_NEW      64
>   #define SO_TIMESTAMPING_NEW     65
>   
> -#if !defined(__KERNEL__)
> +#define SO_RCVTIMEO_NEW         66
> +#define SO_SNDTIMEO_NEW         67
>   
> -#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
> -#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
> +#if !defined(__KERNEL__)
>   
>   #if __BITS_PER_LONG == 64
>   #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
>   #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
>   #define SO_TIMESTAMPING         SO_TIMESTAMPING_OLD
> +
> +#define SO_RCVTIMEO		SO_RCVTIMEO_OLD
> +#define SO_SNDTIMEO		SO_SNDTIMEO_OLD

Maybe I'm a bit late in this discussion as you are already in v5 ...

I can see patches making the transition in different steps where it 
might be helpful to name them *_OLD and *_NEW to understand the patches.

But in the end the naming stays in the kernel for a very long time and I 
remember myself (in early years) to name things 'new', 'new2', 'new3'.

In fact SO_TIMESTAMP_OLD should be named SO_TIMESTAMP32 and 
SO_TIMESTAMP_NEW should be named SO_TIMESTAMP64.

Especially as it tells you what is 'inside', the naming of these new 
introduced constants should be replaced with *32 and *64 names.

The documentation and the other comments still fit perfectly then.

Regards,
Oliver
