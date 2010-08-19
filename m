From: Namhyung Kim <namhyung@gmail.com>
Subject: Re: [RFC][PATCH] introduce ptr_diff()
Date: Fri, 20 Aug 2010 00:53:06 +0900
Message-ID: <1282233186.1713.10.camel@leonhard>
References: <1282217856-8625-1-git-send-email-namhyung@gmail.com>
	 <87aaoiu6z6.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:50946 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445Ab0HSPxK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Aug 2010 11:53:10 -0400
In-Reply-To: <87aaoiu6z6.fsf@basil.nowhere.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

2010-08-19 (=EB=AA=A9), 14:23 +0200, Andi Kleen:
> IMHO it would be better to simply disable the warning in sparse inste=
ad
> of uglying the code just to work around sparse bogosity. It doesnt' s=
eem
> to make much sense. A subtraction followed by a shift is not expensiv=
e.
>=20
> -Andi
>=20

I'm curious who turns on that switch. -Wptr-subtraction-blows is turned
off by default, I didn't use CF variable at build time and I could not
find any reference of it in the source tree. Hmm..

--=20
Regards,
Namhyung Kim
