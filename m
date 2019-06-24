From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v7 00/25] Unify vDSOs across more architectures
Date: Mon, 24 Jun 2019 02:34:24 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1906240142000.32342@nanos.tec.linutronix.de>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190621095252.32307-1-vincenzo.frascino@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Andy Lutomirski <luto@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, linux-arch@vger.kernel.org, Dmitry Safonov <dima@arista.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Russell King <linux@armlinux.org.uk>, Sasha Levin <sashal@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andre Przywara <andre.przywara@arm.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Michael Kelley <mikelley@microsoft.com>, Peter Collingbourne <pcc@google.com>, LAK <linux-arm-kernel@lists.infradead.org>, Andrei Vagin <avagin@openvz.org>, Huw Davies <huw@codeweavers.com>, LKML <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Shijith
List-Id: linux-arch.vger.kernel.org

Vincenzo,

On Fri, 21 Jun 2019, Vincenzo Frascino wrote:
> vDSO (virtual dynamic shared object) is a mechanism that the Linux
> kernel provides as an alternative to system calls to reduce where
> possible the costs in terms of cycles.
> This is possible because certain syscalls like gettimeofday() do
> not write any data and return one or more values that are stored
> in the kernel, which makes relatively safe calling them directly
> as a library function.
> 
> Even if the mechanism is pretty much standard, every architecture
> in the last few years ended up implementing their own vDSO library
> in the architectural code.

....
 
> This implementation contains the portings to the common library for: arm64,
> compat mode for arm64, arm, mips, x86_64, x32, compat mode for x86_64 and
> i386.

I picked up the core implementation and the ARM64 and x86 conversion. I did
some refinements in several places, coding style, naming conventions,
comments and changelogs including subject prefixes. Please double check!

I did not merge the ARM and MIPS parts as they lack any form of
acknowlegment from their maintainers. Please talk to those folks. If they
ack/review the changes then I can pick them up and they go into 5.3 or they
have to go in a later cycle. Nevertheless it was well worth the trouble to
have those conversions done to confirm that the new common library fits a
bunch of different architectures.

As you can see from the commit dates, this has soaked for some time in a
WIP branch and I did extensive regression testing. So far so good.

Thanks a lot for going through several iterations. It's a very much
appreciated effort!

Especially with the upcoming time namespaces this will avoid a lot of
duplicated and pointlessly different horrors all over the architecture
space. Any architecture which wants to gain that support needs to convert
to the generic VDSO first.

As you have become the dude who knows almost everything about VDSO
including all the nasty pitfalls, I propose the patch below.

Thanks,

	tglx

8<------------
Subject: MAINTAINERS: Add entry for the generic VDSO library
From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 24 Jun 2019 02:03:50 +0200

Asign the following folks in alphabetic order:

 - Andy for being the VDSO wizard of x86 and in general. He's also the
   performance monitor of choice and the code in the generic library is
   heavily influenced by his previous x86 VDSO work.

 - Thomas for being the dude who has to deal with any form of time(r)
   nonsense anyway

 - Vincenzo for being the poor sod who went through all the different
   architecture implementations in order to unify them. A lot of knowledge
   gained from VDSO implementation details to the intricacies of taming the
   build system.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 MAINTAINERS |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6665,6 +6665,18 @@ L:	kvm@vger.kernel.org
 S:	Supported
 F:	drivers/uio/uio_pci_generic.c
 
+GENERIC VDSO LIBRARY:
+M:	Andy Lutomirksy <luto@kernel.org>
+M:	Thomas Gleixner <tglx@linutronix.de>
+M:	Vincenzo Frascino <vincenzo.frascino@arm.com>
+L:	linux-kernel@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso
+S:	Maintained
+F:	lib/vdso
+F:	kernel/time/vsyscall.c
+F:	include/vdso
+F:	include/asm-generic/vdso/vsyscall.h
+
 GENWQE (IBM Generic Workqueue Card)
 M:	Frank Haverkamp <haver@linux.ibm.com>
 S:	Supported
