From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH -tip -v4] irq_work: generic hard-irq context callbacks
Date: Sun, 26 Sep 2010 08:32:03 +0100
Message-ID: <5042.1285486323@redhat.com>
References: <1285461624.15685.51.camel@yhuang-dev> <1284627425.2754.434.camel@yhuang-dev> <1284360648.3269.115.camel@yhuang-dev.sh.intel.com> <20100913123213.76b1b5fa@mschwide.boeblingen.de.ibm.com> <1284377790.2275.212.camel@laptop> <1284528590.2256.135.camel@yhuang-dev.sh.intel.com> <1284539320.3764.266.camel@twins> <615.1285272720@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:12836 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751467Ab0IZHcy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 26 Sep 2010 03:32:54 -0400
In-Reply-To: <1285461624.15685.51.camel@yhuang-dev>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Huang Ying <ying.huang@intel.com>
Cc: dhowells@redhat.com, Peter Zijlstra <peterz@infradead.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, paulus <paulus@samba.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, Russell King <rmk@arm.linux.org.uk>, Kyle McMartin <kyle@mcmartin.ca>, davem <davem@davemloft.net>, Linux-Arch <linux-arch@vger.kernel.org>, Matt Fleming <matt@console-pimps.org>

Huang Ying <ying.huang@intel.com> wrote:

> /home/caritas/projects/mce/kernel/linux-mce.git/arch/frv/mm/tlb-flush.S: Assembler messages:
> /home/caritas/projects/mce/kernel/linux-mce.git/arch/frv/mm/tlb-flush.S:51: Error: operand out of range (4294967295 not between -32768 and 32767) `setlos #0xffffffff,gr4'

Hmmm...  It's a newer binutils by the looks of it.  They seem to have made it
more stroppy about unsigned constants for signed parameters:-(

I'll get back to you on it.

David
