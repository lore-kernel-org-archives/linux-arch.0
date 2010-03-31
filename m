From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: start_kernel(): bug: interrupts were enabled early
Date: Wed, 31 Mar 2010 14:57:20 -0700
Message-ID: <4BB3C540.9000405@zytor.com>
References: <20100325194100.GA2364@debian> <20100331134048.da4e35a7.akpm@linux-foundation.org> <4BB3B4DB.7040904@kernel.org> <20100331210145.GB32165@parisc-linux.org> <4BB3B8FC.1020608@zytor.com> <20100331211754.GC32165@parisc-linux.org> <alpine.DEB.2.00.1003311640410.30456@router.home> <20100331215411.GB17715@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:40368 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755808Ab0CaWBb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Mar 2010 18:01:31 -0400
In-Reply-To: <20100331215411.GB17715@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <cl@linux-foundation.org>, Matthew Wilcox <matthew@wil.cx>, Yinghai Lu <yinghai@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Rabin Vincent <rabin@rab.in>

On 03/31/2010 02:54 PM, Russell King wrote:
> On Wed, Mar 31, 2010 at 04:42:25PM -0500, Christoph Lameter wrote:
>> Do not run the checks while we are in a single threaded context?
>>
>> I thought we had some dynamic code patching thingamy that could change
>> those when we go to smp mode?
> 
> You have to remember that on embedded architectures, such as ARM,
> where XIP is supported we can't change the text segment at run time -
> which means dynamic code patching won't work.
> 
> However, the kernel should still work in such situations.
> 

The question still remains what the incremental cost is of doing
irqsave/irqrestore.

	-hpa
