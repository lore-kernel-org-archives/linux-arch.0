From: john stultz <johnstul@us.ibm.com>
Subject: Re: [patch] Remove the per cpu tick skew
Date: Wed, 28 Jul 2010 13:26:39 -0700
Message-ID: <AANLkTikZ_RHHv9cudUh8pp9H8MtKO8Rsr+eboupv49xD@mail.gmail.com>
References: <20100727210210.58d3118c@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:61001 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659Ab0G1U0m (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jul 2010 16:26:42 -0400
In-Reply-To: <20100727210210.58d3118c@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, linux-arch@vger.kernel.org

On Tue, Jul 27, 2010 at 9:02 PM, Arjan van de Ven <arjan@infradead.org> wrote:
> the following patch is a win for power management on x86....
> ... but since this touches generic code.. are there any
> other architectures that would be negatively affected by this?

It was added to avoid contention when all the cpus grabbed the
xtime_lock (causing latency spikes of timer overhead * number of
cpus). We don't grab the xtime lock everywhere anymore, so that
shouldn't bite us, but I'm curious if there are not other global locks
taken that may see extra contention without this change.

> Subject: [patch] Remove the per cpu tick skew
>
> Historically, Linux has tried to make the regular timer tick on the various
> CPUs not happen at the same time, to avoid contention on xtime_lock.
>
> Nowadays, with the tickless kernel, this contention no longer happens
> since time keeping and updating are done differently. In addition,
> this skew is actually hurting power consumption in a measurable
> way on many-core systems.
>
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

I'll give it a spin against -rt and see if we show any latency jumps.

thanks
-john
