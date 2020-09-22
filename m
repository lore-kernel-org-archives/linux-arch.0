Return-Path: <SRS0=B1nT=C7=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758F0C2D0E2
	for <linux-arch@archiver.kernel.org>; Tue, 22 Sep 2020 04:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F03323A34
	for <linux-arch@archiver.kernel.org>; Tue, 22 Sep 2020 04:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgIVEh5 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 22 Sep 2020 00:37:57 -0400
Received: from verein.lst.de ([213.95.11.211]:43032 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbgIVEhz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 22 Sep 2020 00:37:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4D5D86736F; Tue, 22 Sep 2020 06:37:52 +0200 (CEST)
Date:   Tue, 22 Sep 2020 06:37:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Palmer Dabbelt <palmer@dabbelt.com>, viro@zeniv.linux.org.uk,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: remove set_fs for riscv v2
Message-ID: <20200922043752.GA29151@lst.de>
References: <20200907055825.1917151-1-hch@lst.de> <mhng-5fa86587-c404-420e-a4c0-43d197d1cd27@palmerdabbelt-glaptop1> <20200909065515.GA9618@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909065515.GA9618@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Given tht we've not made much progress with the common branch,
are you fine just picking this up through the riscv tree for 5.10?

I'll defer other architectures that depend on the common changes to
5.11 then.

On Wed, Sep 09, 2020 at 08:55:15AM +0200, Christoph Hellwig wrote:
> now that we've sorted out a remaining issue base.set_fs should not
> be rebased any more, so you could pull it into the riscv tree or a topic
> branch.
> 
> The first four patch should go into base.set_fs, though.  Arnd, can you
> re-review the updated patches?
---end quoted text---
