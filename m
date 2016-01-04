Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.citrix.com ([66.165.176.89]:54107 "EHLO SMTP.CITRIX.COM"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753269AbcADLcf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 4 Jan 2016 06:32:35 -0500
Message-ID: <568A584C.2070501@citrix.com>
Date: Mon, 4 Jan 2016 11:32:28 +0000
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCH v2 34/34] xen/io: use virt_xxx barriers
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-35-git-send-email-mst@redhat.com>
In-Reply-To: <1451572003-2440-35-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, linux-xtensa@linux-xtensa.org, user-mode-linux-devel@lists.sourceforge.net, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, adi-buildroot-devel@lists.sourceforge.net, Thomas Gleixner <tglx@linutronix.de>, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andrew Cooper <andrew.cooper3@citrix.com>, David Vrabel <david.vrabel@citrix.com>, linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>
Message-ID: <20160104113228.MHWtVjg-GIsq7U7a16InKAWWUs5286xqYyU4u4qAjSo@z>

On 31/12/15 19:10, Michael S. Tsirkin wrote:
> include/xen/interface/io/ring.h uses
> full memory barriers to communicate with the other side.
> 
> For guests compiled with CONFIG_SMP, smp_wmb and smp_mb
> would be sufficient, so mb() and wmb() here are only needed if
> a non-SMP guest runs on an SMP host.
> 
> Switch to virt_xxx barriers which serve this exact purpose.

Acked-by: David Vrabel <david.vrabel@citrix.com>

David
