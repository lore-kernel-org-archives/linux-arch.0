Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2A2C47096
	for <linux-arch@archiver.kernel.org>; Sun,  6 Jun 2021 14:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3096613AD
	for <linux-arch@archiver.kernel.org>; Sun,  6 Jun 2021 14:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhFFOld (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sun, 6 Jun 2021 10:41:33 -0400
Received: from verein.lst.de ([213.95.11.211]:43014 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230085AbhFFOld (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Jun 2021 10:41:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 774BC68AFE; Sun,  6 Jun 2021 16:39:41 +0200 (CEST)
Date:   Sun, 6 Jun 2021 16:39:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     guoren@kernel.org
Cc:     anup.patel@wdc.com, palmerdabbelt@google.com, arnd@arndb.de,
        wens@csie.org, maxime@cerno.tech, drew@beagleboard.org,
        liush@allwinnertech.com, lazyparser@gmail.com, wefu@redhat.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Guo Ren <guoren@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH v2 06/11] riscv: pgtable: Add DMA_COHERENT with
 custom PTE attributes
Message-ID: <20210606143941.GA6032@lst.de>
References: <1622970249-50770-1-git-send-email-guoren@kernel.org> <1622970249-50770-10-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622970249-50770-10-git-send-email-guoren@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

NAK, no SOC must ever mess with pagetable attributes.
