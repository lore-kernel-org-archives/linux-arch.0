Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852D3C433EF
	for <linux-arch@archiver.kernel.org>; Mon,  4 Apr 2022 07:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377705AbiDDHmn (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 4 Apr 2022 03:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377704AbiDDHmh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 03:42:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCE1237C3;
        Mon,  4 Apr 2022 00:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=eu9Je3RrxZlpneew2UOYS1LBpD
        mfXNsSaLw6sXh+EXlW3AnZ4lQnwI7mZ+d/0NV1GzerFrXHlQiDw1zxA857RjZEMKO84agxpAlAaQz
        tUj/Q4SFr58LcEcMikskqG/O9a589bAmW8cs43jh/JdjsKIvFgbzV9ziKjDuDz7+/63wZ1atb6/TQ
        V0BiKe97/6sfDc228ZRUxe4dM0IsMckNRYllqYiDmAMhk5Aa4xJYH/cAw903xaEaXqblDXW0XctQ9
        FZNIhnOwkusG35KB2IRDQwCSsYsFequ6I0OjDw78K41zqh1p7v9+tS+rGj/OLMMbI0Jhv39g43F2v
        1gWP+e/g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbHKJ-00Deil-1D; Mon, 04 Apr 2022 07:40:39 +0000
Date:   Mon, 4 Apr 2022 00:40:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/8] agpgart.h: do not include <stdlib.h> from exported
 header
Message-ID: <Ykqg90A/nkD5iUkw@infradead.org>
References: <20220404061948.2111820-1-masahiroy@kernel.org>
 <20220404061948.2111820-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404061948.2111820-2-masahiroy@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
