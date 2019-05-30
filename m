Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfE3O2l (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 May 2019 10:28:41 -0400
Subject: Re: [PATCH v5 1/3] powerpc: Fix vDSO clock_getres()
References: <20190528120446.48911-1-vincenzo.frascino@arm.com>
 <20190528120446.48911-2-vincenzo.frascino@arm.com>
From: shuah <shuah@kernel.org>
Message-ID: <d4c2380d-1811-18f3-51a3-10bd3782b9de@kernel.org>
Date: Thu, 30 May 2019 08:28:27 -0600
MIME-Version: 1.0
In-Reply-To: <20190528120446.48911-2-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org, shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <20190530142827.0Q7qVgTlhCgUvo1BPIx68mCHgMPI5gQ2zTCxGmv4EeE@z>

On 5/28/19 6:04 AM, Vincenzo Frascino wrote:
> clock_getres in the vDSO library has to preserve the same behaviour
> of posix_get_hrtimer_res().
> 
> In particular, posix_get_hrtimer_res() does:
>      sec = 0;
>      ns = hrtimer_resolution;
> and hrtimer_resolution depends on the enablement of the high
> resolution timers that can happen either at compile or at run time.
> 
> Fix the powerpc vdso implementation of clock_getres keeping a copy of
> hrtimer_resolution in vdso data and using that directly.
> 
> Fixes: a7f290dad32e ("[PATCH] powerpc: Merge vdso's and add vdso support
> to 32 bits kernel")
> Cc: stable@vger.kernel.org
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
> 
> Note: This patch is independent from the others in this series, hence it
> can be merged singularly by the powerpc maintainers.
> 

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
