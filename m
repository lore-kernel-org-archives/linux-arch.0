From: Changli Gao <xiaosuo@gmail.com>
Subject: Re: [PATCH] fs: add FD_CLOFORK and O_CLOFORK
Date: Sat, 7 May 2011 14:22:33 +0800
Message-ID: <BANLkTi=tZf1uQig8A-WiXUpSWcuqaqV=fg@mail.gmail.com>
References: <1304743740-3405-1-git-send-email-xiaosuo@gmail.com> <1304748394.2821.654.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-px0-f173.google.com ([209.85.212.173]:59975 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505Ab1EGGWx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 7 May 2011 02:22:53 -0400
In-Reply-To: <1304748394.2821.654.camel@edumazet-laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox <matthew@wil.cx>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Sat, May 7, 2011 at 2:06 PM, Eric Dumazet <eric.dumazet@gmail.com> w=
rote:
> Le samedi 07 mai 2011 =E0 12:49 +0800, Changli Gao a =E9crit :
>
>>
>> =A0 =A0 =A0 for (i =3D open_files; i !=3D 0; i--) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct file *f =3D *old_fds++;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (f) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_file(f);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (FD_ISSET(open_files - =
i, new_fdt->close_on_fork)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FD_CLR(ope=
n_files - i, new_fdt->open_fds);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 f =3D NULL=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_file(f=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>
> You should change the main loop to
>
> for (i =3D 0; i < open_files; i++) {
> =A0 =A0 =A0 =A0struct file *f =3D *old_fds++;
>
> =A0 =A0 =A0 =A0if (f && FD_ISSET(i, new_fdt->close_on_fork))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0f =3D NULL;
> =A0 =A0 =A0 =A0if (f)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0get_file(f);
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0FD_CLR(i, new_fdt->open_fds)
> =A0 =A0 =A0 =A0rcu_assign_pointer(*new_fds++, f);
> }

It seems more clear. Thanks.

BTW: I will work on F_CLOSFD after this patch accepted. It is useful
to close all the opened file descriptors when programing a daemon.

--=20
Regards,
Changli Gao(xiaosuo@gmail.com)
