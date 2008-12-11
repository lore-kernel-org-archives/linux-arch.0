From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 13/19] mips: convert to generic init_task.c
Date: Thu, 11 Dec 2008 13:21:46 +0000
Message-ID: <20081211132146.GA17667@linux-mips.org>
References: <cover.1228966585.git.kyle@mcmartin.ca> <c89dc10c8a51d3f0f014dcdd86b70ef253b22710.1228966585.git.kyle@mcmartin.ca> <e7880c938229e333f2c0dbe34eee62257c159a5e.1228966585.git.kyle@mcmartin.ca> <200812111404.25597.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from h4.dl5rb.org.uk ([81.2.74.4]:45416 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755480AbYLKNWW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 11 Dec 2008 08:22:22 -0500
Content-Disposition: inline
In-Reply-To: <200812111404.25597.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kyle McMartin <kyle@mcmartin.ca>, linux-arch@vger.kernel.org, Kyle McMartin <kyle@redhat.com>

On Thu, Dec 11, 2008 at 02:04:25PM +0100, Arnd Bergmann wrote:

> On Thursday 11 December 2008, Kyle McMartin wrote:
> > - */
> > -union thread_union init_thread_union
> > -=A0=A0=A0=A0=A0=A0=A0__attribute__((__section__(".data.init_task")=
,
> > -=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __aligned__(THRE=
AD_SIZE))) =3D
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0{ INIT_THREAD_INFO(in=
it_task) };
> > -
>=20
> The __aligned__(THREAD_SIZE) is only present in sparc, mips and
> parisc (though the latter uses 128 byte align). I guess you
> verified that dropping it is ok for parisc, but is that also
> true for mips and sparc?

Duhh...  Good point.  The alignment is also enforced or at least should
be enforced in vmlinux.lds.S.  Which in case of MIPS

[...]
                . =3D ALIGN(_PAGE_SIZE);
                *(.data.init_task)
[...]

only enforces _PAGE_SIZE alignment and _PAGE_SIZE can be less than
THREAD_SIZE so removing the __aligned__ would have broken things.  Of
course that's a bug of the linker script not Kyle's patches.

  Ralf
