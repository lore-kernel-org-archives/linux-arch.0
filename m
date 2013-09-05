From: Christoph Lameter <cl@linux.com>
Subject: Re: [gcv v3 32/35] arc: Replace __get_cpu_var uses
Date: Thu, 5 Sep 2013 14:19:37 +0000
Message-ID: <00000140ee7e1cf2-bfccaa36-5c54-4513-b7a8-cfa67a476dd7-000000@email.amazonses.com>
References: <20130828193457.140443630@linux.com> <00000140c6781cab-d0df0392-b65b-4213-8be0-1e4a04f67fb2-000000@email.amazonses.com> <C2D7FE5348E1B147BCA15975FBA23075140F60@IN01WEMBXA.internal.synopsys.com> <00000140caf51d3b-0c5ebca6-f4a7-49b8-94c8-fc8b0bde04b8-000000@email.amazonses.com>
 <5226E55A.3000705@synopsys.com> <00000140e952bc1f-25743208-6728-4ded-b110-9ded0321f723-000000@email.amazonses.com> <52281024.20309@synopsys.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from a194-110.smtp-out.amazonses.com ([199.255.194.110]:16480 "EHLO
	a194-110.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751968Ab3IEOTi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 5 Sep 2013 10:19:38 -0400
In-Reply-To: <52281024.20309@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Tejun Heo <tj@kernel.org>, "akpm@linuxfoundation.org" <akpm@linuxfoundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Steven Rostedt <srostedt@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, 5 Sep 2013, Vineet Gupta wrote:

> Yes I do see the macro fix in mainline but no discussions related to missing
> preemption debug checks after NAK from Peter/Ingo.

v4 was posted yesterday with the preemption bug checks.
