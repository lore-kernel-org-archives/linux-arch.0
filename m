From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] arc: use little endian accesses
Date: Thu, 10 Mar 2016 09:55:49 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075F4E8F1A0@us01wembx1.internal.synopsys.com>
References: <1457544064-16167-1-git-send-email-ltrimas@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075F4E8EDF9@us01wembx1.internal.synopsys.com>
 <1457595846.2868.10.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:42450 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932691AbcCJJzw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Mar 2016 04:55:52 -0500
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "noamc@ezchip.com" <noamc@ezchip.com>, Lada Trimasova <Lada.Trimasova@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>

On Thursday 10 March 2016 01:14 PM, Alexey Brodkin wrote:
>>> For example, serial port driver doesn't work when kernel is build for
>>> arc big endian architecture.
>> Last I tested Big Endian on SDP with 8250 part + 8250 driver it was working fine.
>> I presume this is the systemC model for device and standard 8250 driver and very
>> likely the model is not fixed endian or something.
> Model is indeed little-endian. We build it only once and than changing
> only "nsim_isa_big_endian" property (which changes only CPU core endianess) may use
> it equally well with little- and big-endian builds of Linux kernel.

Can you or Lada provide more details as to exactly what is not working - what
driver to be precise 8250 or dw-8250.
And where exactly the failure shows up. I want to understand this more
Noam told me off list that he has no issues with both big endian ARC + 8250 in
systemc model or silicon.

-Vineet
