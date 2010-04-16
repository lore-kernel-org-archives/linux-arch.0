Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48067 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932396Ab0DPUfA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 16 Apr 2010 16:35:00 -0400
Date: Fri, 16 Apr 2010 13:33:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/8] numa:  add generic percpu var numa_node_id()
 implementation
Message-ID: <20100416133324.fcb1c168.akpm@linux-foundation.org>
In-Reply-To: <20100415172956.8801.18133.sendpatchset@localhost.localdomain>
References: <20100415172950.8801.60358.sendpatchset@localhost.localdomain>
	<20100415172956.8801.18133.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lee Schermerhorn <lee.schermerhorn@hp.com>
Cc: linux-mm@kvack.org, linux-numa@vger.kernel.org, Tejun Heo <tj@kernel.org>, Mel Gorman <mel@csn.ul.ie>, andi@firstfloor.org, Christoph Lameter <cl@linux-foundation.org>, Nick Piggin <npiggin@suse.de>, David Rientjes <rientjes@google.com>, eric.whitney@hp.com, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, linux-arch@vger.kernel.org
Message-ID: <20100416203324.2XKtVNPomPxY9tilcbkHcvM-GxRtGZ6PFuZy1W3TlRw@z>

On Thu, 15 Apr 2010 13:29:56 -0400
Lee Schermerhorn <lee.schermerhorn@hp.com> wrote:

> Rework the generic version of the numa_node_id() function to use the
> new generic percpu variable infrastructure.
> 
> Guard the new implementation with a new config option:
> 
>         CONFIG_USE_PERCPU_NUMA_NODE_ID.
> 
> Archs which support this new implemention will default this option
> to 'y' when NUMA is configured.  This config option could be removed
> if/when all archs switch over to the generic percpu implementation
> of numa_node_id().  Arch support involves:
> 
>   1) converting any existing per cpu variable implementations to use
>      this implementation.  x86_64 is an instance of such an arch.
>   2) archs that don't use a per cpu variable for numa_node_id() will
>      need to initialize the new per cpu variable "numa_node" as cpus
>      are brought on-line.  ia64 is an example.
>   3) Defining USE_PERCPU_NUMA_NODE_ID in arch dependent Kconfig--e.g.,
>      when NUMA is configured.  This is required because I have
>      retained the old implementation by default to allow archs to
>      be modified incrementally, as desired.
> 
> Subsequent patches will convert x86_64 and ia64 to use this
> implemenation.

So which arches _aren't_ converted?  powerpc, sparc and alpha?

Is there sufficient info here for the maintainers to be able to
perform the conversion with minimal head-scratching?
