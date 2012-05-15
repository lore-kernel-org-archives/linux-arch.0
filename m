From: Alex Shi <alex.shi@intel.com>
Subject: Re: [PATCH v5 6/7] x86/tlb: optimizing flush_tlb_mm
Date: Tue, 15 May 2012 21:24:28 +0800
Message-ID: <4FB2590C.1050303@intel.com>
References: <1337072138-8323-1-git-send-email-alex.shi@intel.com> <1337072138-8323-7-git-send-email-alex.shi@intel.com> <CAPa8GCDsSOrzQwX2qRJyocYAZdGbwjD4t4fjxmWXV6=EoXjXZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:21158 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758823Ab2EONYw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 15 May 2012 09:24:52 -0400
In-Reply-To: <CAPa8GCDsSOrzQwX2qRJyocYAZdGbwjD4t4fjxmWXV6=EoXjXZw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, arnd@arndb.de, rostedt@goodmis.org, fweisbec@gmail.com, jeremy@goop.org, riel@redhat.com, luto@mit.edu, avi@redhat.com, len.brown@intel.com, dhowells@redhat.com, fenghua.yu@intel.com, borislav.petkov@amd.com, yinghai@kernel.org, ak@linux.intel.com, cpw@sgi.com, steiner@sgi.com, akpm@linux-foundation.org, penberg@kernel.org, hughd@google.com, rientjes@google.com, kosaki.motohiro@jp.fujitsu.com, n-horiguchi@ah.jp.nec.com, tj@kernel.org, oleg@redhat.com, axboe@kernel.dk, jmorris@namei.org, a.p.zijlstra@chello.nl, kamezawa.hiroyu@jp.fujitsu.com, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, yongjie.ren@intel.com, linux-arch@vger.kernel.org

On 05/15/2012 05:15 PM, Nick Piggin wrote:

> So this should go to linux-arch...
> 
> On 15 May 2012 18:55, Alex Shi <alex.shi@intel.com> wrote:
>> Not every flush_tlb_mm execution moment is really need to evacuate all
>> TLB entries, like in munmap, just few 'invlpg' is better for whole
>> process performance, since it leaves most of TLB entries for later
>> accessing.
>>
>> This patch is changing flush_tlb_mm(mm) to flush_tlb_mm(mm, start, end)
>> in cases.
> 
> What happened with Peter's comment about using flush_tlb_range for this?
> 
> flush_tlb_mm() API should just stay unchanged AFAIKS.
> 
> Then you need to work out the best way to give range info to the tlb/mmu gather
> API. Possibly passing in the rage for that guy is OK, which x86 can
> then implement
> as flush range.


Sorry. I don't understand what's the comments Peter's made days ago. I should ask for more details originally. 

So, Peter, the correct change should like following, am I right?

-#define tlb_flush(tlb) flush_tlb_mm((tlb)->mm)
+#define tlb_flush(tlb, start, end) __flush_tlb_range((tlb)->mm, start, end)
