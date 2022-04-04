Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0258C433FE
	for <linux-arch@archiver.kernel.org>; Mon,  4 Apr 2022 07:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243687AbiDDHn3 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 4 Apr 2022 03:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377713AbiDDHn2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 03:43:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E3B237DB;
        Mon,  4 Apr 2022 00:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=2B3T57OGEnbekVCnZQD6xjEJyU
        k+aWGbpsa5gqfrO8SWb5yGI94SUtpK6Zh0v2mdGZtsU+LZUkm9guKCwdCDKMnWz8uezwa8reJvjhY
        xvGgBqj0XBGl5DRFV3ipS3ZfVTCaSjUe9hB3TM682XG6gwaZZsxEw64xJ6VGnTJVOhMsPT9POjdJR
        Kk676O/Wfd6jg+fXluCXXuPhflU88EaPqaU9ebdwY1L7vBEl+JW/rWNI4oNCLkVSZPNHsNQE5pGkT
        u6yE/zEIhfWcJq2O6YCQRRmJiQwUh3SLOiOrcJ+Ne0KclGUvKXNSeyDlYCg3hgBhr2qI/SeDKx4V4
        gMUZYOUQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbHL9-00DewI-Go; Mon, 04 Apr 2022 07:41:31 +0000
Date:   Mon, 4 Apr 2022 00:41:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/8] riscv: add linux/bpf_perf_event.h to UAPI
 compile-test coverage
Message-ID: <YkqhKzX85zwXHoSq@infradead.org>
References: <20220404061948.2111820-1-masahiroy@kernel.org>
 <20220404061948.2111820-4-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404061948.2111820-4-masahiroy@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

