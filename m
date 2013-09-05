From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [gcv v3 32/35] arc: Replace __get_cpu_var uses
Date: Thu, 5 Sep 2013 10:31:24 +0530
Message-ID: <52281024.20309@synopsys.com>
References: <20130828193457.140443630@linux.com> <00000140c6781cab-d0df0392-b65b-4213-8be0-1e4a04f67fb2-000000@email.amazonses.com> <C2D7FE5348E1B147BCA15975FBA23075140F60@IN01WEMBXA.internal.synopsys.com> <00000140caf51d3b-0c5ebca6-f4a7-49b8-94c8-fc8b0bde04b8-000000@email.amazonses.com> <5226E55A.3000705@synopsys.com> <00000140e952bc1f-25743208-6728-4ded-b110-9ded0321f723-000000@email.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hermes.synopsys.com ([198.182.44.81]:50441 "EHLO
	hermes.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753553Ab3IEFBl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 5 Sep 2013 01:01:41 -0400
In-Reply-To: <00000140e952bc1f-25743208-6728-4ded-b110-9ded0321f723-000000@email.amazonses.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <cl@linux.com>
Cc: Tejun Heo <tj@kernel.org>, "akpm@linuxfoundation.org" <akpm@linuxfoundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Steven Rostedt <srostedt@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 09/04/2013 07:44 PM, Christoph Lameter wrote:
> On Wed, 4 Sep 2013, Vineet Gupta wrote:
> 
>> Considering other discussions on this thread, shall I drop this from my for-curr
>> for this merge window ? I don't see any other arch changes to that effect in
>> latest linux-next.
> 
> The required fix of the macros was merged yesterday into upstream.
> 

Yes I do see the macro fix in mainline but no discussions related to missing
preemption debug checks after NAK from Peter/Ingo.

I'm gonna move this one out of my 3.12 merge window queue to my for-next - so not
dropping it (you can rest assured) but it doesn't look merge ready too. OK ?

-Vineet
