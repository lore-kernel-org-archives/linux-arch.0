From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH] ia64: convert to dynamic percpu allocator
Date: Wed, 22 Jul 2009 07:14:31 +0900
Message-ID: <4A663DC7.4060600@kernel.org>
References: <4A65B0AB.5000608@kernel.org> <A6AD88C3F2289247BE726C37303E1EB8B097D4C5@orsmsx505.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <A6AD88C3F2289247BE726C37303E1EB8B097D4C5@orsmsx505.amr.corp.intel.com>
Sender: linux-ia64-owner@vger.kernel.org
To: "Yu, Fenghua" <fenghua.yu@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, 'lkml' <linux-kernel@vger.kernel.org>, "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>, "'linux-ia64@vger.kernel.org'" <linux-ia64@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hello,

Yu, Fenghua wrote:
>> This patch is available in the following git tree.
>>
>>  git://git.kernel.org/pub/scm/linux/kernel/git/tj/percpu.git review-ia64
> 
> Is this patch against the latest linux-next? It's applied cleanly on
> linux-next. But compilation reports undefined function
> pcpu_alloc_alloc_info() in both contig.c and discontig.c.

Oh, it's on top of percpu#for-next + 20 patches to implement sparse
embedding[1].  I think it would be the easiest to fetch the above git
tree.

Thanks.

-- 
tejun

[1] http://thread.gmane.org/gmane.linux.kernel.cross-arch/4124
