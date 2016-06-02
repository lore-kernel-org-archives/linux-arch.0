From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] locking/qrwlock: fix write unlock issue in big endian
Date: Thu, 2 Jun 2016 13:15:05 +0200
Message-ID: <20160602111505.GB3190@twins.programming.kicks-ass.net>
References: <1464862148-5672-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <4399273.0kije2Qdx5@wuerfel>
 <575011FD.4070109@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:50207 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbcFBLPJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jun 2016 07:15:09 -0400
Content-Disposition: inline
In-Reply-To: <575011FD.4070109@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, waiman.long@hp.com

On Thu, Jun 02, 2016 at 07:01:17PM +0800, xinhui wrote:
>=20
> On 2016=E5=B9=B406=E6=9C=8802=E6=97=A5 18:44, Arnd Bergmann wrote:
> >On Thursday, June 2, 2016 6:09:08 PM CEST Pan Xinhui wrote:
> >>diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qr=
wlock.h
> >>index 54a8e65..eadd7a3 100644
> >>--- a/include/asm-generic/qrwlock.h
> >>+++ b/include/asm-generic/qrwlock.h
> >>@@ -139,7 +139,7 @@ static inline void queued_read_unlock(struct qr=
wlock *lock)
> >>   */
> >>  static inline void queued_write_unlock(struct qrwlock *lock)
> >>  {
> >>-       smp_store_release((u8 *)&lock->cnts, 0);
> >>+       (void)atomic_sub_return_release(_QW_LOCKED, &lock->cnts);
> >>  }
> >
> >Isn't this more expensive than the existing version?
> >
> yes, a little more expensive than the existing version

Think 20+ cycles worse.

> But does this is generic code, I am not sure how it will impact the p=
erformance on other archs.

As always, you get to audit users of stuff you change. And here you're
lucky, there's only 1.

> If you like
> we calculate the correct address to set to NULL
> say,
> static inline void queued_write_unlock(struct qrwlock *lock)
> {
> u8 *wl =3D lock;
>=20
> #ifdef __BIG_ENDIAN
> wl +=3D 3;
> #endif
> smp_store_release(wl, 0);
>=20
> }

No, that's horrible. Either lift __qrwlock into qrwlock_types.h or do
what qspinlock does. And looking at that, we could make
queued_spin_unlock() use the atomic_sub_return_relaxed() thing too I
suppose, that generates slightly better code.
