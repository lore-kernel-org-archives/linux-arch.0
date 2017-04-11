Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:47663 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752433AbdDKXQg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 11 Apr 2017 19:16:36 -0400
Message-ID: <1491952528.7236.26.camel@kernel.crashing.org>
Subject: Re: [PATCH v3 21/32] powerpc: include default ioremap_nopost()
 implementation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 12 Apr 2017 09:15:28 +1000
In-Reply-To: <20170411142456.GB6821@red-moon>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
         <20170411122923.6285-22-lorenzo.pieralisi@arm.com>
         <1491917928.7236.8.camel@kernel.crashing.org>
         <20170411142456.GB6821@red-moon>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Michael Ellerman <mpe@ellerman.id.au>, Bjorn Helgaas <bhelgaas@google.com>, Paul Mackerras <paulus@samba.org>
Message-ID: <20170411231528.SEENdpuWCXewDnsK1KjTOKBVPWEeByePuObBPvLnoCI@z>

On Tue, 2017-04-11 at 15:24 +0100, Lorenzo Pieralisi wrote:
> Ok, point taken. BTW, may I ask you guys to have a look into this
> please ?
> 
> https://lkml.org/lkml/2017/4/6/743
> 
> It is a side effect of this thread (v2), not sure why <asm/io.h>
> on powerpc has to include <linux/io.h>.

Not sure how we ended up with that... it's odd indeed.

Michael ? Any reason we can't just remove it ?

Cheers,
Ben.
