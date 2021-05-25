Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F77CC2B9F8
	for <linux-arch@archiver.kernel.org>; Tue, 25 May 2021 12:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A1D76141B
	for <linux-arch@archiver.kernel.org>; Tue, 25 May 2021 12:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhEYM3n (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 25 May 2021 08:29:43 -0400
Received: from verein.lst.de ([213.95.11.211]:58955 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232385AbhEYM3l (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 May 2021 08:29:41 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5CC3068AFE; Tue, 25 May 2021 14:28:09 +0200 (CEST)
Date:   Tue, 25 May 2021 14:28:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     guoren@kernel.org
Cc:     anup.patel@wdc.com, palmerdabbelt@google.com, arnd@arndb.de,
        hch@lst.de, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V3 1/2] riscv: Fixup _PAGE_GLOBAL in _PAGE_KERNEL
Message-ID: <20210525122809.GA4842@lst.de>
References: <1621945447-38820-1-git-send-email-guoren@kernel.org> <1621945447-38820-2-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621945447-38820-2-git-send-email-guoren@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 25, 2021 at 12:24:06PM +0000, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Kernel virtual address translation should avoid care asid or it'll

s/care aisd/to use ASIDs/ ?

> cause more TLB-miss and TLB-refill. Because the current asid in satp

s/asid/ASID/ ?

> belongs to the current process, but the target kernel va TLB entry's
> asid still belongs to the previous process.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>

Otherwise looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
