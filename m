From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic: Fix typo in asm-generic/unistd.h.
Date: Wed, 4 Nov 2009 10:28:11 +0100
Message-ID: <200911041028.12098.arnd@arndb.de>
References: <OFC90831A4.A99EC411-ON48257664.00080761-48257664.0009EC42@sunplusct.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:50554 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753259AbZKDJ2k (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 4 Nov 2009 04:28:40 -0500
In-Reply-To: <OFC90831A4.A99EC411-ON48257664.00080761-48257664.0009EC42@sunplusct.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, liqin.gnu@gmail.com, Greg KH <greg@kroah.com>

On Wednesday 04 November 2009, liqin.chen@sunplusct.com wrote:
> Arnd Bergmann <arnd@arndb.de> =D0=B4=D3=DA 2009-11-03 16:52:17:
>=20
> > Is there any reason to use glibc-2.5 though? The current release
> > is 2.10.1, and the version you used is over three years old.
>=20
> We found many stable toolchain use glibc-2.5. so we select it.
> In fact, what we think first is to could used it in product=A1=A3

It is unfortunately a common misunderstanding that older releases
that are currently used by others are more stable. The reason
you find glibc-2.5 in products today is that it was the current
version at the time when the development cycle for the product
was started.

In general, when you upgrade to a more recent version, the
best idea is to take the latest stable release, and stabilizing
on that for a given embedded product. By always using the latest
version, you can greatly reduce the amount of work needed for
each upgrade, and you get all improvements and bug fixes
automatically without having to backport them.

> Even linux kernel, in company we still use kernel-2.6.27 version.

Yes, that is good and expected, if that version has proven to be
stable for you.

Obviously you will have to do an update at some point and then
you can easily move to the latest kernel version since it is now
upstream.

I also expect that you have device driver code that is not yet
upstream. Getting that in should be a lot easier than the initial
architecture code and Greg KH can help you with his drivers/staging
infrastructure if you are interested.
 =20
> > Do you have plans to merge your port into eglibc when it's done?
>=20
> We have not this plan now.

I would recommend to look into this at some point in the future.
Unlike the main glibc project, eglibc[1] is specifically there for
supporting embedded architectures and already hosts ports for
other platforms that are not in glibc itself, while it closely
follows the main glibc development. Contributing there unfortunately
requires some paperwork for copyright assignment, but it's probably
worth it in the end.

You've done the right thing by merging your kernel code into the
official Linux tree, porting your glibc code to the lastest=20
snapshot and submitting it into eglibc is the next big step.

	Arnd <><

--
[1] http://www.eglibc.org/
