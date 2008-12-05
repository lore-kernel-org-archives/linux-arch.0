From: David Miller <davem@davemloft.net>
Subject: Re: [patch 0/3] [Announcement] Performance Counters for Linux
Date: Fri, 05 Dec 2008 00:27:01 -0800 (PST)
Message-ID: <20081205.002701.172921476.davem@davemloft.net>
References: <20081205081137.GB2030@elte.hu>
	<20081205.001717.216522767.davem@davemloft.net>
	<20081205082431.GD2030@elte.hu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:51345
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750852AbYLEI1B (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Dec 2008 03:27:01 -0500
In-Reply-To: <20081205082431.GD2030@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mingo@elte.hu
Cc: a.p.zijlstra@chello.nl, paulus@samba.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, eranian@googlemail.com, dada1@cosmosbay.com, robert.richter@amd.com, arjan@infradead.org, hpa@zytor.com, rostedt@goodmis.org

From: Ingo Molnar <mingo@elte.hu>
Date: Fri, 5 Dec 2008 09:24:31 +0100

> Right now we begun with the most trivial ones:
> 
>   enum perf_record_type {
>           PERF_RECORD_SIMPLE,
>           PERF_RECORD_IRQ,
>   };
> 
> ... but it would be natural to do a PERF_RECORD_GP_REGISTERS as well. 
> Perhaps even a PERF_RECORD_STACKTRACE using the sysprof facilities, to do 
> a hierarchic multi-dimension profile that sysprof does so nicely.

Maybe even add something like PERF_RECORD_THE_MOON...

see how rediculious this is?

It's not your business in the kernel to decide what things are
useful.  The monitor can stop the task and inspect whatever
it wants with _existing_ facilities.  We need none of this stuff.
