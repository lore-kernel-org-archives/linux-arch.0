From: Mark Lord <lkml-gsilrlXbHYg@public.gmane.org>
Subject: Re: [PATCH 1/11] Add generic helpers for arch IPI function calls
Date: Tue, 22 Apr 2008 19:12:45 -0400
Message-ID: <480E70ED.3030701@rtr.ca>
References: <1208851058-8500-1-git-send-email-jens.axboe@oracle.com> <1208851058-8500-2-git-send-email-jens.axboe@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1208851058-8500-2-git-send-email-jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org

Jens,

While you're in there, :)

Could you perhaps fix this bug (below) if it still exists?

> Date:	Thu, 15 Nov 2007 12:07:48 -0500
> From: Mark Lord <lkml-gsilrlXbHYg@public.gmane.org>
> To: Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>
> Cc: Yasunori Goto <y-goto-+CUm20s59erQFUHtdCDX3A@public.gmane.org>,
> 	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
> 	Alexey Dobriyan <adobriyan-3ImXcnM4P+0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: EIP is at device_shutdown+0x32/0x60
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
> Content-Transfer-Encoding: 7bit
> Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
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
