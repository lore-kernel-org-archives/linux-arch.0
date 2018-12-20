From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: [PATCH 1/2] ARC: show_regs: avoid page allocator
Date: Thu, 20 Dec 2018 22:30:08 +0900
Message-ID: <e2d2c160-0ef6-5504-7824-032a5c70fa7f@I-love.SAKURA.ne.jp>
References: <1545159239-30628-1-git-send-email-vgupta@synopsys.com>
 <1545159239-30628-2-git-send-email-vgupta@synopsys.com>
 <1545239047.14089.13.camel@synopsys.com>
 <49f9edc9-87ee-1efc-58f8-b0d9a52c8a49@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <49f9edc9-87ee-1efc-58f8-b0d9a52c8a49@synopsys.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <vineet.gupta1@synopsys.com>, Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>
List-Id: linux-arch.vger.kernel.org

On 2018/12/20 10:16, Vineet Gupta wrote:
> On 12/19/18 9:04 AM, Eugeniy Paltsev wrote:
>> As I can see x86 use print_vma_addr() in their show_signal_msg()
>> function which allocate page with __get_free_page(GFP_NOWAIT);
> 
> Indeed with that the __get_free_page() lockdep splat is gone.
> 
> There's a different one now hence my other patch.
> 
> | [ARCLinux]# ./segv-null-ptr
> | potentially unexpected fatal signal 11.
> | BUG: sleeping function called from invalid context at kernel/fork.c:1011
> | in_atomic(): 1, irqs_disabled(): 0, pid: 70, name: segv-null-ptr
> | no locks held by segv-null-ptr/70.
> | CPU: 0 PID: 70 Comm: segv-null-ptr Not tainted 4.18.0+ #69
> |
> | Stack Trace:
> |  arc_unwind_core+0xcc/0x100
> |  ___might_sleep+0x17a/0x190
> |  mmput+0x16/0xb8

Then, does mmput_async() help?

> |  show_regs+0x52/0x310
> |  get_signal+0x5ee/0x610
> |  do_signal+0x2c/0x218
> |  resume_user_mode_begin+0x90/0xd8
