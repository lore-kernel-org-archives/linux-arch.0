Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3C6346A10
	for <linux-arch@vger.kernel.org>; Wed, 10 Jun 2026 17:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781113264; cv=pass; b=hlBaFFJk4JxpveWkjcxf4zjDrzZBmGhiT9ez5AddXQbjMV7I6LYrLh4XxjrHndwla5tNZ7dzspByupN2s6q+B4+ikcWWJXnXyNdFmvALFIFOr2Zunw/+qT4/MyBsR3cvJyylaDfM25EqMufC6SUiT7dlNy4zjE3VZXrKfhTmpmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781113264; c=relaxed/simple;
	bh=1AxItsFe16jGeUOX9ul3gEcPkmr5Ky6rSQxHxc9GX+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HydlqOrLyGFCNjTUrn/N6iBFDFuIuIGTu5hddZ7zjzbqD6QaD6mG0DaoWjA2c0oKIsfG6qQXGUPp+rXjp9dUJUna/YgplIiZc4f+VHsdGzd7HWcR5gCtO6cuIsCSEeWaDzWlyEPyQDlF3t5Bk8RQ2ArdM/T2WFx3MNs+StMpjO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AXjZ8L6N; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QS2zSd5X; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AXjZ8L6N";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QS2zSd5X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781113261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8rRrx2CMmFDPJ+DJMgfhWsa26qfJLjrkLxeC/ehw4UU=;
	b=AXjZ8L6N5UATgOpEHw9EHVlDYzFTEEyXN7p8dO81hfGqyGfkqyOPK2H6cd7ZAFZjFnVPJ9
	P+QZUnZ85PilhwVChnvjvkcNZcRoqS/SIzM+ChAWIHwctaEiGVG0CAAhog2btkkPqzErBH
	vZSSRkXJLLH3XISOUaIBcKKu33roFco=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-yxOHrVW_PIWPqi1-NFW8yw-1; Wed, 10 Jun 2026 13:41:00 -0400
X-MC-Unique: yxOHrVW_PIWPqi1-NFW8yw-1
X-Mimecast-MFC-AGG-ID: yxOHrVW_PIWPqi1-NFW8yw_1781113259
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-beeb1713d20so606346866b.1
        for <linux-arch@vger.kernel.org>; Wed, 10 Jun 2026 10:41:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781113259; cv=none;
        d=google.com; s=arc-20240605;
        b=Cbe04/86ayMzSjR08Qg7BR8TQPYVWwdc2MwOXfMcfuzcgYKPKEuq9W7W118JSfK1cu
         IiU5r+W8fMCCLixkNFJTEWsiLG4aIt2XMsdIVNVSQ2IqoWrFhxbdEcRd7ufgOrDbl0Ov
         W2xK+w7e+mb9dewBYq5mUqZjJSkpQPb6uJcj9Agzy0m6X3l30R0H6JUgq6LEqILZad9A
         rkqUDsgayYr6zKa3G8C3lsJiQUBroNXG9I9VjdqUWejI9MWh2ts5ojYO7wdrgHt1Iupc
         KQ11guvfr5rYS4ByFNIRjIT9kF6fOf7F9id6AkqSPbpZzxwMTJYx1mHU83smoOf976aQ
         juXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8rRrx2CMmFDPJ+DJMgfhWsa26qfJLjrkLxeC/ehw4UU=;
        fh=rvkfUnP7uswkfrVgZaI9nbXpC27Q6zs0s1ua+Up6Z/o=;
        b=k2Fke7Mljs6JloF2Z2Uua9RP+8nNO1ob9vJzEBsS+R9HFAJaOlF1/YOERYVZs/0ZdW
         Ko/uYG4C1WEbDnanQkMFHoMma/adiewIZD+itS9DmzkI4bHabJ38xJlQPz3Gy+oh0jr1
         S2ByEsU0ISxCfzLfydTofva1fQwqSie/vF59IBy7GtFoCMPx0u3a4H9CmMZ17DFgon8y
         UnOBRfxy/L3cLfleyD8Lb9/LIih1XyVF9dNFh+TWAqmsnw36vDquKHGtKKCCwOE74pMJ
         WmwLkRblhQUr6ME5I/BDi/iUmY/rj4YZnIo3NHvxtV1Xa8yr50HeYFbIEJdoYs/HqjWD
         hzUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781113259; x=1781718059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rRrx2CMmFDPJ+DJMgfhWsa26qfJLjrkLxeC/ehw4UU=;
        b=QS2zSd5X3t0eThz+LSMhBjsul5jpaJBV212uB8/zGozPe59z18/le0VrGKm6aJoYwB
         T4XIwLac0si6SGzDtDUO9Dcn5XYNkZC9Qdzk/QWnXBUeREaga40GSlTkpUcwBBj3jBsP
         Dbq9io+j1lMZ31mUIZQ7OLeiBCNuYKmgr57UWwXVhB2snpr/fDwQ7FAnwC/TG6iEXwjz
         hO/rFP1whFUQx78ahSbzLepKEUlS3GZkH/kKL0Z9EjauYE3gSH11cBrhPP2QZQ7uM1oh
         +jklm0PYsquyKRl2/4nApCYOeiTblov8Kg4YSBHwIQDXitxvFpcMmrh/xaPHyHFbaspt
         cdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781113259; x=1781718059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8rRrx2CMmFDPJ+DJMgfhWsa26qfJLjrkLxeC/ehw4UU=;
        b=rxCkOUUTc5M9Eb5lVuWShqppqxkrMAXVqMukvRUOnygcSolHjkbMuml6BeUg31p576
         vOx0Lhc9f2pf1lgOomuz4o45CJN21QPMcyfP38QgbL1IanLdNIVFXqB6lGa7QhbgTZ/B
         cXl9OFJqLDon/pVjAmmU/FGO9OkNYgOpWYWyZkYGMl165X4or96jqyClPubkNEZr43d+
         ot11vFsO8/vJrXUkJoBOppW4CuRw9nMgku7VFBFx6s/oddywRCueHWPpZsZ6er0pasoY
         Kbo9L6joukh1k4P/5CgvOVfz5w2Cw+NbNS1yFo8cC9gNGYu+Fx5Cqppyneac301fOBNs
         eu/A==
X-Forwarded-Encrypted: i=1; AFNElJ8SuBKIzMtQ2vGnaJ0tnp7mni3Ccgk9MC3cjdrCn/wPl/CUvTA1Pq3+1bPWkc12HVXk3EtFSYfGak97@vger.kernel.org
X-Gm-Message-State: AOJu0YxRo10zmXBcdojg21qR0o/t6Koczm7Ta59gDW4+3jsuPTrsUtM6
	CRUaH5dfHjxxQEyBU5u6h/xo/n91co2BWqRYIpnUO30WnlD6RDi3MqlLM+gcZiqbggztAnzmQ86
	BdSapdirsoREZChv2QSHmiQ10rOfKLh8oq6XXhXWFZRY5SzRmrOe8AeNtjJdudlU0gJftIYU53v
	5a4/oE/Jq84YeO3mOZKtD7MRq6uM/4mXm9ITVGkg==
X-Gm-Gg: Acq92OH7BcCaTLePythIQ0vCdGK24SK89X+nkmv7eVJnt59LyOv0cHrpgmDRAOPn5lY
	FD+BJgERpbQH2yBL9Rhmnz/8Zm4s+FuENICrHtepZmUi5LqJfx44tVy0KCXPyixJgBA0u67EJq9
	mkbQZ9ajva/zY7FNSENpvPfIWeFQsXrCGAoM/7aFqd2G6+sgigjGUfn48kZ99w9VtCmF8J50EoP
	+t9njMslqw3sniy6RgWiPLqQUHrTVFVVTZNtJohBU43+3r1NbO8asl5J9lTU0WJqsJf+asoqIbk
	93mcV41cLah0tp1fYgvUXPTK5xdO2xSxxg0=
X-Received: by 2002:a17:906:6a01:b0:bed:87c:b24e with SMTP id a640c23a62f3a-bf3721513damr1253746166b.29.1781113259330;
        Wed, 10 Jun 2026 10:40:59 -0700 (PDT)
X-Received: by 2002:a17:906:6a01:b0:bed:87c:b24e with SMTP id
 a640c23a62f3a-bf3721513damr1253744866b.29.1781113258996; Wed, 10 Jun 2026
 10:40:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610164719.2668906-1-rrobaina@redhat.com> <476e0a44-c6fb-4e6a-af56-a9f1d054518a@app.fastmail.com>
In-Reply-To: <476e0a44-c6fb-4e6a-af56-a9f1d054518a@app.fastmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 10 Jun 2026 14:40:47 -0300
X-Gm-Features: AVVi8CeUHfgLiWmp9hQn1L3Vkdm96Ld0E64v1VlTaEQSS5bJm1lcsISDAQPRmA0
Message-ID: <CAABTaaBBVP6eY8D+a1KTgfZ3x8v3egnKTiQLRQfXPiOhpmQXjg@mail.gmail.com>
Subject: Re: [PATCH] audit: add missing syscalls to PERM class tables
To: Arnd Bergmann <arnd@arndb.de>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Eric Paris <eparis@redhat.com>, sgrubb@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 2:05=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Wed, Jun 10, 2026, at 18:47, Ricardo Robaina wrote:
> > diff --git a/include/asm-generic/audit_read.h
> > b/include/asm-generic/audit_read.h
> > index fb9991f53fb6..8feebc5b4c50 100644
> > --- a/include/asm-generic/audit_read.h
> > +++ b/include/asm-generic/audit_read.h
> > @@ -18,3 +21,19 @@ __NR_fgetxattr,
> >  #ifdef __NR_readlinkat
> >  __NR_readlinkat,
> >  #endif
> > +#ifdef __NR_file_getattr
> > +__NR_file_getattr,
> > +#endif
> > +#ifdef __NR_stat
> > +__NR_stat,
> > +#endif
> > +#ifdef __NR_lstat
> > +__NR_lstat,
> > +#endif
> > +#ifdef __NR_fstat
> > +__NR_fstat,
> > +#endif
> > +#ifdef __NR_newfstatat
> > +__NR_newfstatat,
> > +#endif
> > +__NR_statx,
>
> There are additional variants of 'stat' that I think you need
> to cover here:
>
> scripts/syscall.tbl:79  stat64  fstatat64                       sys_fstat=
at64
> scripts/syscall.tbl:80  stat64  fstat64                         sys_fstat=
64
> arch/x86/entry/syscalls/syscall_32.tbl:18       i386    oldstat          =
       sys_stat
> arch/x86/entry/syscalls/syscall_32.tbl:28       i386    oldfstat         =
       sys_fstat
> arch/x86/entry/syscalls/syscall_32.tbl:84       i386    oldlstat         =
       sys_lstat
> arch/x86/entry/syscalls/syscall_32.tbl:195      i386    stat64           =
       sys_stat64                      compat_sys_ia32_stat64
> arch/x86/entry/syscalls/syscall_32.tbl:196      i386    lstat64          =
       sys_lstat64                     compat_sys_ia32_lstat64
> arch/x86/entry/syscalls/syscall_32.tbl:197      i386    fstat64          =
       sys_fstat64                     compat_sys_ia32_fstat64
> arch/x86/entry/syscalls/syscall_32.tbl:300      i386    fstatat64        =
       sys_fstatat64                   compat_sys_ia32_fstatat64
> arch/alpha/kernel/syscalls/syscall.tbl:224      common  osf_stat         =
               sys_osf_stat
> arch/alpha/kernel/syscalls/syscall.tbl:225      common  osf_lstat        =
               sys_osf_lstat
> arch/alpha/kernel/syscalls/syscall.tbl:226      common  osf_fstat        =
               sys_osf_fstat
>

Hi Arnd,

Thanks for reviewing this patch! You're right, it seems all these stat
variants should be added as well. Steve and Paul, correct me if I'm
wrong here, please.

> Not sure about ustat/fstatfs/statfs, I suppose those are a different
> category, right?

Yes, I believe these would fall under a different category, since they
are related to filesystem stats. Audit PERM classes are specifically
for file metadata and access operations, not filesystem statistics

>
>        Arnd
>

I will work on v2 shortly.

Thanks,
-Ricardo

