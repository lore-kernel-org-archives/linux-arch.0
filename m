From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH/RFC] headers: drop 2 #included headers from
 <linux/interrupt.h>
Date: Fri, 16 Feb 2018 08:59:42 +0100
Message-ID: <20180216075942.kmgdyvmluke2s5vg@gmail.com>
References: <b24b9ec8-4970-65f5-759a-911d4ba2fcf0@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b24b9ec8-4970-65f5-759a-911d4ba2fcf0@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org


* Randy Dunlap <rdunlap@infradead.org> wrote:

> Does anyone know or see why <linux/interrupt.h> needs <linux/linkage.h> or
> <linux/preempt.h>?  There are no direct uses in <linux/interrupt.h> AFAICT.

These are likely historical, plus it's a classic 'tragedy of the commons' 
scenario: it's easy to take away from the "public good" of "clean header 
dependencies" and very hard to add to it:

 - it's very easy to add a new #include line

 - it's very hard to remove one, not just due to the 2^10000 complex Kconfig
   space, but due to 99% of the developers not testing cross-arch builds
   (and we don't want to require them to do it)

 - the cost of getting the removal wrong is high (the build breaks for many 
   people who will be unhappy at the person removing the header), while the 
   benefit of the removal is low in isolation

Then apply this dynamic for more than 20 years and we get a spaghetti:

 triton:~/tip> grep -c '#include <' include/linux/*.h | sort -n -t: -k +2  | tail -20

 include/linux/device.h:15
 include/linux/ide.h:16
 include/linux/module.h:16
 include/linux/acpi.h:17
 include/linux/filter.h:17
 include/linux/init_task.h:17
 include/linux/mmzone.h:17
 include/linux/cgroup.h:18
 include/linux/nfs_fs.h:18
 include/linux/sched.h:18
 include/linux/irq.h:19
 include/linux/pci.h:19
 include/linux/perf_event.h:23
 include/linux/blkdev.h:25
 include/linux/kvm_host.h:26
 include/linux/mm.h:26
 include/linux/netdevice.h:26
 include/linux/skbuff.h:26
 include/linux/isdn.h:27
 include/linux/fs.h:39

Plus there's collateral damage as well: there's countless primitives that were 
forced into the CPP macro space because the header dependencies were too hard. 
Such code is not just harder to read and maintain, it's more fragile to macro 
substitution bugs and it's less type safe as well.

I'd argue that due to the basic human dynamics here this calls for tooling help.

In the meanwhile I've applied your patch to tip:core/headers and will do full 
build testing + fixing, should anything break.

Thanks,

	Ingo
