From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic/io.h: remove unnecessary include of linux/vmalloc.h
Date: Tue, 5 Sep 2017 22:49:14 +0200
Message-ID: <CAK8P3a3ZK5BFZ=F4nKYOiwOanBN=um9XD+3GfcpcRMpZMFYscw@mail.gmail.com>
References: <20170905112727.13668-1-tklauser@distanz.ch> <CAK8P3a3R_12CdsL85tW+Y9cWMuQ0E-CMU9TyseLjj9GczbwnhA@mail.gmail.com>
 <20170905152134.GB5028@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34636 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752273AbdIEUtP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Sep 2017 16:49:15 -0400
In-Reply-To: <20170905152134.GB5028@distanz.ch>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tobias Klauser <tklauser@distanz.ch>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Sep 5, 2017 at 5:21 PM, Tobias Klauser <tklauser@distanz.ch> wrote:
> On 2017-09-05 at 17:11:50 +0200, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Tue, Sep 5, 2017 at 1:27 PM, Tobias Klauser <tklauser@distanz.ch> wrote:
>> > Including linux/vmalloc.h in asm-generic/io.h isn't necessary since none
>> > of the definitions are used in the header itself. Remove the include in
>> > order to avoid potential header dependency problems if other headers
>> > rely on implict inclusion of linux/vmalloc.h which means that changes
>> > there could break unrelated parts.
>> >
>> > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
>> > ---
>> >  include/asm-generic/io.h | 1 -
>> >  1 file changed, 1 deletion(-)
>> >
>> > diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
>> > index b4531e3b2120..d2d3bd163f5f 100644
>> > --- a/include/asm-generic/io.h
>> > +++ b/include/asm-generic/io.h
>> > @@ -764,7 +764,6 @@ static inline void iowrite64_rep(volatile void __iomem *addr,
>> >
>> >  #ifdef __KERNEL__
>> >
>> > -#include <linux/vmalloc.h>
>> >  #define __io_virt(x) ((void __force *)(x))
>> >
>> >  #ifndef CONFIG_GENERIC_IOMAP
>>
>> This seems like a good idea in principle, but I think it needs to be tested
>> well before we apply it, to avoid breaking random drivers that forgot to
>> add their own includes of that header.
>
> Yes, this certainly needs extensive testing. I already did several
> randconfig builds on multiple platforms locally. Also, I sent the same
> patch a while ago to LKML already as a fix (which wasn't sufficient) [1]
> in order to get the kbuild test bot to test it ;)
>
>   [1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1392578.html
>
> And indeed, the kbuild test bot failed on multiple drivers as a result
> of me submitting this patch back then and I successively sent patches to
> fix the fallout. Now all of them are merged.

I've done around 200 randconfig builds (x86, arm and arm64) now and
found two new issues so far, there will probably be a couple more, but
I can take care of the ones in arch/arm/mach-*/.

       Arnd

commit ac5fa2421993e6372214b95b533592a8be65fb49
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Tue Sep 5 21:13:58 2017 +0200

    ARM: add missing include statements

    After removing linux/vmalloc.h from asm-generic/io.h, a few other
    files fail:

    arch/arm/mach-shmobile/pm-r8a7779.c:35:13: error: expected '=',
',', ';', 'asm' or '__attribute__' before 'r8a7779_pm_init'
     void __init r8a7779_pm_init(void)
                 ^~~~~~~~~~~~~~~
    scripts/Makefile.build:311: recipe for target
'arch/arm/mach-shmobile/pm-r8a7779.o' failed
    In file included from arch/arm/mach-imx/devices/../mx3x.h:146:0,
                     from arch/arm/mach-imx/devices/../hardware.h:109,
                     from arch/arm/mach-imx/devices/platform-flexcan.c:8:
    arch/arm/include/asm/irq.h:39:50: error: unknown type name 'cpumask_t'

    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index e53638c8ed8a..6095a1649865 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -22,6 +22,8 @@
 #endif

 #ifndef __ASSEMBLY__
+#include <linux/cpumask.h>
+
 struct irqaction;
 struct pt_regs;
 extern void migrate_irqs(void);
diff --git a/arch/arm/mach-shmobile/pm-r8a7779.c
b/arch/arm/mach-shmobile/pm-r8a7779.c
index 5c9a93f5e650..a891101e0a85 100644
--- a/arch/arm/mach-shmobile/pm-r8a7779.c
+++ b/arch/arm/mach-shmobile/pm-r8a7779.c
@@ -10,7 +10,7 @@
  */

 #include <linux/soc/renesas/rcar-sysc.h>
-
+#include <linux/init.h>
 #include <asm/io.h>

 #include "r8a7779.h"
