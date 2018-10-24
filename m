Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35279 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeJYHXW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Oct 2018 03:23:22 -0400
MIME-Version: 1.0
References: <cover.1539655731.git.ren_guo@c-sky.com> <801add6d63256a3bf0802e2b03efb0f9c206dab0.1539655731.git.ren_guo@c-sky.com>
 <20181023000834.GA20335@guoren-Inspiron-7460>
In-Reply-To: <20181023000834.GA20335@guoren-Inspiron-7460>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 24 Oct 2018 23:53:05 +0100
Message-ID: <CAK8P3a2coXVaaiZUcxsp8DmWcVdBrDMomYAN--M42TuSnHxKNA@mail.gmail.com>
Subject: Re: [PATCH V9 01/21] csky: Build infrastructure
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20181024225305.Ql7zLV-C1xssOmBsl34-bDFfquoPW-j9SnGqMKl-OiE@z>

On Tue, Oct 23, 2018 at 1:08 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> Hi Arnd,
>
> Could you help me review the patch, seems the patch is skipped.
> ref: https://lkml.org/lkml/2018/10/16/224

Ah right, I missed that. I think I originally had some thoughts on it but
didn't immediately comment and then forgot about it. It's basically
ok, so

Acked-by: Arnd Bergmann <arnd@arndb.de>

but please have a look below for a follow-up patch:

> > diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
> > new file mode 100644
> > index 0000000..014eb57
> > --- /dev/null
> > +++ b/arch/csky/include/asm/Kbuild
> > @@ -0,0 +1,72 @@
> > +generic-y += asm-offsets.h
> > +generic-y += bitsperlong.h
> > +generic-y += bugs.h
> > +generic-y += clkdev.h
> > +generic-y += compat.h
> > +generic-y += current.h
> > +generic-y += delay.h
> > +generic-y += device.h
> > +generic-y += div64.h
...
> > +generic-y += errno.h
...
> > +generic-y += ioctl.h
> > +generic-y += ioctls.h

A number of the header files that are marked as generic-y in
asm/Kbuild are also marked the same way in uapi/asm/Kbuild.
I think this is a mistake, since we only need one of the two
for each header.

When both exist, we just take the one from asm/, but then we install
the uapi/asm/ version in the 'make headers_install' stage, and they
both have the same contents, so I think you only need the uapi/asm/
version here.

> > diff --git a/arch/csky/include/uapi/asm/Kbuild b/arch/csky/include/uapi/asm/Kbuild
> > new file mode 100644
> > index 0000000..b65252b
> > --- /dev/null
> > +++ b/arch/csky/include/uapi/asm/Kbuild
> > @@ -0,0 +1,33 @@
> > +include include/uapi/asm-generic/Kbuild.asm
> > +
> > +header-y += cachectl.h
> > +header-y += stat.h

It also seems that the second statement here (for stat.h) is from
an older version, since that header no longer exists, at least if
I'm reading your patches correctly.

         Arnd
