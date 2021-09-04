Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D5CC433EF
	for <linux-arch@archiver.kernel.org>; Sat,  4 Sep 2021 17:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D29A60F90
	for <linux-arch@archiver.kernel.org>; Sat,  4 Sep 2021 17:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237237AbhIDR7C (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sat, 4 Sep 2021 13:59:02 -0400
Received: from angie.orcam.me.uk ([78.133.224.34]:33188 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237178AbhIDR7C (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 4 Sep 2021 13:59:02 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id F11A892009C; Sat,  4 Sep 2021 19:57:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id E1AEA92009B;
        Sat,  4 Sep 2021 19:57:56 +0200 (CEST)
Date:   Sat, 4 Sep 2021 19:57:56 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Huang Pei <huangpei@loongson.cn>
cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        ambrosehua@gmail.com, Bibo Mao <maobibo@loongson.cn>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] MIPS: fix local_t operation on MIPS64
In-Reply-To: <20210904151218.10167-1-huangpei@loongson.cn>
Message-ID: <alpine.DEB.2.21.2109041955310.38640@angie.orcam.me.uk>
References: <20210904151218.10167-1-huangpei@loongson.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 4 Sep 2021, Huang Pei wrote:

> diff --git a/arch/mips/include/asm/llsc.h b/arch/mips/include/asm/llsc.h
> index ec09fe5d6d6c..788e26ad7fca 100644
> --- a/arch/mips/include/asm/llsc.h
> +++ b/arch/mips/include/asm/llsc.h
> @@ -16,11 +16,15 @@
>  #define __SC		"sc	"
>  #define __INS		"ins	"
>  #define __EXT		"ext	"
> +#define __ADDU		"addu	"
> +#define __SUBU		"subu	"
>  #elif _MIPS_SZLONG == 64
>  #define __LL		"lld	"
>  #define __SC		"scd	"
>  #define __INS		"dins	"
>  #define __EXT		"dext	"
> +#define __ADDU		"daddu	"
> +#define __SUBU		"dsubu	"

 Why invent things instead of using standard macros (LONG_ADDU/LONG_SUBU)?

  Maciej
