Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:41824 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbeCNUTK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Mar 2018 16:19:10 -0400
Subject: Re: Do we need to disable preemption in flush_tlb_range()?
References: <1519917189.13866.6.camel@synopsys.com>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <5a5c67c1-9f45-f908-2c8d-0914cd616a18@synopsys.com>
Date: Wed, 14 Mar 2018 13:19:01 -0700
MIME-Version: 1.0
In-Reply-To: <1519917189.13866.6.camel@synopsys.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Message-ID: <20180314201901.X7Xo2XIgPuCiOUXIEEdrARzNZy3M9tJgqdzikrlsyYo@z>

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
