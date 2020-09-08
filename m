Return-Path: <SRS0=vPgs=CR=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF183C433E2
	for <linux-arch@archiver.kernel.org>; Tue,  8 Sep 2020 06:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 938612078B
	for <linux-arch@archiver.kernel.org>; Tue,  8 Sep 2020 06:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbgIHGPc (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 8 Sep 2020 02:15:32 -0400
Received: from verein.lst.de ([213.95.11.211]:51452 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728775AbgIHGPb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Sep 2020 02:15:31 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BA83B68AFE; Tue,  8 Sep 2020 08:15:28 +0200 (CEST)
Date:   Tue, 8 Sep 2020 08:15:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Russell King <rmk@arm.linux.org.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] ARM: traps: use get_kernel_nofault instead of
 set_fs()
Message-ID: <20200908061528.GB13930@lst.de>
References: <20200907153701.2981205-1-arnd@arndb.de> <20200907153701.2981205-3-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907153701.2981205-3-arnd@arndb.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> +static void dump_mem(const char *, const char *, unsigned long, unsigned long, bool kernel_mode);

This adds a pointlessly long line.  

And looking at the code I don't see why the argument is even needed.

dump_mem() currently does an unconditional set_fs(KERNEL_DS), so it
should always use get_kernel_nofault.

> +static void dump_instr(const char *lvl, struct pt_regs *regs)
>  {
>  	unsigned long addr = instruction_pointer(regs);
>  	const int thumb = thumb_mode(regs);
> @@ -173,10 +169,20 @@ static void __dump_instr(const char *lvl, struct pt_regs *regs)
>  	for (i = -4; i < 1 + !!thumb; i++) {
>  		unsigned int val, bad;
>  
> -		if (thumb)
> -			bad = get_user(val, &((u16 *)addr)[i]);
> -		else
> -			bad = get_user(val, &((u32 *)addr)[i]);
> +		if (!user_mode(regs)) {
> +			if (thumb) {
> +				u16 val16;
> +				bad = get_kernel_nofault(val16, &((u16 *)addr)[i]);
> +				val = val16;
> +			} else {
> +				bad = get_kernel_nofault(val, &((u32 *)addr)[i]);
> +			}
> +		} else {
> +			if (thumb)
> +				bad = get_user(val, &((u16 *)addr)[i]);
> +			else
> +				bad = get_user(val, &((u32 *)addr)[i]);
> +		}

When I looked at this earlier I just added a little helper to make
this a little easier to read.   Here is my patch from an old tree:

http://git.infradead.org/users/hch/misc.git/commitdiff/67413030ccb7a64a7eb828e13ff0795f4eadfeb7
