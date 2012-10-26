From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC][PATCH 0/5] tools, perf: Fix up for x86 UAPI disintegration
Date: Fri, 26 Oct 2012 13:33:19 +0900
Message-ID: <87liet97jk.fsf@sejong.aot.lge.com>
References: <20121024194619.GC17945@liondog.tnic>
	<20121019165558.23037.40181.stgit@warthog.procyon.org.uk>
	<20121024184337.GD13993@ghostprotocols.net>
	<8477.1351151840@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from LGEMRELSE1Q.lge.com ([156.147.1.111]:60744 "EHLO
	LGEMRELSE1Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753403Ab2JZEdW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 26 Oct 2012 00:33:22 -0400
In-Reply-To: <8477.1351151840@warthog.procyon.org.uk> (David Howells's message
	of "Thu, 25 Oct 2012 08:57:20 +0100")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, mingo@kernel.org, tglx@linutronix.de, davem@davemloft.net, torvalds@linux-foundation.org, paulus@samba.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org

Hi David,

On Thu, 25 Oct 2012 08:57:20 +0100, David Howells wrote:
> Borislav Petkov <bp@alien8.de> wrote:
>
>> David, where can get that x86 UAPI disintegration patch?
>
> The tip tree has it in branch x86/uapi or you can get it from:
>
> 	git://git.infradead.org/users/dhowells/linux-headers.git
>
> branch disintegrate-x86 or tag disintegrate-x86-20121009.
>
> I've posted a couple of additional patches to deal with files that be=
came
> empty, but they're only for dealing with people who construct their k=
ernel
> sources with the patch program.

I applied this series on top of you disintegrate-x86 branch which has
following commit.

commit 8d2c63c2b664bae1fb0f386661ea5f635330e570
Author: David Howells <dhowells@redhat.com>
Date:   Tue Oct 9 09:47:54 2012 +0100

    UAPI: (Scripted) Disintegrate arch/x86/include/asm
   =20
    Signed-off-by: David Howells <dhowells@redhat.com>
    Acked-by: Arnd Bergmann <arnd@arndb.de>
    Acked-by: Thomas Gleixner <tglx@linutronix.de>
    Acked-by: Michael Kerrisk <mtk.manpages@gmail.com>
    Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    Acked-by: Dave Jones <davej@redhat.com>


But I got a conflict like this:

--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@@ -112,7 -102,7 +102,11 @@@ void get_term_dimensions(struct winsiz
  #include <sys/types.h>
  #include <sys/syscall.h>
 =20
++<<<<<<< HEAD
 +#include "../../include/linux/perf_event.h"
++=3D=3D=3D=3D=3D=3D=3D
+ #include <linux/perf_event.h>
++>>>>>>> perf: Make perf build for x86 with UAPI disintegration applie=
d
  #include "util/types.h"
  #include <stdbool.h>

This was because your patch 3 has "uapi" between "include" and "linux".
It seems I need more patches to apply your series since there's no
perf_event.h under ../../include/uapi/linux directory.

Anyways, resolving the conflict resulted in build error:

    CC builtin-kvm.o
builtin-kvm.c:25:21: fatal error: asm/svm.h: No such file or directory
make: *** [builtin-kvm.o] Error 1

    CC util/evsel.o
In file included from util/perf_regs.h:5:0,
                 from util/evsel.c:23:
arch/x86/include/perf_regs.h:6:27: fatal error: asm/perf_regs.h: No suc=
h file or directory
make: *** [util/evsel.o] Error 1

    CC util/rbtree.o
=2E./../lib/rbtree.c:24:36: fatal error: linux/rbtree_augmented.h: No s=
uch file or directory
make: *** [util/rbtree.o] Error 1

    CC util/header.o
util/header.c:2276:8: error: =E2=80=98PERF_ATTR_SIZE_VER3=E2=80=99 unde=
clared here (not in a function)
make: *** [util/header.o] Error 1


Thanks,
Namhyung
