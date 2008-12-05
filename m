From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [patch 0/3] [Announcement] Performance Counters for Linux
Date: Fri, 05 Dec 2008 08:16:25 +0100
Message-ID: <1228461385.18899.13.camel@twins>
References: <20081204225345.654705757@linutronix.de>
	 <18744.29747.728320.652642@cargo.ozlabs.ibm.com>
	 <20081205063131.GB12785@elte.hu>  <20081205070329.GA30874@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from viefep18-int.chello.at ([213.46.255.22]:22001 "EHLO
	viefep18-int.chello.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752213AbYLEHQe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Dec 2008 02:16:34 -0500
In-Reply-To: <20081205070329.GA30874@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Stephane Eranian <eranian@googlemail.com>, Eric Dumazet <dada1@cosmosbay.com>, Robert Richter <robert.richter@amd.com>, Arjan van de Veen <arjan@infradead.org>, Peter Anvin <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, David Miller <davem@davemloft.net>

On Fri, 2008-12-05 at 08:03 +0100, Ingo Molnar wrote:

> int main(void)
> {
> 	unsigned long long count1, count2;
> 	int fd1, fd2, ret;
> 
> 	fd1 = perf_counter_open(PERF_COUNT_INSTRUCTIONS, 0, 0, 0, -1);
> 	assert(fd1 >= 0);
> 	fd2 = perf_counter_open(PERF_COUNT_CACHE_MISSES, 0, 0, 0, -1);
> 	assert(fd1 >= 0);
> 
> 	for (;;) {
> 		ret = read(fd1, &count1, sizeof(count1));
> 		assert(ret == 8);
> 		ret = read(fd2, &count2, sizeof(count2));
> 		assert(ret == 8);
> 
> 		printf("counter1 value: %Ld instructions\n", count1);
> 		printf("counter2 value: %Ld cachemisses\n",  count2);
> 		sleep(1);
> 	}
> 	return 0;
> }

So, while most people would not consider two consecutive read() ops to
be close or near the same time, due to preemption and such, that is
taken away by the fact that the counters are task local time based - so
preemption doesn't affect thing. Right?
