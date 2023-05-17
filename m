Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F014C7EE23
	for <linux-arch@archiver.kernel.org>; Wed, 17 May 2023 06:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbjEQG2T (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 17 May 2023 02:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbjEQG2T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 02:28:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1153D35BB;
        Tue, 16 May 2023 23:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Vspge/HY+CqpXSg2weUlsF8Uhf
        7vqByyappM3l++Nu1wyd2H8Iplmyk6CD5d3pnLpLrP1KCFdi/MDOP5Q/lIYLG4fdjk+fWXQGjc4dA
        JgTY3rGmC98X04LV1+e01z1+HsOOLZ+hFlHaZwBVPZgszS/XywZuEj2gkKDYx1G1Kszuq1E3gnejN
        loKUjfagQlP7QiRQ9B2mNIMjMmrAq+YZBu85ksrEERvgzN6rWHq/baU0wGj/DZLn6jkLtTUc8oP8g
        Qa9L/P2a1xVi2bKMAN6Ud2mUrMFrA1HxpbAnalfuOaC+STBlU6LSxuzTJxkSABQ9uCMFwE6Gj+j6O
        k6zpRMbg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzAdx-008SSt-0W;
        Wed, 17 May 2023 06:28:13 +0000
Date:   Tue, 16 May 2023 23:28:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, willy@infradead.org,
        deller@gmx.de, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH v5 RESEND 03/17] openrisc: mm: remove unneeded early
 ioremap code
Message-ID: <ZGRz/a7aDla63C2y@infradead.org>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-4-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515090848.833045-4-bhe@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
