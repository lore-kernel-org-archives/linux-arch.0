From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [RFC] Introduce __ARCH_WANT_SYS_SYSFS
Date: Tue, 22 Apr 2008 17:38:19 +0200
Message-ID: <200804221738.19635.arnd@arndb.de>
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com> <20080422152122.GF19802@phobos.i.cabal.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080422152122.GF19802-EK4dZfYtfFRW/gs8oUvUg/d9D2ou9A/h@public.gmane.org>
Content-Disposition: inline
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Kyle McMartin <kyle-pfcGkIkfWfAsA/PxXw9srA@public.gmane.org>
Cc: Will Newton <will.newton-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tuesday 22 April 2008, Kyle McMartin wrote:
>=20
> This should (imnsho, at least),
> =A0=A0=A0=A0=A0=A0=A0=A01 - Add a cond_syscall for sys_sysfs to sys_n=
i.c
> =A0=A0=A0=A0=A0=A0=A0=A02 - Use a CONFIG_EMBEDDED dependent option th=
at defaults on,
> =A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0possibly depend on BLACKFIN if you re=
ally want to.
>=20
> Adding this junk to every arch header is, in my opinion, completely
> unacceptable just because blackfin wants to be different.

It's not that they want to be different, but rather that I (among other=
s)
requested that they don't implement obsolete syscalls, so they removed =
it
from their syscall table.

	Arnd <><
