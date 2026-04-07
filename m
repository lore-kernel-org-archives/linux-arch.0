Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2A930FC1D
	for <linux-arch@vger.kernel.org>; Tue,  7 Apr 2026 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775552432; cv=pass; b=cdEDAgB7WGYgA+Im7BlRZdmAcfBS4ZJa7qlpWq0rMx4AoZUyyMgVzGJekqOwaltesiTg/DfZx2QZtBikUQtAWiQsB8FkquUE6T5QZDjARrpEjdC6l2/ryc0heaLY/3IUkv8VI4BfRyYsccywt7ybGLCyi21vdF2pXJ5pOJxEECg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775552432; c=relaxed/simple;
	bh=/qHCexAei7RF7p2L9Y8baQacw83HsvWaoqQzNumxOc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QmJWT7B+/GKNT94YX5IxnMFk6zxbnr4s5j+b6+cnlozmwcVFIcZrAfsShQS7MSs9699yw/ESnV2qav4NxKTEEi7221JxbmmQay8EPU93mFZd7ih69uiQuMOykfoydnEDFXoIlak36ZM/8hMMVsc7DAtvRnVceeW1lqgpF3Zei1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWl/6TbX; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWl/6TbX"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-65c4152313fso6301032a12.1
        for <linux-arch@vger.kernel.org>; Tue, 07 Apr 2026 02:00:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775552429; cv=none;
        d=google.com; s=arc-20240605;
        b=CP6/tajgSYEbEXveHIrstLq/fz8GyPU3+zJuqKk7NaLTUz7lfR6tkJr04AdW3dNuu2
         8qdgNbwhBZ3FFA5BftyzZPZu5RwVV8RN1nSs7a09fQWRezyHdMdPC48gazGREflR5/h8
         tRdpNgGf+HOm9zaL0eX4xThhtZQTVGxM9DDrvYMI8w6S2fxsibe3isF+erYpFxRfEdFz
         yxZFeo21Dajm6tIyckALqNjGLUdDmrhzu4xoirUnYewDJTAcz496Gg+9iCiG1EUC7cva
         yofoj0xYl8FGrrh/dqbuyHq9Z5wD0V1MCypma4GYnDd7kPqloHVoO6+YjoD3vNS31HPG
         gIuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FFOsIxaJz5dSO/KiouzcRuRQBGo6Ioal7l5wuulXe+0=;
        fh=vqgV+vNFaWfYiz/42rK4f4XV7Mnawp5ULWPmyZm53I8=;
        b=KQnGaUSRozdSDwho/20yxZBjzBcml7PCfaTqUc1fxQjaRqw936F5284yowf206i0FS
         kr5t/LkC7qHukFe0ytm438WEpuE5dM+F5kRJvQe3tXmleGCIxOy76pFg3hqaMysVbqE8
         l23Ry4yHKAOJPTJGfOdxPtyA559KXsjDt1ZaAl1vr8kfmb+wtub28in0vEnpQGD4nF1t
         /+4yIY7XEf3vkRwIOlTyxXO7PSzozuZVB5JfFO6CZuOAgVJC7igCyMu8mgEA+HIJ3qRN
         xJhTtf0bOdYT5ygbRbYfk5nLFTibvF7sBsWr+r/E+kQ99risFEDjEvPybAT/OUCAF6WF
         wuxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775552429; x=1776157229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFOsIxaJz5dSO/KiouzcRuRQBGo6Ioal7l5wuulXe+0=;
        b=jWl/6TbXsKsAwDhGUGza9pOYYIBVHnidqHYZTBVdaNbTX9ME5XX/rm4v363GU9j5K9
         KQG4134uovS+P/PiXTyazoN4TumiD86pUuTXHVfHLjW+BvVwQFtqhDsA/IXvSTprjNXy
         7edCAZE7Pcl+1sP3Lh2g8/2CIzpzt8dAQFQCCpR1jDYvr4DdCtfAt6Sc417uB2zBWwPS
         58Mzjh+JRCtXrk7IcDCzUxowbPgOQvdHzZS+C4vX2WgMl/J+R0D07WkC+s8Ihx8hDnb1
         yeCkZ3wUBgrS7mqij9tHcusixgBsVpQL6ov3Sp12bckyj0tzmEIvLv8aOz7RpkXCJ0lV
         HjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775552429; x=1776157229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FFOsIxaJz5dSO/KiouzcRuRQBGo6Ioal7l5wuulXe+0=;
        b=lFKV7YAh4ow1rome6ZCvh7Rb2TZ2GtnViDtWawZqY0trU/wFv9oZbg7I+5Ncmm1qiX
         SMKsT4zHkc+9MjOe0toOM3CLzupgZeyAnFgiKjkHLHhXOqTuqbEHOZ26EWcU41MKNrZW
         nEq0p3SQy9VP6HftQtmFjUJh4YzeCs05Cr7sXHSJ6a2JNn0CwAJEk6YipEODB0o6SNOx
         wqBZpUjIPjDLLjG9zKder/K2P9wQ+EdYrQgTvaoPrJgPjwPwhfoUD8yUechEJ2q6uRnj
         tuc6k01qTJioTypxO43WJOW8Z4HiHg5NhYYsmp0AjlrCpENHa+mcFkDVUCtq6GbuZIAS
         Xfeg==
X-Forwarded-Encrypted: i=1; AJvYcCVTcnxv+3f+wAvQVdCWmvXE6+3IjVvDk/uERk/KIKVakajRS+4+q9pJJPEAUxOS+p2sz/YfM/vtf32i@vger.kernel.org
X-Gm-Message-State: AOJu0YwFtcJTRZWlw+YebF7FCnIsNxrJXUZZw1So28e8gJm4///Xd6Y5
	5Tcb2cyz1MHjYr0AjsLGwU4U0d35piwxiqo1pKxGfPCh3IsRGEyzjkeTr+fwYVeNGOa/wGp1Rfp
	dbH/1khGSDEzUcK4Lulc1baWKMyTVH0A=
X-Gm-Gg: AeBDieugY+OND2yYAKAwdKHyDSF453zbk0mpFBrJJR84i92pMGhgHEnX8Qg6IjgSoER
	emlOAxMcGdLAxFDQALEvQ72VY7KG9ecbwXfMVvVTP1mmJ++qp6kmADAJDTBR6ZhgBfB879mnuri
	Z5deyMTotftMr2vCNb4IQI68wwaZ90x51HIAdCbjsDxyvG2TPF6aAm7R2mDAJSbZeP28RuPaSHd
	4aB712gnrKFqp16kaqqZUgGyVdcuII3x5JH4cWOO93b+ZSQ/L3i/EvbVFAw07DgE9KZ7t0MPyEG
	lN1OCPFPlGnK+fcLWVLxwmAKDT5m670OoVDFfQFvwlDeTazHYQ==
X-Received: by 2002:a05:6402:354f:b0:66e:6ff8:58ea with SMTP id
 4fb4d7f45d1cf-66e6ff85a1cmr5384406a12.4.1775552428473; Tue, 07 Apr 2026
 02:00:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331172011.3512876-1-jkoolstra@xs4all.nl> <20260331172011.3512876-2-jkoolstra@xs4all.nl>
 <pbobkjhtuli53o3z34ajyxztaosmztwlygxfxhhjq5ajt47inc@ngtoge3ucdm5> <1632825771.784338.1775039101736@kpc.webmail.kpnmail.nl>
In-Reply-To: <1632825771.784338.1775039101736@kpc.webmail.kpnmail.nl>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 7 Apr 2026 11:00:15 +0200
X-Gm-Features: AQROBzCSqaG2KiYg9FZOSa8vXjApBFJDEWda_0GT-r0h8fSgpilsGWZjwPwtzvA
Message-ID: <CAGudoHE-zSfiL2aVf41UHOtMsE53gCqLpVoy-NxoB8HeXtdgEA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] vfs: syscalls: add mkdirat_fd()
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Alexander Aring <alex.aring@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Andrey Albershteyn <aalbersh@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, cmirabil@redhat.com, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 12:25=E2=80=AFPM Jori Koolstra <jkoolstra@xs4all.nl>=
 wrote:
>
>
> > Op 01-04-2026 06:19 CEST schreef Mateusz Guzik <mjguzik@gmail.com>:
> >
> >
> > On Tue, Mar 31, 2026 at 07:19:58PM +0200, Jori Koolstra wrote:
> > > @@ -5286,7 +5290,25 @@ int filename_mkdirat(int dfd, struct filename =
*name, umode_t mode)
> > >             lookup_flags |=3D LOOKUP_REVAL;
> > >             goto retry;
> > >     }
> > > +
> > > +   if (!error && (flags & MKDIRAT_FD_NEED_FD)) {
> > > +           struct path new_path =3D { .mnt =3D path.mnt, .dentry =3D=
 dentry };
> > > +           error =3D FD_ADD(0, dentry_open(&new_path, O_DIRECTORY, c=
urrent_cred()));
> > > +   }
> > > +   end_creating_path(&path, dentry);
> > >     return error;
> >
> >
> > You can't do it like this. Should it turn out no fd can be allocated,
> > the entire thing is going to error out while keeping the newly created
> > directory behind. You need to allocate the fd first, then do the hard
> > work, and only then fd_install and or free the fd. The FD_ADD machinery
> > can probably still be used provided proper wrapping of the real new
> > mkdir.
>
> But isn't this exactly what happens in open(O_CREAT) too? Eventually we
> call
>                 error =3D dir_inode->i_op->create(idmap, dir_inode, dentr=
y,
>                                                 mode, open_flag & O_EXCL)=
;
>
> and only then do we assign and install the fd. AFAIK there is no cleanup
> happening there either if the FD_ADD step fails. You will just have a
> regular file and no descriptor. But I would have to test this to be sure.
>

FD_ADD(how->flags, do_file_open(dfd, name, &op)) means fd itself will
be allocated upfront and only then file creation will happen and which
is what I'm saying is how it should be done. With your patch the
directory is created first and the possibly failing fd allocation
happens later.

> >
> > On top of that similarly to what other people mentioned the new syscall
> > will definitely want to support O_CLOEXEC and probably other flags down
> > the line.
> >
>
> I agree, and perhaps O_PATH too. Maybe just all open flags relevant to
> directories?
>

I don't know about O_PATH as is, but certainly the syscall needs to be
able to grab more flags in the future.

> > Trying to handle this in open() is a no-go. openat2 is rather
> > problematic.
>
> I don't think that is necessarily true. It turned out O_CREAT | O_DIRECTO=
RY
> was bugged for a very long time. Christian Brauner fixed it eventually, a=
nd
> that combination now returns EINVAL. But I think there is nothing really
> stopping us from implementing that combination in the expected way, apart
> from whatever reasons there were for not allowing this in the first place=
,
> which I don't know about (maybe mixing semantics?)
>

I am not saying it's impossible. I am saying mkdir was always a
separate codepath and in order to change that you would need to add a
branchfest to open. I don't see any reason to go that route.
