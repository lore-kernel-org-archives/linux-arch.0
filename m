Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38956 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbfB1MjJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 Feb 2019 07:39:09 -0500
Received: by mail-qt1-f193.google.com with SMTP id o6so23206418qtk.6
        for <linux-arch@vger.kernel.org>; Thu, 28 Feb 2019 04:39:09 -0800 (PST)
MIME-Version: 1.0
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <CAK8P3a1Q1uMFLs6eq26Rkv8hQdu0FkPUoq0gDnZPju-Eu1oHgQ@mail.gmail.com> <b02ee1da-e756-f7c7-ad8d-944b9b9e56e0@arm.com>
In-Reply-To: <b02ee1da-e756-f7c7-ad8d-944b9b9e56e0@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 28 Feb 2019 13:38:52 +0100
Message-ID: <CAK8P3a3__F6jRn6JC2hLWG5yvgV38rBRtjwZKN4cV=yAusuo8Q@mail.gmail.com>
Subject: Re: [PATCH v5 00/23] Unify vDSOs across more architectures
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190228123852.8aqFCaMxf7-At45wg0cbkYZw1qGHkrGZVNDS7aUp27E@z>

On Thu, Feb 28, 2019 at 1:09 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> thank you for testing my code.
>
> On 28/02/2019 11:40, Arnd Bergmann wrote:
> > On Fri, Feb 22, 2019 at 1:25 PM Vincenzo Frascino
> > <vincenzo.frascino@arm.com> wrote:
> >   ^
> >
> > I think this is all harmless, but we need to limit the set of header files
> > that can be included indirectly when compiling the vdso in arm32 mode.
> >
>
> I agree with you on the principle, but I am unable to replicate the warnings.
> Did you make any customization to the default defconfig? What is the top
> commit-id you have on your tree?

I observed this on top of v5.0-rc7 earlier, and have since rebased to
today's linux-next, where it still happens with the regular 'make defconfig',
on all compiler versions I have (4.8 through 8.1).

     Arnd
