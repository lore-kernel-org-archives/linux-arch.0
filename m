Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f53.google.com ([209.85.167.53]:36685 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbfDLPc7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Apr 2019 11:32:59 -0400
Received: by mail-lf1-f53.google.com with SMTP id u17so7842745lfi.3
        for <linux-arch@vger.kernel.org>; Fri, 12 Apr 2019 08:32:57 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 1sm8258950ljw.56.2019.04.12.08.32.55
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 08:32:55 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id k8so9247027lja.8
        for <linux-arch@vger.kernel.org>; Fri, 12 Apr 2019 08:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <5cae03c4.iIPk2cWlfmzP0Zgy%lkp@intel.com> <20190411193906.GA12232@hirez.programming.kicks-ass.net>
 <20190411195424.GL14281@hirez.programming.kicks-ass.net> <20190411211348.GA8451@worktop.programming.kicks-ass.net>
 <20190412105633.GM14281@hirez.programming.kicks-ass.net>
In-Reply-To: <20190412105633.GM14281@hirez.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 12 Apr 2019 08:32:38 -0700
Message-ID: <CAHk-=wieBr3G=_ZGoCndi8XnuG1wtkedaGqkWB+=AVq65=_8sQ@mail.gmail.com>
Subject: Re: 1808d65b55 ("asm-generic/tlb: Remove arch_tlb*_mmu()"): BUG:
 KASAN: stack-out-of-bounds in __change_page_attr_set_clr
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: kernel test robot <lkp@intel.com>, LKP <lkp@01.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>, Nadav Amit <namit@vmware.com>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20190412153238._oae3MkJsMC-5xQuPVrNWcriQHa3MJ5_XJg4SSgZCFY@z>

On Fri, Apr 12, 2019 at 3:56 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -728,7 +728,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
>  {
>         int cpu;
>
> -       struct flush_tlb_info info __aligned(SMP_CACHE_BYTES) = {
> +       struct flush_tlb_info info = {
>                 .mm = mm,
>                 .stride_shift = stride_shift,
>                 .freed_tables = freed_tables,
>

Ack.

We should never have stack alignment bigger than 16 bytes.  And
preferably not even that. Trying to align stack at a cacheline
boundary is wrong - if you *really* need things to be that aligned, do
something else (regular kmalloc, percpu temp area, static allocation -
whatever).

           Linus
