Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45373D6691
	for <linux-arch@vger.kernel.org>; Wed, 18 Mar 2026 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773838942; cv=pass; b=cAC/Xw0bdt5T+FucbVCjVuHcU1fUNJJHhNoEO7UDq6KDCfpNSvkXuz8pV88bOr8PxBaDYe+mNhvho3vZlGcydFDKEIzEpZXC/WDPS34eqALmb390G0+8t8RSmsw09ltqAsEheNZwWVLdUEfzXZ9VnqwClnZGmH0gsnRK+m7Af7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773838942; c=relaxed/simple;
	bh=o3lTuve6FmrHLuXOIXAYjieyDtwft4teOpVhSgSXuTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ROn5Ud4zS5bL8ZM09c/pDRf7BJwZDxSQw6L7PH+uaj3YGUb4gu+IJp/I3Oqay6n+6Ho9pvO1xZyCVwBRv+w0ev4hvrvDqTBtYPQBGcIhkyTyq/FisazC8Oq2yetQ7PjNgA/m6+wzcmglf3/cP5y8uORimJiJ2q692Ee/bD/8MaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FazfpTgo; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FazfpTgo"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-798374d0f44so13772827b3.0
        for <linux-arch@vger.kernel.org>; Wed, 18 Mar 2026 06:02:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773838940; cv=none;
        d=google.com; s=arc-20240605;
        b=KBu6Xf+zZPgiXTfIGfcd/YvyE6zCQkjGbJsEjM/Gpxfczx15kPZ00XO9Wy2xJnGWaU
         cT1LdsoeD3/I/lrzAQeDoVbVotTWvN8YKkJdpAEXV3o6mhzUqGkwabYbdrEfrpFHFqvO
         FN/3jY1MgWfbVdVo1nLV1f3v5Tmu7DQ5f1j4+2kTiyfn5nV8JGikfytNfqXURaySGFNb
         CUJoaCYXGq84cEn00MBxULox1/lA2kc3O0vr2aIX/2KW3Lviwmbzqjxibrsx3xtMhJXa
         2rL9OQtv/Of/rRw1Hdr7Z6ZrETt9+zyrJZrHT1swZkhngDsipKT38Q/zPChhYOVbZGjq
         9i/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YGyN3/V2lLSysih1vfA5X+2mQdHmhSaVpBXGZaNdkck=;
        fh=Amdj+xk8udopDR3LIjfdCCVOfQRPXe+Kv1wVXG5T7ZQ=;
        b=A9T9HlRC2uI23+MVlS23AxQjZ1Lq6+zLN37Uy90iCDjEdj4KpTgJfLgR/c+HB6Xa//
         iQ3m8RguUFMNQhpPeJ0sfpntcS0nCGN2cno7nJ1sGyWSBgU2LI5a6Z9Wl+9jf+aSQPBl
         WhoDfOQ4/R6ZjVJMT4CMKMFniIh7UqAQQiR2MpJSdZqP+02q2z3J7INVjWuXBrADlKwz
         oP/cBLqN1N9mLfRL1GY7T4JsLJ9a652uYEe0RYwDlAdEURS243/GsbTWoPY14uVTydrP
         LLHJ89XnBgI0VkifwXjQf3WGbknYtz4T1M75dczJlyX2VQZdv+nh9udShsA94AFctd8o
         C2kQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773838940; x=1774443740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGyN3/V2lLSysih1vfA5X+2mQdHmhSaVpBXGZaNdkck=;
        b=FazfpTgoaMRNlcWM/bvP5zgJAKIZvcpjZ9vehnHfNaiVepkryP0MZe7oI57+Q8W1I5
         tcIxNdqWnYxYt1EjUqazHgUH08NvyFssvpRohTzCjoVKP5eTr6MreFqNcJybODSdmD1L
         110IWpf4NjjLI6aySM6vvzLQLjfC+kDrK0rt8aHc7DdjxohMbU7DNjUe/1FqlyRdEsL+
         yDcu3xsiPNMYcjWIk8cPp0f/F3UuUl8rbUbWXcM4JyxDjA9HQ/iqooRm4iHIkUnMmsMO
         6OLqgdJFlXRgUeN/TzoWnBI7cpx8Yu19FInHuK/jL02teLSmeqG7TaV5sWWZs62FsnnR
         ZFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773838940; x=1774443740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YGyN3/V2lLSysih1vfA5X+2mQdHmhSaVpBXGZaNdkck=;
        b=TcMeQKMW0ui3eSDSLR7TIRIJQVfbb3l5q2f6GQVdni1z5dgBN/rK/hwlm7L38USvYM
         CmFS6HQk6vDMGLb3g/4Rtt88p3pqeuTY2Q0+19OWgOvLvcM/ZrEe2sR61Bin5WYt5que
         CYvmY2C7+lfEifO29eje4t8MLMmFtpV9pXNbKW0cchHewMwoeEP7wBY2zvARlmCeQNOf
         KstaXJP2Uwd4FquObqf4jxPlG2JMGvcXigo5an1tC8s3HT0Vk8winfHcJKdkacQk0o5p
         srWXbVJPVWHD10zR9d1rC0QmRXoMwhaoVdgpMvKFkLSXqJEunGvYEt7qn5IcWle8iXmg
         dqcw==
X-Forwarded-Encrypted: i=1; AJvYcCWTcuKIDogjQlEiq0ZVcQ0T681bQYimpnrU8mu9kI9Khskd19294ggcFOsS2o/VMx1x+LD7kfgHyrn7@vger.kernel.org
X-Gm-Message-State: AOJu0YzWx4cPY1441oqcm6CBQOCB7dYfmenWKwo2Vweqdw4i61xK5Fsi
	xeHkE/3EVXfLstQ6i+mVjj4Nh7KRIvenZH9OH7BM/P8dDpdRF6CNMAdvg1jaTaa+i9kwPeVMVDJ
	pkp/B5S237rUnD2tFGETuzkDBm3s7X+Q=
X-Gm-Gg: ATEYQzyyB1T/cH6cp3J320RnW4PLp7ajC0cPsmT7QNojf1QP/Eu5WhZcBTzWnWMcbHZ
	rxDR7tEg0u/sCGa5ZZMaE/zT3pVblkGkTLcDVvWHHDklpODIKp1rdJsl8zX+TH1stVPehFczFoF
	D25jO9vM9i5+wPUi07PH58DNRqtcjPT4COXd7zsFOtkgRdSW7VL2o4huwT0gQTd3Q+bvqqQPFu1
	9rcrkUX+xipqa8iEB0pkI7EOKlfAvzjnBky/TQlL4LsFo8nIFiY5j+kfYZQVGu8ExOl8f/QUErl
	FbtVS147R2M7Q5bsX95Q43yNfc2RHGS3MjgLxzWO
X-Received: by 2002:a05:690c:6e86:b0:79a:7cff:7b7e with SMTP id
 00721157ae682-79a7cff7f4dmr5215507b3.30.1773838939458; Wed, 18 Mar 2026
 06:02:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260315214656.658590-1-academic1mathura@gmail.com>
 <CAMuHMdV4MTNUmZdqMd+PhChDLL6yom2zj1bsiJfiK5+gr+j7Ow@mail.gmail.com>
 <CA+QNo20REG+nJLCJBYtOJfsTiwr-7L637BJgP7XURE7QdJw=kA@mail.gmail.com>
 <CA+QNo23jM2_puZGi3FsiyU4VxMuqbTEuz9MaLKt58ss=VQz-nw@mail.gmail.com> <CA+QNo23xYi3NOZ8BY0FzLQKgmjaCQCTsnAyeppJ7TQWiiPjKHw@mail.gmail.com>
In-Reply-To: <CA+QNo23xYi3NOZ8BY0FzLQKgmjaCQCTsnAyeppJ7TQWiiPjKHw@mail.gmail.com>
From: Mathura <academic1mathura@gmail.com>
Date: Wed, 18 Mar 2026 18:32:08 +0530
X-Gm-Features: AaiRm52Ff2DIXoqXu75ZhcWH-XD65064XDZtJW7Y8YQuJ1_IgHzQTjnmEGhU9Hw
Message-ID: <CA+QNo21D1nkwFs8KPni2mKHMvNcNCGkWtn8xiNCWieVV1apq-A@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Add new system call for non-destructive peek and
 inspection to posix ipc mqueue
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: brauner@kernel.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For context, in the old series of patches, the following major serious
implementation issues and  minor issues were pointed out in feedback
and I  carefully handled all of them in this new series. The earlier
series was messed up, and for some reason, after taking all the
feedback in new one, I just want to move on from there so i started
fresh new patch:

1) Busted implementation leading to bad user space pointer handling

2) Unnecessary obsolete time32 version

3) Some architectures have missing and inconsistent new syscall
numbers in the table

4) Misc. minor issues

     Thanks
    Mathura


On Wed, 18 Mar 2026 at 16:56, Mathura <academic1mathura@gmail.com> wrote:
>
> Hi Geert Uytterhoeven,
> Just forget everything that about  work submitted in two weeks ago
> Patch,that is a waste of time to talk, earlier work is  messed up ,no
> modularity , Please focus on the current version that has all related
> information in the cover letter.
> This is fresh work -
>  v1- https://lore.kernel.org/20260306075009.83723-1-academic1mathura@gmai=
l.com
>  v2-  https://lore.kernel.org/linux-arch/CAMuHMdV4MTNUmZdqMd+PhChDLL6yom2=
zj1bsiJfiK5+gr+j7Ow@mail.gmail.com/T/#t
>
> I am resending this email as I was out of station earlier. The main
> list could not be submitted previously because plain text mode was not
> accessible on my phone.
>
> Kindly review the resubmitted details.
>
> Thank you for your understanding.
>
>
> On Wed, 18 Mar 2026 at 15:49, Mathura <academic1mathura@gmail.com> wrote:
> >
> > Hi Greet,
> > Just forget everything that about  work submitted in two weeks ago Patc=
h,that is a waste of time to talk, earlier work is  messed up ,no modularit=
y , Please focus on the current version that has all related information in=
 the cover letter.
> > This is fresh work -
> >  v1- https://lore.kernel.org/20260306075009.83723-1-academic1mathura@gm=
ail.com
> >  v2-  https://lore.kernel.org/linux-arch/CAMuHMdV4MTNUmZdqMd+PhChDLL6yo=
m2zj1bsiJfiK5+gr+j7Ow@mail.gmail.com/T/#t
> > Thanks
> >
> > On Wed, 18 Mar 2026 at 15:20, Mathura <academic1mathura@gmail.com> wrot=
e:
> >>
> >> I have discarded all previous work and earlier patches, as most of the=
 implementation has been redone from scratch using a completely new approac=
h.
> >> Therefore, please disregard the patches from two weeks ago and review =
this as a fresh series.
> >>
> >> Thanks
> >>
> >>
> >> On Wed, 18 Mar, 2026, 2:01=E2=80=AFpm Geert Uytterhoeven, <geert@linux=
-m68k.org> wrote:
> >>>
> >>> Hi Mathura,
> >>>
> >>> On Sun, 15 Mar 2026 at 22:47, Mathura_Kumar <academic1mathura@gmail.c=
om> wrote:
> >>> > Patch series overview:
> >>> >
> >>> >   1. Add New system call do_mq_timedreceive2() and handler implemen=
tation
> >>> >   2. Add system call number in all  most common arch.
> >>> >   3. Prepared Documentation and test
> >>> >   4. Add entry in performance tools all most common file
> >>> >
> >>> >
> >>> > Short Description:
> >>> >
> >>> >     POSIX message queues currently lack a mechanism to read
> >>> >     a message without removing it from the queue. This is a
> >>> >     long-standing limitation,when we require inspection of queue st=
ate
> >>> >     without altering it.
> >>>
> >>> [...]
> >>>
> >>> Thanks for your series!
> >>>
> >>> > change since v1:
> >>> >  - minor update, header guard was removed from include/uapi/linux/m=
queue.h
> >>> >  - v1 Link: https://lore.kernel.org/all/20260315040827.156558-1-aca=
demic1mathura@gmail.com/T/#t
> >>>
> >>> Weren't you at v5 before, so how did you get to v1 and v2 again?
> >>> What has changed?
> >>>
> >>> "[PATCH] [PATCH V5] mqueue: introduce new do_mq_timedreceive2() [
> >>> mq_peek syscall] for non-destructive receive and inspection,fix minor
> >>> issue,prepared doc."
> >>> https://lore.kernel.org/20260306075009.83723-1-academic1mathura@gmail=
.com
> >>>
> >>> Gr{oetje,eeting}s,
> >>>
> >>>                         Geert
> >>>
> >>> --
> >>> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linu=
x-m68k.org
> >>>
> >>> In personal conversations with technical people, I call myself a hack=
er. But
> >>> when I'm talking to journalists I just say "programmer" or something =
like that.
> >>>                                 -- Linus Torvalds
