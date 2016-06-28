From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2] locking/qrwlock: Let qrwlock has same layout
 regardless of the endian
Date: Tue, 28 Jun 2016 18:16:07 +0100
Message-ID: <20160628171606.GI5425@arm.com>
References: <1465983109-3217-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <57644A39.9080509@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49328 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752639AbcF1RQD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 28 Jun 2016 13:16:03 -0400
Content-Disposition: inline
In-Reply-To: <57644A39.9080509@hpe.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <waiman.long@hpe.com>
Cc: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, ingo@redhat.com, peterz@infradead.org, arnd@arndb.de

On Fri, Jun 17, 2016 at 03:06:33PM -0400, Waiman Long wrote:
> On 06/15/2016 05:31 AM, Pan Xinhui wrote:
> >This patch aims to get rid of endianness in queued_write_unlock(). We
> >want to set  __qrwlock->wmode to NULL, however the address is not
> >&lock->cnts in big endian machine. That causes queued_write_unlock()
> >write NULL to the wrong field of __qrwlock.
> >
> >Actually qrwlock can have same layout, IOW we can remove the #if
> >__little_endian in struct __qrwlock. With such modification, we only
> >need define some _QW* and _QR* with corresponding values in different
> >endian systems.
> >
> >Suggested-by: Will Deacon<will.deacon@arm.com>
> >Signed-off-by: Pan Xinhui<xinhui.pan@linux.vnet.ibm.com>
> >---
> >change from v1:
> >	A typo fix which is really bad...
> >	thanks Will for the carefull review. :)
> >---
> >  include/asm-generic/qrwlock.h | 15 +++++++++++----
> >  kernel/locking/qrwlock.c      | 10 ++++------
> >  2 files changed, 15 insertions(+), 10 deletions(-)
> >
> >diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
> >index 54a8e65..28fb94a 100644
> >--- a/include/asm-generic/qrwlock.h
> >+++ b/include/asm-generic/qrwlock.h
> >@@ -27,11 +27,18 @@
> >  /*
> >   * Writer states&  reader shift and bias
> >   */
> >-#define	_QW_WAITING	1		/* A writer is waiting	   */
> >-#define	_QW_LOCKED	0xff		/* A writer holds the lock */
> >-#define	_QW_WMASK	0xff		/* Writer mask		   */
> >+#ifdef	__LITTLE_ENDIAN
> >  #define	_QR_SHIFT	8		/* Reader count shift	   */
> >-#define _QR_BIAS	(1U<<  _QR_SHIFT)
> >+#define	_QW_SHIFT	0		/* Writer mode shift	*/
> >+#else
> >+#define	_QR_SHIFT	0		/* Reader count shift	   */
> >+#define	_QW_SHIFT	24		/* Writer mode shift	*/
> >+#endif
> >+
> >+#define	_QW_WAITING	(1U<<  _QW_SHIFT)	/* A writer is waiting	   */
> >+#define	_QW_LOCKED	(0xffU<<  _QW_SHIFT)	/* A writer holds the lock */
> >+#define	_QW_WMASK	(0xffU<<  _QW_SHIFT)	/* Writer mask		   */
> >+#define	_QR_BIAS	(1U<<  _QR_SHIFT)
> >
> >  /*
> >   * External function declarations
> >diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
> >index fec0823..57d66cf 100644
> >--- a/kernel/locking/qrwlock.c
> >+++ b/kernel/locking/qrwlock.c
> >@@ -30,18 +30,15 @@ struct __qrwlock {
> >  	union {
> >  		atomic_t cnts;
> >  		struct {
> >-#ifdef __LITTLE_ENDIAN
> >  			u8 wmode;	/* Writer mode   */
> >  			u8 rcnts[3];	/* Reader counts */
> >-#else
> >-			u8 rcnts[3];	/* Reader counts */
> >-			u8 wmode;	/* Writer mode   */
> >-#endif
> >  		};
> >  	};
> >  	arch_spinlock_t	lock;
> >  };
> >
> >+#define	_QW_MODEVAL(v)	((v)>>  _QW_SHIFT)
> 
> I know what you are doing here, but it is a bit hard to understand it just
> by looking at the name of the macro itself. Maybe some other names like
> _QW_MASKVAL() or_QW_BYTEVAL(). You may also want to have a line of comment
> about it. Other than that, I don't see any problem with it.
> 
> Acked-by: Waiman Long <Waiman.Long@hpe.com>

I agree that the macro is ugly. I think I'd be inclined to drop it
altogether.

That said, the code looks correct to me:

Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
