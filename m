From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/7] preempt_count rework -v2
Date: Tue, 10 Sep 2013 09:24:21 -0700
Message-ID: <CA+55aFz3S6_g4TQ11VKGM3GW=a=r3qYWQ_a0qJ_5241qQz8D=w@mail.gmail.com>
References: <20130910130811.507933095@infradead.org>
	<20130910135152.GD7537@gmail.com>
	<20130910135636.GA8268@gmail.com>
	<522F3ACC.9000701@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ee0-f52.google.com ([74.125.83.52]:37464 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463Ab3IJQYX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Sep 2013 12:24:23 -0400
In-Reply-To: <522F3ACC.9000701@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andi Kleen <ak@linux.intel.com>, Peter Anvin <hpa@zytor.com>, Mike Galbraith <bitbucket@online.de>, Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <fweisbec@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Tue, Sep 10, 2013 at 8:29 AM, Arjan van de Ven <arjan@linux.intel.com> wrote:
>>
> also.. yuck on using "dec"
> "dec" sucks, please use "sub foo  ,1" instead

That's a bigger instruction, largely due to the constant.

> (dec sucks because of its broken flags behavior; it creates basically a
> bubble in the pipeline)

Intel could (and should) just fix that. It's "easy" enough - you just
need to rename the carry flag as a separate register (and make sure
that the conditional instructions that don't use it don't think they
need it).

In fact I thought Intel already did that on their large cores. Are you
sure they still have trouble with inc/dec?

           Linus
