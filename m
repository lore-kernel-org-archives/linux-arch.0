From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V4 00/27] C-SKY(csky) Linux Kernel Port
Date: Fri, 14 Sep 2018 18:09:35 +0200
Message-ID: <CAK8P3a0ZBBL8LHoV=tDr3Ner6wRK=QcrepciZqCPNEHk=B2n7A@mail.gmail.com>
References: <cover.1536757532.git.ren_guo@c-sky.com> <CAK8P3a0CUYyMR9hDG97Zf2Oyj+D9vwQRnPZrEs0rrOLwHqxYfw@mail.gmail.com>
 <20180914143719.GA27689@guoren-Inspiron-7460> <CAK8P3a0fZYbd4a2nBnExPVXKs-898R9vaCSa4kXyz0qA=rCzZQ@mail.gmail.com>
 <20180914160231.GA32161@guoren-Inspiron-7460>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180914160231.GA32161@guoren-Inspiron-7460>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, DTML <devicetree@vger.kernel.org>, andrea.parri@amarulasolutions.com, Peter Zijlstra <peterz@infradead.org>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-arch.vger.kernel.org

On Fri, Sep 14, 2018 at 6:02 PM Guo Ren <ren_guo@c-sky.com> wrote:
>
> On Fri, Sep 14, 2018 at 04:46:56PM +0200, Arnd Bergmann wrote:
> > On Fri, Sep 14, 2018 at 4:37 PM Guo Ren <ren_guo@c-sky.com> wrote:
>
> > One level below that, you can of course choose to build
> > a distro with only 64-bit time_t regardless of whether there
> > is still support for 32-bit time_t in kernel and glibc or not.
> Do you mean I could merge kernel port into linux-4.19 or linux-4.20.
> But let glibc merged after linux-4.21 and csky glibc only support
> time64 syscalls ?

Yes, that's what I meant. Note that it won't get merged into 4.19:
the merge window for that was after the 4.18 release and no
new features are getting merged for 4.19 that have not made it
into 4.19-rc1 already.

Getting your code into linux-next now is the prerequisite for you
sending a pull request during the 4.20 window.

     Arnd
