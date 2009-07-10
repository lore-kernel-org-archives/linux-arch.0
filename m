From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] score: add regsets support for score
Date: Fri, 10 Jul 2009 12:44:28 +0200
Message-ID: <200907101244.28829.arnd@arndb.de>
References: <OF46A53443.CAD32185-ON482575EF.0034F550-482575EF.0035E714@sunplusct.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:64136 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754824AbZGJKog (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2009 06:44:36 -0400
In-Reply-To: <OF46A53443.CAD32185-ON482575EF.0034F550-482575EF.0035E714@sunplusct.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com
Cc: Christoph Hellwig <hch@infradead.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Roland McGrath <roland@redhat.com>

On Friday 10 July 2009, liqin.chen@sunplusct.com wrote:
> Arnd Bergmann <arnd@arndb.de> =D0=B4=D3=DA 2009-07-09 23:08:54:
>=20
> > You still use an email client that breaks patches by adding line-wr=
aps.
> > Please use a different mail client for sending patches. You could f=
or
> > example use git-send-email with a random freemail account and still
> > set your corporate sender address.
>=20
> Sorry, our MIS haven't solved this problem yet,
> I have to used it until they fixed this bug.

What's the problem? Do you need a development machine with SMTP access =
to
the internet? If so, the easiest way would be to use master.kernel.org
once you have an account there and not rely on your company infrastruct=
ure.

I noticed that you have started using Thunderbird instead of Notes now.
While Thunderbird has the same bug, you can at least work around it,
see the section on thunderbird in
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
blob;f=3DDocumentation/email-clients.txt

OTOH, if you got thunderbird to send out your mails, you should
also be able to send out using git-send-email on the same server,
without any help from your MIS.

	Arnd <><
