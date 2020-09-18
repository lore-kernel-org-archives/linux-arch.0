Return-Path: <SRS0=8KsW=C3=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B797C43464
	for <linux-arch@archiver.kernel.org>; Fri, 18 Sep 2020 15:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 168C62311D
	for <linux-arch@archiver.kernel.org>; Fri, 18 Sep 2020 15:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgIRPBw (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 18 Sep 2020 11:01:52 -0400
Received: from elvis.franken.de ([193.175.24.41]:44667 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbgIRPBu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Sep 2020 11:01:50 -0400
X-Greylist: delayed 1241 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 11:01:49 EDT
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1kJHZL-0002r7-00; Fri, 18 Sep 2020 16:40:59 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id A828DC0FDF; Fri, 18 Sep 2020 16:13:36 +0200 (CEST)
Date:   Fri, 18 Sep 2020 16:13:36 +0200
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
Subject: Re: [PATCH v2] MIPS: make userspace mapping young by default
Message-ID: <20200918141336.GA21486@alpha.franken.de>
References: <20200908021647.21907-1-huangpei@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908021647.21907-1-huangpei@loongson.cn>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 08, 2020 at 10:16:47AM +0800, Huang Pei wrote:
> -#define PAGE_NONE	__pgprot(_PAGE_PRESENT | _PAGE_NO_READ | \
> -				 _page_cachable_default)
> [...]
> +#define PAGE_NONE      __pgprot(_PAGE_PRESENT | _PAGE_NO_READ | \
> +                                _page_cachable_default)

this looks like pure white space changes, please re-send without
whitespace changes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
