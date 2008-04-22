Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2073 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757592AbYDVXMl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 22 Apr 2008 19:12:41 -0400
Message-ID: <480E70ED.3030701@rtr.ca>
Date: Tue, 22 Apr 2008 19:12:45 -0400
From: Mark Lord <lkml@rtr.ca>
MIME-Version: 1.0
Subject: Re: [PATCH 1/11] Add generic helpers for arch IPI function calls
References: <1208851058-8500-1-git-send-email-jens.axboe@oracle.com> <1208851058-8500-2-git-send-email-jens.axboe@oracle.com>
In-Reply-To: <1208851058-8500-2-git-send-email-jens.axboe@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, npiggin@suse.de, torvalds@linux-foundation.org
Message-ID: <20080422231245.Ekyh1UCWnxOdGzGaJnO20T0pMy3cYFOtqgQzTejhEIw@z>

Jens,

While you're in there, :)

Could you perhaps fix this bug (below) if it still exists?

> Date:	Thu, 15 Nov 2007 12:07:48 -0500
> From: Mark Lord <lkml@rtr.ca>
> To: Greg KH <gregkh@suse.de>
> Cc: Yasunori Goto <y-goto@jp.fujitsu.com>,
> 	Andrew Morton <akpm@linux-foundation.org>,
> 	Alexey Dobriyan <adobriyan@sw.ru>, linux-kernel@vger.kernel.org
> Subject: Re: EIP is at device_shutdown+0x32/0x60
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
> Content-Transfer-Encoding: 7bit
> Sender: linux-kernel-owner@vger.kernel.org
> 
> ... < snip > ...
> 
> Greg, I don't know if this is relevant or not,
> but x86 has bugs in the halt/reboot code for SMP.
> 
> Specifically, in native_smp_send_stop() the code now uses
> spin_trylock() to "lock" the shared call buffers,
> but then ignores the result.
> 
> This means that multiple CPUs can/will clobber each other
> in that code.
> 
> The second bug, is that this code does not wait for the
> target CPUs to actually stop before it continues.
> 
> This was the real cause of the failure-to-poweroff problems
> I was having with 2.6.23, which we fixed by using CPU hotplug
> to disable_nonboot_cpus() before the above code ever got run.
> 
> Maybe it's related, maybe not.
