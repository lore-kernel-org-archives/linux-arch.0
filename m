From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH -tip -v4] irq_work: generic hard-irq context callbacks
Date: Thu, 23 Sep 2010 21:12:00 +0100
Message-ID: <615.1285272720@redhat.com>
References: <1284627425.2754.434.camel@yhuang-dev> <1284360648.3269.115.camel@yhuang-dev.sh.intel.com> <20100913123213.76b1b5fa@mschwide.boeblingen.de.ibm.com> <1284377790.2275.212.camel@laptop> <1284528590.2256.135.camel@yhuang-dev.sh.intel.com> <1284539320.3764.266.camel@twins>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32915 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753837Ab0IWUMo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 23 Sep 2010 16:12:44 -0400
In-Reply-To: <1284627425.2754.434.camel@yhuang-dev>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Huang Ying <ying.huang@intel.com>
Cc: dhowells@redhat.com, Peter Zijlstra <peterz@infradead.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, paulus <paulus@samba.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, Russell King <rmk@arm.linux.org.uk>, Kyle McMartin <kyle@mcmartin.ca>, davem <davem@davemloft.net>, Linux-Arch <linux-arch@vger.kernel.org>, Matt Fleming <matt@console-pimps.org>

Huang Ying <ying.huang@intel.com> wrote:

> Where can I find latest FRV cross compiler workable for Linux kernel?

Look in here:

	ftp://ftp.ges.redhat.com/frv/

There's a toolchain here:

	ftp://ftp.ges.redhat.com/frv/i686-pc-linux-gnulibc2.3-x-frv-linux-gnu.tar.bz2

plus sources.

David
