Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:42250
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753315AbXKABJG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Oct 2007 21:09:06 -0400
Date: Wed, 31 Oct 2007 18:09:06 -0700 (PDT)
Message-Id: <20071031.180906.155917087.davem@davemloft.net>
Subject: Re: [patch 0/7] [RFC] SLUB: Improve allocpercpu to reduce per cpu
 access overhead
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.64.0710311801110.25515@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0710311752380.25515@schroedinger.engr.sgi.com>
	<20071031.180007.86834938.davem@davemloft.net>
	<Pine.LNX.4.64.0710311801110.25515@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: clameter@sgi.com
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mathieu.desnoyers@polymtl.ca, penberg@cs.helsinki.fi
List-ID: <linux-arch.vger.kernel.org>

From: Christoph Lameter <clameter@sgi.com>
Date: Wed, 31 Oct 2007 18:01:34 -0700 (PDT)

> On Wed, 31 Oct 2007, David Miller wrote:
> 
> > Without DEBUG_VM I get a loop of crashes shortly after SSHD
> > is started, I'll try to track it down.
> 
> Check how much per cpu memory is in use by
> 
> cat /proc/vmstat
> 
> currently we have a 32k limit there.

It crashes when SSHD starts, the serial console GETTY hasn't
started up yet so I can't even log in to run those commands
Christoph.

All I can do now is bisect and then try to figure out what about the
guilty change might cause the problem.

This is on a 64-cpu sparc64 box, and fast cmpxchg local is not set, so
maybe it's one of the locking changes.
