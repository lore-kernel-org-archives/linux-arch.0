Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:54434 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751784AbXKQAFR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 16 Nov 2007 19:05:17 -0500
Date: Fri, 16 Nov 2007 16:05:15 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
Subject: RE: [patch 07/30] cpu alloc: IA64 support
In-Reply-To: <617E1C2C70743745A92448908E030B2A02F944FB@scsmsx411.amr.corp.intel.com>
Message-ID: <Pine.LNX.4.64.0711161604450.9491@schroedinger.engr.sgi.com>
References: <20071116230920.278761667@sgi.com> <20071116231103.808561432@sgi.com>
 <617E1C2C70743745A92448908E030B2A02F944FB@scsmsx411.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-arch.vger.kernel.org>

On Fri, 16 Nov 2007, Luck, Tony wrote:

> +# Maximum of 128 MB cpu_alloc space per cpu
> +config CPU_AREA_ORDER
> +	int
> +	default "13"
> 
> Comment only matches code when page size is 16K ... and we are (slowly)
> moving to 64k as the default (which with order 13 allocation would mean
> 512M)

But the page table also grow so 512M may be okay?

