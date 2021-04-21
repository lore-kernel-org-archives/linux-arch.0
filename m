Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A231C433B4
	for <linux-arch@archiver.kernel.org>; Wed, 21 Apr 2021 16:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A55C261453
	for <linux-arch@archiver.kernel.org>; Wed, 21 Apr 2021 16:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236107AbhDUQQy (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 21 Apr 2021 12:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236051AbhDUQQx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Apr 2021 12:16:53 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8CA0C06174A;
        Wed, 21 Apr 2021 09:16:19 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 8A87E92009C; Wed, 21 Apr 2021 18:16:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 7BE6A92009B;
        Wed, 21 Apr 2021 18:16:18 +0200 (CEST)
Date:   Wed, 21 Apr 2021 18:16:18 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] MIPS: Avoid DIVU in `__div64_32' is result would be
 zero
In-Reply-To: <284CBC37-0F4F-4077-A172-7E47C90B8B43@goldelico.com>
Message-ID: <alpine.DEB.2.21.2104211810200.44318@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2104200044060.44318@angie.orcam.me.uk> <alpine.DEB.2.21.2104200331110.44318@angie.orcam.me.uk> <284CBC37-0F4F-4077-A172-7E47C90B8B43@goldelico.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 21 Apr 2021, H. Nikolaus Schaller wrote:

> > We already check the high part of the divident against zero to avoid the 
> 
> nit-picking: s/divident/dividend/

 Umm, I find this embarassing (and I hesitated reaching for a dictionary 
to double-check the spelling!).  Indeed why would this be different from 
subtrahend or minuend?

 Thomas, as this mistake has spread across three out of these patches,
both in change descriptions and actual code, would you mind dropping the 
series from mips-next altogether and I'll respin the series with all 
these issues corrected?

  Maciej
