From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v4] locking/qrwlock: Fix write unlock issue in big endian
Date: Thu, 21 Jul 2016 17:17:31 +0100
Message-ID: <20160721161731.GI21616@arm.com>
References: <1468835259-4486-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48992 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753047AbcGUQRc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 21 Jul 2016 12:17:32 -0400
Content-Disposition: inline
In-Reply-To: <1468835259-4486-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, peterz@infradead.org, arnd@arndb.de, Waiman.Long@hpe.com, mingo@redhat.com, boqun.feng@gmail.com

On Mon, Jul 18, 2016 at 05:47:39PM +0800, Pan Xinhui wrote:
> From: pan xinhui <xinhui.pan@linux.vnet.ibm.com>
> 
> This patch aims to get rid of endianness in queued_write_unlock(). We
> want to set  __qrwlock->wmode to NULL, however the address is not
> &lock->cnts in big endian machine. That causes queued_write_unlock()
> write NULL to the wrong field of __qrwlock.
> 
> So implement __qrwlock_write_byte() which returns the correct
> __qrwlock->wmode address.
> 
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
> ---
> change from v3:
> 	rewrite totally. :)
> change from v2:
> 	change macro's name, add comments.
> change from v1:
> 	A typo fix which is really bad...
> 	thanks Will for the carefull review.
> ---
>  include/asm-generic/qrwlock.h | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
> index 54a8e65..7d026bf 100644
> --- a/include/asm-generic/qrwlock.h
> +++ b/include/asm-generic/qrwlock.h
> @@ -25,7 +25,20 @@
>  #include <asm-generic/qrwlock_types.h>
>  
>  /*
> - * Writer states & reader shift and bias
> + * Writer states & reader shift and bias.
> + *
> + *       | +0 | +1 | +2 | +3 |
> + *   ----+----+----+----+----+
> + *    LE | 78 | 56 | 34 | 12 | 0x12345678
> + *   ----+----+----+----+----+
> + *       | wr |      rd      |
> + *       +----+----+----+----+
> + *
> + *   ----+----+----+----+----+
> + *    BE | 12 | 34 | 56 | 78 | 0x12345678
> + *   ----+----+----+----+----+
> + *       |      rd      | wr |
> + *       +----+----+----+----+
>   */
>  #define	_QW_WAITING	1		/* A writer is waiting	   */
>  #define	_QW_LOCKED	0xff		/* A writer holds the lock */
> @@ -134,12 +147,22 @@ static inline void queued_read_unlock(struct qrwlock *lock)
>  }
>  
>  /**
> + * __qrwlock_write_byte - retrieve the write byte address of a queue rwlock
> + * @lock : Pointer to queue rwlock structure
> + * Return: the write byte address of a queue rwlock
> + */
> +static inline u8 *__qrwlock_write_byte(struct qrwlock *lock)
> +{
> +	return (u8 *)lock + 3 * IS_BUILTIN(CONFIG_CPU_BIG_ENDIAN);
> +}

Might be worth a comment here, saying that IS_BUILTIN expands to 1 or 0.

Either way, the patch looks correct to me:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
