Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812B8352F85
	for <linux-arch@vger.kernel.org>; Wed, 10 Jun 2026 18:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781115234; cv=none; b=tufjGDe9FYuDn4SibHBiI7CVQqwJBgk5eQ/fxjTQ/4SxDZGhv5OpxwMF0B5rOaOyrpZNaptrBOJWbDVwZOEQFm+SPTLVQbmorD/M898J7kP5VmNGK92c3kl9t/Uj56SpX9fJqkVgwyrhWZ+Xy2qJQliO8i2rkEQsOphtuK7I3ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781115234; c=relaxed/simple;
	bh=hOH8ap3dDUF+7Na6xgSw/8YbNTwc3Euac5TX66yhc/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DUGinHtw4T4Les5Ko1AnMyAcKRR1b9023ZESw7UTsUZ9vjZGApTEVsXvUHG6TjlsWdQL6Zm7p4h0U5utuYfl0Focrvzxp1IRobjNAqTbcOGFlrJzV4RbvssjzhEFvsps3i+q9qCCyhVV6fpSPTyEAXfPrME82GQv1Dv+JGPcGQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NLaYl6FQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NLaYl6FQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781115232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jqB333kKhI/fZnZpU3wbg5SEVlfhj055nL3FK05N7k0=;
	b=NLaYl6FQ0nboTmpO2h0YTtvgznHxEYliUTJtIcOPS2sdHrJrgylokj8del0AIb3Ij6aGUj
	HLDKCE08NlqGEOvPz9unFdXGxjO5z0snS+0+4WFdFa8cxi2JosASGdyfhFT/QrSaeV49zj
	Y7EI0RmfEfdeRf2I5HSMVh+7wRRpzRo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-399-El-EspnlMVG0ldYYtuwNUQ-1; Wed,
 10 Jun 2026 14:13:48 -0400
X-MC-Unique: El-EspnlMVG0ldYYtuwNUQ-1
X-Mimecast-MFC-AGG-ID: El-EspnlMVG0ldYYtuwNUQ_1781115227
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3176A186D571;
	Wed, 10 Jun 2026 18:13:47 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.89.149])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE1A51954B0C;
	Wed, 10 Jun 2026 18:13:45 +0000 (UTC)
From: Steve Grubb <sgrubb@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>, Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, Paul Moore <paul@paul-moore.com>,
 Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH] audit: add missing syscalls to PERM class tables
Date: Wed, 10 Jun 2026 14:13:44 -0400
Message-ID: <2021591.7Z3S40VBb9@x2>
Organization: Red Hat
In-Reply-To:
 <CAABTaaBBVP6eY8D+a1KTgfZ3x8v3egnKTiQLRQfXPiOhpmQXjg@mail.gmail.com>
References:
 <20260610164719.2668906-1-rrobaina@redhat.com>
 <476e0a44-c6fb-4e6a-af56-a9f1d054518a@app.fastmail.com>
 <CAABTaaBBVP6eY8D+a1KTgfZ3x8v3egnKTiQLRQfXPiOhpmQXjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wednesday, June 10, 2026 1:40:47=E2=80=AFPM Eastern Daylight Time Ricard=
o Robaina=20
wrote:
> On Wed, Jun 10, 2026 at 2:05=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wro=
te:
> > On Wed, Jun 10, 2026, at 18:47, Ricardo Robaina wrote:
> > > diff --git a/include/asm-generic/audit_read.h
> > > b/include/asm-generic/audit_read.h
> > > index fb9991f53fb6..8feebc5b4c50 100644
> > > --- a/include/asm-generic/audit_read.h
> > > +++ b/include/asm-generic/audit_read.h
> > > @@ -18,3 +21,19 @@ __NR_fgetxattr,
> > >=20
> > >  #ifdef __NR_readlinkat
> > >  __NR_readlinkat,
> > >  #endif
> > >=20
> > > +#ifdef __NR_file_getattr
> > > +__NR_file_getattr,
> > > +#endif
> > > +#ifdef __NR_stat
> > > +__NR_stat,
> > > +#endif
> > > +#ifdef __NR_lstat
> > > +__NR_lstat,
> > > +#endif
> > > +#ifdef __NR_fstat
> > > +__NR_fstat,
> > > +#endif
> > > +#ifdef __NR_newfstatat
> > > +__NR_newfstatat,
> > > +#endif
> > > +__NR_statx,
> >=20
> > There are additional variants of 'stat' that I think you need
> > to cover here:
> >=20
> > scripts/syscall.tbl:79  stat64  fstatat64                     =20
> > sys_fstatat64 scripts/syscall.tbl:80  stat64  fstat64                  =
=20
> >      sys_fstat64 arch/x86/entry/syscalls/syscall_32.tbl:18       i386  =
=20
> > oldstat                 sys_stat
> > arch/x86/entry/syscalls/syscall_32.tbl:28       i386    oldfstat       =
=20
> >        sys_fstat arch/x86/entry/syscalls/syscall_32.tbl:84       i386  =
=20
> > oldlstat                sys_lstat
> > arch/x86/entry/syscalls/syscall_32.tbl:195      i386    stat64         =
=20
> >        sys_stat64                      compat_sys_ia32_stat64
> > arch/x86/entry/syscalls/syscall_32.tbl:196      i386    lstat64        =
=20
> >        sys_lstat64                     compat_sys_ia32_lstat64
> > arch/x86/entry/syscalls/syscall_32.tbl:197      i386    fstat64        =
=20
> >        sys_fstat64                     compat_sys_ia32_fstat64
> > arch/x86/entry/syscalls/syscall_32.tbl:300      i386    fstatat64      =
=20
> >        sys_fstatat64                   compat_sys_ia32_fstatat64
> > arch/alpha/kernel/syscalls/syscall.tbl:224      common  osf_stat       =
=20
> >                sys_osf_stat arch/alpha/kernel/syscalls/syscall.tbl:225 =
=20
> >    common  osf_lstat                       sys_osf_lstat
> > arch/alpha/kernel/syscalls/syscall.tbl:226      common  osf_fstat      =
=20
> >                sys_osf_fstat
> Hi Arnd,
>=20
> Thanks for reviewing this patch! You're right, it seems all these stat
> variants should be added as well. Steve and Paul, correct me if I'm
> wrong here, please.

Alpha is unsupported. Those are True64 compatibility syscalls. You can=20
include it and #ifdef will filter it everywhere else.  But, yeah. I guess t=
he=20
rest are ok. I don't pay much attention to the 32 bit arches.

=2DSteve


