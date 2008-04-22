From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [RFC] Introduce __ARCH_WANT_SYS_SYSFS
Date: Tue, 22 Apr 2008 11:42:16 -0400
Message-ID: <20080422154216.GI19802@phobos.i.cabal.ca>
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com> <20080422152122.GF19802@phobos.i.cabal.ca> <200804221738.19635.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764359AbYDVPm3@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200804221738.19635.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kyle McMartin <kyle@mcmartin.ca>, Will Newton <will.newton@gmail.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Apr 22, 2008 at 05:38:19PM +0200, Arnd Bergmann wrote:
> On Tuesday 22 April 2008, Kyle McMartin wrote:
> >=20
> > This should (imnsho, at least),
> > =A0=A0=A0=A0=A0=A0=A0=A01 - Add a cond_syscall for sys_sysfs to sys=
_ni.c
> > =A0=A0=A0=A0=A0=A0=A0=A02 - Use a CONFIG_EMBEDDED dependent option =
that defaults on,
> > =A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0possibly depend on BLACKFIN if you =
really want to.
> >=20
> > Adding this junk to every arch header is, in my opinion, completely
> > unacceptable just because blackfin wants to be different.
>=20
> It's not that they want to be different, but rather that I (among oth=
ers)
> requested that they don't implement obsolete syscalls, so they remove=
d it
> from their syscall table.
>=20

Ah, I stupidly assumed sys_sysfs was something to do with /sys.

regards, Kyle
