Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:41530
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751404AbXKAV3g (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 Nov 2007 17:29:36 -0400
Date: Thu, 01 Nov 2007 14:29:36 -0700 (PDT)
Message-Id: <20071101.142936.114015234.davem@davemloft.net>
Subject: Re: [patch 0/7] [RFC] SLUB: Improve allocpercpu to reduce per cpu
 access overhead
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0711010601430.27666@schroedinger.engr.sgi.com>
References: <20071101.000118.208338243.davem@davemloft.net>
	<20071101.021451.217578606.davem@davemloft.net>
	<Pine.LNX.4.64.0711010601430.27666@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: clameter@sgi.com
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mathieu.desnoyers@polymtl.ca, penberg@cs.helsinki.fi
List-ID: <linux-arch.vger.kernel.org>

From: Christoph Lameter <clameter@sgi.com>
Date: Thu, 1 Nov 2007 06:03:44 -0700 (PDT)

> In order to make it truly dynamic we would have to virtually map the
> area.  vmap? But that reduces performance.

But it would still be faster than the double-indirection we do now,
right?
