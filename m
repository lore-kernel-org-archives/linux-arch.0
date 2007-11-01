Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:38647
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752771AbXKAWOl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 Nov 2007 18:14:41 -0400
Date: Thu, 01 Nov 2007 15:14:40 -0700 (PDT)
Message-Id: <20071101.151440.88131899.davem@davemloft.net>
Subject: Re: [patch 0/7] [RFC] SLUB: Improve allocpercpu to reduce per cpu
 access overhead
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0711011511240.22508@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0711010555390.27666@schroedinger.engr.sgi.com>
	<20071101.142809.179954273.davem@davemloft.net>
	<Pine.LNX.4.64.0711011511240.22508@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: clameter@sgi.com
Cc: dada1@cosmosbay.com, akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mathieu.desnoyers@polymtl.ca, penberg@cs.helsinki.fi
List-ID: <linux-arch.vger.kernel.org>

From: Christoph Lameter <clameter@sgi.com>
Date: Thu, 1 Nov 2007 15:11:41 -0700 (PDT)

> On Thu, 1 Nov 2007, David Miller wrote:
> 
> > The remaining issue with accessing per-cpu areas at multiple virtual
> > addresses is D-cache aliasing.
> 
> But that is not an issue for physicallly mapped caches.

Right but I'd like to use this on sparc64 which has L1 D-cache
aliasing on some chips :-)
