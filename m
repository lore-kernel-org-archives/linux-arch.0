From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] optimize 64-by-32 ddivision for constant divisors on 32-bit machines
Date: Fri, 20 Nov 2015 13:27:26 +0100
Message-ID: <4208584.1csaaiK5v3@wuerfel>
References: <alpine.LFD.2.20.1511161710270.5826@knanqh.ubzr> <3830931.6tMHPeiNRU@wuerfel> <alpine.LFD.2.20.1511191920470.22569@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:61209 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760013AbbKTM1b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 Nov 2015 07:27:31 -0500
In-Reply-To: <alpine.LFD.2.20.1511191920470.22569@knanqh.ubzr>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 19 November 2015 19:29:33 Nicolas Pitre wrote:
> On Thu, 19 Nov 2015, Arnd Bergmann wrote:
>=20
> > On Monday 16 November 2015 20:20:38 Nicolas Pitre wrote:
> > > Arnd,
> > >=20
> > > Please pull the following branch:
> > >=20
> > >     git://git.linaro.org/people/nicolas.pitre/linux div64
> >=20
> > Pulled into my asm-generic tree now, it should show up in linux-nex=
t
> > tomorrow.
>=20
> Thanks.
>=20
> I removed a small optimization from the top commit that was included =
by=20
> mistake into a patch that was supposed to produce identical code=20
> (noticed by M=E5ns). It's not urgent but it would be good if you coul=
d=20
> repull at some point.

I already applied another patch on top, could you send a relative
patch instead? If that ends up being ugly, I can redo the branch,
but I generally prefer to not rebase things I have on kernel.org that I
plan to send to Linus.

	Arnd
