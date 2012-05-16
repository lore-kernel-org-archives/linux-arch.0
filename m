From: Alex Shi <alex.shi@intel.com>
Subject: Re: [PATCH v5 6/7] x86/tlb: optimizing flush_tlb_mm
Date: Wed, 16 May 2012 21:44:38 +0800
Message-ID: <4FB3AF46.8090309@intel.com>
References: <1337072138-8323-1-git-send-email-alex.shi@intel.com>   <1337072138-8323-7-git-send-email-alex.shi@intel.com>   <CAPa8GCDsSOrzQwX2qRJyocYAZdGbwjD4t4fjxmWXV6=EoXjXZw@mail.gmail.com>   <4FB2590C.1050303@intel.com> <1337092577.27694.45.camel@twins>  <1337093840.27694.56.camel@twins> <4FB34D49.1060809@intel.com> <1337155239.27694.131.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1337155239.27694.131.camel@twins>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nick Piggin <npiggin@gmail.com>, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, arnd@arndb.de, rostedt@goodmis.org, fweisbec@gmail.com, jeremy@goop.org, riel@redhat.com, luto@mit.edu, avi@redhat.com, len.brown@intel.com, dhowells@redhat.com, fenghua.yu@intel.com, borislav.petkov@amd.com, yinghai@kernel.org, ak@linux.intel.com, cpw@sgi.com, steiner@sgi.com, akpm@linux-foundation.org, penberg@kernel.org, hughd@google.com, rientjes@google.com, kosaki.motohiro@jp.fujitsu.com, n-horiguchi@ah.jp.nec.com, tj@kernel.org, oleg@redhat.com, axboe@kernel.dk, jmorris@namei.org, kamezawa.hiroyu@jp.fujitsu.com, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, yongjie.ren@intel.com, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


> Now IF you're going to change the tlb interface like this, you're going
> to get to do it for all architectures, along with a sane benchmark to
> show its beneficial to track ranges like this.
> 
> But as it stands, people are still questioning the validity of your
> mprotect micro-bench, so no, you don't get to change the tlb interface.


Yes, sure. You are definitely right!
