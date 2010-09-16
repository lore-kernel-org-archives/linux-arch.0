From: Robert Richter <robert.richter@amd.com>
Subject: Re: [PATCH 4/6] oprofile: Abstract the perf-events backend
Date: Thu, 16 Sep 2010 15:15:03 +0200
Message-ID: <20100916131503.GA13563@erda.amd.com>
References: <cover.1284357372.git.matt@console-pimps.org>
 <490b61c044891ab1c85761143a3b093b15986bbb.1284357372.git.matt@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:12202
	"EHLO VA3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753887Ab0IPNPx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Sep 2010 09:15:53 -0400
Content-Disposition: inline
In-Reply-To: <490b61c044891ab1c85761143a3b093b15986bbb.1284357372.git.matt@console-pimps.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matt Fleming <matt@console-pimps.org>
Cc: Will Deacon <will.deacon@arm.com>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Frederic Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On 13.09.10 02:07:35, Matt Fleming wrote:
> Move the perf-events backend from arch/arm/oprofile into
> drivers/oprofile so that the code can be shared between architectures.
> 
> This allows each architecture to maintain only a single copy of the PMU
> accessor functions instead of one for both perf and OProfile. It also
> becomes possible for other architectures to delete much of their
> OProfile code in favour of the common code now available in
> drivers/oprofile/oprofile_perf.c.
> 
> Signed-off-by: Matt Fleming <matt@console-pimps.org>
> ---
>  arch/arm/oprofile/Makefile       |    2 +-
>  arch/arm/oprofile/common.c       |  315 -------------------------------------
>  drivers/oprofile/oprofile_perf.c |  322 ++++++++++++++++++++++++++++++++++++++
>  include/linux/oprofile.h         |    6 +
>  4 files changed, 329 insertions(+), 316 deletions(-)
>  create mode 100644 drivers/oprofile/oprofile_perf.c

This patch looks good.

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
