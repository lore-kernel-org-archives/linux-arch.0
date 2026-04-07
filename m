Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A995397E9F
	for <linux-arch@vger.kernel.org>; Tue,  7 Apr 2026 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775551951; cv=pass; b=ZX8mD3gtXRC26YUDuktSLlZI+NIjC9FG4etOonkNYHnH3bBOA5nCTKzhUJG6gVsx8I8ZW/Drv+HY/MMyL6bNZ5u+lLRI2mgMAOipxCMCHuG2XYl7DWtNs2U4TP8Dye0ortYtndOKEmeFuP9MdAHDfBP6QVvE2dZLoKwmHVNukbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775551951; c=relaxed/simple;
	bh=1/yxO41x8fx08HBDLEnG68zlrtgzWXfreGygoOQjbaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7Cw9DO+QOXqR4pse4pS+SFJuH3BnZejzrOqvWy+DFafCilyVgav8/ApcJ22iSJ4j95XgWOp4ImItoHVNFL3BU87JlB2j/qg7BJ8D6D5y0xm0mwMA3BooG2adlY0goDLhgR9ngqdaWk9P4pagmeI8yEGno1FqQhpGnOZTX4mx8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7LzFUkn; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7LzFUkn"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-66f74fa69ceso39423a12.2
        for <linux-arch@vger.kernel.org>; Tue, 07 Apr 2026 01:52:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775551948; cv=none;
        d=google.com; s=arc-20240605;
        b=kJg5qYpz1UtgEuZgn9giowyoAeHWlEgBuYix01i0tquYbuunN1pp2EzuKcqUVhc5bu
         yf4Dn+vtr4XZTzzXk8wBZAwEdy9XVxPs/wFbFfQfmSmKKx1hIzb/zLw3+GcLF/78SSqf
         WSMPPBNskJyK+O381owZ/Y81z01Lx7EhUrdi4F5h5unNEwscyXfnuntW1SstgvZQ5fQ7
         EG4RfepKp3y6REd1DYLSHL34rrByH+csHsnPDP0hf9QanZrS/zMcy6Y6Il3G4bZ1pnGn
         hOLgNdHzuvxAEFJLMWi6kKNNV1SNVUK3FuvCCVhTcf4Sq88jMXj+H/SyCsg4xtcCdHiH
         8IHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1/yxO41x8fx08HBDLEnG68zlrtgzWXfreGygoOQjbaw=;
        fh=aDks7HEfyMNjhXXTdJi1a81BY2nMjM7O733tep5idY0=;
        b=a8/yFIrVZhtWHVTBzpxkGeBA8F/JL3HHL5DHg5yPknMBal+IQphzEITyf/K4onYCsN
         nhr7dBfgx+9EgUZDcapnBFV39z3txd+XtKDvaDgT3+hP3aDdKE81uBRhvfe5D9sRrptC
         k1e648jNjB15Xz8ZCwn4pntzR/pVCT7Iauk5myAnYZM2NxRDG7LhibzPEK5v8NM2HX5E
         /Kgtebqz2bE+hiZ3JSh5vnrQ8lfcHvnguZwYV7OpdDjbqRalywV8o5ipE+ygx2sLvubc
         R2rTha9FZasvj1oOgYoruoOE0GVCGFFhnmdYMXNdXDkIXqamIeN2mDsh8GJXP3V5wU5O
         EkmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775551948; x=1776156748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/yxO41x8fx08HBDLEnG68zlrtgzWXfreGygoOQjbaw=;
        b=V7LzFUknaNaa+Ni3xvKOIPElGYuOJXP1y0XM1OPOmTQVGAyQQjxKJOTRD83CDp0Vf1
         m68toxhmpregUOeHgK81IHSWDfz8n0uUt/QST5qkegHj119alX5cEyNeUd8UthSkNBAU
         RqDwG2ru9JVu2sG76beHJ33ZkqF6wkexVML+G3avEWfPcevmGEdiLeHR6Hbwpq5vVz4j
         s3Z/mKubjaR12r3hmJZu0fDyqjUnMbQkRm+Q0zb2M41qBkWpz+t+HyiWkQF+/SON2sRB
         s6LT0FCMi8LtUK9o0gjkdxj0ob+7DpK1BVqo1BQb0iTchNgLIZo6a4gMNKx4/tLnNjr1
         l87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775551948; x=1776156748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1/yxO41x8fx08HBDLEnG68zlrtgzWXfreGygoOQjbaw=;
        b=bSTihc+puQXfBdLHhkzZ2JkqnICebGkgQTE1Wk9r9USLibTe16YuxYJM/h2Ax1dmwK
         rfrfIRDv8pNwBeHAZdoANnewd1th7l1/18ks/2jZuhiKYh+3G2ZkLMVkckUjqjbmepRL
         BA4ZDiIGNCzL0tC+116JQhoMfSfNt0Sz4qlc10Xlot4FtPJHxipl0tDj7nkI87l5A0hg
         F5p5Z4u9N+NvnsqBjJx6fQw7TFRJXxW4xNdqG3NyE7l8wwcrvPjjD9LVTnUjU6cwOsmI
         GNeI75yINFE7ruDKOBTQ5HbgzweBuxa5eYkRl/Un3uDDu8aHZcjiPJONOCMUHtiNbVEX
         b9Uw==
X-Forwarded-Encrypted: i=1; AJvYcCUufE2tTWSJ97lcPuzTKrtF++sGMJ86XpIU8VLQyqsmxQj5UTHrkX41vy0jSnupvjy0+KauOHsq3cQM@vger.kernel.org
X-Gm-Message-State: AOJu0YwDKigerrnJAUFaawItvaKVAX0NlXsorZzRgWKwQwmmwhZwqpjx
	q7ZZoabNDPJDqPN8XqecguRfaBxqEKvVauYBeqEKYwVav5BZz9Z0bz4nw56BVZ6LcVFXNuW/ija
	n2BpGoMHcQc8lUAvGazGxotsFWNG4VgE=
X-Gm-Gg: AeBDiesGd+iNYRpCmgjPWJkZOV9HfpI3VGo0A7fqvOk9IkZuqL7EbNzXiVeVMf9HToh
	zItpXzmn4EBOfRuBD/0nauQtDpsB9mYFFEeh2Oh5ATyEnmAj6JTA87XH6XIqGs0H3O7AJKaWLWR
	iMpPAzE+rpQSTCV5MijbMhNvAb2GOILb39Z8yfkdADNgutOVm5wiYUKswffc0qfJ1ZEHRcLOeaW
	A9ozPivEidcWzwggJuRzuWDp9+EjImEeghNOr79JOQH0hVlPU69KFRIfUdNNz/wmdrkzx96doBo
	F/sgubFlv+0xPsyAM9hJ/EtBAdANyWK8LPu7V5xMkkCC+867SA==
X-Received: by 2002:a05:6402:358e:b0:66e:378d:2e56 with SMTP id
 4fb4d7f45d1cf-66e3eedec45mr7929165a12.6.1775551948068; Tue, 07 Apr 2026
 01:52:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331172011.3512876-1-jkoolstra@xs4all.nl> <20260331172011.3512876-2-jkoolstra@xs4all.nl>
 <pbobkjhtuli53o3z34ajyxztaosmztwlygxfxhhjq5ajt47inc@ngtoge3ucdm5> <2026-04-02-aged-convex-snowbird-foxes-Ym20JZ@cyphar.com>
In-Reply-To: <2026-04-02-aged-convex-snowbird-foxes-Ym20JZ@cyphar.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 7 Apr 2026 10:52:16 +0200
X-Gm-Features: AQROBzCvAizTWNJ0cjKYiQAmPZiL_VBNVb8McO5K2r3B9TnWKq4dAI0MnvUnod8
Message-ID: <CAGudoHH7z8CwAXMxAxTbjfovRBpne5f19Tz0okMh7_6G9NfQ-Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] vfs: syscalls: add mkdirat_fd()
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Alexander Aring <alex.aring@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Andrey Albershteyn <aalbersh@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	cmirabil@redhat.com, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 4:52=E2=80=AFAM Aleksa Sarai <cyphar@cyphar.com> wro=
te:
>
> On 2026-04-01, Mateusz Guzik <mjguzik@gmail.com> wrote:
> > Trying to handle this in open() is a no-go. openat2 is rather
> > problematic.
>
> I'm interested in what makes you say that. It would be very nice to be ab=
le
> to do mkdir + RESOLVE_IN_ROOT and get an fd back all in one syscall. :D
>

Not handling this in either of open or openat2 does not preclude mkdir
+ RESOLVE_IN_ROOT + getting a fd in one go from existing.

Creating a directory was always a different syscall than creating a
file. I don't see any benefit to squeezing it into open. I do see a
downside because of an extra branchfest to differentiate the cases.

> > The routine would have to start with validating the passed O_ flags, fo=
r
> > now only allowing O_CLOEXEC and EINVAL-ing otherwise.
>
> Please do not use O_* flags! O_CLOEXEC takes up 3 flag bits on different
> architectures which makes adding new flags a nightmare.
>

With my proposal there are no new flags added so I don't think that's relev=
ant.

> I think this should take AT_* flags and (like most newer syscalls)
> O_CLOEXEC should be automatically set. Userspace can unset it with
> fnctl(F_SETFD) in the relatively rare case where they don't want
> O_CLOEXEC. Alternatively, we could just bite the bullet and make
> AT_NO_CLOEXEC a thing...
>

I would say that's a pretty weird discrepancy vs what normally happens
with other syscalls, but perhaps it would be fine.
