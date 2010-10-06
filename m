Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from am1ehsobe002.messaging.microsoft.com ([213.199.154.205]:47656
	"EHLO AM1EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756008Ab0JFMlT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 Oct 2010 08:41:19 -0400
Date: Wed, 6 Oct 2010 14:41:05 +0200
From: Robert Richter <robert.richter@amd.com>
Subject: Re: [PATCH 3/7] ARM: oprofile: Rename op_arm to oprofile_perf
Message-ID: <20101006124105.GN13563@erda.amd.com>
References: <cover.1286222593.git.matt@console-pimps.org>
 <094e8a33da82ce840f77fd1f7646391c08205b6e.1286222593.git.matt@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <094e8a33da82ce840f77fd1f7646391c08205b6e.1286222593.git.matt@console-pimps.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matt Fleming <matt@console-pimps.org>
Cc: Will Deacon <will.deacon@arm.com>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Frederic Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Deng-Cheng Zhu <dengcheng.zhu@gmail.com>, Grant Likely <grant.likely@secretlab.ca>
Message-ID: <20101006124105.hPNO307RrTW5hmJsuy2KO98yarQnc39dpAwX-6Ev7wk@z>

On 04.10.10 16:44:21, Matt Fleming wrote:
> In preparation for moving the generic functions out of this file, give
> the functions more general names (e.g. remove "arm" from the names).
> 
> Signed-off-by: Matt Fleming <matt@console-pimps.org>
> Tested-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/oprofile/common.c |   68 ++++++++++++++++++++++----------------------
>  1 files changed, 34 insertions(+), 34 deletions(-)

This patch looks good.

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center

