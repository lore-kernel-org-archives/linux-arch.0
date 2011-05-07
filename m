From: Changli Gao <xiaosuo@gmail.com>
Subject: Re: [PATCH] fs: add FD_CLOFORK and O_CLOFORK
Date: Sat, 7 May 2011 18:09:22 +0800
Message-ID: <BANLkTinAT5Wa5-_N1HPST4dv7TM=m+NAfA@mail.gmail.com>
References: <1304743740-3405-1-git-send-email-xiaosuo@gmail.com> <1304745945.2821.601.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44410 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753948Ab1EGKJm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 7 May 2011 06:09:42 -0400
In-Reply-To: <1304745945.2821.601.camel@edumazet-laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox <matthew@wil.cx>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Sat, May 7, 2011 at 1:25 PM, Eric Dumazet <eric.dumazet@gmail.com> w=
rote:
> Le samedi 07 mai 2011 =E0 12:49 +0800, Changli Gao a =E9crit :
>> If FD_CLOFORK is 1, when a fork occurs, the corresponding file descr=
iptor
>> will be closed for the child process. IOW, the file descriptor isn't
>> inheritable.
>>
>> FD_CLOFORK is used as IBM does.
>
> Is it part of a standard, and what could be the use for such thing ?
> Why had we wait 2011 to add it in linux ?
>

It isn't part of any standard. It can be used in multi-process
programs, which don't want the child processes inherit some file
descriptors. Here is a basic server program.

serv_sock =3D socket(...);
bind(serv_sock, ...);
listen(serv_sock, ...);
fcntl(serv_sock, F_SETFD, FD_CLOFORK);
while (1) {
   clnt_sock =3D accept(serv_sock);
   switch (fork()) {
   case 0:
      exit(do_serv(clnt_sock));
   default:
      break;
   }
}

This flag can also been used instead of FD_CLOEXEC in the exec(2)
after fork(2) environment. As no such file descriptors is duplicated
between fork(2) and exec(2), the later close(2) in kernel won't be
needed when exec(2). It can improve the performance.

Thanks.

--=20
Regards,
Changli Gao(xiaosuo@gmail.com)
