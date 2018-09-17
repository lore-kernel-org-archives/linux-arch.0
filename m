From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V4 00/27] C-SKY(csky) Linux Kernel Port
Date: Mon, 17 Sep 2018 22:37:59 +0800
Message-ID: <20180917143759.GA2612@guoren-Inspiron-7460>
References: <cover.1536757532.git.ren_guo@c-sky.com>
 <CAK8P3a0CUYyMR9hDG97Zf2Oyj+D9vwQRnPZrEs0rrOLwHqxYfw@mail.gmail.com>
 <b5bbb3e5-d970-dd82-400f-ae13ca782fd5@c-sky.com>
 <20180917215443.3b5808c5@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180917215443.3b5808c5@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, DTML <devicetree@vger.kernel.org>, andrea.parri@amarulasolutions.com, Peter Zijlstra <peterz@infradead.org>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Sep 17, 2018 at 09:54:43PM +1000, Stephen Rothwell wrote:
> Hi Guo,
> 
> On Sun, 16 Sep 2018 12:53:26 +0800 Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > I'm Guo Ren from C-SKY and I'm working on csky linux port upstream.
> > I've prepared my git-tree based on linux-4.19-rc3:
> > git clone -b linux-next https://github.com/c-sky/csky-linux.git
> > 
> > Here is the pre-built cross compiler for fast test from our CI:
> > https://gitlab.com/c-sky/buildroot/-/jobs/97941896/artifacts/file/output/images/csky_toolchain_csky_ck860_platform_defconfig_72371bf75a51f27ea59fc34eeaf236e06b75bf69.tar.xz
> > 
> > You can also build newest gcc, binutils and they are upstreamed but not
> > released on gnu.org. Glibc is uptreaming now.
> > 
> > Please have a look and any feed back is welcome.
> 
> Added from today (called "csky").
> 
> Thanks for adding your subsystem tree as a participant of linux-next.  As
> you may know, this is not a judgement of your code.  The purpose of
> linux-next is for integration testing and to lower the impact of
> conflicts between subsystems in the next merge window. 
> 
> You will need to ensure that the patches/commits in your tree/series have
> been:
>      * submitted under GPL v2 (or later) and include the Contributor's
>         Signed-off-by,
>      * posted to the relevant mailing list,
>      * reviewed by you (or another maintainer of your subsystem tree),
>      * successfully unit tested, and 
>      * destined for the current or next Linux merge window.
> 
> Basically, this should be just what you would send to Linus (or ask him
> to fetch).  It is allowed to be rebased if you deem it necessary.

 I am very excited to receive your mail. I have been preparing for this
 for nearly 3 years.

 - All files are under GPL v2
 
 - All Contributors have been Signed-off.

 - All have been reviewed.

 - For develop detail you can find in: https://github.com/c-sky/csky-linux
   It records from 'Dec 2015' to 'Sep 2018'.

 - Here is the newest ltp test result: https://gitlab.com/c-sky/buildroot/-/jobs/98061317

 Best Regards
  Guo Ren
