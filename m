Return-Path: <glauber@gmx.de>
Received: from mtagate5.de.ibm.com ([195.212.29.154]:45041 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S264073AbUDVOQl
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Apr 2004 10:16:41 -0400
Subject: Re: [Patch] SMP call function cleanup
From: Jan Glauber <glauber@gmx.de>
Reply-To: glauber@gmx.de
In-Reply-To: <1082642332.1778.39.camel@mulgrave>
References: <1082636511.1332.34.camel@halo>
	 <20040422122818.GR743@holomorphy.com>  <20040422123703.GY22027@krispykreme>
	 <1082638779.1778.16.camel@mulgrave>  <1082641822.1329.45.camel@halo>
	 <1082642332.1778.39.camel@mulgrave>
Content-Type: text/plain
Message-Id: <1082643325.1332.66.camel@halo>
Mime-Version: 1.0
Date: Thu, 22 Apr 2004 16:15:25 +0200
Content-Transfer-Encoding: 7bit
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Linux Architecture List <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2004-04-22 at 15:58, James Bottomley wrote:
> Because to execute on a single cpu it's less efficient than the single
> cpu variant (even with the sparse mask traversal) and the
> smp_call_functions are usually in the critical path, so saving cycles is
> good...

With my patch you would use on_single_cpu:

static inline void on_single_cpu(void (*func) (void *info), void *info,
                                 int nonatomic, int wait, int cpu)
{
        cpumask_t map;

        preempt_disable();
        cpus_clear(map);
        cpu_set(cpu, map);
        on_cpu(func, info, nonatomic, wait, map);
        preempt_enable();
}

so the overhead to the single cpu variant of smp_call_function is 

	cpus_clear(map);
	cpu_set(cpu, map);

on_cpu():
	cpus_and(map, map, cpu_online_map);
	if (cpus_empty(map))
		goto out;

and the for_each loop in on_cpu

I don't know if that overhead is so much that you want to have two smp
call functions.

Jan

---
Jan Glauber
Linux on zSeries Development
IBM Deutschland Entwicklung GmbH
Phone: +49 7031 161911   Mail: jang@de.ibm.com
