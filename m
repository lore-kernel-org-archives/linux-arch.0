From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: + kthread-numa-aware-kthread_create_on_cpu.patch added to -mm
 tree
Date: Thu, 23 Dec 2010 20:12:02 +0100
Message-ID: <1293131522.2170.798.camel@laptop>
References: <201012100044.oBA0ivp3016990@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:60539 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab0LWTMH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 23 Dec 2010 14:12:07 -0500
In-Reply-To: <201012100044.oBA0ivp3016990@imap1.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: mm-commits@vger.kernel.org, eric.dumazet@gmail.com, ak@linux.intel.com, davem@davemloft.net, dhowells@redhat.com, fenghua.yu@intel.com, linux-arch@vger.kernel.org, rusty@rustcorp.com.au, tj@kernel.org, tony.luck@intel.com

On Thu, 2010-12-09 at 16:44 -0800, akpm@linux-foundation.org wrote:
> +struct task_struct *kthread_create_on_cpu(int (*threadfn)(void *data),
> +                                         void *data,
> +                                         int cpu,
> +                                         const char namefmt[],
> +                                         ...)

I thought it was agreed that name sucked too much to live?

All other *_on_cpu() interfaces actually do stuff on that cpu, but this
does not in fact create a cpu affine task.
