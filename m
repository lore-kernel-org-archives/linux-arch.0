Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167A1C11F68
	for <linux-arch@archiver.kernel.org>; Fri,  2 Jul 2021 14:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB95A61413
	for <linux-arch@archiver.kernel.org>; Fri,  2 Jul 2021 14:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhGBPAd (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 2 Jul 2021 11:00:33 -0400
Received: from imap3.hz.codethink.co.uk ([176.9.8.87]:58604 "EHLO
        imap3.hz.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbhGBPAd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Jul 2021 11:00:33 -0400
X-Greylist: delayed 1236 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Jul 2021 11:00:32 EDT
Received: from cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net ([86.15.83.122] helo=[192.168.0.18])
        by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1lzKID-0007JQ-2I; Fri, 02 Jul 2021 15:37:21 +0100
Subject: Re: [PATCH v2 1/3] lib/string: optimized memcpy
To:     Matteo Croce <mcroce@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, Nick Kossifidis <mick@ics.forth.gr>,
        Guo Ren <guoren@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Drew Fustini <drew@beagleboard.org>
Cc:     linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org
References: <20210702123153.14093-1-mcroce@linux.microsoft.com>
 <20210702123153.14093-2-mcroce@linux.microsoft.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <0e0fa030-8995-b930-5e22-954349a0b82e@codethink.co.uk>
Date:   Fri, 2 Jul 2021 15:37:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210702123153.14093-2-mcroce@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 02/07/2021 13:31, Matteo Croce wrote:
> From: Matteo Croce <mcroce@microsoft.com>
> 
> Rewrite the generic memcpy() to copy a word at time, without generating
> unaligned accesses.
> 
> The procedure is made of three steps:
> First copy data one byte at time until the destination buffer is aligned
> to a long boundary.
> Then copy the data one long at time shifting the current and the next long
> to compose a long at every cycle.
> Finally, copy the remainder one byte at time.
> 
> This is the improvement on RISC-V:
> 
> original aligned:	 75 Mb/s
> original unaligned:	 75 Mb/s
> new aligned:		114 Mb/s
> new unaligned:		107 Mb/s
> 
> and this the binary size increase according to bloat-o-meter:
> 
> Function     old     new   delta
> memcpy        36     324    +288
> 
> 
> Signed-off-by: Matteo Croce <mcroce@microsoft.com>
> ---
>   lib/string.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 77 insertions(+), 3 deletions(-)

Doesn't arch/riscv/lib/memcpy.S also exist for an architecture
optimised version? I would have thought the lib/string.c version
was not being used?


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
