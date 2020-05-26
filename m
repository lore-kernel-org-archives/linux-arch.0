From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] topology: Fix cpumask_of_node macro for
 CONFIG_NEED_MULTIPLE_NODES=n
Date: Tue, 26 May 2020 11:07:14 -0700
Message-ID: <45fda375-3691-e722-000f-188dd13d2e0b@infradead.org>
References: <20200526174443.207610-1-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbgEZSHP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 May 2020 14:07:15 -0400
In-Reply-To: <20200526174443.207610-1-linux@roeck-us.net>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>

On 5/26/20 10:44 AM, Guenter Roeck wrote:
> The following compile error is seen in linux-next if
> NUMA=n and CONFIG_NEED_MULTIPLE_NODES=n.
> 
>   CC      drivers/hwmon/amd_energy.o
> In file included from ../arch/x86/include/asm/cpumask.h:5:0,
>                  from ../arch/x86/include/asm/msr.h:11,
>                  from ../arch/x86/include/asm/processor.h:22,
>                  from ../arch/x86/include/asm/cpu_device_id.h:16,
>                  from ../drivers/hwmon/amd_energy.c:6:
> ../drivers/hwmon/amd_energy.c: In function 'amd_energy_read':
> ../include/asm-generic/topology.h:51:36: error:
> 			void value not ignored as it ought to be
>      #define cpumask_of_node(node) ((void)node, cpu_online_mask)
> ../include/linux/cpumask.h:618:72: note:
> 			in definition of macro 'cpumask_first_and'
>  #define cpumask_first_and(src1p, src2p) cpumask_next_and(-1, (src1p), (src2p))
>                                                                         ^~~~~
> ../drivers/hwmon/amd_energy.c:194:6: note: in expansion of macro 'cpumask_of_node'
> 
> cpumask_of_node() is missing () around the 'node' parameter.
> 
> Fixes: b339752d054f ("cpumask: fix spurious cpumask_of_node() on non-NUMA multi-node configs")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>


Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

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
> 


-- 
~Randy
