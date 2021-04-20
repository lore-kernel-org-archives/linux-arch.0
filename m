Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63940C43460
	for <linux-arch@archiver.kernel.org>; Tue, 20 Apr 2021 14:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 208DF613CA
	for <linux-arch@archiver.kernel.org>; Tue, 20 Apr 2021 14:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbhDTOk3 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 20 Apr 2021 10:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbhDTOk2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Apr 2021 10:40:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE80C06174A;
        Tue, 20 Apr 2021 07:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JdFnlCKsPAkRgtWeQVKwem1FA1yZRVTt5cXvtYatp2Y=; b=gsSKE/y4OtsBGW0P+XDa6g5Ykj
        IXgIWd5IQmkJC4SIOTiLkPZ7CPRcONM+B4Ml7M+jjLVIM8/keo7CZCFoH9NpkQ8pHEM8/NMCPQKKm
        fMljFdwE/liyCFkZx/p7RYvXK9fMY4QUOlpPkg5w0HiAmeHcB3d3cPlIA1w36VQ4ZvGfRmqvNWlsZ
        5dKha4TjqnWLTmxXtvAYyQVFfiz6e7a9tzNQsEsMXuj7DXTx+QIZ5iuhT2NXNVqea2zAHusrVzMSi
        y4+s3BirRckeNm3u0ptiBAhEQibKjHoipYyOISezT4MhPGqBh7FvXS9A+5GGh+2YUbTgLmLodJfdP
        qwKllvTQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lYrWA-00FH6e-Om; Tue, 20 Apr 2021 14:38:48 +0000
Date:   Tue, 20 Apr 2021 15:38:22 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH 1/3] nds32: Cleanup deprecated function strlen_user
Message-ID: <20210420143822.GA3640266@infradead.org>
References: <1618925829-90071-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618925829-90071-1-git-send-email-guoren@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Can you also clean up the reference to strlen_user in the comments
in the ia64 and mips code, please?
