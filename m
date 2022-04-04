Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8103C433F5
	for <linux-arch@archiver.kernel.org>; Mon,  4 Apr 2022 07:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350479AbiDDHoO (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 4 Apr 2022 03:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352836AbiDDHoN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 03:44:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3103B00B;
        Mon,  4 Apr 2022 00:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=vLAJbXDawzRId4C1Tb9fqvx+JO
        AktZVEeAOTG38FT11eGuwjUER5A3z+pmMTzwGQYmE+fkntfJ47EU173+RF/nZ2WKyNSVM998N0DqJ
        0kWgNdxPeAr4tNbkc3ivHDSDoUcEsflAkeDcm24KtJBv+JhS5DQ75a38xY9Ewv/IUmh4X5XcnQNoh
        SgcYAxwhcrWFPXj8t2ReYQy1/2WfPbGGojmVKMFPsEPcDFDcgSsfyoYJe97bnmfGNtfaYFuPJN7Ih
        92r78utpr4k85aK+A+h91o288OIn4JFFTsMOB/BG1tn1XLeSBdNjvlW0SImrWBAVJImdnHI9K2dnj
        NoM6lUBA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbHLs-00Df9E-PM; Mon, 04 Apr 2022 07:42:16 +0000
Date:   Mon, 4 Apr 2022 00:42:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 4/8] mips: add asm/stat.h to UAPI compile-test coverage
Message-ID: <YkqhWKEs5h67IXGi@infradead.org>
References: <20220404061948.2111820-1-masahiroy@kernel.org>
 <20220404061948.2111820-5-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404061948.2111820-5-masahiroy@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
