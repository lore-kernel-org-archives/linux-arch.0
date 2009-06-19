From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Representing Embedded Architectures at the Kernel Summit
Date: Fri, 19 Jun 2009 02:53:23 -0500
Message-ID: <CFF5881B-56E5-47CF-A879-D5285A92B591@kernel.crashing.org>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com> <BE4622E9-611A-4D56-BB54-3C7786939CF2@kernel.crashing.org> <20090618025125.GA26531@linux-sh.org> <AED49645-009B-45A4-BF7B-EBF60D9C34C8@kernel.crashing.org> <20090619030009.GB16806@linux-sh.org>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:43953 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751362AbZFSHxf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 19 Jun 2009 03:53:35 -0400
In-Reply-To: <20090619030009.GB16806@linux-sh.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mundt <lethal@Linux-SH.ORG>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org


On Jun 18, 2009, at 10:00 PM, Paul Mundt wrote:

> On Thu, Jun 18, 2009 at 09:59:20PM -0500, Kumar Gala wrote:
>>
>> On Jun 17, 2009, at 9:51 PM, Paul Mundt wrote:
>>
>>> On Wed, Jun 17, 2009 at 09:31:48AM -0500, Kumar Gala wrote:
>>>> One topic that was partially touched on was dealing with various
>>>> memories on embedded systems.  We have several sram based  
>>>> allocators
>>>> in the kernel for various different arch's:
>>>>
>>>> - Blackfin sram allocator arch/blackfin/mm/sram-alloc.c
>>>> - Lite5200(b) sram allocator arch/powerpc/sysdev/bestcomm/sram.c
>>>> - AVR32 sram allocator arch/avr32/mach-at32ap/at32ap700x.c and  
>>>> arch/
>>>> avr32/mach-at32ap/include/mach/sram.h
>>>> - Potential davinci sram allocator
>>>>
>>>> There maybe others.
>>>>
>>> SH does this through NUMA on SRAM blocks that are anywhere from
>>> 128kB to
>>> 64MB. Some of our SMP configurations have upwards of a dozen of  
>>> these
>>> blocks.
>>
>> Do you really have that much on chip memory?
>>
> Is this really a serious question? If we didn't, I would not have
> mentioned it.

It was.  I'm not familiar with SH hardware so wasn't sure if there was  
some other application you had for the multiple regions.

- k
