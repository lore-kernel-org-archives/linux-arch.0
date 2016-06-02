From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] locking/qrwlock: fix write unlock issue in big endian
Date: Thu, 2 Jun 2016 13:02:00 +0200
Message-ID: <20160602110200.GZ3190@twins.programming.kicks-ass.net>
References: <1464862148-5672-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <4399273.0kije2Qdx5@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:50744 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932124AbcFBLCH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jun 2016 07:02:07 -0400
Content-Disposition: inline
In-Reply-To: <4399273.0kije2Qdx5@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, waiman.long@hp.com

On Thu, Jun 02, 2016 at 12:44:51PM +0200, Arnd Bergmann wrote:
> On Thursday, June 2, 2016 6:09:08 PM CEST Pan Xinhui wrote:
> > diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
> > index 54a8e65..eadd7a3 100644
> > --- a/include/asm-generic/qrwlock.h
> > +++ b/include/asm-generic/qrwlock.h
> > @@ -139,7 +139,7 @@ static inline void queued_read_unlock(struct qrwlock *lock)
> >   */
> >  static inline void queued_write_unlock(struct qrwlock *lock)
> >  {
> > -       smp_store_release((u8 *)&lock->cnts, 0);
> > +       (void)atomic_sub_return_release(_QW_LOCKED, &lock->cnts);
> >  }
> 
> Isn't this more expensive than the existing version?

Yes, loads. And while this might be a suitable fix for asm-generic, it
will introduce a fairly large regression on x86 (which is currently the
only user of this).
