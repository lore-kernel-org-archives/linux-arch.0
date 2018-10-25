From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V9 01/21] csky: Build infrastructure
Date: Fri, 26 Oct 2018 01:04:08 +0800
Message-ID: <20181025170407.GA9747@guoren-Inspiron-7460>
References: <cover.1539655731.git.ren_guo@c-sky.com>
 <801add6d63256a3bf0802e2b03efb0f9c206dab0.1539655731.git.ren_guo@c-sky.com>
 <20181023000834.GA20335@guoren-Inspiron-7460>
 <CAK8P3a2coXVaaiZUcxsp8DmWcVdBrDMomYAN--M42TuSnHxKNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a2coXVaaiZUcxsp8DmWcVdBrDMomYAN--M42TuSnHxKNA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Oct 24, 2018 at 11:53:05PM +0100, Arnd Bergmann wrote:
> On Tue, Oct 23, 2018 at 1:08 AM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > Hi Arnd,
> >
> > Could you help me review the patch, seems the patch is skipped.
> > ref: https://lkml.org/lkml/2018/10/16/224
> 
> Ah right, I missed that. I think I originally had some thoughts on it but
> didn't immediately comment and then forgot about it. It's basically
> ok, so
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
Thx.

> 
> but please have a look below for a follow-up patch:
> 
> > > diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
> > > new file mode 100644
> > > index 0000000..014eb57
> > > --- /dev/null
> > > +++ b/arch/csky/include/asm/Kbuild
> > > @@ -0,0 +1,72 @@
> > > +generic-y += asm-offsets.h
> > > +generic-y += bitsperlong.h
> > > +generic-y += bugs.h
> > > +generic-y += clkdev.h
> > > +generic-y += compat.h
> > > +generic-y += current.h
> > > +generic-y += delay.h
> > > +generic-y += device.h
> > > +generic-y += div64.h
> ...
> > > +generic-y += errno.h
> ...
> > > +generic-y += ioctl.h
> > > +generic-y += ioctls.h
> 
> A number of the header files that are marked as generic-y in
> asm/Kbuild are also marked the same way in uapi/asm/Kbuild.
> I think this is a mistake, since we only need one of the two
> for each header.
> 
> When both exist, we just take the one from asm/, but then we install
> the uapi/asm/ version in the 'make headers_install' stage, and they
> both have the same contents, so I think you only need the uapi/asm/
> version here.
Ok, I've cleaned them up.

> 
> > > diff --git a/arch/csky/include/uapi/asm/Kbuild b/arch/csky/include/uapi/asm/Kbuild
> > > new file mode 100644
> > > index 0000000..b65252b
> > > --- /dev/null
> > > +++ b/arch/csky/include/uapi/asm/Kbuild
> > > @@ -0,0 +1,33 @@
> > > +include include/uapi/asm-generic/Kbuild.asm
> > > +
> > > +header-y += cachectl.h
> > > +header-y += stat.h
> 
> It also seems that the second statement here (for stat.h) is from
> an older version, since that header no longer exists, at least if
> I'm reading your patches correctly.
Yes, no "header-y += stat.h" and I've removed it.

Thx for the reviewed.

Best Regards
 Guo Ren
