Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33038 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933271AbeGIPaD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 9 Jul 2018 11:30:03 -0400
Date: Mon, 9 Jul 2018 16:29:58 +0100
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3] devres: Explicitly align datai[] to 64-bit
Message-ID: <20180709152958.565weccfaktqauef@lakrids.cambridge.arm.com>
References: <20180709134550.29541-1-abrodkin@synopsys.com>
 <20180709140717.GR2476@hirez.programming.kicks-ass.net>
 <20180709141056.GR2512@hirez.programming.kicks-ass.net>
 <44727d3cebda7bee5b68fb388bd2fecfc6dc7b89.camel@synopsys.com>
 <20180709144925.GU2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709144925.GU2476@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "greg@kroah.com" <greg@kroah.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>
Message-ID: <20180709152958.qDNhzxC7HWkAXTlflqGt-QlTjni1D4lRn7CAob35BDI@z>

On Mon, Jul 09, 2018 at 04:49:25PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 09, 2018 at 02:33:26PM +0000, Alexey Brodkin wrote:
> > > In fact, since alloc_dr() uses kmalloc() to allocate the entire thing,
> > > it is impossible to guarantee a larger alignment than kmalloc does.
> > 
> > Well but 4-bytes [which is critical for atomic64_t] should be much less
> > than a sane cache line length so above should work.
> 
> AFAICT ARCH_KMALLOC_MINALIGN ends up being 4 on x86_32 (it doesn't
> define ARCH_DMA_MINALIGN and doesn't seem to otherwise override the
> thing).

Shouldn't that be 8? AFAICT, __alignof__(unsigned long long) is 8 on
x86_32:

----
[mark@lakrids:~]% cat test.c     
#include <stdio.h>

#define PRINT_TYPE_INFO(t) \
        printf("%10s %5d %5d\n", #t, sizeof(t), __alignof__(t))

int main(int argc, char *argv[])
{
        printf("%10s %5s %5s\n", "TYPE", "SIZE", "ALIGN");
        PRINT_TYPE_INFO(int);
        PRINT_TYPE_INFO(long);
        PRINT_TYPE_INFO(long long);

        return 0;
}
[mark@lakrids:~]% gcc -m32 test.c -o test
[mark@lakrids:~]% ./test 
      TYPE  SIZE ALIGN
       int     4     4
      long     4     4
 long long     8     8
----

Mark.
