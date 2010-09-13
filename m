Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:36927 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751086Ab0IMKJg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 13 Sep 2010 06:09:36 -0400
Subject: Re: [PATCH V3 0/6] Generalise ARM perf-events backend for oprofile
From: Will Deacon <will.deacon@arm.com>
In-Reply-To: <cover.1284357372.git.matt@console-pimps.org>
References: <cover.1284357372.git.matt@console-pimps.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 13 Sep 2010 11:08:53 +0100
Message-ID: <1284372533.3042.11.camel@e102144-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matt Fleming <matt@console-pimps.org>
Cc: Robert Richter <robert.richter@amd.com>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Frederic Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, linux-arch@vger.kernel.org
Message-ID: <20100913100853.P7iLs4uVjwpIZQ94vupn15KJcic1Mult8-3bLlwlG1Y@z>

Hi Matt,

On Mon, 2010-09-13 at 07:07 +0100, Matt Fleming wrote:
> The perf-events backend for OProfile that Will Deacon wrote in
> 8c1fc96f6fd1f361428ba805103af0d0eee65179 ("ARM: 6072/1: oprofile: use
> perf-events framework as backend") is of use to more architectures
> than just ARM. Move the code into drivers/oprofile/ so that SH can use
> it instead of the nearly identical copy of its OProfile code.
> 
[...]
> 
> Note that I haven't been able to test these patches on an ARM board to
> see if I've caused any regressions. If anyone else could do that I'd
> appreciate it. Though, I have been able to compile this version of the
> series.
> 
I've tested this patch series on a multicore Cortex-A9 board. If I
revert patch 5/6 (ARM: Make oprofile depend on CONFIG_HW_PERF_EVENTS)
then everything seems to work fine. Otherwise, testing without
HW_PERF_EVENTS doesn't fall back to timer mode.

So, with the exception of the patch above:

Tested-by: Will Deacon <will.deacon@arm.com>

Cheers!

Will

