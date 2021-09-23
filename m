Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31620C433EF
	for <linux-arch@archiver.kernel.org>; Thu, 23 Sep 2021 20:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E07F61211
	for <linux-arch@archiver.kernel.org>; Thu, 23 Sep 2021 20:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhIWUil (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 23 Sep 2021 16:38:41 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:59852 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbhIWUik (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Sep 2021 16:38:40 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 497031C0BA3; Thu, 23 Sep 2021 22:37:06 +0200 (CEST)
Date:   Thu, 23 Sep 2021 22:37:05 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V3 01/22] Documentation: LoongArch: Add basic
 documentations
Message-ID: <20210923203705.GA1936@bug>
References: <20210917035736.3934017-1-chenhuacai@loongson.cn>
 <20210917035736.3934017-2-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917035736.3934017-2-chenhuacai@loongson.cn>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi!

> Add some basic documentations for LoongArch. LoongArch is a new RISC

... documentation ...

> +wide in LA64. $r0 is always zero, and other registers has no special feature,

...have no special features...

> +but we actually have an ABI register conversion as below.

convention?

> +``$r21``          ``$x``          Reserved            Unused
> +``$r22``          ``$fp``         Frame pointer       Yes
> +``$r23``-``$r31`` ``$s0``-``$s8`` Static registers    Yes
> +================= =============== =================== ============

Not sure I know the term 'static registers' before.
								Pavel
