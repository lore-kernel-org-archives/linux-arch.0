From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 14/19] csky: Misc headers
Date: Tue, 20 Mar 2018 15:54:53 +0800
Message-ID: <CAK8P3a1TokZ_odmBFy5FWCLp2ExF+uYR2X_pn-MSPbuM26MZ2w@mail.gmail.com>
References: <cover.1521399976.git.ren_guo@c-sky.com> <9cb4cf158b8c73325dc524cba8d575e41647131f.1521399976.git.ren_guo@c-sky.com>
 <CAK8P3a15wbEmejpiokATLW=Cwe-XHZEdgU8fNQY-opjbjuU3-w@mail.gmail.com> <20180320033654.GA21731@guoren>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180320033654.GA21731@guoren>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
List-Id: linux-arch.vger.kernel.org

On Tue, Mar 20, 2018 at 11:36 AM, Guo Ren <ren_guo@c-sky.com> wrote:
> Hi Arnd,
>
> On Tue, Mar 20, 2018 at 12:11:24AM +0800, Arnd Bergmann wrote:
>> On Mon, Mar 19, 2018 at 3:51 AM, Guo Ren <ren_guo@c-sky.com> wrote:
>> > +++ b/arch/csky/include/uapi/asm/fcntl.h
>> > @@ -0,0 +1,13 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> > +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
>> > +#ifndef __ASM_CSKY_FCNTL_H
>> > +#define __ASM_CSKY_FCNTL_H
>> > +
>> > +#define O_DIRECTORY    040000
>> > +#define O_NOFOLLOW     0100000
>> > +#define O_DIRECT       0200000
>> > +#define O_LARGEFILE    0400000
>> > +
>> > +#include <asm-generic/fcntl.h>
>>
>> This should just use the generic file without overrides: Please don't diverge
>> from the generic syscall ABI.
>>
>
> It's a stupid copy from arm/include/uapi/asm/fcntl.h and the csky/bits/fcntl.h
> in uclibc-ng and glibc are also defined with:
>
> #define __O_DIRECTORY    040000 /* Must be a directory.  */
> #define __O_NOFOLLOW    0100000 /* Do not follow links.  */
> #define __O_DIRECT      0200000 /* Direct disk access.  */
> #define __O_LARGEFILE   0400000
>
> So may I keep it for a while?
> (I will let glibc uclibc-ng csky/bits/fcntl.h include the linux/uapi/asm/fcntl.h
> first.)

We generally assume that any upstream kernel ABI cannot be changed, so this
has to be changed before the code gets merged upstream.

You can obviously maintain the old and the new ABI in parallel for a while,
until the libc supports the new ABI, but you can't do that in the patches
you send for integration.

This is more important for the list of system calls, but when you change
the ABI, it should be changed all at once.

           Arnd
