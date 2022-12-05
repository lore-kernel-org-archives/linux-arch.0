Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF49C47089
	for <linux-arch@archiver.kernel.org>; Mon,  5 Dec 2022 09:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiLEJSi (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 5 Dec 2022 04:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiLEJSb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Dec 2022 04:18:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C59512A84;
        Mon,  5 Dec 2022 01:18:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0BE45B80DB4;
        Mon,  5 Dec 2022 09:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329F1C433D7;
        Mon,  5 Dec 2022 09:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670231907;
        bh=De2KVlqjeBbR7VemazKGpJfXUbvbA/TDtgMxqbod7hE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FEQscB+Az2Snk7BVIQ71HFPDRkBV9BNE0hkMcTY8XNkWaLv1Wcqx90DRk4kmUnnzm
         GWeJG7Q8Lw4HDXQmmXvXCPseb4C0MCssXCFCWfeHHex6G2UgZdSPlrBZe9g1sOVS6W
         66Oae5Dlqv+sNjGfEq1NAxAt7m0FxT19FiuQ0X+aX47w116VUICF1hJP6pKZHUSQm4
         fPdL5WUu5ACgYNqvT8p3Uoek4EIj881YpP8Sewk+YdO40SUZB9nyHCgNI0xZ0yQCfN
         T8QUrA/C9tZ5FqnVI5x2DCp5ilSGdAKGcamlA76dv4If48/ikUsLZb6gZAvl9lHg0q
         9YEu2G/XO8s8A==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     guoren@kernel.org, arnd@arndb.de, guoren@kernel.org,
        palmer@rivosinc.com, tglx@linutronix.de, peterz@infradead.org,
        luto@kernel.org, conor.dooley@microchip.com, heiko@sntech.de,
        jszhang@kernel.org, lazyparser@gmail.com, falcon@tinylab.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com, chenzhongjin@huawei.com,
        greentime.hu@sifive.com, andy.chiu@sifive.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH -next V8 10/14] riscv: Typo fixup for addi -> andi in
 comment
In-Reply-To: <20221103075047.1634923-11-guoren@kernel.org>
References: <20221103075047.1634923-1-guoren@kernel.org>
 <20221103075047.1634923-11-guoren@kernel.org>
Date:   Mon, 05 Dec 2022 10:18:25 +0100
Message-ID: <87edte9pjy.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

guoren@kernel.org writes:

> From: Guo Ren <guoren@linux.alibaba.com>
>
> Correct typo for addi -> andi in comment, although the immediate[11:0]
> are the same.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/kernel/entry.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 9864e784d6a6..03655577e26f 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -138,7 +138,7 @@ ENTRY(ret_from_exception)
>  	REG_L s0, PT_STATUS(sp)
>  
>  #ifdef CONFIG_RISCV_M_MODE
> -	/* the MPP value is too large to be used as an immediate arg for addi */
> +	/* the MPP value is too large to be used as an immediate arg for andi */
>  	li t0, SR_MPP
>  	and s0, s0, t0
>  #else
> -- 
> 2.36.1

This doesn't belong in the series. Please do this as a separate fix,
which a Fixes tag.
