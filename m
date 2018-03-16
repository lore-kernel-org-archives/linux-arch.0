Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:60860 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751069AbeCPRzB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Mar 2018 13:55:01 -0400
Subject: Re: arc_usr_cmpxchg and preemption
References: <1521045375.11552.27.camel@synopsys.com>
 <fdf30e76-f75d-9dda-26ca-ac011c41ee64@synopsys.com>
 <20180314175352.GP4064@hirez.programming.kicks-ass.net>
 <1521221606.4805.16.camel@synopsys.com>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <b0283507-5ab7-e40b-74a7-3ddebafb076d@synopsys.com>
Date: Fri, 16 Mar 2018 10:54:52 -0700
MIME-Version: 1.0
In-Reply-To: <1521221606.4805.16.camel@synopsys.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "peterz@infradead.org" <peterz@infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Message-ID: <20180316175452.gERooF2i5_YtaECbG0ed_3pabg_5hn0ZndlnJFoxC_g@z>

On 03/16/2018 10:33 AM, Alexey Brodkin wrote:
> Hi Peter, Vineet,
>
> On Wed, 2018-03-14 at 18:53 +0100, Peter Zijlstra wrote:
>> On Wed, Mar 14, 2018 at 09:58:19AM -0700, Vineet Gupta wrote:
>>
>>> Well it is broken wrt the semantics the syscall is supposed to provide.
>>> Preemption disabling is what prevents a concurrent thread from coming in and
>>> modifying the same location (Imagine a variable which is being cmpxchg
>>> concurrently by 2 threads).
>>>
>>> One approach is to do it the MIPS way, emulate the llsc flag - set it under
>>> preemption disabled section and clear it in switch_to
>> *shudder*... just catch the -EFAULT, force the write fault and retry.
> More I look at this initially quite simple thing more it looks like
> a can of worms...
>

I'd say just bite the bullet, write the patch and we can refine it there !

-Vineet
