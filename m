Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46EFC25B08
	for <linux-arch@archiver.kernel.org>; Sat, 20 Aug 2022 09:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbiHTJlU (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sat, 20 Aug 2022 05:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiHTJlU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 Aug 2022 05:41:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908A6B99E8;
        Sat, 20 Aug 2022 02:41:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1835161127;
        Sat, 20 Aug 2022 09:41:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3295BC433D6;
        Sat, 20 Aug 2022 09:41:15 +0000 (UTC)
Date:   Sat, 20 Aug 2022 10:41:10 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     guoren@kernel.org
Cc:     xianting.tian@linux.alibaba.com, palmer@dabbelt.com,
        heiko@sntech.de, conor.dooley@microchip.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, liaochang1@huawei.com,
        mick@ics.forth.gr, jszhang@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        x86@kernel.org
Subject: Re: [PATCH V3 3/3] arch: crash: Remove duplicate declaration in smp.h
Message-ID: <YwCsNnfGwkTYShGs@arm.com>
References: <20220819025444.2121315-1-guoren@kernel.org>
 <20220819025444.2121315-4-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819025444.2121315-4-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 18, 2022 at 10:54:44PM -0400, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Remove crash_smp_send_stop declarations in arm64, x86 asm/smp.h which
> has been done in include/linux/smp.h.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: x86@kernel.org

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
