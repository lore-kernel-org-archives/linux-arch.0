From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: microblaze syscall list
Date: Mon, 5 May 2008 00:54:19 +0200
Message-ID: <200805050054.20903.arnd@arndb.de>
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com> <481D7DF7.3000909@seznam.cz> <481E3433.2030408@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:60935 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887AbYEDWyx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 4 May 2008 18:54:53 -0400
In-Reply-To: <481E3433.2030408@zytor.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: monstr@seznam.cz, microblaze-uclinux@itee.uq.edu.au, Matthew Wilcox <matthew@wil.cx>, Will Newton <will.newton@gmail.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, git@xilinx.com, John Williams <john.williams@petalogix.com>, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>, John Linn <John.Linn@xilinx.com>

On Monday 05 May 2008, H. Peter Anvin wrote:
> Michal Simek wrote:
> > /* fs/select.c */
> > =A0=A0=A0=A0=A0=A0.long sys_select /* obsolete -> sys_pselect6 */
> > ok=A0=A0=A0=A0.long sys_pselect7
> > =A0=A0=A0=A0=A0=A0.long sys_pselect6 /* obsolete -> sys_pselect7 */
>=20
> I thought there was some semantic differences between select() and=20
> pselect()... perhaps those changes have been removed?

According to the main page, there are three differences:

* POSIX pselect does not update the timeout argument, but linux pselect=
7
does, so it's easy to implement both pselect and select based on it.
* pselect also has a timespec arguement, not timeval as select, but tha=
t's
trivial to convert.
* pselect obviously takes an extra argument, but if that's NULL, it wil=
l
behave like select (aside from the timeout handling).

	Arnd <><
