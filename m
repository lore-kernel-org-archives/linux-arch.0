From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: Do we need to disable preemption in flush_tlb_range()?
Date: Wed, 14 Mar 2018 13:19:01 -0700
Message-ID: <5a5c67c1-9f45-f908-2c8d-0914cd616a18@synopsys.com>
References: <1519917189.13866.6.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519917189.13866.6.camel@synopsys.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

+CC Peter since we have his attention ;-)

On 03/01/2018 07:13 AM, Alexey Brodkin wrote:
> Hi Vineet,
> 
> Just noticed that in comments for smp_call_function_many() it is said that
> preemption must be disabled during its execution. And that function gets executed
> among other ways like that:
> -------------------------->8-----------------------
>    flush_tlb_range()
>      -> on_each_cpu_mask()
>           -> smp_call_function_many()
> -------------------------->8-----------------------

In general I prefer not to - Peter what say you ?

> 
> I'm not seeing right now any real problem with current implementation but
> some architectures do that thus the question.
> 
> -Alexey
> 
