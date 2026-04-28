Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B265394462
	for <linux-arch@vger.kernel.org>; Tue, 28 Apr 2026 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777387164; cv=pass; b=ID1VDbx/k48OUOSTTUWoNqeueirMTYkhBfFaRmExPJ77cC+fUBOAWFfIfhUWWg3jNxhC2MIriexWiSSkvpkYZSt+SNbsFuujHnAxvRbIfjjzN6imS9xpN3l96c7OqiRpDCqnriOAnNiJnryObSZ111xsgMynGaBM1OQLknKOym0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777387164; c=relaxed/simple;
	bh=o5yp/O/UpJT2rk9hPW1wx6A8M3OZah1AeYGoao4WXUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qpniL5tE7HDrNBqhjATJ4vzwr06TGlHtLjWigwYkAQ3xhGCIBXuxCJYANOFgL4Oa2Djb23gWR2iHheWD+w4r3kVJbIH7kHr6qmZLUlzlzyr6oWHYp+9sPoc4DTlwoInq0zs1kXoVFtQpWDTQLno3mAQJvma1P98zOpodG2Abwts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D08mcnP5; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D08mcnP5"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-677f7c29af6so10796356a12.2
        for <linux-arch@vger.kernel.org>; Tue, 28 Apr 2026 07:39:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777387160; cv=none;
        d=google.com; s=arc-20240605;
        b=RZDmdOXkYqZ/mW7ghMJRNYdQ0+nlyCFM7rpS3WZ1eBTClh2RmvB57td4beRRX7d73t
         I5WoKCGusBFXnIHlyWiyTvyyHo10qChoi0nVUsoxbM28JUIhaYcXkWUj9vwD1ne1WcD0
         OxP/6C91E9MHGNwX8broeTckMZsMz7S1jjzqC49h5SkhEAjkDTmg5rx7iPVDmUul74s1
         M2xpo9ZdtTk8x3HI+B+GNON5Ql01KBGtxeCTv1B/T5Kwpy+MprBCelQbrw9sZkMUzlMh
         5glPUZfZGYqDiBCY5/nq6XXghX8tYo8IP0YiHLRKicZ3ddtz92c0oIA5IlIWldqCdbBJ
         axYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PN1B9vhJycrgbEH0DOyhYXb0qxN2cniV/ZcL9J2GD5k=;
        fh=sqkwYSdZETBb9ULw/fALitzVEzYiSeDmSc2KkXVbRlk=;
        b=EoalgI/8tdDsoav4+mPHCSoeN1bgOGoPTPZQpqbA4zxv3lGKSfP3cLLnbFU+YWbwoF
         eJF6wZgWe9fKY8y5WGcfa8JBmBtvI5DS0porDxE7C/P4i+iZ8fsrCSLfnMX2zbe6a3JS
         vpXwsq64pDISBd9a/opXV7j3PiTemWyQSVR7WlE/QfrUkUzhQMKqV+f7yLkf4RxtWMmb
         U78ekgoT2QM2Jd/rdSWpWnqikHpJxKrGfuHD4VLgJaHexqgy37hNOTS305wpwMsH094J
         MgNk/U9PM0aiSKew1JUkvlPJeyKCAvCgZ3QrJqqWYCriwUGhgULJzpJ/DiR5nhC0+uLj
         Dzdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777387160; x=1777991960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PN1B9vhJycrgbEH0DOyhYXb0qxN2cniV/ZcL9J2GD5k=;
        b=D08mcnP5szl+13rSRXOE9LH8Qc4jOlJdFOrsL3d5rSmnIWRl2EQMMdhsnQ0VzTI/p3
         z4PFNZ5PWDzow9X4xtOVmJ7h8xY0taALshxRAZgUAXxUnrPyzwznZnbvd4s6vw1ZMM6b
         RPW49w0al36ig6M48MBi5BStjBbzdVz7aZgP68JqJLlhU9A5sfGD94dDZQ16MYRL3CKV
         95i3ALKLBMRxxh6+2mNY5OVwSQJM21tiKp8PbiGWcwtHYZFekNFUYDVwlMVtnBTsYye3
         8C5raITCLyi1C17H3EmKSreZP8jOcMvv55fRU1wY4BkTUxCjWwFtpyEZr7Xky/75i36C
         ZUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777387160; x=1777991960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PN1B9vhJycrgbEH0DOyhYXb0qxN2cniV/ZcL9J2GD5k=;
        b=RrqWwiPQg8g0U4DJPZfe8WJpsh+YIQ/hlvNGiYJ5KopAmF8n1RRKkIKeWWDcmQLcoI
         n2DXCxVWo9UZzAbykk+B897BSvySGibEzXRZTvjsorUdkBcveqh3Lf9O7CSLmc9OdKBr
         C7OcD2kYyn2raqPfpuE5U6/PAfWhW6K0cIcK5q8ipltQy314j1XOfRILuaaulGfsjNZz
         9T8nE6r/mQrB/Q9tPo0IGEOVnencfUNa5b9YakKAY8/jWd/bnyP4ByGgSv/wLkkqpAFI
         MnyQYVyDN/x2RzDGtpsDZkgJB/sR+oecq41QAK1OySPpV+5cANk7zAaZnTsG/exhOqvS
         eqxg==
X-Forwarded-Encrypted: i=1; AFNElJ8OfvsaCng43DppfvGJ3pgSgCL8+eNNk4efxxN2P1grbqs6r3PeZfmRYLazXIsAAjE74eu4pfCyXDu5@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh9fM6KuQotM24IuCRpYoM20bEd55ttVBtafEw/Gy+HkcxoPqG
	gRvRWLI9QiKsZkVzxYGfqK4jXQsozNmDB2QhHmLDlgZFf0D7es2+qplb0x+cGmelg/uNSoN4Zni
	M3bm7C9yAsgBtpLqwWcAy6lyLaBjlxSA=
X-Gm-Gg: AeBDievfqPa6mooXZyHo1taRFizLDx6Oa5Mc8xfjpytQMkxHG+7TWd4a4m8K0eOl5nV
	/n7771TdDkNTZEfw60mksarL2ivgY+9hm62yvxCnFT9ExklIBEbaJfmKoCwGMN2Q7tg5+SAU7fB
	JCyQg2FVOT4QxjEoj4RQzQnPzUlHOw5uVBBZkikorgQ8Wpy4i1xDg2KAsAV7MteABYupdO5blsg
	7I6mUtQ5Tw9R4YQVeERnWD+4cUKoWePyqVI+a+QVEyHy0+vYsxP7t2mjmQ7kQOgvyX+C4V61Exq
	cPZbuB115t7fNGkAMB8CxQnsbMRbqC/2LlRyLhvUify5lFA9xv4RplvL9y/3
X-Received: by 2002:a05:6402:501c:b0:672:bc73:a124 with SMTP id
 4fb4d7f45d1cf-679bb092fdbmr1761172a12.24.1777387159785; Tue, 28 Apr 2026
 07:39:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412135434.3095416-1-jkoolstra@xs4all.nl> <20260412135434.3095416-2-jkoolstra@xs4all.nl>
 <5xexygc3rvvlir4smdfn7gndwjgbuijqfummwwumivsnosijux@ygqs3iqxmovh>
 <20260427-rudel-gipsabdruck-a7884db4ecea@brauner> <CAGudoHFLSHhDZoC6maLsn234dMQVnG4ZbpKXoVrueGujArNF-A@mail.gmail.com>
 <20260428-zoodirektor-latten-e412db97141d@brauner>
In-Reply-To: <20260428-zoodirektor-latten-e412db97141d@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 28 Apr 2026 16:39:06 +0200
X-Gm-Features: AVHnY4Ja3pLpw7UMkXw0oBF-9fgYduWvYEChf9BQ65RTEdqUwZXM4GrqcMzSxBY
Message-ID: <CAGudoHHMG2Arne=B1XnJmSesfUH4se5eEQ2Lsc0FRmCxr3AECw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] vfs: syscalls: add mkdirat2() that returns an
 O_DIRECTORY fd
To: Christian Brauner <brauner@kernel.org>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>, 
	Andrey Albershteyn <aalbersh@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jeff Layton <jlayton@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, cmirabil@redhat.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 10:55=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Mon, Apr 27, 2026 at 06:30:42PM +0200, Mateusz Guzik wrote:
> > On Mon, Apr 27, 2026 at 5:14=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > > Things proceed to handle_truncate:
> > > >       int error =3D get_write_access(inode);
> > > >       if (error)
> > > >               return error;
> > > >
> > > >       error =3D security_file_truncate(filp);
> > > >       if (!error) {
> > > >               error =3D do_truncate(idmap, path->dentry, 0,
> > > >                                   ATTR_MTIME|ATTR_CTIME|ATTR_OPEN,
> > > >                                   filp);
> > > >       }
> > > >
> > > > I'm going to ignore the LSM situation and do_truncate failure modes=
 in this one.
> > > >
> > > > AFAICS nothing prevents the same user from racing against file crea=
tion to
> > > > execve it, which starts with exe_file_deny_write_access. Should the
> > > > other thread win the race, get_write_access will fail and the WARN_=
ON
> > > > splat will be generated. That is definitely a problem.
> > >
> > > That can't happen:
> > >
> > > static inline int get_write_access(struct inode *inode)
> > > {
> > >         return atomic_inc_unless_negative(&inode->i_writecount) ? 0 :=
 -ETXTBSY;
> > > }
> > >
> > > and the check is:
> > >
> > > error =3D handle_truncate(idmap, file);
> > > if (unlikely(error > 0)) {
> > >
> > > This was a catch all for broken LSM hook or ->open() instance.
> > >
> >
> > So with this prog:
> > #include <fcntl.h>
> >
> > int main(void)
> > {
> >     open("test", O_TRUNC);
> > }
> >
> > I verified writecount is 0 on entry to handle_truncate like so:
> >
> > bpftrace -e 'kprobe:security_file_truncate { @[comm, (int64)((struct
> > file *)arg0)->f_path.dentry->d_inode->i_writecount.counter] =3D count()=
;
> > }'
> >
> > @[a.out, 1]: 1
> >
> > i.e., get_write_access in handle_truncate transitioned the count 0 -> 1
> >
> > but then what prevents the following race:
> >
> > CPU0                    CPU1
> > open("test")            execve("test")
> >   handle_truncate         do_open_execat
> >                             exe_file_deny_write_access # should
> > succeed as count is 0?
> >   get_write_access # should fail as the count is now -1?
>
> I'm not arguing that get_write_access() cannot fail. I'm arguing that it
> cannot hit that WARN_ON() as you said above because get_write_access()
> returns either 0 or -ETXTBUSY.

ops, right:
  4681         =E2=94=82       error =3D handle_truncate(idmap, file);
  4682         if (unlikely(error > 0)) {
  4683                 WARN_ON(1);
  4684                 error =3D -EINVAL;
  4685         }

I mentally had it warn on any error.
