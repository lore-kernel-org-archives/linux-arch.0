From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH] fs: add FD_CLOFORK and O_CLOFORK
Date: Sat, 07 May 2011 08:06:34 +0200
Message-ID: <1304748394.2821.654.camel@edumazet-laptop>
References: <1304743740-3405-1-git-send-email-xiaosuo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1304743740-3405-1-git-send-email-xiaosuo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Changli Gao <xiaosuo@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox <matthew@wil.cx>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Le samedi 07 mai 2011 =C3=A0 12:49 +0800, Changli Gao a =C3=A9crit :

> =20
>  	for (i =3D open_files; i !=3D 0; i--) {
>  		struct file *f =3D *old_fds++;
>  		if (f) {
> -			get_file(f);
> +			if (FD_ISSET(open_files - i, new_fdt->close_on_fork)) {
> +				FD_CLR(open_files - i, new_fdt->open_fds);
> +				f =3D NULL;
> +			} else {
> +				get_file(f);
> +			}
>  		} else {
>  			/*

You should change the main loop to

for (i =3D 0; i < open_files; i++) {
	struct file *f =3D *old_fds++;

	if (f && FD_ISSET(i, new_fdt->close_on_fork))
		f =3D NULL;
	if (f)
		get_file(f);
	else
		FD_CLR(i, new_fdt->open_fds)
	rcu_assign_pointer(*new_fds++, f);
}

BTW the rcu_assign_pointer() is not necessary here, since we are the
only thread populating new_fds at this point.

spin_unlock(&oldf->file_lock); and=20
rcu_assign_pointer(newf->fdt, new_fdt);
make sure once new_fds is visible to other threads, all our memory
writes are committed.

sparse even warns us ;)

fs/file.c:371:3: warning: incorrect type in assignment (different addre=
ss spaces)
fs/file.c:371:3:    expected struct file *<noident>
fs/file.c:371:3:    got struct file [noderef] <asn:4>*<noident>


I'll submit a patch in a separate thread
