Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:56389
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752153AbXKABNf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Oct 2007 21:13:35 -0400
Date: Wed, 31 Oct 2007 18:13:35 -0700 (PDT)
Message-Id: <20071031.181335.207429553.davem@davemloft.net>
Subject: Re: [patch 0/7] [RFC] SLUB: Improve allocpercpu to reduce per cpu
 access overhead
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0710311810390.25643@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0710311801110.25515@schroedinger.engr.sgi.com>
	<20071031.180906.155917087.davem@davemloft.net>
	<Pine.LNX.4.64.0710311810390.25643@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: clameter@sgi.com
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mathieu.desnoyers@polymtl.ca, penberg@cs.helsinki.fi
List-ID: <linux-arch.vger.kernel.org>

From: Christoph Lameter <clameter@sgi.com>
Date: Wed, 31 Oct 2007 18:12:11 -0700 (PDT)

> On Wed, 31 Oct 2007, David Miller wrote:
> 
> > All I can do now is bisect and then try to figure out what about the
> > guilty change might cause the problem.
> 
> Reverting the 7th patch should avoid using the sparc register that caches 
> the per cpu area offset? (I though so, does it?)

Yes, that's right, %g5 holds the local cpu's per-cpu offset.
