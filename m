From: "Luck, Tony" <tony.luck@intel.com>
Subject: ia64 broken by transparent huge pages - other arches too?
Date: Fri, 14 Jan 2011 09:50:45 -0800
Message-ID: <4d308cf5394566ccc@agluck-desktop.sc.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:57007 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757693Ab1ANRur (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 14 Jan 2011 12:50:47 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Arcangeli <aarcange@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org

Didn't Andrew make some rash promise at kernel summit about stopping
eating if "-mm" wasn't included in linux-next by the end of November?

Must be getting pretty hungry by now.

The transparent huge page code just arrived in the merge window
without having been in linux-next.  I see this error when trying
to build for ia64 from Linus' tree this morning:

In file included from /home/aegl/generic-smp/arch/ia64/include/asm/pgta=
ble.h:611,
                 from include/linux/mm.h:41,
                 from /home/aegl/generic-smp/arch/ia64/include/asm/uacc=
ess.h:39,
                 from include/linux/poll.h:14,
                 from include/linux/rtc.h:117,
                 from include/linux/efi.h:19,
                 from /home/aegl/generic-smp/arch/ia64/include/asm/sal.=
h:40,
                 from /home/aegl/generic-smp/arch/ia64/include/asm/mca.=
h:20,
                 from arch/ia64/kernel/asm-offsets.c:17:
include/asm-generic/pgtable.h: In function =E2=80=98pmdp_get_and_clear=E2=
=80=99:
include/asm-generic/pgtable.h:96: error: implicit declaration of functi=
on =E2=80=98__pmd=E2=80=99
include/asm-generic/pgtable.h:96: error: incompatible types in return
make[1]: *** [arch/ia64/kernel/asm-offsets.s] Error 1


Looks like arch/*/include/pgtable.h needs to define __pmd() but only x8=
6
was blessed with it.

-Tony
