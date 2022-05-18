Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495CEC433F5
	for <linux-arch@archiver.kernel.org>; Wed, 18 May 2022 15:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239437AbiERPfE (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 18 May 2022 11:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239438AbiERPfD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 May 2022 11:35:03 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8326979381;
        Wed, 18 May 2022 08:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1652888100; bh=fz89MzLACE4JJirQHkbb4IhP7LGZ1kQfeXobpNq8y0k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZDfLtLq+5w6gVLpfjLZOfemZN83Kx6qCDrSb8GgFlWoir2tqtFJRhchMMKRGGsS1R
         zcWyUHb10lyNGcvcJJJn4bwFp8Xa6YZiHPbGEGgH/YuqeeDuMp2fkKJgZdA/KrxLsk
         Cf6omGzJdaJIsxe/tHH3vULA87HQ7UEaIilEu5WU=
Received: from [192.168.9.172] (unknown [101.88.28.48])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 0E43A60694;
        Wed, 18 May 2022 23:35:00 +0800 (CST)
Message-ID: <7e13c3f8-5f2c-3787-fb71-20a946a6a8e1@xen0n.name>
Date:   Wed, 18 May 2022 23:34:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0a1
Subject: Re: [PATCH V11 01/22] Documentation: LoongArch: Add basic
 documentations
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20220518092619.1269111-1-chenhuacai@loongson.cn>
 <20220518092619.1269111-2-chenhuacai@loongson.cn>
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20220518092619.1269111-2-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 5/18/22 17:25, Huacai Chen wrote:
> Add some basic documentation for LoongArch. LoongArch is a new RISC ISA,
> which is a bit like MIPS or RISC-V. LoongArch includes a reduced 32-bit
> version (LA32R), a standard 32-bit version (LA32S) and a 64-bit version
> (LA64).
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   Documentation/arch.rst                     |   1 +
>   Documentation/loongarch/features.rst       |   3 +
>   Documentation/loongarch/index.rst          |  21 ++
>   Documentation/loongarch/introduction.rst   | 387 +++++++++++++++++++++
>   Documentation/loongarch/irq-chip-model.rst | 168 +++++++++
>   5 files changed, 580 insertions(+)
>   create mode 100644 Documentation/loongarch/features.rst
>   create mode 100644 Documentation/loongarch/index.rst
>   create mode 100644 Documentation/loongarch/introduction.rst
>   create mode 100644 Documentation/loongarch/irq-chip-model.rst

This feels much better now; I feel it's acceptable from a random 
community member's perspective. Thanks for incorporating my comments and 
tweaks!

Reviewed-by: WANG Xuerui <git@xen0n.name>

