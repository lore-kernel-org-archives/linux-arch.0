From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] cpumask: guard cpumask_of_node() macro argument
Date: Wed, 27 May 2020 07:51:38 -0700
Message-ID: <20200527145138.GB209591@roeck-us.net>
References: <20200527134623.930247-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388621AbgE0Ovk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 May 2020 10:51:40 -0400
Content-Disposition: inline
In-Reply-To: <20200527134623.930247-1-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Naveen Krishna Chatradhi <nchatrad@amd.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@redhat.com>, Tony Luck <tony.luck@intel.com>, Ralf Baechle <ralf@linux-mips.org>, Richard Henderson <rth@twiddle.net>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 03:46:08PM +0200, Arnd Bergmann wrote:
> drivers/hwmon/amd_energy.c:195:15: error: invalid operands to binary expression ('void' and 'int')
>                                         (channel - data->nr_cpus));
>                                         ~~~~~~~~~^~~~~~~~~~~~~~~~~
> include/asm-generic/topology.h:51:42: note: expanded from macro 'cpumask_of_node'
>     #define cpumask_of_node(node)       ((void)node, cpu_online_mask)
>                                                ^~~~
> include/linux/cpumask.h:618:72: note: expanded from macro 'cpumask_first_and'
>  #define cpumask_first_and(src1p, src2p) cpumask_next_and(-1, (src1p), (src2p))
>                                                                        ^~~~~
> 
> Fixes: f0b848ce6fe9 ("cpumask: Introduce cpumask_of_{node,pcibus} to replace {node,pcibus}_to_cpumask")
> Fixes: 8abee9566b7e ("hwmon: Add amd_energy driver to report energy counters")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Didn't I Cc: you on the same patch I sent out earlier ? Never mind, though.

Acked-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
>  include/asm-generic/topology.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/asm-generic/topology.h b/include/asm-generic/topology.h
> index 238873739550..5aa8705df87e 100644
> --- a/include/asm-generic/topology.h
> +++ b/include/asm-generic/topology.h
> @@ -48,7 +48,7 @@
>    #ifdef CONFIG_NEED_MULTIPLE_NODES
>      #define cpumask_of_node(node)	((node) == 0 ? cpu_online_mask : cpu_none_mask)
>    #else
> -    #define cpumask_of_node(node)	((void)node, cpu_online_mask)
> +    #define cpumask_of_node(node)	((void)(node), cpu_online_mask)
>    #endif
>  #endif
>  #ifndef pcibus_to_node
> -- 
> 2.26.2
> 
