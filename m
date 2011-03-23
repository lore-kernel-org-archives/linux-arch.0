From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: smp: move smp setup functions to kernel/smp.c
Date: Wed, 23 Mar 2011 08:24:58 +0100
Message-ID: <20110323072457.GA4156@osiris.boeblingen.de.ibm.com>
References: <201103230200.p2N20TTN010372@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate6.uk.ibm.com ([194.196.100.166]:44268 "EHLO
	mtagate6.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954Ab1CWHZE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 Mar 2011 03:25:04 -0400
Received: from d06nrmr1307.portsmouth.uk.ibm.com (d06nrmr1307.portsmouth.uk.ibm.com [9.149.38.129])
	by mtagate6.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p2N7Oxjj028031
	for <linux-arch@vger.kernel.org>; Wed, 23 Mar 2011 07:24:59 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
	by d06nrmr1307.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p2N7PQ5Z1114286
	for <linux-arch@vger.kernel.org>; Wed, 23 Mar 2011 07:25:26 GMT
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p2N7OwOA000614
	for <linux-arch@vger.kernel.org>; Wed, 23 Mar 2011 01:24:58 -0600
Content-Disposition: inline
In-Reply-To: <201103230200.p2N20TTN010372@hera.kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amerigo Wang <amwang@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-arch@vger.kernel.org

On Wed, Mar 23, 2011 at 02:00:29AM +0000, Linux Kernel Mailing List wrote:
> Gitweb:     http://git.kernel.org/linus/34db18a054c600b6f81787165669dc572fe4de25
> Commit:     34db18a054c600b6f81787165669dc572fe4de25
> Parent:     fa9ee9c4b9885dfdf8eccac19b8b4fc8a7c53288
> Author:     Amerigo Wang <amwang@redhat.com>
> AuthorDate: Tue Mar 22 16:34:06 2011 -0700
> Committer:  Linus Torvalds <torvalds@linux-foundation.org>
> CommitDate: Tue Mar 22 17:44:11 2011 -0700
> 
>     smp: move smp setup functions to kernel/smp.c
>     
>     Move setup_nr_cpu_ids(), smp_init() and some other SMP boot parameter
>     setup functions from init/main.c to kenrel/smp.c, saves some #ifdef
>     CONFIG_SMP.
>     
>     Signed-off-by: WANG Cong <amwang@redhat.com>
>     Cc: Rakib Mullick <rakib.mullick@gmail.com>
>     Cc: David Howells <dhowells@redhat.com>
>     Cc: Ingo Molnar <mingo@elte.hu>
>     Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
>     Cc: Tejun Heo <tj@kernel.org>
>     Cc: Arnd Bergmann <arnd@arndb.de>
>     Cc: Akinobu Mita <akinobu.mita@gmail.com>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  include/linux/smp.h |    2 +
>  init/main.c         |   90 +--------------------------------------------------
>  kernel/smp.c        |   81 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 84 insertions(+), 89 deletions(-)
> 
> diff --git a/include/linux/smp.h b/include/linux/smp.h
> index 6dc95ca..48159dd 100644
> --- a/include/linux/smp.h
> +++ b/include/linux/smp.h
> @@ -114,6 +114,8 @@ int on_each_cpu(smp_call_func_t func, void *info, int wait);
>  void smp_prepare_boot_cpu(void);
> 
>  extern unsigned int setup_max_cpus;
> +extern void __init setup_nr_cpu_ids(void);
> +extern void __init smp_init(void);

This causes a build error on s390. The patch below will fix it.
Cc'ed linux-arch just in case other architectures are affected as well.

Subject: [PATCH] smp: add missing init.h include

From: Heiko Carstens <heiko.carstens@de.ibm.com>

34db18a05 "smp: move smp setup functions to kernel/smp.c" causes this build
error on s390 because of a missing init.h include:

CC      arch/s390/kernel/asm-offsets.s
In file included from /home2/heicarst/linux-2.6/arch/s390/include/asm/spinlock.h:14:0,
from include/linux/spinlock.h:87,
from include/linux/seqlock.h:29,
from include/linux/time.h:8,
from include/linux/timex.h:56,
from include/linux/sched.h:57,
from arch/s390/kernel/asm-offsets.c:10:
include/linux/smp.h:117:20: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'setup_nr_cpu_ids'
include/linux/smp.h:118:20: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'smp_init'

Fix it by adding the include statement.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 include/linux/smp.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 48159dd..74243c8 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -10,6 +10,7 @@
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/cpumask.h>
+#include <linux/init.h>
 
 extern void cpu_idle(void);
 
