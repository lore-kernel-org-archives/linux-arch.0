Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53657 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282AbcACJBQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 3 Jan 2016 04:01:16 -0500
Date: Sun, 3 Jan 2016 11:01:05 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 32/32] virtio_ring: use virt_store_mb
Message-ID: <20160103110052-mutt-send-email-mst@redhat.com>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-33-git-send-email-mst@redhat.com>
 <5686B622.6070600@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5686B622.6070600@cogentembedded.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org
Message-ID: <20160103090105.9Maq2NJuePnPLLB1BjAN98-DL_oQ15WAGb06mYmnl54@z>

On Fri, Jan 01, 2016 at 08:23:46PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 12/31/2015 10:09 PM, Michael S. Tsirkin wrote:
> 
> >We need a full barrier after writing out event index, using
> >virt_store_mb there seems better than open-coding.  As usual, we need a
> >wrapper to account for strong barriers.
> >
> >It's tempting to use this in vhost as well, for that, we'll
> >need a variant of smp_store_mb that works on __user pointers.
> >
> >Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >---
> >  include/linux/virtio_ring.h  | 12 ++++++++++++
> >  drivers/virtio/virtio_ring.c | 15 +++++++++------
> >  2 files changed, 21 insertions(+), 6 deletions(-)
> >
> >diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
> >index f3fa55b..3a74d91 100644
> >--- a/include/linux/virtio_ring.h
> >+++ b/include/linux/virtio_ring.h
> >@@ -45,6 +45,18 @@ static inline void virtio_wmb(bool weak_barriers)
> >  		wmb();
> >  }
> >
> >+static inline void virtio_store_mb(bool weak_barriers,
> >+				   __virtio16 *p, __virtio16 v)
> >+{
> >+	if (weak_barriers)
> >+		virt_store_mb(*p, v);
> >+	else
> >+	{
> 
>    The kernel coding style dictates:
> 
> 	if (weak_barriers) {
> 		virt_store_mb(*p, v);
> 	} else {
> 
> >+		WRITE_ONCE(*p, v);
> >+		mb();
> >+	}
> >+}
> >+
> [...]
> 
> MBR, Sergei

Will fix, thanks!
