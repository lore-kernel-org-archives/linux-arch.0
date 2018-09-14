From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V4 00/27] C-SKY(csky) Linux Kernel Port
Date: Fri, 14 Sep 2018 16:46:56 +0200
Message-ID: <CAK8P3a0fZYbd4a2nBnExPVXKs-898R9vaCSa4kXyz0qA=rCzZQ@mail.gmail.com>
References: <cover.1536757532.git.ren_guo@c-sky.com> <CAK8P3a0CUYyMR9hDG97Zf2Oyj+D9vwQRnPZrEs0rrOLwHqxYfw@mail.gmail.com>
 <20180914143719.GA27689@guoren-Inspiron-7460>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180914143719.GA27689@guoren-Inspiron-7460>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, DTML <devicetree@vger.kernel.org>, andrea.parri@amarulasolutions.com, Peter Zijlstra <peterz@infradead.org>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-arch.vger.kernel.org

On Fri, Sep 14, 2018 at 4:37 PM Guo Ren <ren_guo@c-sky.com> wrote:
> On Wed, Sep 12, 2018 at 04:30:36PM +0200, Arnd Bergmann wrote:
> > On Wed, Sep 12, 2018 at 3:25 PM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > One big question for me is what to do about time_t. Deepa and I are
> > in the process of finalizing the system call ABI for 32-bit architectures
> > with 64-bit time_t, but we are not done yet and it won't be complete
> > for 4.20. If you target 4.21, that could be a chance to make csky the
> > first architecture to only need the 64-bit time_t interface, with the
> > corresponding user space changes.
> y2038 is very important and csky32 has the issue. But 4.21 is too late for
> us, we really want to get into kernel.org as soon as possible.
> We could remove 32-bit time_t in future.

Not really: the way we deal with user-visible APIs in the kernel, it's
practically impossible to remove something that was working before,
since there may always be users relying on it. This is why it is so
important that we get the ABI right at the first try.

We can always add new ABIs later, and that's what we're doing with
all the other 32-bit architectures as well: each system call that takes a
32-bit time_t argument also needs to get the corresponding 64-bit
replacement, and then we have to keep them both around.

However, once the 64-bit syscalls are there, you don't need to
use them, so if you merge the glibc port after both csky and
the time64 syscalls are merged upstream, you can choose
to only support the time64 syscalls rather than making it a compile
time decision in each application. If you merge the glibc port
before migrating to 64-bit syscalls, glibc will also have to support
both indefinitely for compatibility with existing binaries.

One level below that, you can of course choose to build
a distro with only 64-bit time_t regardless of whether there
is still support for 32-bit time_t in kernel and glibc or not.

        Arnd
