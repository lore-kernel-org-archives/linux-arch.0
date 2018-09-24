From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V4 00/27] C-SKY(csky) Linux Kernel Port
Date: Mon, 24 Sep 2018 10:47:09 +0200
Message-ID: <CAK8P3a0AVPL3nYF4HTM_jD8-vFn_ScSTnLMUku9vRdbwZQeD4g@mail.gmail.com>
References: <20180914143719.GA27689@guoren-Inspiron-7460> <mhng-9d591179-01d4-4a84-a490-8a09d4f3a3d1@palmer-si-x1c4>
 <CAK8P3a3v0K6G47dAVFtn+XjM3iM7vx6L_RB0mmONBDB9gBNgag@mail.gmail.com> <CAMuHMdVV0QWXCkkL8dq4UMLaANGMHu7ePhQ83FiFDtynpJzbLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVV0QWXCkkL8dq4UMLaANGMHu7ePhQ83FiFDtynpJzbLA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Palmer Dabbelt <palmer@sifive.com>, Guo Ren <ren_guo@c-sky.com>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, DTML <devicetree@vger.kernel.org>, andrea.parri@amarulasolutions.com, Peter Zijlstra <peterz@infradead.org>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-arch.vger.kernel.org

On Mon, Sep 24, 2018 at 9:21 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Arnd,
>
> On Fri, Sep 21, 2018 at 7:19 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thu, Sep 20, 2018 at 10:52 AM Palmer Dabbelt <palmer@sifive.com> wrote:
> > > On Fri, 14 Sep 2018 07:37:20 PDT (-0700), ren_guo@c-sky.com wrote:
> > > > On Wed, Sep 12, 2018 at 04:30:36PM +0200, Arnd Bergmann wrote:
> > > >> On Wed, Sep 12, 2018 at 3:25 PM Guo Ren <ren_guo@c-sky.com> wrote:
> > My plan was to get that all into 4.20, and then have a conversation about the
> > actual syscall table changes in 4.21. If we need it for both csky and rv32,
> > we might just change the generic syscall table that way in 4.21 without
> > changing all the other ones along with them. I don't want to drag things out
> > over too many merge windows though, and my plan was to do all architectures
> > together to simplify the version checks in the libc code to only have to check
> > for a single version.
>
> What happens with the version checks if it is backported to stable?

They end up as dead code.

The way these version checks are done in glibc, we always try the new
interface first before falling back to the old version, but don't check the
kernel version at runtime.

The compile-time check optimizes out the fallback if glibc is built for
a recent-enough minimum kernel version that is guaranteed to have
the new version.

      Arnd
