Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:56709 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751856AbXGXVPy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 24 Jul 2007 17:15:54 -0400
Message-ID: <46A66BD1.9020802@goop.org>
Date: Tue, 24 Jul 2007 14:14:57 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
Subject: Re: [PATCH][RFC] getting rid of stupid loop in BUG()
References: <20070724153916.GS21668@ftp.linux.org.uk> <46A62F35.2000501@goop.org> <20070724171455.GT21668@ftp.linux.org.uk> <46A64F4F.80107@goop.org> <20070724200401.GU21668@ftp.linux.org.uk>
In-Reply-To: <20070724200401.GU21668@ftp.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Al Viro wrote:
> On Tue, Jul 24, 2007 at 12:13:19PM -0700, Jeremy Fitzhardinge wrote:
>   
>> Al Viro wrote:
>>     
>>> Works here...
>>>   
>>>       
>> Hm, doesn't here:
>>
>>   CC      arch/i386/kernel/irq.o
>> /home/jeremy/hg/xen/paravirt/linux/arch/i386/kernel/irq.c: In function '__BUG':
>> include2/asm/bug.h:29: warning: 'noreturn' function does return
>>
>> This is with current FC7 distro gcc: gcc version 4.1.2 20070502 (Red Hat
>> 4.1.2-12)
>>     
>
> Interesting...  Looks like it's both version- and flags-dependent.
> Oh, well...
>
> BTW, alpha, frv, m68k and s390 have BUG() that is not recognized as
> noreturn by gcc.
>   

Yes, it was something I added because I thought it would be useful. 
Traditionally, BUG has not affected gcc's control flow analysis.

The other option is trying to use __builtin_trap, which happens to
generate ud2a on i386.  But I don't think its necessarily guaranteed to
always do that, and I don't know if it does anything useful for other
architectures.

    J
