Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-4-out.sgi.com ([192.48.171.29]:50711 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752771AbXKAWLn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 Nov 2007 18:11:43 -0400
Date: Thu, 1 Nov 2007 15:11:41 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 0/7] [RFC] SLUB: Improve allocpercpu to reduce per cpu
 access overhead
In-Reply-To: <20071101.142809.179954273.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0711011511240.22508@schroedinger.engr.sgi.com>
References: <20071101000211.970501947@sgi.com> <47297DA6.5070904@cosmosbay.com>
 <Pine.LNX.4.64.0711010555390.27666@schroedinger.engr.sgi.com>
 <20071101.142809.179954273.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: dada1@cosmosbay.com, akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mathieu.desnoyers@polymtl.ca, penberg@cs.helsinki.fi
List-ID: <linux-arch.vger.kernel.org>

On Thu, 1 Nov 2007, David Miller wrote:

> The remaining issue with accessing per-cpu areas at multiple virtual
> addresses is D-cache aliasing.

But that is not an issue for physicallly mapped caches.

