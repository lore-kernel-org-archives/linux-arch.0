Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:42886 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752303AbXKABVD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 31 Oct 2007 21:21:03 -0400
Date: Wed, 31 Oct 2007 18:21:02 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 0/7] [RFC] SLUB: Improve allocpercpu to reduce per cpu
 access overhead
In-Reply-To: <20071031.181335.207429553.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0710311820340.25687@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0710311801110.25515@schroedinger.engr.sgi.com>
 <20071031.180906.155917087.davem@davemloft.net>
 <Pine.LNX.4.64.0710311810390.25643@schroedinger.engr.sgi.com>
 <20071031.181335.207429553.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mathieu.desnoyers@polymtl.ca, penberg@cs.helsinki.fi
List-ID: <linux-arch.vger.kernel.org>

On Wed, 31 Oct 2007, David Miller wrote:

> From: Christoph Lameter <clameter@sgi.com>
> Date: Wed, 31 Oct 2007 18:12:11 -0700 (PDT)
> 
> > On Wed, 31 Oct 2007, David Miller wrote:
> > 
> > > All I can do now is bisect and then try to figure out what about the
> > > guilty change might cause the problem.
> > 
> > Reverting the 7th patch should avoid using the sparc register that caches 
> > the per cpu area offset? (I though so, does it?)
> 
> Yes, that's right, %g5 holds the local cpu's per-cpu offset.

And if I add the address of a percpu variable then I get to the variable 
for this cpu right?

