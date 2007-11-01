Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:39651
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752846AbXKAVZw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 Nov 2007 17:25:52 -0400
Date: Thu, 01 Nov 2007 14:25:51 -0700 (PDT)
Message-Id: <20071101.142551.93114462.davem@davemloft.net>
Subject: Re: [patch 0/7] [RFC] SLUB: Improve allocpercpu to reduce per cpu
 access overhead
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0711010559300.27666@schroedinger.engr.sgi.com>
References: <47297DA6.5070904@cosmosbay.com>
	<20071101.005727.218970168.davem@davemloft.net>
	<Pine.LNX.4.64.0711010559300.27666@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: clameter@sgi.com
Cc: dada1@cosmosbay.com, akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mathieu.desnoyers@polymtl.ca, penberg@cs.helsinki.fi
List-ID: <linux-arch.vger.kernel.org>

From: Christoph Lameter <clameter@sgi.com>
Date: Thu, 1 Nov 2007 06:01:14 -0700 (PDT)

> On Thu, 1 Nov 2007, David Miller wrote:
> 
> > IA64 seems to use it universally for every __get_cpu_var()
> > access, so maybe it works out somehow :-)))
> 
> IA64 does not do that. It addds the local cpu offset
> 
> #define __get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, 
> __ia64_per_cpu_var(local_per_cpu_offset)))
> #define __raw_get_cpu_var(var) (*RELOC_HIDE(&per_cpu__##var, 
> __ia64_per_cpu_var(local_per_cpu_offset)))

Oh I see, it's the offset itself which is accessed at the fixed
virtual address slot.
