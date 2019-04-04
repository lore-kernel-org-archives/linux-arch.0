From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Date: Thu, 4 Apr 2019 10:02:30 +0800
Message-ID: <5ac2fb0e-744b-3bb5-133a-ac684e061d17@huawei.com>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190329152006.110370-4-alex.kogan@oracle.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org
Cc: dave.dice@oracle.com, rahul.x.yadav@oracle.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com
List-Id: linux-arch.vger.kernel.org

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
