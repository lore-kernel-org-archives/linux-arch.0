From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] locking/qrwlock: fix write unlock issue in big endian
Date: Tue, 14 Jun 2016 11:40:33 +0100
Message-ID: <20160614104032.GE19407@arm.com>
References: <1464862148-5672-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160608092244.GA27029@arm.com>
 <575FA024.7060608@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57819 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806AbcFNKkh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 14 Jun 2016 06:40:37 -0400
Content-Disposition: inline
In-Reply-To: <575FA024.7060608@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, waiman.long@hp.com, peterz@infradead.org

On Tue, Jun 14, 2016 at 02:11:48PM +0800, xinhui wrote:
>=20
> On 2016=E5=B9=B406=E6=9C=8808=E6=97=A5 17:22, Will Deacon wrote:
> >On Thu, Jun 02, 2016 at 06:09:08PM +0800, Pan Xinhui wrote:
> >>strcut __qrwlock has different layout in big endian machine. we nee=
d set
> >>the __qrwlock->wmode to NULL, and the address is not &lock->cnts in=
 big
> >>endian machine.
> >>
> >>Do as what read unlock does. we are lucky that the __qrwlock->wmode=
's
> >>val is _QW_LOCKED.
> >
> >Doesn't this have wider implications for the qrwlocks, for example:
> >
> >   while ((cnts & _QW_WMASK) =3D=3D _QW_LOCKED) { ... }
> >
> >would actually end up looking at the wrong field of the lock?
> >
> I does not clearly understand your idea. :(

That's because I'm talking rubbish :) Sorry, I completely confused myse=
lf.
Locking is bad enough on its own, but add big-endian to the mix and I'm
all done.

> >Shouldn't we just remove the #ifdef __LITTLE_ENDIAN stuff from __qrw=
lock,
> >given that all the struct members are u8?
> >
> No. that makes codes complex. for example
>=20
> struct __qrwlock lock;
>=20
> WRITE_ONCE(lock->wmode, _QW_WAITING);
> if (atomic_(&lock->cnts) =3D=3D _QW_WAITING) {
> 	do_something();
> }
>=20
> IF you remove the  #ifdef __LITTLE_ENDIAN stuff from __qrwlock.
> codes above obviously will break. And we already have such code.

I was wondering more along the lines of having one definition of the da=
ta
structure, but then defining _QW_* differently depending on endianness
(i.e. add a << 24 when big-endian). That way queued_write_unlock can
stay like it is (having an arch override to handle the big-endian case
is incredibly ugly).

Will
