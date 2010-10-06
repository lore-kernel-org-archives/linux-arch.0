From: Robert Richter <robert.richter@amd.com>
Subject: Re: [PATCH 5/7] oprofile: Abstract the perf-events backend
Date: Wed, 6 Oct 2010 20:34:22 +0200
Message-ID: <20101006183422.GV13563@erda.amd.com>
References: <cover.1286222593.git.matt@console-pimps.org>
 <f1c48cb70de8129566db8a9196bcf3a3bc500aa8.1286222593.git.matt@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]:37060
	"EHLO VA3EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759477Ab0JFSee (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 Oct 2010 14:34:34 -0400
Content-Disposition: inline
In-Reply-To: <f1c48cb70de8129566db8a9196bcf3a3bc500aa8.1286222593.git.matt@console-pimps.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matt Fleming <matt@console-pimps.org>
Cc: Will Deacon <will.deacon@arm.com>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Frederic Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Deng-Cheng Zhu <dengcheng.zhu@gmail.com>, Grant Likely <grant.likely@secretlab.ca>

On 04.10.10 16:44:23, Matt Fleming wrote:
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
> Tested-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/oprofile/Makefile       |    4 +
>  arch/arm/oprofile/common.c       |  319 -------------------------------------
>  drivers/oprofile/oprofile_perf.c |  326 ++++++++++++++++++++++++++++++++++++++
>  include/linux/oprofile.h         |    6 +
>  4 files changed, 336 insertions(+), 319 deletions(-)
>  create mode 100644 drivers/oprofile/oprofile_perf.c

This patch looks good.

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
