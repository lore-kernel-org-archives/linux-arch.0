From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH -tip -v4] irq_work: generic hard-irq context callbacks
Date: Thu, 16 Sep 2010 16:57:05 +0800
Message-ID: <1284627425.2754.434.camel@yhuang-dev>
References: <1284360648.3269.115.camel@yhuang-dev.sh.intel.com>
	 <20100913123213.76b1b5fa@mschwide.boeblingen.de.ibm.com>
	 <1284377790.2275.212.camel@laptop>
	 <1284528590.2256.135.camel@yhuang-dev.sh.intel.com>
	 <1284539320.3764.266.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:6033 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751768Ab0IPI5J (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Sep 2010 04:57:09 -0400
In-Reply-To: <1284539320.3764.266.camel@twins>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: dhowells <dhowells@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, paulus <paulus@samba.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, Russell King <rmk@arm.linux.org.uk>, Kyle McMartin <kyle@mcmartin.ca>, davem <davem@davemloft.net>, Linux-Arch <linux-arch@vger.kernel.org>, Matt Fleming <matt@console-pimps.org>

Hi, David,

On Wed, 2010-09-15 at 16:28 +0800, Peter Zijlstra wrote:
> FRV is one of those architectures that doesn't build a toolchain from
> plain gcc sources, David Howells did provide me with a toolchain for
> that, it does build, but really it should be getting its toolchain
> sorted upstream.

Where can I find latest FRV cross compiler workable for Linux kernel?

Best Regards,
Huang Ying
