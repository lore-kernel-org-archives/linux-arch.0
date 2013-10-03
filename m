From: Christoph Lameter <cl@linux.com>
Subject: Re: [pchecks v2 2/2] percpu: Add preemption checks to __this_cpu
 ops
Date: Thu, 3 Oct 2013 14:15:17 +0000
Message-ID: <000001417eac34d5-43f9e4c6-661b-4329-ab17-4b8a044922c8-000000@email.amazonses.com>
References: <20130924154159.855373283@linux.com> <0000014150a21408-2d759c49-6a9e-4553-956f-2d4b53e710f8-000000@email.amazonses.com> <20130924171029.GB10261@gmail.com> <0000014155fdd6cf-d54da8b8-2198-40ce-8831-4559971e69f0-000000@email.amazonses.com>
 <20130925181146.GA16693@gmail.com> <000001415fb34afc-79a24112-5d3f-431c-b90c-d6cfa1caf27a-000000@email.amazonses.com> <20130928084412.GC26167@gmail.com> <0000014179b65a63-512751f8-346a-4621-b6d1-9abd62e781c9-000000@email.amazonses.com>
 <20131003072100.GA5775@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131003072100.GA5775@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, akpm@linuxfoundation.org, linux-arch@vger.kernel.org, Steven Rostedt <srostedt@redhat.com>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-arch.vger.kernel.org

On Thu, 3 Oct 2013, Ingo Molnar wrote:

> It was important to me and other maintainers as well back then and today
> as well, as me and others complained about it out numerous times.

Yes there were some complaints and in discussions about what to do. I
suggested how this could be addressed. But no patches showed up and there
were always other more pressing things. Especially since this is a minor
issue related to CONFIG_PREEMPT which seems to be not in use in the
kernels that I see in HPC, FIS and the industry at large.

> I can fix that omission easily: consider all your __this_cpu* patches
> NAK-ed by me until the (trivial) preemption debug checks are upstream
> worthy:
>
>   - tested
>   - complete
>   - don't produce false warnings when enabled.

Not sure what tests you will like to see run and if it is even possible to
test all possible kernel runtime configurations. You seem to have some
setup to do some testing along these lines I believe?

These two patches will allow this testing to be done. And I do not see any
mention of technical issues with the code. Once these patches are merged
then I will post an updated series of patches that use raw_cpu_ops for the
places where this patch triggers and we can then discuss how to address
these issues in each of the cases.

Having these two patches merged will mean that other can join in an
reproduce test as well discover more instances where the preempt checks
trigger. There is no harm in merging these.
