Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36022 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbfARROv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jan 2019 12:14:51 -0500
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de> <be3863ae-d903-8e9e-5e6c-e4a58fac189d@blastwave.org>
In-Reply-To: <be3863ae-d903-8e9e-5e6c-e4a58fac189d@blastwave.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 18 Jan 2019 18:14:33 +0100
Message-ID: <CAK8P3a3xUpbk+Wpo5kdDtZ81jQuzEZH6jdmJJNeNM+acueg+Dw@mail.gmail.com>
Subject: Re: [PATCH v2 00/29] y2038: add time64 syscalls
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dennis Clarke <dclarke@blastwave.org>
Cc: y2038 Mailman List <y2038@lists.linaro.org>, Linux API <linux-api@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Matt Turner <mattst88@gmail.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Paul Burton <paul.burton@mips.com>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Rich Felker <dalias@libc.org>, David Miller <davem@davemloft.net>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Max Filippov <jcmvbkbc@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Deepa Dinamani <deepa.kernel@gmail.com>, "Eric W . Biederman" <ebiederm@xmission.com>, Firoz Khan <firoz.khan@linaro.org>, alpha <linux-alpha@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-ia64@vger.kernel.org, linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-mips@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Message-ID: <20190118171433.3CWXp-KOeNbIMv-I2lTY0zJW5kVwKWxwithIxUeBi-8@z>

On Fri, Jan 18, 2019 at 5:57 PM Dennis Clarke <dclarke@blastwave.org> wrote:
>
> On 1/18/19 11:18 AM, Arnd Bergmann wrote:
> > This is a minor update of the patches I posted last week, I
> > would like to add this into linux-next now, but would still do
> > changes if there are concerns about the contents. The first
> > version did not see a lot of replies, which could mean that
> > either everyone is happy with it, or that it was largely ignored.
> >
> > See also the article at https://lwn.net/Articles/776435/.
>
> I would be happy to read "Approaching the kernel year-2038 end game"
> however it is behind a pay wall.  Perhaps it may be best to just
> host interesting articles about open source idea elsewhere.

It's a short summary of the current state. You can also find a
video and slides from my ELC presentation online for a little more
context.

Generally speaking, I'd recommend paying for the subscription to
lwn.net to anyone interested in the kernel, but it should become
visible to everyone with the next day (a week after the initial
publication). In the meantime, you can find the article at
https://lwn.net/SubscriberLink/776435/a59d93d01d1addfc/.

Finally, I've made a list of the remaining work that Deepa
and I are planning to still continue (this should be mostly
complete but may be missing a few things):

syscalls
 - merge big series for 5.1, to allow time64 syscalls
 - waitid/wait4/getrusage should get a replacement based on __kernel_timespec
 - getitimer/setitimer should probably follow getrusage
 - vdso, waiting for consolidation series from Vincenzo Frascino before
   adding time64 entry points

file systems
 - range checks on timestamps
 - xfs
 - NFS
 - hfs/hfsplus
 - coda
 - hostfs
 - relatime_need_update

drivers
 - media
 - alsa
 - sockets
 - af_packet
 - ppp ioctl
 - rtc ioctl
 - omap3isp

core kernel
 - fix ELF core files (elfcore.h)
 - syscall Audit code (kernel/audit.c, kernel/auditsc.c)
 - make all time32 code conditional
 - remove include/linux/timekeeping32.h
 - remove compat_time* from time32.h
 - remove timeval
 - remove timespec
 - remove time_t

     Arnd
