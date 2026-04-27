Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFED43D6699
	for <linux-arch@vger.kernel.org>; Mon, 27 Apr 2026 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777307461; cv=pass; b=tZrd7ZQ1FPZTndwr42kRAEJQsfLzkCaM0olBEHCwGUCBwly1nFSLtalhX9jH/AaQi6DzTf0nKYp09eMC6QCgdjxko7rP5b4WKMRr+VCYe59GUELecVHWay0v4BXTdXpN58N3FBwF5NabaBspb65HPnJtV+TNIuMhoh96M/ifJAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777307461; c=relaxed/simple;
	bh=idvner3mgft23dklNp8J4rH+ZI4P2VAwnJOBXPrMcrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krdJwDXM4FFlfUZWb9urLmMR2fWeDrnJ9A/HHcoCuDpW8Sc7KO8/c6oikAFXLz/hDCGeDMgWpttdXYd7B6Qd+P8kCmYWCrCiPcSlB51Sw0Sp4vj0K+mtv8Dwr6KfcCFUhE2JPFxLaWuASAEKLStkXonI9Qac/ufwQyfsJQqkvgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLUXXzdF; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLUXXzdF"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ba67b332bbaso1221150666b.0
        for <linux-arch@vger.kernel.org>; Mon, 27 Apr 2026 09:30:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777307455; cv=none;
        d=google.com; s=arc-20240605;
        b=CQBUf+dvHUY1NUYiD8H2v5zR1pXgcOL7HJXh1Yh+Z6VjtAsdd/wz1GJFfD5HvalNTd
         BzVkKEaIxOG3qexgK1ZCQiamk3s/5nk+gIrkvae+w0eZJcxwnriLplQwlZs77MPT+8tv
         ITE4U7KOS20OmG7S44p+ZpVD5v8wpyiu8IR/wqW7oi1Mej3EcZ2Z5JNCBWKl9Y/f3cOg
         JxanhB0NV1uYm/LB0wbw7NpPASzsGGAqp2AYzC9gisbosLnEFlwiP9HARUTlY/tIMcp9
         ZewRPiC9XE29bo1yiGU6zFsnyQroKtL1kdGEBYYSXjCTdV+Q+E1+vXlXfnPrbyiwNHHB
         k2Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B7Z/bR7l35cxDwn9+LDbQum27vsLynWJhwJbt8jzAnU=;
        fh=TM5khMz66KoYo2KiWSQ32XQVBC7OeNisb2XF08e3d3E=;
        b=JRRL0r0lEjnSIvF058Mk75VTGItNW1f7eCsdxRErRoSerDPEsgxhnNsBJUja+Scxkq
         DMqvxguIg9hBrrM1ZjWQP3690qkt27DOWD0wkNz/z2pfV+x1ehxoapuxoJglRv3IWIgl
         9xegxBPGILCTIYcAa28l6DAd/SwUS8xl2iAwC3K1sKhlvgyY7jjuYfzvpsi0vglDSjkk
         dnZ/+iNsPuY+YRgNiElODSWdHpN2/nhJhY780TATFK6XJ5JI9x2pkClQYVAmnVgo5wxu
         WnoKXxiDxCYAOxLkDwzesj3hrf3RaaVw17+WYhQNtyWudUJ8YgnT3WYAycpPTWMMLrdB
         lNHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777307455; x=1777912255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7Z/bR7l35cxDwn9+LDbQum27vsLynWJhwJbt8jzAnU=;
        b=eLUXXzdF+kXYoyBc8nSDmCGGAz/1e0/zuWoSv5U3a1szoR5/g7LPlWio54onwM2f8y
         /8/tfR/sYCe8SLelIiai1EG5uW5dqol5GkS67zuvpg4pUSLy1GZpDgVKF2PlrzVmHTtK
         Y51i0ML2jdtNzC2eA/n8PcF/oH1X5FdbdqJEwlChduJbJXbDSDV0M3Ope5EchKkgPN41
         K785yoOePwIMaU9Y4v1u/mdZaL55zPAfLu0oQTHNO1nrB1OKKGUD+NamK0YWeAN22B42
         jgbE46KOamulWpQfg62tdVOuYSUVuJb/SiK0N3Oyo+s0MYwSchOdV6UihKPkMb5VUJ3q
         p8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777307455; x=1777912255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B7Z/bR7l35cxDwn9+LDbQum27vsLynWJhwJbt8jzAnU=;
        b=M09uClCL+D8W66x69iRcduDXAnzDcrunE3D9nWBgD3/c/2Qsm9maVPYrt155brJK4Z
         yllh4NMKdexzavRq3t03xHuAtmIBQrbH4uhNFmfJZUgVsmmjYNFpcpkl5O2zlc4k+uaG
         cXqI/xKKv9OmwH2buSfZ4W293gKPlOjLrsKY+AFSGqYXom1/4Hq5IQT4wAi9zuGvP0mw
         T+xO3PahYfoNjUqoz+w2kS5IPTTGYuWuKR8LyzCdN+NpN36ZHjFVpzYUhLX5HjyfWJ/E
         MbdVEWtRCA1dlmjax2hpzOL2x8wMyS19w9Q+Ijq34rl3JX/La6d+kdwfmYFrJaJinOUS
         FnTg==
X-Forwarded-Encrypted: i=1; AFNElJ98I9OH4wuZ8hSicAWCS6uDjJKJunZYOmeCGPCXQC8Aq44X8uHLLr74MV63c4kSFmx43ZxaGihbZTrB@vger.kernel.org
X-Gm-Message-State: AOJu0YxdGrkJnfkyeTouXHGu9YOGqxZ7r/AV9WnXzw8RzUvp5R/5JrkY
	Px3NexxtNo0f5YeRarOAVAytkuyunIspl0LsifasuDF6VT11ecLCCSjb2TwtmgronxzhAfuO67L
	ajt8d3ebEyn/ImEa2Ebgog3B1V5Yesi0=
X-Gm-Gg: AeBDieuf4K9eihnShhkKjveqKRuEPwAskegbsWIr3DNjzKt4RCF2k1Os5DkGT/kkkfR
	glMTijNvlOfQQACP2J6rGz0aoY9NeylWdty2zlAkN3e8hIgNV0NzxraoBEh27eU7AlLi+Y7VWG3
	N/r8s9fKhuLLySmKwvJ7crihh7UDjkHSmklq7bK9u+vlqSC/Y8Ub/f04T8hxCG7+oPuo8bbTkot
	G2hRfDq93QEQxp4KxwiZSZhhsBujfY7zMC/0e5+7OsUu7wB6He+gkI0eL/SlLeaJGaXmmLYvQqL
	b+aa/wDWWFd4WB0yQMXrVa1K7A+gwTuDC27ugT0tzy1P1rh6glpEWqvzo3CK
X-Received: by 2002:a17:906:8e15:b0:b9c:4fa:9141 with SMTP id
 a640c23a62f3a-ba419077377mr2070161466b.9.1777307454882; Mon, 27 Apr 2026
 09:30:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412135434.3095416-1-jkoolstra@xs4all.nl> <20260412135434.3095416-2-jkoolstra@xs4all.nl>
 <5xexygc3rvvlir4smdfn7gndwjgbuijqfummwwumivsnosijux@ygqs3iqxmovh> <20260427-rudel-gipsabdruck-a7884db4ecea@brauner>
In-Reply-To: <20260427-rudel-gipsabdruck-a7884db4ecea@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 27 Apr 2026 18:30:42 +0200
X-Gm-Features: AVHnY4ISYjfmOuhoMK9ONLGmIrCNFHHU0Ih5PKAcLvuNRoFbTb0DP2K6JgsHNoI
Message-ID: <CAGudoHFLSHhDZoC6maLsn234dMQVnG4ZbpKXoVrueGujArNF-A@mail.gmail.com>
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

On Mon, Apr 27, 2026 at 5:14=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> > Things proceed to handle_truncate:
> >       int error =3D get_write_access(inode);
> >       if (error)
> >               return error;
> >
> >       error =3D security_file_truncate(filp);
> >       if (!error) {
> >               error =3D do_truncate(idmap, path->dentry, 0,
> >                                   ATTR_MTIME|ATTR_CTIME|ATTR_OPEN,
> >                                   filp);
> >       }
> >
> > I'm going to ignore the LSM situation and do_truncate failure modes in =
this one.
> >
> > AFAICS nothing prevents the same user from racing against file creation=
 to
> > execve it, which starts with exe_file_deny_write_access. Should the
> > other thread win the race, get_write_access will fail and the WARN_ON
> > splat will be generated. That is definitely a problem.
>
> That can't happen:
>
> static inline int get_write_access(struct inode *inode)
> {
>         return atomic_inc_unless_negative(&inode->i_writecount) ? 0 : -ET=
XTBSY;
> }
>
> and the check is:
>
> error =3D handle_truncate(idmap, file);
> if (unlikely(error > 0)) {
>
> This was a catch all for broken LSM hook or ->open() instance.
>

So with this prog:
#include <fcntl.h>

int main(void)
{
    open("test", O_TRUNC);
}

I verified writecount is 0 on entry to handle_truncate like so:

bpftrace -e 'kprobe:security_file_truncate { @[comm, (int64)((struct
file *)arg0)->f_path.dentry->d_inode->i_writecount.counter] =3D count();
}'

@[a.out, 1]: 1

i.e., get_write_access in handle_truncate transitioned the count 0 -> 1

but then what prevents the following race:

CPU0                    CPU1
open("test")            execve("test")
  handle_truncate         do_open_execat
                            exe_file_deny_write_access # should
succeed as count is 0?
  get_write_access # should fail as the count is now -1?
