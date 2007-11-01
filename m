Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gw1.cosmosbay.com ([86.65.150.130]:40753 "EHLO
	gw1.cosmosbay.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611AbXKAXAh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 Nov 2007 19:00:37 -0400
Message-ID: <472A5A7A.6020508@cosmosbay.com>
Date: Fri, 02 Nov 2007 00:00:10 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
MIME-Version: 1.0
Subject: Re: [patch 0/7] [RFC] SLUB: Improve allocpercpu to reduce per cpu
 access overhead
References: <Pine.LNX.4.64.0711010601430.27666@schroedinger.engr.sgi.com> <20071101.142936.114015234.davem@davemloft.net> <Pine.LNX.4.64.0711011511450.22508@schroedinger.engr.sgi.com> <20071101.153824.91808126.davem@davemloft.net> <Pine.LNX.4.64.0711011545370.23379@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0711011545370.23379@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
To: Christoph Lameter <clameter@sgi.com>
Cc: David Miller <davem@davemloft.net>, akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mathieu.desnoyers@polymtl.ca, penberg@cs.helsinki.fi
List-ID: <linux-arch.vger.kernel.org>

Christoph Lameter a écrit :
> On Thu, 1 Nov 2007, David Miller wrote:
> 
>> From: Christoph Lameter <clameter@sgi.com>
>> Date: Thu, 1 Nov 2007 15:15:39 -0700 (PDT)
>>
>>> After boot is complete we allow the reduction of the size of the per cpu 
>>> areas . Lets say we only need 128k per cpu. Then the remaining pages will
>>> be returned to the page allocator.
>> You don't know how much you will need.  I exhausted the limit on
>> sparc64 very late in the boot process when the last few userland
>> services were starting up.
> 
> Well you would be able to specify how much will remain. If not it will 
> just keep the 2M reserve around.
> 
>> And if I subsequently bring up 100,000 IP tunnels, it will exhaust the
>> per-cpu allocation area.
> 
> Each tunnel needs 4 bytes per cpu?

well, if we move last_rx to a percpu var, we need  8 bytes of percpu space per 
net_device :)

> 
>> You have to make it fully dynamic, there is no way around it.
> 
> Na. Some reasonable upper limit needs to be set. If we set that to say 
> 32Megabytes and do the virtual mapping then we can just populate the first 
> 2M and only allocate the remainder if we need it. Then we need to rely on 
> Mel's defrag stuff though defrag memory if we need it.

If a 2MB page is not available, could we revert using 4KB pages ? (like 
vmalloc stuff), paying an extra runtime overhead of course.


