From: Changli Gao <xiaosuo@gmail.com>
Subject: Re: [PATCH] fs: add FD_CLOFORK and O_CLOFORK
Date: Sat, 7 May 2011 18:10:23 +0800
Message-ID: <BANLkTimMAhp42bWsogL49W7LqOLzAsiaig@mail.gmail.com>
References: <1304743740-3405-1-git-send-email-xiaosuo@gmail.com>
 <1304748394.2821.654.camel@edumazet-laptop> <BANLkTi=tZf1uQig8A-WiXUpSWcuqaqV=fg@mail.gmail.com>
 <1304749754.2821.712.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:46709 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754097Ab1EGKKn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 7 May 2011 06:10:43 -0400
In-Reply-To: <1304749754.2821.712.camel@edumazet-laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox <matthew@wil.cx>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Sat, May 7, 2011 at 2:29 PM, Eric Dumazet <eric.dumazet@gmail.com> w=
rote:
> Le samedi 07 mai 2011 =E0 14:22 +0800, Changli Gao a =E9crit :
>
>> It seems more clear. Thanks.
>>
>> BTW: I will work on F_CLOSFD after this patch accepted. It is useful
>> to close all the opened file descriptors when programing a daemon.
>>
>
> I am sure the following idea already was discussed in the past :
>
> Embed the close_on_exec / close_on_close bits in the low order bits o=
f
> file pointers.
>
> Might be interesting to raise it again.
>
>

Excellent idea! Thanks.

--=20
Regards,
Changli Gao(xiaosuo@gmail.com)
