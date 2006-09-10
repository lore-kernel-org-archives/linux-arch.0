Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.183]:5370 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932180AbWIJWTI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 10 Sep 2006 18:19:08 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFC]: New termios take 2
Date: Mon, 11 Sep 2006 00:19:01 +0200
References: <1157472883.9018.79.camel@localhost.localdomain> <1157887240.2977.147.camel@pmac.infradead.org> <1157891081.23085.1.camel@localhost.localdomain>
In-Reply-To: <1157891081.23085.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609110019.01568.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Am Sunday 10 September 2006 14:24 schrieb Alan Cox:
> > But I don't think it's realistic to suggest that C libraries should be
> > built without access to our asm/term{bit,io}s.h at all. However, I'm
> > only really responsible for the new export _mechanism_ -- I'm not going
> > to impose policy except when people like Andi do stupid things and
> > sneakily send private patches to undo fixes I've already made.
>
> glibc needs them, nobody else does.

strace also needs all ioctl numbers.

	Arnd <><
