From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V4 00/27] C-SKY(csky) Linux Kernel Port
Date: Sun, 16 Sep 2018 09:07:30 +0800
Message-ID: <20180916010729.GA18279@guoren-Inspiron-7460>
References: <cover.1536757532.git.ren_guo@c-sky.com>
 <CAK8P3a0CUYyMR9hDG97Zf2Oyj+D9vwQRnPZrEs0rrOLwHqxYfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a0CUYyMR9hDG97Zf2Oyj+D9vwQRnPZrEs0rrOLwHqxYfw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, DTML <devicetree@vger.kernel.org>, andrea.parri@amarulasolutions.com, Peter Zijlstra <peterz@infradead.org>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-arch.vger.kernel.org

On Wed, Sep 12, 2018 at 04:30:36PM +0200, Arnd Bergmann wrote:
> On Wed, Sep 12, 2018 at 3:25 PM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > This is the 3th version patchset to add the Linux kernel port for C-SKY(csky).
> > Thanks to everyone who provided feedback on the previous version.
> >
> > This patchset adds architecture support to Linux for C-SKY's 32-bit embedded
> > CPU cores and the patches are based on linux-4.18.4
> >
> > There are two ABI versions with several CPU cores in this patchset:
> >   ABIv1: ck610 (16-bit instruction, 32-bit data path, VIPT Cache ...)
> >   ABIv2: ck807 ck810 ck860 (16/32-bit variable length instruction, PIPT Cache,
> >          SMP ...)
> >
> > More information: http://en.c-sky.com
> 
> This looks good to me overall. I think a good next step would be to get the port
> included in linux-next, by preparing a git tree with all the patches and asking
> Stephen Rothwell to include it there. Further comments on the architecture
> port itself can be done on top of the existing patches. I would suggest you
> base the git tree on an -rc release (either 4.19-rc1 or 4.19-rc3) and then never
> rebase again.
Another question:
Could I add "Acked-by: Arnd Bergmann <arnd@arndb.de>" in all my comments?

Best Regards
 Guo Ren
