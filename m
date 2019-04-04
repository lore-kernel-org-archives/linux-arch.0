Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:51196 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726167AbfDDCDG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Apr 2019 22:03:06 -0400
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <5ac2fb0e-744b-3bb5-133a-ac684e061d17@huawei.com>
Date: Thu, 4 Apr 2019 10:02:30 +0800
MIME-Version: 1.0
In-Reply-To: <20190329152006.110370-4-alex.kogan@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org
Cc: dave.dice@oracle.com, rahul.x.yadav@oracle.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com
Message-ID: <20190404020230.BOs3FIBisS4uBKVth8Ms8JvqyBFqqV9sgUTRGmQg-EU@z>

Hi Alex,

On 2019/3/29 23:20, Alex Kogan wrote:
> +
> +static __always_inline void cna_init_node(struct mcs_spinlock *node, int cpuid,
> +					  u32 tail)
> +{
> +	if (decode_numa_node(node->node_and_count) == -1)
> +		store_numa_node(node, numa_cpu_node(cpuid));

How about using cpu_to_node() here and #include <linux/topology.h> in this
file, then the code can be reused for other architectures such as ARM64?

Thanks
Hanjun
