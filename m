Return-Path: <SRS0=bFu9=BY=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD3AC433DF
	for <linux-arch@archiver.kernel.org>; Fri, 14 Aug 2020 23:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 737BB20774
	for <linux-arch@archiver.kernel.org>; Fri, 14 Aug 2020 23:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="duCnFkXK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgHNXUD (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 14 Aug 2020 19:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgHNXUC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Aug 2020 19:20:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7C8C061385;
        Fri, 14 Aug 2020 16:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=/k+FCjWU06VGb2159RBI2JE7ici1nTwl6uGEUcvW8u8=; b=duCnFkXKHIs9RUqJo10Z/9LP6f
        kHPvfdSST7h1NCcFpY5ySDUPo3g0vY2bpH3A56OvTGU1LDVT3T4FXY5AggTQmUznP3FyyVh8+sUxX
        m3CjcwehIAA6UcUrrEDU3+MFrCwox9hnSBUuJSwSHpVIHbYCw9+is3FeOqe3xN7a6b/4ht95PrydZ
        iyuZlh3txnvSFXxeaWP0dOwcXyyFk3/aOhRCMKXNkycUrt+mq2mHLJlAn2HDCN9IJ53quej40LTDz
        1MxgS3T3C3ycfhDdyrysm9QBxQ/ogQXHwJSc6z6eywFjNDjzGqEBmf95qbiUvNHc6Oxj+cYVI6rrx
        RGhUjLyA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6izE-0003Yk-MW; Fri, 14 Aug 2020 23:19:49 +0000
Subject: Re: [RFC/RFT PATCH 1/6] numa: Move numa implementation to common code
To:     Atish Patra <atish.patra@wdc.com>, linux-kernel@vger.kernel.org
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Anup Patel <Anup.Patel@wdc.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>, Zong Li <zong.li@sifive.com>,
        Ganapatrao Kulkarni <gkulkarni@cavium.com>,
        linux-arm-kernel@lists.infradead.org
References: <20200814214725.28818-1-atish.patra@wdc.com>
 <20200814214725.28818-2-atish.patra@wdc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <abc3e4de-f58e-98c9-b289-477663f64997@infradead.org>
Date:   Fri, 14 Aug 2020 16:19:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814214725.28818-2-atish.patra@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/14/20 2:47 PM, Atish Patra wrote:
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 8d7001712062..73c2151de194 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -210,4 +210,10 @@ config GENERIC_ARCH_TOPOLOGY
>  	  appropriate scaling, sysfs interface for reading capacity values at
>  	  runtime.
>  
> +config GENERIC_ARCH_NUMA
> +	bool
> +	help
> +	  Enable support for generic numa implementation. Currently, RISC-V

	                             NUMA

> +	  and ARM64 uses it.

	            use it.

> +
>  endmenu

thanks.
-- 
~Randy

