From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC PATCH v1 14/31] ARC: syscall support
Date: Fri, 9 Nov 2012 09:50:09 +0000
Message-ID: <509CD1D1.3050105@imgtec.com>
References: <1352281674-2186-1-git-send-email-vgupta@synopsys.com> <1352281674-2186-15-git-send-email-vgupta@synopsys.com> <201211071421.39523.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:54483 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013Ab2KIJvJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 9 Nov 2012 04:51:09 -0500
In-Reply-To: <201211071421.39523.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de

On 07/11/12 14:21, Arnd Bergmann wrote:
> On Wednesday 07 November 2012, Vineet Gupta wrote:
>> + * Being uClibc based we need some of the deprecated syscalls:
>> + * -Not emulated by uClibc at all
>> + *     unlink, mkdir,... (needed by Busybox, LTP etc)
>> + *     times (needed by LTP pan test harness)
>> + * -Not emulated efficiently
>> + *     select: emulated using pselect (but extra code to chk usec > 1sec)
>> + *
>> + * some (send/recv) correctly emulated using (recfrom/sendto) and
>> + * some arch specific ones (fork/vfork)can easily be emulated using clone but
>> + * thats the price of using common-denominator....
>> + */
>> +#define __ARCH_WANT_SYSCALL_NO_AT
>> +#define __ARCH_WANT_SYSCALL_NO_FLAGS
>> +#define __ARCH_WANT_SYSCALL_OFF_T
>> +#define __ARCH_WANT_SYSCALL_DEPRECATED
> 
> I'm pretty sure that this has been solved before, best get in contact with
> the maintainers of the openrisc/c6x/hexagon platforms, that probably all
> use uClibc without needing these.
> 
> You have to remove the legacy calls here.

Hi Vineet,

FYI, we'll soon be making some uClibc patches available so that it can
work without these deprecated syscalls and with the newer IPC interface
(the work was needed for metag too). It's based roughly on the OpenRisc
patches from last year, but with a fair few changes.

Thanks
James
