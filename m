From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v8 8/8] powerpc/vdso: Provide __kernel_clock_gettime64()
 on vdso32
Date: Tue, 28 Apr 2020 18:05:03 +0200
Message-ID: <CAK8P3a2aXJRWjxWO8oMRX2AJkfeVeeoYbOPbpd9-UTgjqM4B7g@mail.gmail.com>
References: <cover.1588079622.git.christophe.leroy@c-s.fr> <e78344d3fcc1d33bfb1782e430b7f0529f6c612f.1588079622.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:44447 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbgD1QFW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Apr 2020 12:05:22 -0400
In-Reply-To: <e78344d3fcc1d33bfb1782e430b7f0529f6c612f.1588079622.git.christophe.leroy@c-s.fr>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Nathan Lynch <nathanl@linux.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Andy Lutomirski <luto@kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On Tue, Apr 28, 2020 at 3:16 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
> Provides __kernel_clock_gettime64() on vdso32. This is the
> 64 bits version of __kernel_clock_gettime() which is
> y2038 compliant.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Looks good to me

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

There was a bug on ARM for the corresponding function, so far it is unclear
if this was a problem related to particular hardware, the 32-bit kernel code,
or the common implementation of clock_gettime64 in the vdso library,
see https://github.com/richfelker/musl-cross-make/issues/96

Just to be sure that powerpc is not affected by the same issue, can you
confirm that repeatedly calling clock_gettime64 on powerpc32, alternating
between vdso and syscall, results in monotically increasing times?

       Arnd
