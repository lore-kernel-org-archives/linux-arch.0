Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0E4C43460
	for <linux-arch@archiver.kernel.org>; Thu,  8 Apr 2021 11:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC0A461151
	for <linux-arch@archiver.kernel.org>; Thu,  8 Apr 2021 11:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhDHLBs (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 8 Apr 2021 07:01:48 -0400
Received: from marcansoft.com ([212.63.210.85]:33280 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229803AbhDHLBs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Apr 2021 07:01:48 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 250EB419B4;
        Thu,  8 Apr 2021 11:01:27 +0000 (UTC)
Subject: Re: [PATCH v4 11/18] asm-generic/io.h: implement pci_remap_cfgspace
 using ioremap_np
To:     Will Deacon <will@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210402090542.131194-1-marcan@marcan.st>
 <20210402090542.131194-12-marcan@marcan.st>
 <CAHp75Vcghw6=05vbhX5J8sHoo78JMoq5z4w9__XcocrtRVjF3g@mail.gmail.com>
 <20210407210317.GB16198@willie-the-truck>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <a89af1a3-b065-fca3-19d8-b7fd5ca2f1ae@marcan.st>
Date:   Thu, 8 Apr 2021 20:01:25 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210407210317.GB16198@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 08/04/2021 06.03, Will Deacon wrote:
>> I would rewrite above as
>>
>> void __iomem *ret;
>>
>> ret = ioremap_np(offset, size);
>> if (ret)
>>    return ret;
>>
>> return ioremap(offset, size);
> 
> Looks like it might be one of those rare occasions where the GCC ternary if
> extension thingy comes in handy:
> 
> 	return ioremap_np(offset, size) ?: ioremap(offset, size);

Today I learned that this one is kosher in kernel code. Handy! Let's go 
with that.

> Acked-by: Will Deacon <will@kernel.org>

Thanks!

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
