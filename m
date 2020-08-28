Return-Path: <SRS0=gEkT=CG=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6192C433E2
	for <linux-arch@archiver.kernel.org>; Fri, 28 Aug 2020 13:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A6AF207DF
	for <linux-arch@archiver.kernel.org>; Fri, 28 Aug 2020 13:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbgH1Nh4 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 28 Aug 2020 09:37:56 -0400
Received: from foss.arm.com ([217.140.110.172]:49482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729472AbgH1Ndw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Aug 2020 09:33:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91FD81FB;
        Fri, 28 Aug 2020 06:31:52 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 795CC3F66B;
        Fri, 28 Aug 2020 06:31:49 -0700 (PDT)
Date:   Fri, 28 Aug 2020 14:31:31 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, rostedt@goodmis.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        linux-arch@vger.kernel.org, cameron@moodycamel.com,
        oleg@redhat.com, will@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH v4 04/23] arm64: kprobes: Use generic kretprobe
 trampoline handler
Message-ID: <20200828133131.GA71981@C02TD0UTHF1T.local>
References: <159861759775.992023.12553306821235086809.stgit@devnote2>
 <159861764221.992023.10214437014901668680.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159861764221.992023.10214437014901668680.stgit@devnote2>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On Fri, Aug 28, 2020 at 09:27:22PM +0900, Masami Hiramatsu wrote:
> Use the generic kretprobe trampoline handler, and use the
> kernel_stack_pointer(regs) for framepointer verification.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  arch/arm64/kernel/probes/kprobes.c |   78 +-----------------------------------
>  1 file changed, 3 insertions(+), 75 deletions(-)

> +	return (void *)kretprobe_trampoline_handler(regs, &kretprobe_trampoline,
> +					(void *)kernel_stack_pointer(regs));
>  }
>  
>  void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
>  				      struct pt_regs *regs)
>  {
>  	ri->ret_addr = (kprobe_opcode_t *)regs->regs[30];
> +	ri->fp = (void *)kernel_stack_pointer(regs);

This is probably a nomenclature problem, but what exactly is
kretprobe_instance::fp used for?

I ask because arm64's frame pointer lives in x29 (and is not necessarily
the same as the stack pointer at function boundaries), so the naming
is potentially misleading and possibly worth a comment or rename.

Thanks,
Mark.
