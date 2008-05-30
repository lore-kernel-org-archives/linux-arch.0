From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [patch 00/41] cpu alloc / cpu ops v3: Optimize per cpu access
Date: Fri, 30 May 2008 15:51:41 +0900
Message-ID: <20080530155141.a87fa316.kamezawa.hiroyu@jp.fujitsu.com>
References: <20080530035620.587204923@sgi.com>
	<20080529215827.b659d032.akpm@linux-foundation.org>
	<Pine.LNX.4.64.0805292159360.12107@schroedinger.engr.sgi.com>
	<20080529222143.5d7aa1e5.akpm@linux-foundation.org>
	<Pine.LNX.4.64.0805292224540.12329@schroedinger.engr.sgi.com>
	<20080529224959.3297a4f1.akpm@linux-foundation.org>
	<Pine.LNX.4.64.0805292313240.12457@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:38903 "EHLO
	fgwmail7.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822AbYE3Gqo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 May 2008 02:46:44 -0400
In-Reply-To: <Pine.LNX.4.64.0805292313240.12457@schroedinger.engr.sgi.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, Mike Travis <travis@sgi.com>

On Thu, 29 May 2008 23:16:11 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> On Thu, 29 May 2008, Andrew Morton wrote:
> 
> > > No. The module subsystem has its own alloc_percpu subsystem that the 
> > > cpu_alloc replaces.
> > 
> > That is to support DEFINE_PER_CPU, not alloc_percpu().
> 
> Right but it needs to have its own section of the percpu space from which 
> it allocates the percpu segments for the modules. So it effectively 
> implements an allocator.
> 

Could you add a text to explain "This interface is for wise use of
pre-allocated limited area (see Documentation/xxxx). please use this only
when you need very fast access to per-cpu object and you can estimate the amount
which you finally need. If unsure, please use generic allocator."

for the moment ?

At first look, I thought of using this in memory-resource-controller but it seems
I shouldn't do so because thousands of cgroup can be used in theory...

Thanks,
-Kame
