From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] arc: use little endian accesses
Date: Fri, 11 Mar 2016 05:18:32 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075F4E8F5FE@us01wembx1.internal.synopsys.com>
References: <1457544064-16167-1-git-send-email-ltrimas@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075F4E8EDF9@us01wembx1.internal.synopsys.com>
 <201603100845.30602.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:34434 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbcCKFSf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Mar 2016 00:18:35 -0500
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lada Trimasova <Lada.Trimasova@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Noam Camus <noamc@ezchip.com>

On Thursday 10 March 2016 01:15 PM, Arnd Bergmann wrote:
> On Thursday 10 March 2016, Vineet Gupta wrote:
>> On Wednesday 09 March 2016 10:51 PM, Lada Trimasova wrote:
>>> Memory access primitives should use cpu_to_le16, cpu_to_le32, le16_to_cpu
>>> and le32_to_cpu because it is not really guaranteed that drivers handles
>>> any ordering themselves.
>> That is the driver issue. readxx as API simply returns data in native endianness.
>> We've had EZChip running big endian and so far and they didn't need this change.
> Most drivers using readl() or readl_relaxed() expect those to perform byte
> swaps on big-endian architectures, as the registers tend to be fixed endian,
> so the change seems reasonable.
>
> It depends a little bit on how endian mode is implemented in the CPU: do you
> follow the normal model of swapping byte order in the load/store instructions
> of the CPU when running big-endian, or is the CPU always running little-endian
> but the bus addresses get mangled on byte accesses to give the illusion
> of a big-endian system?

OK I got the response from hardware guys that we follow the normal mode of
swapping byte order for big-endian mode. Arnd can u please explain how that might
impact the io accessors, it at all.

And what exactly are semantics of readX() and ioreadX() - even if arch specific
and I'd be glad to change that for ARC.

I can also help with documenting them properly some where as went digging into
mailing list first thing Lada posted this patch :-)

Thx,
-Vineet
