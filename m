Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp07.uk.ibm.com ([195.75.94.103]:51592 "EHLO
	e06smtp07.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbcADPFZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jan 2016 10:05:25 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <schwidefsky@de.ibm.com>;
	Mon, 4 Jan 2016 15:05:23 -0000
Date: Mon, 4 Jan 2016 16:03:39 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH v2 06/32] s390: reuse asm-generic/barrier.h
Message-ID: <20160104160339.25101b5d@mschwide>
In-Reply-To: <20160104132042.GW6344@twins.programming.kicks-ass.net>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
	<1451572003-2440-7-git-send-email-mst@redhat.com>
	<20160104132042.GW6344@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Molnar <mingo@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Andrey Konovalov <andreyknvl@google.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20160104150339.qYaqyZCbkQv3q9kS80-iBNXw1A53d3B2LouFJIvm7Hg@z>

On Mon, 4 Jan 2016 14:20:42 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Dec 31, 2015 at 09:06:30PM +0200, Michael S. Tsirkin wrote:
> > On s390 read_barrier_depends, smp_read_barrier_depends
> > smp_store_mb(), smp_mb__before_atomic and smp_mb__after_atomic match the
> > asm-generic variants exactly. Drop the local definitions and pull in
> > asm-generic/barrier.h instead.
> > 
> > This is in preparation to refactoring this code area.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/s390/include/asm/barrier.h | 10 ++--------
> >  1 file changed, 2 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/s390/include/asm/barrier.h b/arch/s390/include/asm/barrier.h
> > index 7ffd0b1..c358c31 100644
> > --- a/arch/s390/include/asm/barrier.h
> > +++ b/arch/s390/include/asm/barrier.h
> > @@ -30,14 +30,6 @@
> >  #define smp_rmb()			rmb()
> >  #define smp_wmb()			wmb()
> >  
> > -#define read_barrier_depends()		do { } while (0)
> > -#define smp_read_barrier_depends()	do { } while (0)
> > -
> > -#define smp_mb__before_atomic()		smp_mb()
> > -#define smp_mb__after_atomic()		smp_mb()
> 
> As per:
> 
>   lkml.kernel.org/r/20150921112252.3c2937e1@mschwide
> 
> s390 should change this to barrier() instead of smp_mb() and hence
> should not use the generic versions.
 
Yes, we wanted to simplify this. Thanks for the reminder, I'll queue
a patch.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

