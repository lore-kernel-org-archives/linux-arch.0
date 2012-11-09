From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC PATCH v1 00/40] Meta Linux Kernel Port
Date: Fri, 9 Nov 2012 16:06:06 +0000
Message-ID: <509D29EE.4050709@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <201211091516.22018.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:56731 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752914Ab2KIQGI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 9 Nov 2012 11:06:08 -0500
In-Reply-To: <201211091516.22018.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org

On 09/11/12 15:16, Arnd Bergmann wrote:
> On Wednesday 31 October 2012, James Hogan wrote:
>> This patchset adds core architecture support to Linux for Imagination's
>> Meta ATP (Meta 1) and HTP (Meta 2) processor cores. It is primarily an
>> RFC patchset to get some early feedback about what changes we need to
>> make, although of course all feedback is most welcome.
>>
>> The patches are based on v3.6 for now, and can also be found in the
>> following git tree:
>>   git://github.com/jahogan/metag-linux.git metag-core
>>
>> Meta cores are 32-bit, hardware multithreaded, general purpose, embedded
>> processors which also feature a DSP instruction set, and can be found in
>> many digital radios. They are capable of running different operating
>> systems on different hardware threads, for example a digital radio might
>> run RTOSes for DAB decoding and audio decoding on 3 hardware threads,
>> and run Linux on the 4th hardware thread to manage the user interface,
>> networking etc. HTPs are also capable of running SMP Linux on multiple
>> hardware threads.
>>
>> Instruction set and architecture overview documents can be found on the
>> following page (these currently require registration/NDA, a restriction
>> which was not intended and will shortly be removed):
>>   http://www.imgtec.com/downloads.asp
>>
> 
> Hi James,
> 
> I'm finished with my initial review now. The code all looks reasonable
> so far, I could find no show-stoppers and only had small comments.

Thanks for reviewing :-)

> What mainly seems to be missing here is platform specific support and
> device drivers.  You are using the flattened device tree, which is good,
> but don't have any example device tree files or new drivers, which makes
> me wonder how you test the code ;-)

We maintain some support for a couple of SoCs, a couple dozen SoC
peripherals, and around 7 boards which we're still in the process of
cleaning up and converting to devicetree and the relevant newer APIs
(pinmux, common clocks framework etc), so we have some confidence that
IRQs and basic device tree stuff is working.

> What are your plans around those?
> I assume that the drivers are not ready yet and will follow later.

Basically submit them as soon as we've got them ready.

> Do you expect a lot of device drivers to be shared with MIPS and ARM
> based systems?

Certainly some, and for others it's always a possibility. Will's already
the dw_mmc maintainer, and we also have a partially cleaned up version
of the dwc_otg driver which I think is in the Raspberry Pi. We also make
use of various in-tree drivers, and have a fair few drivers for IMG
hardware blocks that could potentially be used with other architectures
in the future.

Thanks
James
