From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH] fs: add FD_CLOFORK and O_CLOFORK
Date: Sat, 07 May 2011 08:29:14 +0200
Message-ID: <1304749754.2821.712.camel@edumazet-laptop>
References: <1304743740-3405-1-git-send-email-xiaosuo@gmail.com>
	 <1304748394.2821.654.camel@edumazet-laptop>
	 <BANLkTi=tZf1uQig8A-WiXUpSWcuqaqV=fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:32835 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159Ab1EGG3U (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 7 May 2011 02:29:20 -0400
In-Reply-To: <BANLkTi=tZf1uQig8A-WiXUpSWcuqaqV=fg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Changli Gao <xiaosuo@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox <matthew@wil.cx>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Le samedi 07 mai 2011 =C3=A0 14:22 +0800, Changli Gao a =C3=A9crit :

> It seems more clear. Thanks.
>=20
> BTW: I will work on F_CLOSFD after this patch accepted. It is useful
> to close all the opened file descriptors when programing a daemon.
>=20

I am sure the following idea already was discussed in the past :

Embed the close_on_exec / close_on_close bits in the low order bits of
file pointers.

Might be interesting to raise it again.
