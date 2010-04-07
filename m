Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:48039 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932517Ab0DGI6N (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 7 Apr 2010 04:58:13 -0400
Subject: Re: Arch specific mmap attributes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20100407.000343.181989028.davem@davemloft.net>
References: <20100406185246.7E63.A69D9226@jp.fujitsu.com>
	 <1270592111.13812.88.camel@pasglop>
	 <20100407095145.FB70.A69D9226@jp.fujitsu.com>
	 <20100407.000343.181989028.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 07 Apr 2010 18:58:00 +1000
Message-ID: <1270630680.2300.91.camel@pasglop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: kosaki.motohiro@jp.fujitsu.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20100407085800.d9Dfr1Z_440HsVyMRk_mmP6uZge-arTvAg_vG-97FUg@z>

On Wed, 2010-04-07 at 00:03 -0700, David Miller wrote:
> > I'm not against changing kernel internal. I only disagree mmu
> > attribute fashion will be become used widely.
> 
> Desktop already uses similar features via PCI mmap
> attributes and such, not to mention MSR settings on
> x86.

This is a very good point, we've had all sort of trouble hacking that in
for PCI mmap, between trying to get write combine in, which we got
on /proc via a tweak I think we never got over to sysfs, and the ability
to control cachability, for which we used to have O_SYNC hacks
in /dev/mem, I think there is room for some nice and clean set of
attributes here.

Cheers,
Ben.


