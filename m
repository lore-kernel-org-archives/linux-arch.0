From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC PATCH v1 14/31] ARC: syscall support
Date: Tue, 13 Nov 2012 11:41:34 +0000
Message-ID: <50A231EE.7050204@imgtec.com>
References: <1352281674-2186-1-git-send-email-vgupta@synopsys.com> <1352281674-2186-15-git-send-email-vgupta@synopsys.com> <201211071421.39523.arnd@arndb.de> <509CD1D1.3050105@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:56745 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751698Ab2KMLmI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 Nov 2012 06:42:08 -0500
In-Reply-To: <509CD1D1.3050105@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de

On 09/11/12 09:50, James Hogan wrote:
> On 07/11/12 14:21, Arnd Bergmann wrote:
>> On Wednesday 07 November 2012, Vineet Gupta wrote:
>>> + * Being uClibc based we need some of the deprecated syscalls:
>>> + * -Not emulated by uClibc at all
>>> + *     unlink, mkdir,... (needed by Busybox, LTP etc)
>>> + *     times (needed by LTP pan test harness)
>>> + * -Not emulated efficiently
>>> + *     select: emulated using pselect (but extra code to chk usec > 1sec)
>>> + *
>>> + * some (send/recv) correctly emulated using (recfrom/sendto) and
>>> + * some arch specific ones (fork/vfork)can easily be emulated using clone but
>>> + * thats the price of using common-denominator....
>>> + */
>>> +#define __ARCH_WANT_SYSCALL_NO_AT
>>> +#define __ARCH_WANT_SYSCALL_NO_FLAGS
>>> +#define __ARCH_WANT_SYSCALL_OFF_T
>>> +#define __ARCH_WANT_SYSCALL_DEPRECATED
>>
>> I'm pretty sure that this has been solved before, best get in contact with
>> the maintainers of the openrisc/c6x/hexagon platforms, that probably all
>> use uClibc without needing these.
>>
>> You have to remove the legacy calls here.

> FYI, we'll soon be making some uClibc patches available so that it can
> work without these deprecated syscalls and with the newer IPC interface
> (the work was needed for metag too). It's based roughly on the OpenRisc
> patches from last year, but with a fair few changes.

Hi Vineet,

The uClibc patches I mentioned have been posted, see here:

http://lists.busybox.net/pipermail/uclibc/2012-November/047110.html

Please do try them out and provide any feedback.

Cheers
James
