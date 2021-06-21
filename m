Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A64BC48BC2
	for <linux-arch@archiver.kernel.org>; Mon, 21 Jun 2021 14:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DB6661151
	for <linux-arch@archiver.kernel.org>; Mon, 21 Jun 2021 14:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhFUOcA (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 21 Jun 2021 10:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhFUOcA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jun 2021 10:32:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F5AC061574;
        Mon, 21 Jun 2021 07:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6IFijS4A1CMsYF9LXMI82lGpHP++GBbMtZaDe+rkt80=; b=WM5CqpL2hhNoX06P6+L+2bK48Q
        5VFx/eD+JFzkCCZbBoCAMr2vQ+OQBCZei58rQaLkee8cUnLrAsTKzTzAR9yYt28CVatFYqj1w3I3z
        YRXwrDbDdQ8o0cyFzdLP1CtoEJ7aLv5NhN87H7eRnkV4aZ+x0wJwiVIBRO0lbjCKapovL3gF/uHyc
        3XgIMSd7XgxE5vzTG8faBN0P99RaCBp8O4H/sGa02sFs3FHiR66ASFZCj7Q+r9Pl46relgzNMF6NE
        dBp9dCr3TQoKq/rSRcLUaVt6zKqPUTyx77bBOLS3gfgGxxPdsXgIwN7XtIwUfsxPo/A4oXbLpRyJp
        48pIz/cw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvKut-00DBCH-JT; Mon, 21 Jun 2021 14:29:04 +0000
Date:   Mon, 21 Jun 2021 15:28:47 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        Bin Meng <bmeng.cn@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v3 2/3] riscv: optimized memmove
Message-ID: <YNCiH7XDMZ7iDKjg@infradead.org>
References: <20210617152754.17960-1-mcroce@linux.microsoft.com>
 <20210617152754.17960-3-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617152754.17960-3-mcroce@linux.microsoft.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This looks nice, but I think it would be a good candidate for lib/
again.
