Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0791DC433F5
	for <linux-arch@archiver.kernel.org>; Mon,  4 Apr 2022 07:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377329AbiDDHpK (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 4 Apr 2022 03:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355884AbiDDHpK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 03:45:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480F736169;
        Mon,  4 Apr 2022 00:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=uYZP19XvQ5IQkoypNv/+nDCbo6
        WFUwujBzewBdibVgDjvItkWyXGYN90CFQDT9LqUBmPLyFuRPZ4IqYdFl0vu6fodyBwoAumq3HEIbc
        4nCZd91ELcQh0iZaQmtj88SPZeNVWdF1KKsU+9YJA/92W602xoTrtQJ0gVJFPf/din2mjT7897Nbk
        ZIANeaNXf0zW+4H2V6KPFsC8pfIr94yDEdI4kev+iLxJy6Qh797ezGrc+lDCT9m5z+lgkzhA2Gj49
        +gJfeJoDdDpvoiYdjnKbSQj4/WO1Rq0UnXZ/w/sZ2lMu0VccfyDypkslffo43xrYhYTxMdAmGnv+N
        yWKoiUjg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbHMm-00DfIg-Q0; Mon, 04 Apr 2022 07:43:12 +0000
Date:   Mon, 4 Apr 2022 00:43:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 6/8] sparc: add asm/stat.h to UAPI compile-test coverage
Message-ID: <YkqhkAh6zkTWAuBC@infradead.org>
References: <20220404061948.2111820-1-masahiroy@kernel.org>
 <20220404061948.2111820-7-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404061948.2111820-7-masahiroy@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
