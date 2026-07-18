Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B20347529
	for <linux-arch@vger.kernel.org>; Sat, 18 Jul 2026 19:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784403596; cv=none; b=HS2kCwisECeJJmXgsg5vlTpw8MIaTW7HMBlR7VWmRv9Du9Q684HSFIprmg0h6TlZ3UaebOFqj8V7/5RM2tbx8/isOXubL3ojHZHJF/lM29OIIPDD5MageMnodR9lHQaKovGKv/J1OnNzFfd588E85RnuaL/R+FZvIxXw+oCeDTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784403596; c=relaxed/simple;
	bh=6HZvEfa/Gg3qLeLXrnqD8wi1HgmNRFlhLvjoQECOQhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wbf8K7wl6NYK8jnHW/FlvxJY7qKInTJFQHidVhEMMCMT6mJB6ZhjLs1biI2ucolhNkGuwdQsYCnAX4Md+wZGMNJ2yrK5br9Oz8UOroIqVAZZwhilEADMqwCP1OlGelGSWvuSy8gUyKcPeQMpODB8s9DPu/yOWLRO1TIQ4Oi0j/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXFoECaa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXFoECaa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D0B1F00A3D
	for <linux-arch@vger.kernel.org>; Sat, 18 Jul 2026 19:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784403595;
	bh=wnjvK5TogWv++ZaSJX8JOOWJ2YLUTBtBygq2xMyDmVY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YXFoECaacun/jaKD9YJK/RDb2bx2UGSkQgbv+oPOZR/fKVj9hSIQRMeKqEg/25+8n
	 iXSuKUj6VjAl+QPDDDmgjswAEAAPCC3e/uZST+YDGXB0xHA9QNYArWmwziUmwPjUX+
	 qoGlnIr1DLGt89IvrP/5rlp8f0N0jMSE1Yi3okED8RdB5YBnLXTWpl0HSuB8VMFjb/
	 g46BHiEjranCHq/Aae0ve3gwP39RImq9h+6xOWNKxy6h9pxVhISglXEqiED+nRLLo6
	 sFMXvp0Jm1ORo6EN8LkLrKK7EAzKfEE5R9bY2fVE3nabU4h4jtWzRwql04RkFYALC9
	 f16fUl4kt3NvA==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39c95395230so45651731fa.2
        for <linux-arch@vger.kernel.org>; Sat, 18 Jul 2026 12:39:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro2/0QwZxggwf1E1WjrtJNYKpzOUMlglpUVZcPr1XMJA/JczCS3UEPp0q3v8KQivt4sF483yxAY9ItI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6qUO3RZ1ityhJ3BKGWQXICuUBZrLPX0N4fjm7/mPTncqmNiKW
	4T+tSLZHJ+MOK30nGtKZnVnFaPcBXDX2u+Yl823sk3uRkKFI1mCyVuChLEAYkc/X6mC2L3dzE5h
	dUNi+lfDpFKFCSNKc3CPjDKqzByN9QBMXOagOd9b2
X-Received: by 2002:a05:6512:318c:b0:5ae:b7d4:7dd7 with SMTP id
 2adb3069b0e04-5b28f879e58mr1729092e87.24.1784403593038; Sat, 18 Jul 2026
 12:39:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com>
 <20260629-hauer-erhitzen-sobald-96d3dff68707@brauner> <CALCETrVuh0-biOw=TgYN9ERTFAoiki57XeZ3S2T3dO2+hL54gA@mail.gmail.com>
 <20260702-entladen-farbkombinationen-klarheit-fe24cb608f23@brauner> <20260706-dabei-radeln-glitzer-71ecb835029c@brauner>
In-Reply-To: <20260706-dabei-radeln-glitzer-71ecb835029c@brauner>
From: Andy Lutomirski <luto@kernel.org>
Date: Sat, 18 Jul 2026 12:39:39 -0700
X-Gmail-Original-Message-ID: <CALCETrVjDtBmB+boCUgd069UpZGUB1TCbEn3k1HZQex-_dPgbQ@mail.gmail.com>
X-Gm-Features: AUfX_mwi8E7EX3ucsAKoGp35lnBZlX3ZZXeZYq3-vf-ZNEwzMurGVJdsjLAABDE
Message-ID: <CALCETrVjDtBmB+boCUgd069UpZGUB1TCbEn3k1HZQex-_dPgbQ@mail.gmail.com>
Subject: Re: [RFC] Null Namespaces
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>, 
	John Ericson <mail@johnericson.me>, Li Chen <me@linux.beauty>, Cong Wang <cwang@multikernel.io>, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Kees Cook <kees@kernel.org>, Sergei Zimmerman <sergei@zimmerman.foo>, 
	Farid Zakaria <farid.m.zakaria@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 8:31=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Thu, Jul 02, 2026 at 11:34:01AM +0200, Christian Brauner wrote:
> > On Mon, Jun 29, 2026 at 02:06:55PM -0700, Andy Lutomirski wrote:
> > > On Mon, Jun 29, 2026 at 4:45=E2=80=AFAM Christian Brauner <brauner@ke=
rnel.org> wrote:
> > > >
> > >
> > > > But I guess the even simpler model would be to copy what I've been =
doing
> > > > for pidfs:
> > > >
> > > > +static struct path nullfs_root_path =3D {};
> > > > +
> > > > +void nullfs_get_root(struct path *path)
> > > > +{
> > > > +       *path =3D nullfs_root_path;
> > > > +       path_get(path);
> > > > +}
> > > > +
> > > >  static void __init init_mount_tree(void)
> > > >  {
> > > >         struct vfsmount *mnt, *nullfs_mnt;
> > > > @@ -6209,6 +6217,8 @@ static void __init init_mount_tree(void)
> > > >         /* Mount mutable rootfs on top of nullfs. */
> > > >         root.mnt                =3D nullfs_mnt;
> > > >         root.dentry             =3D nullfs_mnt->mnt_root;
> > > > +       nullfs_root_path.mnt    =3D nullfs_mnt;
> > > > +       pidfs_root_path.dentry  =3D nullfs_mnt->mnt_root;
> > > >
> > > >         LOCK_MOUNT_EXACT(mp, &root);
> > > >         if (unlikely(IS_ERR(mp.parent)))
> > > > diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.=
h
> > > > index aadfbf6e0cb3..f55c87c70b78 100644
> > > > --- a/include/uapi/linux/fcntl.h
> > > > +++ b/include/uapi/linux/fcntl.h
> > > > @@ -124,6 +124,7 @@ struct delegation {
> > > >
> > > >  #define FD_PIDFS_ROOT                  -10002 /* Root of the pidfs=
 filesystem */
> > > >  #define FD_NSFS_ROOT                   -10003 /* Root of the nsfs =
filesystem */
> > > > +#define FD_NULLFS_ROOT                 -10004 /* Root of the nullf=
s filesystem */
> > > >  #define FD_INVALID                     -10009 /* Invalid file desc=
riptor: -10000 - EBADF =3D -10009 */
> > > >
> > > >  /* Generic flags for the *at(2) family of syscalls. */
> > > >
> > > > we then add fchroot() (overdue anyway) and then teach both fchdir()=
 and
> > > > fchroot() to honor FD_NULLFS_ROOT. Then a process may shed its fs s=
tate
> > > > and move itself into nullfs. Restrict *chdir() and *chroot() for sa=
id
> > > > process via seccomp and it's locked in forever as well.
> > > >
> > >
> > > One thing comes to mind that might need a bit of care: this would giv=
e
> > > an API for any task to get an fd to a directory that lives in the ini=
t
> > > mount namespace.  It's not at all obvious to me that this is dangerou=
s
> > > or even observable (you're not about to find a setuid program in
> > > nullfs), but I think it's at least worth a tiny bit of consideration.
> >
> > Yes, I thought about this as well. But it doesn't have to be this way.
> > Every mount namespaces has nullfs as it's root ever since I introduced
> > it. Which means FD_NULLFS_ROOT can also just mean "nullfs within that
> > specific mount namespace". That's fine.
> >
> > For my FD_FAILFS_ROOT proposal it would be enough if we make failfs
> > SB_KERNMOUNT which means it's logically distinct from every mount
> > namespace. I think that might be the right thing to do. I need to spend
> > one or more brain cycles on this though.
>
> I had to take a long drive on Sunday and I kept thinking about both
> FD_NULLFS_ROOT and FD_FAILFS_ROOT and ofc there are some things to
> consider/discuss.
>
> I think the straightforward solution to FD_NULLFS_ROOT would be to just:
>
> - make it always available
> - refer to the caller's mount namespace nullfs
> - work with fchroot()/fchdir()
>
> So I considered two chroot() use-cases for the sake of simplicity:
>
> (1) You want to isolate yourself for the sake of lookup
>
> (2) You want to isolate yourself to assemble a "private mount tree" but
>     not really be in a separate namespace (very odd use-case... but it
>     helps to make a point).
>
> The problem with this approach is that everyone who chroots into the
> nullfs root would suffer from the problem that any mount on top of it is
> still visible. So that kinda makes it pointless for both (1) and (2).
>
> Also all mounts that someone else would do would also be visible
> allowing multiple chroot()ers to affect each others state. That also
> would somewhat defeat the purpose of the chroot(). So I'm not convinced
> this is what we should do.
>

After some contemplation and a long place flight: are we talking about
nullfs or failfs?  Because I would expect that it's entirely
impossible to mount anything on top of failfs.  So failfs would be
useless for #2 but would still solve #1.

--Andy
