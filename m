Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60948 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726495AbfDHCaV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 7 Apr 2019 22:30:21 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x382TGM3029225
        for <linux-arch@vger.kernel.org>; Sun, 7 Apr 2019 22:30:20 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rqny5f7v4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Sun, 07 Apr 2019 22:30:20 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 8 Apr 2019 03:30:19 +0100
Date: Sun, 7 Apr 2019 19:30:15 -0700
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH v2] srcu: Remove unused vmlinux srcu linker entries
Reply-To: paulmck@linux.ibm.com
References: <20190408004719.178484-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408004719.178484-1-joel@joelfernandes.org>
Message-ID: <20190408023015.GH14111@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, kernel-team@android.com, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Message-ID: <20190408023015.vfTDLIpazUk4RHK1ogTcRnFJ3UXBtLkKYLwEl2Hjre0@z>

On Sun, Apr 07, 2019 at 08:47:19PM -0400, Joel Fernandes (Google) wrote:
> The SRCU for modules optimization (commit title "srcu: Allocate per-CPU
> data for DEFINE_SRCU() in modules") introduced vmlinux linker entries
> which is unused since it applies only to the built-in vmlinux. So remove
> it to prevent any space usage due to the 8 byte alignment it added.
> vmlinux.lds.h has no effect on module loading and is not used for
> building the module object, so the changes were not needed in the first
> place since the optimization is specific to modules.
> 
> Tested with SRCU torture_type and rcutorture. Put prints in module
> loader to confirm it is able to find and initialize the srcu structures.
> 
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: kernel-team@android.com
> Cc: paulmck@linux.vnet.ibm.com
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Queued, thank you, Joel!

							Thanx, Paul

> ---
> v1->v2: Added more context to change log.
> 
>  include/asm-generic/vmlinux.lds.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index c2d919a1566e..f8f6f04c4453 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -338,10 +338,6 @@
>  		KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
>  		__stop___tracepoints_ptrs = .;				\
>  		*(__tracepoints_strings)/* Tracepoints: strings */	\
> -		. = ALIGN(8);						\
> -		__start___srcu_struct = .;				\
> -		*(___srcu_struct_ptrs)					\
> -		__end___srcu_struct = .;				\
>  	}								\
>  									\
>  	.rodata1          : AT(ADDR(.rodata1) - LOAD_OFFSET) {		\
> -- 
> 2.21.0.392.gf8f6787159e-goog
> 
