From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: __get_user_unaligned return value
Date: Sun, 14 Jun 2009 21:44:23 +0200
Message-ID: <200906142144.24487.arnd@arndb.de>
References: <alpine.DEB.2.00.0906141211590.24169@vinegar-pot.mit.edu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:61049 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752773AbZFNTo2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 14 Jun 2009 15:44:28 -0400
In-Reply-To: <alpine.DEB.2.00.0906141211590.24169@vinegar-pot.mit.edu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Anders Kaseorg <andersk@mit.edu>
Cc: Arun Sharma <arun.sharma@intel.com>, "David S. Miller" <davem@nuts.davemloft.net>, linux-arch@vger.kernel.org, tony.luck@intel.com

On Sunday 14 June 2009, Anders Kaseorg wrote:
> The __get_user_unaligned macro in include/asm/uaccess-unaligned.h ret=
urns=20
> the wrong value, since the ? -EFAULT : 0 is not on the last line of t=
he=20
> statement expression:
>=20
> #define __get_user_unaligned(x, ptr)                                 =
   \
> ({                                                                   =
   \
>         __typeof__ (*(ptr)) __x;                                     =
   \
>         __copy_from_user(&__x, (ptr), sizeof(*(ptr))) ? -EFAULT : 0; =
   \
>         (x) =3D __x;                                                 =
     \
> })
>=20
> I couldn=E2=80=99t find any callers, so I=E2=80=99m not sure whether =
the macro should be=20
> patched or just removed.

Not sure either. __put_user_unaligned() still only has the one user tha=
t
Arun added back in 2.6.9, and I don't think we ever added any code that=
 used
__get_user_unaligned(). That bug would probably have been noticed.

Even __put_user_unaligned only matters on ia64, because the only user o=
f
that function is actually accessing aligned data on everything besides
x86-64 and ia64, and x86-64 does not even care.

I'm tempted to just rip out both _unaligned functions and to add a new
put_user_compat_u64() on ia64, and put a default into include/linux/uac=
cess.h
that just calls put_user() for everyone else.

	Arnd <><
