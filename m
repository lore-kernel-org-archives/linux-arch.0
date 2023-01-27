Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556EBC38142
	for <linux-arch@archiver.kernel.org>; Fri, 27 Jan 2023 09:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjA0JPj (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 27 Jan 2023 04:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjA0JPi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Jan 2023 04:15:38 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3C6BBB3;
        Fri, 27 Jan 2023 01:15:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 36060CE2719;
        Fri, 27 Jan 2023 09:15:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBF1C433D2;
        Fri, 27 Jan 2023 09:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674810933;
        bh=U3OAJ8SCEj6VXff108R0INPEUssjs/AFzTgJg9iab6Y=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=vP3VVRSXvS7HLtcqC5+GKhYGu2F3mwJqC3vC3ItyQrmiJnrZcYz/14gF7MTveAbXv
         tWoujlrs0tx62q9+hivVpHkWvw8RIAXtMLLQhWga08TwQ0I5TvBAJTOLB1pScwD5Hb
         CCEbrhEgVrIPGKuLYphfQ0MUpFLxx/69CG3NA7wVnFdD/S3rWm/muKM4toMtiFEHLp
         tEwIhB/g4E6vNJnOnVn/Qnc2qiZgaL72PFtPzhcG0qVJWHn5Gsz+BFkKjBVUvnjhs/
         iNXcmXHu09jHsNwYH+qkOZDdEO+6/Lu+tyRmXrXk4MWKkYSusGL/kvXHQRa3VFx3XR
         +c3+/af7PB+7g==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Conor Dooley <conor@kernel.org>, guoren@kernel.org
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, ben@decadent.org.uk,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH -next V15 0/7] riscv: Add GENERIC_ENTRY support
In-Reply-To: <Y9LTmmYuEWKNmyl2@spud>
References: <20230126172516.1580058-1-guoren@kernel.org>
 <Y9LTmmYuEWKNmyl2@spud>
Date:   Fri, 27 Jan 2023 10:15:30 +0100
Message-ID: <877cx8tk25.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Conor Dooley <conor@kernel.org> writes:

>> v15:
>>  - Fixup compile error for !MMU (Thx Conor)
>>  - Rebase on riscv for-next (20230127)
>
> nommu build looks fine now, thanks for fixing it up. Hopefully you're
> good to now now after 15 versions!

Yay! Would be great to see it end up in 6.3!
