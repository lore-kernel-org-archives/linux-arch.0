From: Bernd Petrovitsch <bernd@sysprog.at>
Subject: Re: [RFC][PATCH] introduce ptr_diff()
Date: Thu, 19 Aug 2010 18:04:49 +0200
Message-ID: <1282233889.10440.220.camel@thorin>
References: <1282217856-8625-1-git-send-email-namhyung@gmail.com>
	 <87aaoiu6z6.fsf@basil.nowhere.org>  <1282233186.1713.10.camel@leonhard>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:4800 "EHLO
	esgaroth.petrovitsch.priv.at" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751308Ab0HSQFC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 19 Aug 2010 12:05:02 -0400
In-Reply-To: <1282233186.1713.10.camel@leonhard>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Namhyung Kim <namhyung@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Fre, 2010-08-20 at 00:53 +0900, Namhyung Kim wrote:
> 2010-08-19 (=EB=AA=A9), 14:23 +0200, Andi Kleen:
> > IMHO it would be better to simply disable the warning in sparse ins=
tead
> > of uglying the code just to work around sparse bogosity. It doesnt'=
 seem
> > to make much sense. A subtraction followed by a shift is not expens=
ive.
[...]
> I'm curious who turns on that switch. -Wptr-subtraction-blows is turn=
ed
> off by default, I didn't use CF variable at build time and I could no=
t
> find any reference of it in the source tree. Hmm..

sparse also gets gcc's parameters which include (usually) "-Wall". And
this activates it.
Adding -Wno-ptr-subtraction-blows to CHECKFLAGS should do the trick.

	Bernd
--=20
mobile: +43 664 4416156              http://www.sysprog.at/
    Linux Software Development, Consulting and Services
