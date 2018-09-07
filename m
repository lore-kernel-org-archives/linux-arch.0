Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:59237 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727212AbeIGHqh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2018 03:46:37 -0400
Date: Fri, 7 Sep 2018 11:07:25 +0800
From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V3 09/26] csky: VDSO and rt_sigreturn
Message-ID: <20180907030724.GA11594@guoren-Inspiron-7460>
References: <cover.1536138304.git.ren_guo@c-sky.com>
 <0f6a6aa2e458df2c3734cf60a68e6f69f0eb1e68.1536138304.git.ren_guo@c-sky.com>
 <CAK8P3a2z2=0qNWZft6rokx0i=8E5ZbEg1WL5HMYg_DE1wPvZQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2z2=0qNWZft6rokx0i=8E5ZbEg1WL5HMYg_DE1wPvZQw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Message-ID: <20180907030725.kNbHuXm6uUu-OH2lT5OdDafvALDv4FZgZxMBETz65ic@z>

On Thu, Sep 06, 2018 at 04:02:42PM +0200, Arnd Bergmann wrote:
> On Wed, Sep 5, 2018 at 2:08 PM Guo Ren <ren_guo@c-sky.com> wrote:
> 
> > +
> > +       /*
> > +        * __NR_rt_sigreturn must be 173
> > +        * Because gcc/config/csky/linux-unwind.h use hard code to parse rt_sigframe.
> > +        */
> > +       err = setup_vdso_page(vdso->rt_signal_retcode);
> > +       if (err) panic("Cannot set signal return code, err: %x.", err);
> 
> __NR_rt_sigreturn is 139
Yes, we've changed to use asm-generic define, and I forgot to update the
comment.

 Guo Ren
