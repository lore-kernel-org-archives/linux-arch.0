From: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/4] gcov: add support for gcc 4.7 gcov format
Date: Thu, 19 Sep 2013 11:04:16 +0200
Message-ID: <523ABE10.6060802@linux.vnet.ibm.com>
References: <1378305776-3644-1-git-send-email-fhrbata@redhat.com> <1378305776-3644-3-git-send-email-fhrbata@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp11.uk.ibm.com ([195.75.94.107]:49072 "EHLO
	e06smtp11.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015Ab3ISJEH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Sep 2013 05:04:07 -0400
Received: from /spool/local
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <oberpar@linux.vnet.ibm.com>;
	Thu, 19 Sep 2013 10:04:05 +0100
In-Reply-To: <1378305776-3644-3-git-send-email-fhrbata@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Frantisek Hrbata <fhrbata@redhat.com>
Cc: linux-kernel@vger.kernel.org, jstancek@redhat.com, keescook@chromium.org, peter.oberparleiter@de.ibm.com, rusty@rustcorp.com.au, linux-arch@vger.kernel.org, arnd@arndb.de, mgahagan@redhat.com, agospoda@redhat.com, akpm@linux-foundation.org

On 04.09.2013 16:42, Frantisek Hrbata wrote:
> The gcov in-memory format changed in gcc 4.7. The biggest change, whi=
ch
> requires this special implementation, is that gcov_info no longer con=
tains
> array of counters for each counter type for all functions and gcov_fn=
_info is
> not used for mapping of function's counters to these arrays(offset). =
Now each
> gcov_fn_info contans it's counters, which makes things a little bit e=
asier.
>=20
> This is heavily based on the previous gcc_3_4.c implementation and pa=
tches
> provided by Peter Oberparleiter. Specially the buffer gcda implementa=
tion for
> iterator.
>=20
> v2: - removed const definition for gcov_fn_info in gcov_info
>     - use vmalloc for counter values in gcov_info_dup
>     - use iter buffer for gcda
>=20
> Signed-off-by: Frantisek Hrbata <fhrbata@redhat.com>

The patch is missing an include statement:

  CC      kernel/gcov/gcc_4_7.o
kernel/gcov/gcc_4_7.c: In function =C2=91gcov_info_dup=C2=92:
kernel/gcov/gcc_4_7.c:293:4: error: implicit declaration of function =C2=
=91vmalloc=C2=92 [-Werror=3Dimplicit-function-declaration]
kernel/gcov/gcc_4_7.c:293:20: warning: assignment makes pointer from in=
teger without a cast [enabled by default]

With that added, it compiles and works with gcc 4.3.4 and 4.7.2 on
kernel 3.21-rc1 on s390x.

--- a/kernel/gcov/gcc_4_7.c
+++ b/kernel/gcov/gcc_4_7.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/seq_file.h>
+#include <linux/vmalloc.h>
 #include "gcov.h"

 #define GCOV_COUNTERS			8
