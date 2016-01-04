Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:56022 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbcADPao (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jan 2016 10:30:44 -0500
Date: Mon, 4 Jan 2016 16:30:36 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 20/32] metag: define __smp_xxx
Message-ID: <20160104153036.GG6344@twins.programming.kicks-ass.net>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-21-git-send-email-mst@redhat.com>
 <20160104134128.GZ6344@twins.programming.kicks-ass.net>
 <20160104152558.GD17861@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160104152558.GD17861@jhogan-linux.le.imgtec.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@kernel.org>, Davidlohr Bueso <dbueso@suse.de>, Andrey Konovalov <andreyknvl@google.com>
Message-ID: <20160104153036.Sg-q8FchSImfLxOcF_mNWBRTFQBVxUH4WT5NowRYMnc@z>

On Mon, Jan 04, 2016 at 03:25:58PM +0000, James Hogan wrote:
> It is used along with the metag specific __global_lock1() (global
> voluntary lock between hw threads) whenever a write is performed, and by
> smp_mb/smp_rmb to try to catch other cases, but I've never been
> confident this fixes every single corner case, since there could be
> other places where multiple CPUs perform unsynchronised writes to the
> same memory location, and expect cache not to become incoherent at that
> location.

Ah, yuck, I thought blackfin was the only one attempting !coherent SMP.
And yes, this is bound to break in lots of places in subtle ways. We
very much assume cache coherency for SMP in generic code.

> It seemed to be sufficient to achieve stability however, and SMP on Meta
> Linux never made it into a product anyway, since the other hw thread
> tended to be used for RTOS stuff, so it didn't seem worth extending the
> generic barrier API for it.

*phew*, should we take it out then, just to be sure nobody accidentally
tries to use it then?
