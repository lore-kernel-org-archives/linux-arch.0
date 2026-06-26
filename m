Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1112B3E00A3
	for <linux-arch@vger.kernel.org>; Fri, 26 Jun 2026 08:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782462475; cv=none; b=XWB01ELyw1Vq2eJm38chPITtAJAVycjv32ufKOkMmJKs0SGMqzDjhW/Lv4Qxl1/x/WcuxKgcT9cVLiPjA0F1kM/Ucd0XyHTlGPraAi4Sv4apO4vBJqO7WxbViM/e/IjJUHX8VO7G6gAOklTKJuLpuoCotoP3MmsDBblqJoi2BNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782462475; c=relaxed/simple;
	bh=zuf6ntfPTW462871MTn9iuX+pcWTpeY3OFHEjvBsUmw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JkmvjcEo5nn/PS8suS9gyY5JfpW7fMouDt/7LqKk8l+nPtURi9+Ccq8x22IrjckFcqQClJkJMRHixf0bDWQemNR8Wu0ShOjbxk84sx0YgP86rLN3p9BOPhlPw3lWvA2W40YqSnO6a7WhgLzLCCp9ypUDIRjX/jtncAbICjjFHio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuQ4qUsx; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuQ4qUsx"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490b613a17bso6417805e9.3
        for <linux-arch@vger.kernel.org>; Fri, 26 Jun 2026 01:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782462472; x=1783067272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPblrGuL3HxTSPqhVNEf1Cuy4s+Ns4aI9V32Ls67imw=;
        b=VuQ4qUsx+cWNoimp2j+KEaMlEKsx6J7flpPXu/uCwRBlS0LPFCUDyGnk7Gd+EYk9aK
         il+5lgu0N+dhbh64JNF1FfVDtWS3EOwTEA7DPSBJLw4BKDTzHPemP0Ftf8FYZ614/Jzj
         EV+p0wKefRVA4EmFLrodWBZ6RH4EIEPFk8FFaB0sj8lv1XPVSsRZHAmK1UUlwhfMS3Hh
         2UFDsQO2vE9BJnHHbtGy9jViDAA5bvUgoTRby3xLcZd0H2kiVCxIFEfhUqU3se/4uz9y
         GMK8uPvMfIe+TXIeaRokXSiOP7QsSUU99yzH761XDm0a5/HuSdgbW3QCYffChpozoLLO
         TApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782462472; x=1783067272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LPblrGuL3HxTSPqhVNEf1Cuy4s+Ns4aI9V32Ls67imw=;
        b=CM1lSzYQ0S3azGfPjhWo6/+xlEcaObE+ZBzPBYetS4/fhlsRWsDtgiudVVsxl/m+d0
         qZVn7Vc8pcI/37I3kbZvVXsEy9xI60Riy+pZkppuaVGrtldNrD3WUX3mVBQ/jz8m+mAZ
         pKz4ssty6H3moMxGUxIZYwM9KPIUzXhPD8/V9eVXiRV2ugk1KyiKdWBNfp4B6aGDHy2s
         FgyTrBv0vA4YO/Tmfi8WYSL7gK01tKwDnUPTs5ZiVmUNBJIKX7+6WteRdhIXM4jQLXNy
         k5CJO+bupoOsOp46G5bfv5aeE1ANG2V+ZsvnTERk+FE7E2d02iPvDZEAU4aPV50D8Frp
         4y0w==
X-Forwarded-Encrypted: i=1; AFNElJ/aQb4I1dcVt+GRtCSSOZgxu07NBzS4x3B7Ul756jkLVzC9ps2HQM7pI3Sx6JD0gQg+NkJgvJ6LTOuf@vger.kernel.org
X-Gm-Message-State: AOJu0YzFa8emA/fOVYOiDxZ+EnFAUw8KH6q1PXqhgB16xREYtS5ksHvC
	GAtD2lDZqEO0n/BYsxksBzKBkSDYcmCtttFn3JlxmwVhxZgFbzGmVlV7
X-Gm-Gg: AfdE7cka8h4BtXmiMSlNrThbMJ2vcBAFElRPqgKfn48Lph+LOpXdbDKPw49D1Ebhb9+
	TCm12sJ4aH1CIQ09+6/FdkqiHOy/3S0BsnhF7VgbWTpse/jh+1qM4f2FJDXl42YI1Zn6vFTjm0Y
	CfLhirhHFVGnBLxSMVIANK5bkUixEF/v2jZj4LGGFIutbYjuiysRJ9gL575cF09abuYh5NrvaVG
	WHVGhm9oVo+vcYifj8hjw/fmUjnHTaooh292us3u7dEMoyiEZjmcEZMDNjZRIsQ0wa+9+RiUhbd
	dKSIL7bS5Q566NGIIYNjUFvf9w99CsPTfZK0Ie5VDIqvEqHPbaDK7k68ubY3dnA+X4cVE9GammZ
	6HmoamwqBqCBdc27aRUzyzhjmmJPKRx6Ms2FLdERvacIERH0JQ036YU7gFnEJjXUgg8m6LmWg0j
	6iF1QISi7abEVH0FwaziLYB3BPePKgqzeAuRtUMR4urbjlUtuYUA==
X-Received: by 2002:a05:600c:6094:b0:492:63c3:8eeb with SMTP id 5b1f17b1804b1-492668aa8b7mr81702715e9.35.1782462472357;
        Fri, 26 Jun 2026 01:27:52 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268fde98csm65311585e9.6.2026.06.26.01.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 01:27:52 -0700 (PDT)
Date: Fri, 26 Jun 2026 09:27:50 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: John Ericson <mail@johnericson.me>, "H. Peter Anvin" <hpa@zytor.com>, Al
 Viro <viro@zeniv.linux.org.uk>, Li Chen <me@linux.beauty>, Cong Wang
 <cwang@multikernel.io>, Christian Brauner <brauner@kernel.org>, linux-arch
 <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-api
 <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Jan Kara
 <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, Sergei Zimmerman
 <sergei@zimmerman.foo>, Farid Zakaria <farid.m.zakaria@gmail.com>
Subject: Re: [RFC] Null Namespaces
Message-ID: <20260626092750.58a8de9c@pumpkin>
In-Reply-To: <CALCETrWxi1g1wy2Bi4y6URW728Cmo8D3tchdMqs4GZ7S476iJA@mail.gmail.com>
References: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com>
	<20260624231219.GL2636677@ZenIV>
	<29cd3188-2d7c-4470-a39a-6648638f795e@zytor.com>
	<614b290f-e274-4eb2-b687-008b004de526@app.fastmail.com>
	<CALCETrWxi1g1wy2Bi4y6URW728Cmo8D3tchdMqs4GZ7S476iJA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 25 Jun 2026 16:09:58 -0700
Andy Lutomirski <luto@kernel.org> wrote:

> On Thu, Jun 25, 2026 at 2:53=E2=80=AFPM John Ericson <mail@johnericson.me=
> wrote:
> >
> > On Thu, Jun 25, 2026, at 5:00 PM, H. Peter Anvin wrote: =20
> > > On 2026-06-24 16:12, Al Viro wrote: =20
> > > > On Wed, Jun 24, 2026 at 06:51:47PM -0400, John Ericson wrote:
> > > > =20
> > > >> #### Null mount namespace
> > > >>
> > > >> - requires:
> > > >>
> > > >>   - null root file system: absolute paths don't work.
> > > >>
> > > >>   - null current working directory: relative paths with traditiona=
l,
> > > >>     non-`*at` system calls (and `*at` ones using `AT_FDCWD`) don't=
 work.
> > > >>
> > > >> - All operations relating to the "ambient" mount tree don't work.
> > > >>
> > > >> - `*at` operations with a file descriptor do work. =20
> > > >
> > > > Huh?  The last bit looks contradicts the previous one - if you have
> > > > an opened directory in a mount from some namespace, those `*at` ope=
rations
> > > > with that descriptor *will* be seeing the mount tree of that namesp=
ace,
> > > > whatever the hell is "ambient" supposed to mean.  Either that, or y=
ou
> > > > will be exposing whatever's overmounted in that mount, which is a h=
uge
> > > > can of worms. =20
> > >
> > > It seems to me that this is really no different *in practice* to havi=
ng an
> > > empty mount namespace, no? You might still be able to stat("/") and g=
et a
> > > d--------- result, but how does that actually affect anything? =20
> >
> > The argument against just having an empty, immutable root directory and
> > calling it a day is the tie-in with a new process-spawning API discussed
> > near the bottom of my original email. I want to have nice secure
> > defaults, rather than forcing the programmer to remember to unshare, but
> > I also don't want to degrade performance by speculatively creating new
> > empty mount namespaces that might just be thrown away. Null fields alone
> > get us both --- security and good performance. =20
>=20
> This seems like a false dichotomy.  There's such thing as a singleton.
>=20
> In fact, we have this spiffy nullfs_fs_get_tree.  It seems relatively
> straightforward to have an API to get an fd to the singleton nullfs,
> and the default for a newly spawned process could even be to have cwd
> pointing at nullfs.
>=20
> root is still harder, because of the shadowing issue.  I think I
> proposed, ages ago, relaxing the chroot rules so that, at least under
> certain circumstances (e.g. the task is not already chrooted) an
> unprivileged task could chroot.  chrooting to nullfs seems like a
> somewhat useful operation.
>=20
> I can imagine more complex schemes to allow even a chrooted process to
> safely start acting as though their root is nullfs, but that would be
> potentially fairly nasty.  *Maybe* everything would work if there was
> a root-for-dotdot and a separate root-for-absolute-paths, and
> nameidata->root could point to the former, but I'm certainly not
> willing to say that I think this would work with any confidence at
> all.

You'd also need to sort out the 'pwd' mess.
The kernel inode always has its real parent, inside a chroot the scan stops
when the inode is the same as that of the base of the chroot.
But faf about with namespaces (IIRC I was doing an unshare to get out of
a network namespace) and that comparison can fail (if the chroot base isn't
a mount point) - so "../.." can go all the way back to the real root rather
than stopping at the base of the chroot (as you would expect).

	David


>=20
> --Andy
>=20

