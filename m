Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp02.citrix.com ([66.165.176.63]:50154 "EHLO
	SMTP02.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759544AbcAKLMN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 11 Jan 2016 06:12:13 -0500
Message-ID: <56938E06.9050702@citrix.com>
Date: Mon, 11 Jan 2016 11:12:06 +0000
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 39/41] xen/events: use virt_xxx barriers
References: <1452426622-4471-1-git-send-email-mst@redhat.com>
 <1452426622-4471-40-git-send-email-mst@redhat.com>
In-Reply-To: <1452426622-4471-40-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Joe Perches <joe@perches.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, adi-buildroot-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, xen-devel@lists.xenproject.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Julien Grall <julien.grall@citrix.com>, Ross Lagerwall <ross.lagerwall@citrix.com>, Stefano Stabellini <stefano.stabellini@citrix.com>, Wei Liu <wei.liu2@citrix.com>
Message-ID: <20160111111206.7aA1MsaWEULyVLJL2oY-AEGMJWEA2V9hrlE5Q-pWvNo@z>

On 10/01/16 14:21, Michael S. Tsirkin wrote:
> drivers/xen/events/events_fifo.c uses rmb() to communicate with the
> other side.
> 
> For guests compiled with CONFIG_SMP, smp_rmb would be sufficient, so
> rmb() here is only needed if a non-SMP guest runs on an SMP host.
> 
> Switch to the virt_rmb barrier which serves this exact purpose.
> 
> Pull in asm/barrier.h here to make sure the file is self-contained.
> 
> Suggested-by: David Vrabel <david.vrabel@citrix.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: David Vrabel <david.vrabel@citrix.com>

David
