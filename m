Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailhub.sw.ru ([195.214.233.200]:31681 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757059AbXGRFak (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 18 Jul 2007 01:30:40 -0400
Message-ID: <469DA543.2030601@openvz.org>
Date: Wed, 18 Jul 2007 09:29:39 +0400
From: Pavel Emelianov <xemul@openvz.org>
MIME-Version: 1.0
Subject: Re: [patch 041/234] Report that kernel is tainted if there was an
 OOPS
References: <200707171103.l6HB3gDf013411@imap1.linux-foundation.org> <20070717181003.GA16147@flint.arm.linux.org.uk>
In-Reply-To: <20070717181003.GA16147@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, xemul@openvz.org, linux-arch@vger.kernel.org, randy.dunlap@oracle.com
List-ID: <linux-arch.vger.kernel.org>

Russell King wrote:
> On Tue, Jul 17, 2007 at 04:03:42AM -0700, akpm@linux-foundation.org wrote:
>> From: Pavel Emelianov <xemul@openvz.org>
>>
>> If the kernel OOPSed or BUGed then it probably should be considered as
>> tainted.  Thus, all subsequent OOPSes and SysRq dumps will report the
>> tainted kernel.  This saves a lot of time explaining oddities in the
>> calltraces.
> 
> A bug causes an oops.  Oops are counted.  So, why do we need this
> additional complexity when we already have the '#' counter in oops
> dumps?
> 
> For instance, on ARM:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000090
> pgd = c0004000
> [00000090] *pgd=00000000
> Internal error: Oops: 817 [#1]
>                           ^^^^
> This is the oops counter.  Anything oops report from anyone other than the
> first should always be questioned.  Also note that this counter is not
> re-settable at run time, unlike the taint flags.
> 

Press SysRq-P and you won't see any oops-counters, but just the info that 
the kernel is tainted. This is helpful to know that kernel oopsed when
observing the SysRq-p output. This is just one of the reasons.

Thanks,
Pavel
