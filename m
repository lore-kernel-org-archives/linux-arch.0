From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 08/27] asm-generic: add generic versions of common headers
Date: Thu, 30 Apr 2009 19:34:58 +0200
Message-ID: <200904301934.59415.arnd@arndb.de>
References: <200904301849.45543.arnd@arndb.de> <200904301907.46515.arnd@arndb.de> <20090430.101231.27030060.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:62259 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933447AbZD3RgG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 30 Apr 2009 13:36:06 -0400
In-Reply-To: <20090430.101231.27030060.davem@davemloft.net>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org, monstr@monstr.eu, remis.developer@googlemail.com, linux-kernel@vger.kernel.org

On Thursday 30 April 2009, David Miller wrote:
> You didn't read what I said.
>=20
> I extract the commit messages and patches using "git format-patch"
> merely as a formality, then I hand craft every aspect of the emails.

Right, this is what I do for smaller sets of patches, but I was
hoping for something slightly simpler when sending out my 27 (plus
the previous 18) patches.

> I never put "Date:" fields into the message body, that's rediculiousl=
y
> stupid. =A0And it confuses patchwork as well. =A0Just say NO.

Right, fair enough. I figured it wouldn't hurt to have the date in the
body because git-am can deal with it, but of course the problem was
the wrong date in the header.

	Arnd <><
