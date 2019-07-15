Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:47662 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730071AbfGONNf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jul 2019 09:13:35 -0400
Date: Mon, 15 Jul 2019 15:13:32 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] generic arch_futex_atomic_op_inuser() cleanup
In-Reply-To: <7b963f9a-21b1-4c6d-3ece-556d018508b4@virtuozzo.com>
Message-ID: <alpine.DEB.2.21.1907151510230.1722@nanos.tec.linutronix.de>
References: <7b963f9a-21b1-4c6d-3ece-556d018508b4@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vasily Averin <vvs@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20190715131332.F0GonfjCg2IFgeSZuZ8qk1jT8LN2SPKN0V4edE6VCLE@z>

On Mon, 15 Jul 2019, Vasily Averin wrote:

> Access to 'op' variable does not require pagefault_disable(),
> 'ret' variable should be initialized before using,
> 'oldval' variable can be replaced by constant.
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  include/asm-generic/futex.h | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/include/asm-generic/futex.h b/include/asm-generic/futex.h
> index 8666fe7f35d7..e9a9655d786d 100644
> --- a/include/asm-generic/futex.h
> +++ b/include/asm-generic/futex.h
> @@ -118,9 +118,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
>  static inline int
>  arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
>  {
> -	int oldval = 0, ret;
> -
> -	pagefault_disable();
> +	int ret = 0;

The variable is clearly initialized before using in 'default:', but the
whole function is pretty useless. It's guaranteed to return -ENOSYS and
does nothing else than disabling/enabling pagefaults for no reason.

Thanks,

	tglx
