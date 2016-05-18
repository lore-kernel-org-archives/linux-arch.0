From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 06/15] Provide 16-bit ISO atomics
Date: Wed, 18 May 2016 19:28:38 +0200
Message-ID: <20160518172838.GC3206@twins.programming.kicks-ass.net>
References: <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
 <146358428286.8596.2865175107430611616.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:58526 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbcERR2p (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 18 May 2016 13:28:45 -0400
Content-Disposition: inline
In-Reply-To: <146358428286.8596.2865175107430611616.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, ramana.radhakrishnan@arm.com, paulmck@linux.vnet.ibm.com, dwmw2@infradead.org

On Wed, May 18, 2016 at 04:11:22PM +0100, David Howells wrote:
> Provide an implementation of atomic_inc_short() using ISO atomics.

It seems entirely unused though; so maybe remove it instead?
