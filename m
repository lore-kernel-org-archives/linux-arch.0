From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH] fs: add FD_CLOFORK and O_CLOFORK
Date: Sat, 07 May 2011 07:25:45 +0200
Message-ID: <1304745945.2821.601.camel@edumazet-laptop>
References: <1304743740-3405-1-git-send-email-xiaosuo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1304743740-3405-1-git-send-email-xiaosuo@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Changli Gao <xiaosuo@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox <matthew@wil.cx>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Le samedi 07 mai 2011 =C3=A0 12:49 +0800, Changli Gao a =C3=A9crit :
> If FD_CLOFORK is 1, when a fork occurs, the corresponding file descri=
ptor
> will be closed for the child process. IOW, the file descriptor isn't
> inheritable.
>=20
> FD_CLOFORK is used as IBM does.

Is it part of a standard, and what could be the use for such thing ?
Why had we wait 2011 to add it in linux ?

>=20
> O_CLOFORK is also added to avoid the additional fcntl(2) after open(2=
).
>=20
> Signed-off-by: Changli Gao <xiaosuo@gmail.com>


Your implementation has some peformance implication.

close_on_exec and close_on_fork bit for a given fd would be on separate
cache lines. So you add a cost on threaded programs for open()/close()

[ Yes, we apparently clear close_on_exec bit in close()... we could let
it untouched and make flush_old_files() aware of that ]



--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
