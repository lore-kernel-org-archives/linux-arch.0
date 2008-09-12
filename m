Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:48116 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757270AbYILWrM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 12 Sep 2008 18:47:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
Subject: Re: CONFIG_HAVE_ARCH_TRACEHOOK and you
In-Reply-To: David Miller's message of  Friday, 12 September 2008 15:40:15 -0700 <20080912.154015.93377289.davem@davemloft.net>
References: <20080912223156.51D4815420D@magilla.localdomain>
	<20080912.153703.21849753.davem@davemloft.net>
	<20080912223926.5EF0715420D@magilla.localdomain>
	<20080912.154015.93377289.davem@davemloft.net>
Message-ID: <20080912224554.61CCB15420D@magilla.localdomain>
Date: Fri, 12 Sep 2008 15:45:54 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: rmk+lkml@arm.linux.org.uk, linux-arch@vger.kernel.org, utrace-devel@redhat.com, linux-kernel@vger.kernel.org
Message-ID: <20080912224554.2qBoFdCWNFLDI90vHJjOoGGmUgvGV3VrwqjWKGcEeSs@z>

> > Didn't it also write NT_PRFPREG notes of the wrong size?
> 
> Yep, but gdb was "generous in what it received" and happily
> read the contents.

Ah.  I've always done core sanity checks with:
	1. generate core1 on old kernel
	2. generate core2 on new kernel (identical userland scenario)
	3. eu-readelf -nl core1 > a
	4. eu-readelf -nl core2 > b
	5. diff -u a b
Then you can eyeball any expected drift like SP address randomization,
and be suspicious of all other differences.  (Of course, I also test
that gdb still likes it.)


Thanks,
Roland
