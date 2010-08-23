From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH 0/3] Generalise ARM perf-events backend for oprofile
Date: Mon, 23 Aug 2010 12:17:17 +0100
Message-ID: <20100823111717.GA31556@console-pimps.org>
References: <1282560381-7700-1-git-send-email-matt@console-pimps.org> <20100823105759.GA18638@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:49814 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751774Ab0HWLRS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 23 Aug 2010 07:17:18 -0400
Content-Disposition: inline
In-Reply-To: <20100823105759.GA18638@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, Robert Richter <robert.richter@amd.com>, Will Deacon <will.deacon@arm.com>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Frederic Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, linux-arch@vger.kernel.org

On Mon, Aug 23, 2010 at 06:57:59AM -0400, Christoph Hellwig wrote:
> On Mon, Aug 23, 2010 at 11:46:18AM +0100, Matt Fleming wrote:
> > The perf-events backend for OProfile that Will Deacon wrote in
> > 8c1fc96f6fd1f361428ba805103af0d0eee65179 ("ARM: 6072/1: oprofile: use
> > perf-events framework as backend") is of use to more architectures
> > than just ARM. Move the code into drivers/oprofile/ so that SH can use
> > it instead of the nearly identical copy of its OProfile code.
> 
> Nice, I didn't know such a backend already existed.  Now that you
> have made it generic we should aim towards making it the only oprofile
> backend and getting rid of all the duplication.

Definitely. I've added linux-arch in case there's some maintainers
that want to use this now.

The new generic code is in this patch,

	http://lkml.org/lkml/2010/8/23/118

For an example of how the SH oprofile stuff changed see,

	http://lkml.org/lkml/2010/8/23/117
