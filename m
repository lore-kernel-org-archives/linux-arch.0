From: David Miller <davem@davemloft.net>
Subject: Re: [PATCHES] Generalize PCI <-> OF node matching
Date: Thu, 07 Apr 2011 15:16:36 -0700 (PDT)
Message-ID: <20110407.151636.183068185.davem@davemloft.net>
References: <1302146796-26825-1-git-send-email-benh@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:33031
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755537Ab1DGWRN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 7 Apr 2011 18:17:13 -0400
In-Reply-To: <1302146796-26825-1-git-send-email-benh@kernel.crashing.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: benh@kernel.crashing.org
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, bheglaas@google.com, monstr@monstr.eu, tglx@linuxtronix.de, bigeasy@linuxtronix.de

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu,  7 Apr 2011 13:26:31 +1000

> This series generalize the PCI <-> OF node matching, moves it to the
> PCI core and make our archs use it. I also rip out while at it a whole
> bunch of useless stuff from microblaze PCI code which was copied from
> ppc32 and is essentially useless there (old workarounds for PowerMac
> and ancient X servers).
> 
> Compile tested on x86_64, microblaze, sparc64 and powerpc.

What tree is this against?  None of the microblaze and x86 bits
apply without rejects against Linus's tree, which is where I'm
trying to test this.

I'll trudge through it, but a heads up about what your patches
are against in the future would be heavily appreciated.
