Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E77537DAB1
	for <linux-arch@vger.kernel.org>; Wed, 10 Jun 2026 19:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121222; cv=pass; b=isENkOeuPhTwTsR6xre0K8pMNz3uyFbjYMGyi7ZD1Y0EAMDAuAvQ6hU53cz3VK6JhnmhKQfNzwdOQEKaNTSJyG9jaL5D2R4ExJ7a2wo7LoFz3cnE3P5rT8rNVnIEd03S4jRqOafi6bUQiULqiGqr8lOIRFBq9dOGYdsy0YkTnig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121222; c=relaxed/simple;
	bh=459PmgaIKTi+jGFsDwJCbEFj0+/x7260xa519JdirmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pm1eLnq3MbAG7+0fKxAe2K+i0MikgCoTqjRU6LkUXLCH2uIwp/+B2WE4IjVeHlSuyOdq9AcsuQNgzyNGEJDjtVhCA9JWFM0P8W4pXQ2U+rqaWMvSWwh8dmgpXyhe0p5hPiZ5d303EfLCpWdkOOI2E4PHJPe1s/ACG48oUmIeeL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d6UXAEWh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EPz+JN4A; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6UXAEWh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPz+JN4A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781121220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eiPgIwpyVmZj/Z9v28nFfViLd+qwYfqwQqLAO1PeANY=;
	b=d6UXAEWhA+cDwBGrwe+54e+NLR98xiyt+55lMF3YJHjSsQSFvPa+d17adFtcrwNFSPNX/k
	xsjkslDV1BXjGLJsjklMmKEHUgPlgAE8M/EplnYiYU/yYS0Id1NDHxz7qZlhixDTzqLd+l
	5h82uQ7DKjaTpGe6LDX9hZw99aIvpaA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-l4vw8N5XPceY3Aep_JwyKg-1; Wed, 10 Jun 2026 15:53:38 -0400
X-MC-Unique: l4vw8N5XPceY3Aep_JwyKg-1
X-Mimecast-MFC-AGG-ID: l4vw8N5XPceY3Aep_JwyKg_1781121218
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-bf523a51c24so460883366b.2
        for <linux-arch@vger.kernel.org>; Wed, 10 Jun 2026 12:53:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781121217; cv=none;
        d=google.com; s=arc-20240605;
        b=dCPorH5gwMsgCKmyzr1V7YJDqpE4vFCBa2YqjMZsLwfxGereu5wwKa948JYG6Q3C05
         +75gcBKNVwNjhiyCCkjbcy66sM7/E+/VRvo8IEJo+B7vfz64pAhISrHYmVAQRNShLAQN
         i/eJEFIVaVBX6edO9aweMeMwL5y1u6wJje3RtMKN7U6zGJpG2yScyY5tT7y6Pq8VWRUc
         W4faiXaZ5Ok7f0dQf+v+6mbCYC6eGHgW8wpYo3jDNkq+g7w9Hqq/mnRWR+moO/e+YRvb
         VRAvjVc8tdYAV9VwkviDhyR6eMgbzi6laz9IafgNk5BtevPNqrhfORaPMwbHhj9M8Th5
         2Wnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eiPgIwpyVmZj/Z9v28nFfViLd+qwYfqwQqLAO1PeANY=;
        fh=LBzCk6SKxae8upA1RbytB70wosmwNejpxBOYJ66VNxU=;
        b=eG/al62dwBaSe2W+3+aDrkYt1FY0eSEX+uEIadS/iPo2od2/Z47+OgdoTHxriZJaCf
         OUd4M1YJ2S3Q7dGJLUyvyWKExKF4lLWGlTtoXlPNtmEkSuhD2H2GOtByJupAb1tKc4hB
         prVVQ9uUdAGkZjriEPbYPGZdnHzcUutxAHr1NujLxtq1dNFDawLYL5INjYCcYBZhLjcC
         C6u+iNdtoEvw25d6pgs8USRbTeIX5LlzBxrKQs2wdNvMlRyJGHRdgMAmiHRrj8uhrnPx
         dNS8XEFN/QybYpu5t/AF+vkE7eX/eOebQPUJ5y9ntandwGwbshodcMvjLPm50EdchT/J
         EVow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781121217; x=1781726017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiPgIwpyVmZj/Z9v28nFfViLd+qwYfqwQqLAO1PeANY=;
        b=EPz+JN4AzkuWyUXGqwj26FVh5ZX/NIxAWG6SdsGtiBHTHLmIMuiCBVO6rGtNMKf2h6
         0rwAh+opkh4qGgBKXCW526sDv4CfcfLPo5BbVOYBrQyku2cZs0DkJZ+6HpxQffsOkxZZ
         JULXGgQ2PrldDcyKuWYN9GZIqUav9vO6KoYgRKzVwqljjxNZTICE4kYcqNnb313iJ01A
         UbT3V+M4mEl99QIvRlzas7WfJygJvyghFJJrXN1ihqxKQbKmPhrg4+imKdim6Nw7Sdec
         K5RFPWDP05fjs4yub+VgoMFFh+uGC6ITF4ma67jxk3anoZ51FmwRl1KDMYBEb54kodA7
         tScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781121217; x=1781726017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eiPgIwpyVmZj/Z9v28nFfViLd+qwYfqwQqLAO1PeANY=;
        b=VDo7cKA93WksLlkWd4CSrUKD/T9ImzrX12NKJqCij+5jPFw47nXrGgGcsOaoKolDFy
         HepVjOHIZFPNXoXW/kIDBHaIoEskwMZPCV2idcw7E54b5QgJzgEK3S0njpLRPhvM7o8b
         jzq82Fevv/0iPQyxo/i8mXW8JHFSOkW6nBUu11HyoyN1g1Cn2DeWqFTQSilmhmfzX6vi
         HjuHThfrC1MZIKpE5UzWvgzD720kKFh+H0I9aBxpJm3ZDomA7ICNaR6QjqR+064HCtUB
         MXKOnGIJCpQ9AOb0jdhcBy/XrsVZDKzfDHOQ7ohL5g3vW9ClAjaaLZdakqh9gSWVrtIs
         M7mg==
X-Forwarded-Encrypted: i=1; AFNElJ849saOo7xpsYvXuZ3PAvRkbYYdvFqzPVDH86NWp60cbAqwnhJZAbh0MvfX/1Xh8RI3LPD6Ny/kh0Ob@vger.kernel.org
X-Gm-Message-State: AOJu0YzNjKf+OGevEH57REGRoIxmJsZmhLFkK4PgO9RWpCWe5w7JDxQX
	HdOwkSawoDY/4EiTwbsPTQGfcRds6PJWAienGbaosRSFQT7Kb/F35aoOTgFvN16o8NKVBlhEXZb
	tLhlpYeGWQj4MWmUL16PqbyToH5U9Q8028QVaic+2phgf5OR4SHbpLbFEnk1OqUJUmRUaHb+LAr
	KXH+P89W3WIshk4vQaDLPfSGnj8N1qcrkAcwpcAA==
X-Gm-Gg: Acq92OGsQO8/SHp75Cj7jLP9CGfaCMx5syes3HB1KyDXOARC5tEN2fq1dm49laiVtf6
	aR5DXE5pLIsNDrbiv2f8Af6wA2B/rMN74AjC2/FguduYqGgcT5WUMVrs2LptPIwNrQYHhItEgyl
	LFyAA5vWeh/0FppIhlB67lZICXM5OGPztJmQfXSZ9nEmHWL1t6LCQjSEnij6gHLqO18smQPax3L
	4LAF0EOrbg1enhy7+qgSb8dEKWBjJhAydzZiK9iBrJlOw+S5y5AUHYzctyqd3T2MiKj+WHRxeHg
	n/dkJTnYVjZg7g86zv6LWhvW/Vvm5d8I+3I=
X-Received: by 2002:a17:907:d40e:b0:bec:a96b:75b8 with SMTP id a640c23a62f3a-bf372741180mr1368090166b.32.1781121217613;
        Wed, 10 Jun 2026 12:53:37 -0700 (PDT)
X-Received: by 2002:a17:907:d40e:b0:bec:a96b:75b8 with SMTP id
 a640c23a62f3a-bf372741180mr1368089166b.32.1781121217229; Wed, 10 Jun 2026
 12:53:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610164719.2668906-1-rrobaina@redhat.com> <476e0a44-c6fb-4e6a-af56-a9f1d054518a@app.fastmail.com>
 <CAABTaaBBVP6eY8D+a1KTgfZ3x8v3egnKTiQLRQfXPiOhpmQXjg@mail.gmail.com>
 <2021591.7Z3S40VBb9@x2> <4c885308-7556-49a9-836b-37089ac3bafb@app.fastmail.com>
In-Reply-To: <4c885308-7556-49a9-836b-37089ac3bafb@app.fastmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 10 Jun 2026 16:53:25 -0300
X-Gm-Features: AVVi8CegNJFmA5pJjXnR6bzdeWqrb7ywcRPoDsKS9Cmo3gkCjJrGU4TIKNqXM6U
Message-ID: <CAABTaaCPpxSxUDXe-YthFOiNqM_SgsvVaVuVv8AxogRTd1nQ5Q@mail.gmail.com>
Subject: Re: [PATCH] audit: add missing syscalls to PERM class tables
To: Arnd Bergmann <arnd@arndb.de>
Cc: Steve Grubb <sgrubb@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 4:39=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Wed, Jun 10, 2026, at 20:13, Steve Grubb wrote:
> > On Wednesday, June 10, 2026 1:40:47=E2=80=AFPM Eastern Daylight Time Ri=
cardo Robaina
> > wrote:
>
> >> > scripts/syscall.tbl:79  stat64  fstatat64
> >> > sys_fstatat64 scripts/syscall.tbl:80  stat64  fstat64
> >> >      sys_fstat64 arch/x86/entry/syscalls/syscall_32.tbl:18       i38=
6
> >> > oldstat                 sys_stat
> >> > arch/x86/entry/syscalls/syscall_32.tbl:28       i386    oldfstat
> >> >        sys_fstat arch/x86/entry/syscalls/syscall_32.tbl:84       i38=
6
> >> > oldlstat                sys_lstat
> >> > arch/x86/entry/syscalls/syscall_32.tbl:195      i386    stat64
> >> >        sys_stat64                      compat_sys_ia32_stat64
> >> > arch/x86/entry/syscalls/syscall_32.tbl:196      i386    lstat64
> >> >        sys_lstat64                     compat_sys_ia32_lstat64
> >> > arch/x86/entry/syscalls/syscall_32.tbl:197      i386    fstat64
> >> >        sys_fstat64                     compat_sys_ia32_fstat64
> >> > arch/x86/entry/syscalls/syscall_32.tbl:300      i386    fstatat64
> >> >        sys_fstatat64                   compat_sys_ia32_fstatat64
> >> > arch/alpha/kernel/syscalls/syscall.tbl:224      common  osf_stat
> >> >                sys_osf_stat arch/alpha/kernel/syscalls/syscall.tbl:2=
25
> >> >    common  osf_lstat                       sys_osf_lstat
> >> > arch/alpha/kernel/syscalls/syscall.tbl:226      common  osf_fstat
> >> >                sys_osf_fstat
> >> Hi Arnd,
> >>
> >> Thanks for reviewing this patch! You're right, it seems all these stat
> >> variants should be added as well. Steve and Paul, correct me if I'm
> >> wrong here, please.
> >
> > Alpha is unsupported. Those are True64 compatibility syscalls. You can
> > include it and #ifdef will filter it everywhere else.  But, yeah. I gue=
ss the
> > rest are ok. I don't pay much attention to the 32 bit arches.
>
> Ah, indeed. I assumed that these were part of the syscalls that
> originally came from osf1 but are still used on Linux systems,
> but it appears that the stat family was never used like that
> with glibc.
>
> The oldstat family is actually in a similar category, as those
> were only used on libc5 or earlier. stat64 is definitely
> still needed on 32-bit userspace with 32-bit time_t.
>
>      Arnd
>

Thanks for the context, Arnd and Steve. I'll append just stat64,
lstat64, fstat64 and fstatat64 to the v2 I'm about to send, then.

Please let me know if there's anything else to adjust.

-Ricardo

