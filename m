From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V3 02/26] csky: defconfig
Date: Fri, 7 Sep 2018 09:43:22 +0800
Message-ID: <20180907014321.GA8288@guoren-Inspiron-7460>
References: <cover.1536138304.git.ren_guo@c-sky.com>
 <dc7a52f2c2571a85c87e163d49cecddd3c2f2430.1536138304.git.ren_guo@c-sky.com>
 <CAK8P3a1obhCyZcY6D-X7_HnGnHCO3+srZQXniThiMNqvxLSQzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a1obhCyZcY6D-X7_HnGnHCO3+srZQXniThiMNqvxLSQzA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 06, 2018 at 03:58:51PM +0200, Arnd Bergmann wrote:
> On Wed, Sep 5, 2018 at 2:08 PM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > ---
> >  arch/csky/configs/defconfig | 76 +++++++++++++++++++++++++++++++++++++++++++++
> > +CONFIG_USELIB=y
> 
> CONFIG_USELIB seems misplaced here, very few architectures can even
> call that, and it's not in the asm-generic/unistd.h file.
Ok, remove it.

> > +CONFIG_RELAY=y
> 
> relay is selected by drivers that need it, you should not need to turn
> it on here.
Ok, remove it.

> > +CONFIG_SYSCTL_SYSCALL=y
> 
> Also not in the asm-generic syscall table. We should probably hide the
> CONFIG_USELIB and CONFIG_SYSCTL_SYSCALL options so they
> only appear on architectures that can use them (patches welcome).
Ok, remove it.
> 
> > +CONFIG_KALLSYMS_ALL=y
> 
> While useful for debugging, this is also something I would not expect
> in the defconfig file
Ok, remove it.

> > +CONFIG_USERFAULTFD=y
> 
> Probably not needed either, unless you have a specific use
> case.
Ok, remove it.

> > +CONFIG_EMBEDDED=y
> 
> This (and CONFIG_EXPERT) is mostly there to expose options
> that are otherwise hidden for good reasons. Is there any option
> you tweak that depends on this? If not, then remove this as well.
Ok, remove it.

> > +CONFIG_PROFILING=y
> 
> This is only for oprofile, which new architectures should generally
> no longer implement. Better implement PERF only.
Ok, remove it and we will only implement perf in future.

> > +CONFIG_BLK_DEV_INTEGRITY=y
> 
> This is also fairly unusual.
Ok, remove it.
 
> > +CONFIG_EXT2_FS=y
> > +CONFIG_EXT2_FS_XATTR=y
> > +CONFIG_EXT2_FS_POSIX_ACL=y
> > +CONFIG_EXT2_FS_SECURITY=y
> > +CONFIG_EXT3_FS=y
> > +CONFIG_EXT3_FS_POSIX_ACL=y
> > +CONFIG_EXT3_FS_SECURITY=y
> 
> Better enable only EXT4 and drop EXT2/EXT3.
Ok.

> > +CONFIG_UNUSED_SYMBOLS=y
> 
> You should only need this to work around bugs, so
> I'd turn it off.
Ok, remove it.

 Guo Ren
