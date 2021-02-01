Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27906C433DB
	for <linux-arch@archiver.kernel.org>; Mon,  1 Feb 2021 12:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2CA564E96
	for <linux-arch@archiver.kernel.org>; Mon,  1 Feb 2021 12:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhBAMYw (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 1 Feb 2021 07:24:52 -0500
Received: from elvis.franken.de ([193.175.24.41]:43552 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhBAMYv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Feb 2021 07:24:51 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1l6YFS-0000Vn-00; Mon, 01 Feb 2021 13:24:06 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 7C044C0CEC; Mon,  1 Feb 2021 13:23:52 +0100 (CET)
Date:   Mon, 1 Feb 2021 13:23:52 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Huang Pei <huangpei@loongson.cn>
Cc:     ambrosehua@gmail.com, Bibo Mao <maobibo@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: Re: [PATCH] MIPS: fix kernel_stack_pointer()
Message-ID: <20210201122352.GA8095@alpha.franken.de>
References: <20210129043507.30488-1-huangpei@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129043507.30488-1-huangpei@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 29, 2021 at 12:35:07PM +0800, Huang Pei wrote:
> MIPS always save kernel stack pointer in regs[29]
> 
> Signed-off-by: Huang Pei <huangpei@loongson.cn>
> ---
>  arch/mips/include/asm/ptrace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
> index 1e76774b36dd..daf3cf244ea9 100644
> --- a/arch/mips/include/asm/ptrace.h
> +++ b/arch/mips/include/asm/ptrace.h
> @@ -53,7 +53,7 @@ struct pt_regs {
>  
>  static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
>  {
> -	return regs->regs[31];
> +	return regs->regs[29];

hmm, I'm still wondering where the trick is... looks like this is used
for uprobes, so nobody has ever used uprobes or I'm missing something.

How did you find that ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
