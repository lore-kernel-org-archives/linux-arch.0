From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] locking/qrwlock: Let qrwlock has same layout regardless
 of the endian
Date: Wed, 15 Jun 2016 10:20:51 +0100
Message-ID: <20160615092051.GC24029@arm.com>
References: <1465982177-2949-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35629 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751529AbcFOJUz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Jun 2016 05:20:55 -0400
Content-Disposition: inline
In-Reply-To: <1465982177-2949-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, ingo@redhat.com, peterz@infradead.org, arnd@arndb.de, Waiman.Long@hpe.com

On Wed, Jun 15, 2016 at 05:16:17PM +0800, Pan Xinhui wrote:
> This patch aims to get rid of endianness in queued_write_unlock(). We
> want to set  __qrwlock->wmode to NULL, however the address is not
> &lock->cnts in big endian machine. That causes queued_write_unlock()
> write NULL to the wrong field of __qrwlock.
> 
> Actually qrwlock can have same layout, IOW we can remove the #if
> __little_endian in struct __qrwlock. With such modification, we only
> need define some _QW* and _QR* with corresponding values in different
> endian systems.
> 
> Suggested-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
> ---
>  include/asm-generic/qrwlock.h | 15 +++++++++++----
>  kernel/locking/qrwlock.c      | 10 ++++------
>  2 files changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
> index 54a8e65..b135c11 100644
> --- a/include/asm-generic/qrwlock.h
> +++ b/include/asm-generic/qrwlock.h
> @@ -27,11 +27,18 @@
>  /*
>   * Writer states & reader shift and bias
>   */
> -#define	_QW_WAITING	1		/* A writer is waiting	   */
> -#define	_QW_LOCKED	0xff		/* A writer holds the lock */
> -#define	_QW_WMASK	0xff		/* Writer mask		   */
> +#ifdef	__LITTLE_ENDIAN
>  #define	_QR_SHIFT	8		/* Reader count shift	   */
> -#define _QR_BIAS	(1U << _QR_SHIFT)
> +#define	_QW_SHIFF	0		/* Writer mode shift	*/

Well, there are other typos that could've been worse, but you probably
want to fix this...

Will
