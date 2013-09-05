From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [gcv v3 32/35] arc: Replace __get_cpu_var uses
Date: Thu, 5 Sep 2013 14:29:49 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075141CCD@IN01WEMBXA.internal.synopsys.com>
References: <20130828193457.140443630@linux.com>
 <00000140c6781cab-d0df0392-b65b-4213-8be0-1e4a04f67fb2-000000@email.amazonses.com>
 <C2D7FE5348E1B147BCA15975FBA23075140F60@IN01WEMBXA.internal.synopsys.com>
 <00000140caf51d3b-0c5ebca6-f4a7-49b8-94c8-fc8b0bde04b8-000000@email.amazonses.com>
 <5226E55A.3000705@synopsys.com>
 <00000140e952bc1f-25743208-6728-4ded-b110-9ded0321f723-000000@email.amazonses.com>
 <52281024.20309@synopsys.com>
 <00000140ee7e1cf2-bfccaa36-5c54-4513-b7a8-cfa67a476dd7-000000@email.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Lameter <cl@linux.com>
Cc: Tejun Heo <tj@kernel.org>, "akpm@linuxfoundation.org" <akpm@linuxfoundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Steven Rostedt <srostedt@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 09/05/2013 07:49 PM, Christoph Lameter wrote:
> On Thu, 5 Sep 2013, Vineet Gupta wrote:
>
>> Yes I do see the macro fix in mainline but no discussions related to missing
>> preemption debug checks after NAK from Peter/Ingo.
> v4 was posted yesterday with the preemption bug checks.

I see that. IMHO it would be better if all of this gets merged into mainline in
one cycle.
I'm a relatively new maintainer so I'm not sure how to handle this. Andrew, Tejun,
Steven what say you ?

-Vineet
