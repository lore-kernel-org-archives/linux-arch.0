From: Cong Wang <amwang@redhat.com>
Subject: Re: smp: move smp setup functions to kernel/smp.c
Date: Wed, 23 Mar 2011 15:30:37 +0800
Message-ID: <4D89A19D.3070002@redhat.com>
References: <201103230200.p2N20TTN010372@hera.kernel.org> <20110323072457.GA4156@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57742 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753607Ab1CWHau (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 23 Mar 2011 03:30:50 -0400
In-Reply-To: <20110323072457.GA4156@osiris.boeblingen.de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-arch@vger.kernel.org

=E4=BA=8E 2011=E5=B9=B403=E6=9C=8823=E6=97=A5 15:24, Heiko Carstens =E5=
=86=99=E9=81=93:
> This causes a build error on s390. The patch below will fix it.
> Cc'ed linux-arch just in case other architectures are affected as wel=
l.
>
> Subject: [PATCH] smp: add missing init.h include
>
> From: Heiko Carstens<heiko.carstens@de.ibm.com>
>
> 34db18a05 "smp: move smp setup functions to kernel/smp.c" causes this=
 build
> error on s390 because of a missing init.h include:
>
> CC      arch/s390/kernel/asm-offsets.s
> In file included from /home2/heicarst/linux-2.6/arch/s390/include/asm=
/spinlock.h:14:0,
> from include/linux/spinlock.h:87,
> from include/linux/seqlock.h:29,
> from include/linux/time.h:8,
> from include/linux/timex.h:56,
> from include/linux/sched.h:57,
> from arch/s390/kernel/asm-offsets.c:10:
> include/linux/smp.h:117:20: error: expected '=3D', ',', ';', 'asm' or=
 '__attribute__' before 'setup_nr_cpu_ids'
> include/linux/smp.h:118:20: error: expected '=3D', ',', ';', 'asm' or=
 '__attribute__' before 'smp_init'
>
> Fix it by adding the include statement.
>
> Signed-off-by: Heiko Carstens<heiko.carstens@de.ibm.com>

Ah... thanks for the fix!

Acked-by: WANG Cong <amwang@redhat.com>
