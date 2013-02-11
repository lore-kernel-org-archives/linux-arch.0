From: James Hogan <james.hogan@imgtec.com>
Subject: Re: pt_regs leak into userspace (was Re: [PATCH v3 20/71] ARC: Signal
 handling)
Date: Mon, 11 Feb 2013 10:28:06 +0000
Message-ID: <5118C7B6.6040807@imgtec.com>
References: <1359024639-21915-1-git-send-email-vgupta@synopsys.com> <1359024639-21915-9-git-send-email-vgupta@synopsys.com> <51189D2F.4030000@synopsys.com> <CACM3HyGNZxfOXpw01POBVT-YcVKQsnPkO6Kgg+epfZS-x-BRCg@mail.gmail.com> <5118C458.2070205@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:26980 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755225Ab3BKK2L (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 11 Feb 2013 05:28:11 -0500
In-Reply-To: <5118C458.2070205@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Jonas Bonn <jonas.bonn@gmail.com>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>

On 11/02/13 10:13, Vineet Gupta wrote:
> On Monday 11 February 2013 03:06 PM, Jonas Bonn wrote:
>> On 11 February 2013 08:26, Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
>>
>>> The only downside of this patch is that userspace signal stack grows in size,
>>> since signal frame only cares about scratch regs (pt_regs), but has to accommodate
>>> unused placeholder for callee regs too by virtue of using user_regs_struct.
>> Is this really true?  Don't setcontext and friends require that _all_
>> the registers be part of sigcontext?
> 
> But for an ABI - callee saved regs will anyhow be saved/restored even in
> setcontext case ! So collecting it for that purpose seems useless, or am I missing
> something here.

I think Jonas' point was that signals are asynchronous, i.e. you could
get interrupted by a signal at virtually any time during the program's
execution.

Cheers
James
