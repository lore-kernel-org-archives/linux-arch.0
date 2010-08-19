From: Namhyung Kim <namhyung@gmail.com>
Subject: Re: [RFC][PATCH] introduce ptr_diff()
Date: Fri, 20 Aug 2010 01:12:22 +0900
Message-ID: <1282234342.1713.11.camel@leonhard>
References: <1282217856-8625-1-git-send-email-namhyung@gmail.com>
	 <87aaoiu6z6.fsf@basil.nowhere.org>  <1282233186.1713.10.camel@leonhard>
	 <1282233889.10440.220.camel@thorin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:54662 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388Ab0HSQM3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Aug 2010 12:12:29 -0400
In-Reply-To: <1282233889.10440.220.camel@thorin>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bernd Petrovitsch <bernd@sysprog.at>
Cc: Andi Kleen <andi@firstfloor.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

2010-08-19 (=EB=AA=A9), 18:04 +0200, Bernd Petrovitsch:
> sparse also gets gcc's parameters which include (usually) "-Wall". An=
d
> this activates it.
> Adding -Wno-ptr-subtraction-blows to CHECKFLAGS should do the trick.
>=20
> 	Bernd

I see. thanks for the info. :-)

--=20
Regards,
Namhyung Kim
