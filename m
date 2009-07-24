From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH] ia64: convert to dynamic percpu allocator
Date: Fri, 24 Jul 2009 15:45:43 +0900
Message-ID: <4A695897.2020902@kernel.org>
References: <4A65B0AB.5000608@kernel.org> <A6AD88C3F2289247BE726C37303E1EB8B097D4C5@orsmsx505.amr.corp.intel.com> <4A663DC7.4060600@kernel.org> <A6AD88C3F2289247BE726C37303E1EB8B0A9115B@orsmsx505.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <A6AD88C3F2289247BE726C37303E1EB8B0A9115B@orsmsx505.amr.corp.intel.com>
Sender: linux-ia64-owner@vger.kernel.org
To: "Yu, Fenghua" <fenghua.yu@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, 'lkml' <linux-kernel@vger.kernel.org>, "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>, "'linux-ia64@vger.kernel.org'" <linux-ia64@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hello,

Yu, Fenghua wrote:

> After cloning from
> git://git.kernel.org/pub/scm/linux/kernel/git/tj/percpu.git, kernel
> built with CONFIG_DISCONTIGMEM=y boots ok.
> 
> After pulling from review-ia64, kernel built with
> CONFIG_DISCONTIGMEM=y can not boot on ia64. After loading kernel and
> initrd, system hangs and doesn't show anything on serial port.

Heh, I didn't really expect it to work that easily either.  The code
builds but is completely untested (I can't test them).  Can you try to
track it down?  Serial console should be up and running at that point,
no?

Thanks.

-- 
tejun
