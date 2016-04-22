From: Waiman Long <waiman.long@hpe.com>
Subject: Re: [RFC][PATCH 31/31] locking,qrwlock: Employ atomic_fetch_add_acquire()
Date: Fri, 22 Apr 2016 10:25:08 -0400
Message-ID: <571A3444.3090703@hpe.com>
References: <20160422090413.393652501@infradead.org> <20160422093925.045007784@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bl2on0129.outbound.protection.outlook.com ([65.55.169.129]:50638
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752850AbcDVOZU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 22 Apr 2016 10:25:20 -0400
In-Reply-To: <20160422093925.045007784@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, fweisbec@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, dbueso@suse.de, fengguang.wu@intel.com

On 04/22/2016 05:04 AM, Peter Zijlstra wrote:
> The only reason for the current code is to make GCC emit only the
> "LOCK XADD" instruction on x86 (and not do a pointless extra ADD on
> the result), do so nicer.
>
> Signed-off-by: Peter Zijlstra (Intel)<peterz@infradead.org>
> ---
>   kernel/locking/qrwlock.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/kernel/locking/qrwlock.c
> +++ b/kernel/locking/qrwlock.c
> @@ -93,7 +93,7 @@ void queued_read_lock_slowpath(struct qr
>   	 * that accesses can't leak upwards out of our subsequent critical
>   	 * section in the case that the lock is currently held for write.
>   	 */
> -	cnts = atomic_add_return_acquire(_QR_BIAS,&lock->cnts) - _QR_BIAS;
> +	cnts = atomic_fetch_add_acquire(_QR_BIAS,&lock->cnts);
>   	rspin_until_writer_unlock(lock, cnts);
>
>   	/*
>
>

Thanks for taking out this weirdness in the code.

Acked-by: Waiman Long <waiman.long@hpe.com>
