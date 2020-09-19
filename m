Return-Path: <SRS0=16f6=C4=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D958BC43464
	for <linux-arch@archiver.kernel.org>; Sat, 19 Sep 2020 05:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99A5420773
	for <linux-arch@archiver.kernel.org>; Sat, 19 Sep 2020 05:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FoXDLxhe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgISF1Z (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sat, 19 Sep 2020 01:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgISF1Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Sep 2020 01:27:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BBAC0613CE;
        Fri, 18 Sep 2020 22:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q8TBa/IwMxUpZzueRcfGukDtWbm4uOIrNJkp/+J+fTo=; b=FoXDLxhe5wa2Maw8rQq4BohRO/
        5oeccx1qro96HXe7FMwSZ25F035k36kDsSpgSp/htmDyKx6co00oFARieXx8g4E4QSN+swanSausK
        kQiy8NLpnTskAsrtGFpKFuJ86AzSXasWNoOgnO9xw4g8ZdYAMkMM82MMl03cWSfYlZJaxn5ixXY7+
        jHLT2ypIxl0DFNV0fI2/8y/j6ll0Mv6H7SPR4/IT2GSFuo76HlxP9RZ9prKpvPzQiA8Ewo3LnQCxv
        fwnZR3HzOK0+mXU0hvxuxTxY6xg05H3Ct/OUINsNJJMOLU/k3ATuGkFj8YhBWV0cBTBFHuOxha7rD
        Wq8Tk28w==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJVP1-0000LD-B3; Sat, 19 Sep 2020 05:27:15 +0000
Date:   Sat, 19 Sep 2020 06:27:15 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 0/9] ARM: remove set_fs callers and implementation
Message-ID: <20200919052715.GF30063@infradead.org>
References: <20200918124624.1469673-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918124624.1469673-1-arnd@arndb.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 18, 2020 at 02:46:15PM +0200, Arnd Bergmann wrote:
> Hi Christoph, Russell,
> 
> Here is an updated series for removing set_fs() from arch/arm,
> based on the previous feedback.
> 
> I have tested the oabi-compat changes using the LTP tests for the three
> modified syscalls using an Armv7 kernel and a Debian 5 OABI user space,
> and I have lightly tested the get_kernel_nofault infrastructure by
> loading the test_lockup.ko module after setting CONFIG_DEBUG_SPINLOCK.

What is the base line?  Just the base.set_fs branch in Als tree, or do
you need anything from my RISC-V series?
