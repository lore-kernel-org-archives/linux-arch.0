Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CC3C433B4
	for <linux-arch@archiver.kernel.org>; Wed, 19 May 2021 05:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75D8161355
	for <linux-arch@archiver.kernel.org>; Wed, 19 May 2021 05:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbhESF5R (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 19 May 2021 01:57:17 -0400
Received: from verein.lst.de ([213.95.11.211]:36714 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232295AbhESF5R (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 May 2021 01:57:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3E3AF67373; Wed, 19 May 2021 07:55:55 +0200 (CEST)
Date:   Wed, 19 May 2021 07:55:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Guo Ren <guoren@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        drew@beagleboard.org, wefu@redhat.com, lazyparser@gmail.com,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-sunxi@lists.linux.dev, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
Message-ID: <20210519055555.GA27451@lst.de>
References: <1621400656-25678-1-git-send-email-guoren@kernel.org> <20210519052048.GA24853@lst.de> <CAJF2gTTjwB4U-NxCtfgMA5aR2HzoQtA8a51W5UM1LHGRbjz9pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTTjwB4U-NxCtfgMA5aR2HzoQtA8a51W5UM1LHGRbjz9pg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 19, 2021 at 01:48:23PM +0800, Guo Ren wrote:
> The patchset just leaves a configuration chance for vendors. Before
> RISC-V ISA fixes it, we should give the chance to let vendor solve
> their real chip issues.

No.  The vendors need to work to get a feature standardized before
implementing it.  There is other way to have a sane kernel build that
supports all the different SOCs.
