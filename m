Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011A9C7EE23
	for <linux-arch@archiver.kernel.org>; Wed, 17 May 2023 06:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbjEQGb4 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 17 May 2023 02:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjEQGbz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 02:31:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7987435A0;
        Tue, 16 May 2023 23:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R+bia8kNOnh/zzckPz9KIXCK6j55WEZoqDL73kF/+sg=; b=cFu/rKWG4aO9DRAq9O4fdaCYuJ
        lC1p/EPe09ZjM+Kwuh3kG/tHsPA7KpSfPG3f/ETB71jX81whefhm7MjZT7HQgppLozACG7eNAmAGs
        UZdqpa3pypr03b69y93R0MdXcjh1CefbD5hNoFMnCiHruzxM7YvO23QVu/wvLFglpzr0w/Yzdxa1c
        O8t74JrYxS+8eY2MeeeIBL6rMJhHT2crq8FAe9CsAeqB5YTnBPdIqfRlKXpb3nPSNqN2qZwhk9c+W
        BOuIGzvDfvMISQnfs5Z7NJJGdkCP4ATb7xmSbESVAb4ncjEXyiZdbkkVU0AvizH30Kx8Cc7UId3fT
        c4LcH0Fg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzAhS-008ThE-2J;
        Wed, 17 May 2023 06:31:50 +0000
Date:   Tue, 16 May 2023 23:31:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, willy@infradead.org,
        deller@gmx.de, Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org
Subject: Re: [PATCH v5 RESEND 07/17] arc: mm: Convert to GENERIC_IOREMAP
Message-ID: <ZGR01vnozJmVIVEi@infradead.org>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-8-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515090848.833045-8-bhe@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> +#define ioremap ioremap
> +#define ioremap_prot ioremap_prot
> +#define iounmap iounmap

Nit:  I think it's cleaner to have these #defines right next to the
function declaration.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
