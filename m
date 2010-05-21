Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47154 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758612Ab0EUXDI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 21 May 2010 19:03:08 -0400
Date: Fri, 21 May 2010 16:02:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/7]
 numa-x86_64-use-generic-percpu-var-numa_node_id-implementation-fix1
Message-ID: <20100521160240.b61d3404.akpm@linux-foundation.org>
In-Reply-To: <20100503150518.15039.3576.sendpatchset@localhost.localdomain>
References: <20100503150455.15039.10178.sendpatchset@localhost.localdomain>
	<20100503150518.15039.3576.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lee Schermerhorn <lee.schermerhorn@hp.com>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-numa@vger.kernel.org, Tejun Heo <tj@kernel.org>, Valdis.Kletnieks@vt.edu, Randy Dunlap <randy.dunlap@oracle.com>, Christoph Lameter <cl@linux-foundation.org>, eric.whitney@hp.com, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <20100521230240.9EwxCUN4IoS5K2naTVMp3m-mp0GY_NdGzJdAZ3ZLY0w@z>

On Mon, 03 May 2010 11:05:18 -0400
Lee Schermerhorn <lee.schermerhorn@hp.com> wrote:

> Incremental patch 1 to
> numa-x86_64-use-generic-percpu-var-numa_node_id-implementation.patch
> in 28apr10 mmotm.
> 
> Use generic percpu numa_node variable only for x86_64.
> 
> x86_32 will require separate support.  Not sure it's worth it.
> 
> Signed-off-by: Lee Schermerhorn <lee.schermerhorn@hp.com>
> 
>  arch/x86/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6.34-rc5-mmotm-100428-1653/arch/x86/Kconfig
> ===================================================================
> --- linux-2.6.34-rc5-mmotm-100428-1653.orig/arch/x86/Kconfig
> +++ linux-2.6.34-rc5-mmotm-100428-1653/arch/x86/Kconfig
> @@ -1720,7 +1720,7 @@ config HAVE_ARCH_EARLY_PFN_TO_NID
>  	depends on NUMA
>  
>  config USE_PERCPU_NUMA_NODE_ID
> -	def_bool y
> +	def_bool X86_64
>  	depends on NUMA
>  
>  menu "Power management and ACPI options"

i386 allmodconfig:

In file included from include/linux/gfp.h:7,
                 from include/linux/kmod.h:22,
                 from include/linux/module.h:13,
                 from include/linux/crypto.h:21,
                 from arch/x86/kernel/asm-offsets_32.c:7,
                 from arch/x86/kernel/asm-offsets.c:2:
include/linux/topology.h: In function 'numa_node_id':
include/linux/topology.h:248: error: implicit declaration of function 'cpu_to_node'

this patchset has been quite a PITA.  What happened?
