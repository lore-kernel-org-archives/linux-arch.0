From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: __ARCH_WANT_SYSCALL_DEPRECATED
Date: Mon, 22 Aug 2011 22:43:18 +0200
Message-ID: <2047151.mWElcT8jZQ@wuerfel>
References: <20110822193602.GA23301@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <libc-ports-return-2007-gclgp-libc-ports=m.gmane.org@sourceware.org>
In-Reply-To: <20110822193602.GA23301@codeaurora.org>
List-Unsubscribe: <mailto:libc-ports-unsubscribe-gclgp-libc-ports=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:libc-ports-subscribe@sourceware.org>
List-Post: <mailto:libc-ports@sourceware.org>
List-Help: <mailto:libc-ports-help@sourceware.org>, <http://sourceware.org/lists.html#faqs>
Sender: libc-ports-owner@sourceware.org
To: "Linas Vepstas (Code Aurora)" <linas@codeaurora.org>
Cc: GLIBC Devel <libc-alpha@sourceware.org>, Chris Metcalf <cmetcalf@tilera.com>, Jonas Bonn <jonas.bonn@gmail.com>, libc-ports@sourceware.org, linux-hexagon@vger.kernel.org, linux-arch@vger.kernel.org, Mark Salter <msalter@redhat.com>, Tobias Klauser <tklauser@distanz.ch>, Guan Xuetao <gxt@mprc.pku.edu.cn>
List-Id: linux-arch.vger.kernel.org

On Monday 22 August 2011 14:36:02 Linas Vepstas wrote:
>=20
> So: What's the latest on asm-generic support on glibc?=20
> I just pulled glibc-2.14 and note that Chris Metcalf's
> generic implementation hasn't been folded in yet.=20
> It seems to work well for me, so can we expect it
> anytime soon?
>=20
> Another problem:  If I don't define __ARCH_WANT_SYSCALL_DEPRECATED
> in the kernel asm/unistd.h  then glibc won't build: currently,
> I get=20
> ../sysdeps/unix/sysv/linux/getdents.c:105: error: =E2=80=98__NR_getdents=
=E2=80=99 undeclared (first use in this function)
>=20
> A very quick grep tells me that asm-generic defines a getdents64
> but that is not what glibc is looking for.  Is there any chance
> that there are glibc patches floating around somewhere that heal
> this and any remaining __ARCH_WANT_SYSCALL_DEPRECATED issues?

I don't know the answer to your question, but I've added Mark Salter,
Guan Xuetao and Tobias Klauser to the list, since they probably have
the same issue on c64x, unicore32 and nios2. c64x is currently nommu,
but there is a similar problem with uclibc and I expect that architecture
to grow an mmu at some point.

As far as I can tell, there is now a total of six architectures using
the generic syscalls (not counting s*core, because that relies on
the deprecated calls) and at least two unnamed ones waiting to have
their coming-out, plus a few stagnated ports (lm32, arc, mmix, meta, ...)
that would need to get converted if someone wanted to push kernel
support upstream.

	Arnd
