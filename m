Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44091 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728989AbfARTbP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jan 2019 14:31:15 -0500
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de> <20190118161835.2259170-14-arnd@arndb.de>
 <20190118171830.quvvwdgbuhq2nqrh@lt-gp.iram.es>
In-Reply-To: <20190118171830.quvvwdgbuhq2nqrh@lt-gp.iram.es>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 18 Jan 2019 20:30:57 +0100
Message-ID: <CAK8P3a1R8BfAnNGvBa-hoQBL3uJQ5bJ0_YO91YLv8pp3-nAe3Q@mail.gmail.com>
Subject: Re: [PATCH v2 13/29] arch: add split IPC system calls where needed
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Gabriel Paubert <paubert@iram.es>
Cc: y2038 Mailman List <y2038@lists.linaro.org>, Linux API <linux-api@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Max Filippov <jcmvbkbc@gmail.com>, Deepa Dinamani <deepa.kernel@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Helge Deller <deller@gmx.de>, the arch/x86 maintainers <x86@kernel.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Firoz Khan <firoz.khan@linaro.org>, Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>, Parisc List <linux-parisc@vger.kernel.org>, Networking <netdev@vger.kernel.org>, linux-mips@vger.kernel.org, Paul Burton <paul.burton@mips.com>, "Eric W . Biederman" <ebiederm@xmission.com>, alpha <linux-alpha@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, David Miller <davem@davemloft.net>
Message-ID: <20190118193057.6RPdFZ3c7qcxUPFNYt4c_cH7eilaYS97qo4ASff2SjM@z>

On Fri, Jan 18, 2019 at 6:20 PM Gabriel Paubert <paubert@iram.es> wrote:
>
> On Fri, Jan 18, 2019 at 05:18:19PM +0100, Arnd Bergmann wrote:
> > The IPC system call handling is highly inconsistent across architectures,
> > some use sys_ipc, some use separate calls, and some use both.  We also
> > have some architectures that require passing IPC_64 in the flags, and
> > others that set it implicitly.
> >
> > For the additon of a y2083 safe semtimedop() system call, I chose to only
>
> It's not critical, but there are two typos in that line:
> additon -> addition
> 2083 -> 2038

Fixed both, thanks!

     Arnd
