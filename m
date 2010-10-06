Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:54425 "EHLO
	TX2EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757107Ab0JFPvM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 Oct 2010 11:51:12 -0400
Date: Wed, 6 Oct 2010 17:50:26 +0200
From: Robert Richter <robert.richter@amd.com>
Subject: Re: [PATCH 2/7] perf: New helper function for pmu name
Message-ID: <20101006155026.GT13563@erda.amd.com>
References: <cover.1286222593.git.matt@console-pimps.org>
 <59a8e68894a2e755232189abbe9b1a3b892e309c.1286222593.git.matt@console-pimps.org>
 <20101006122736.GL13563@erda.amd.com>
 <20101006123950.GA29118@linux-sh.org>
 <20101006131825.GO13563@erda.amd.com>
 <20101006133041.GA29273@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20101006133041.GA29273@linux-sh.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mundt <lethal@linux-sh.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Matt Fleming <matt@console-pimps.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Frederic Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Deng-Cheng Zhu <dengcheng.zhu@gmail.com>, Grant Likely <grant.likely@secretlab.ca>
Message-ID: <20101006155026.9yK_tHZUa3xVSy-SwIAPRFSaYuX1SYa1yBhPNUAo1-Q@z>

On 06.10.10 09:30:41, Paul Mundt wrote:
> On Wed, Oct 06, 2010 at 03:18:25PM +0200, Robert Richter wrote:
> > So, I am also fine with implementing a generic perf_pmu_name() for sh
> > and then derive the oprofile cpu_type string from it in the oprofile
> > code.
> > 
> Again, this is unacceptable.

Paul,

maybe I misunderstood you, but isn't this you preferred solution? We
make perf_pmu_name() part of the generic i/f and then derive the
oprofile name from the pmu name provided by perf.

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center

