Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81E1C433EF
	for <linux-arch@archiver.kernel.org>; Mon,  4 Apr 2022 07:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377752AbiDDHot (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 4 Apr 2022 03:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377329AbiDDHot (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 03:44:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C083B021;
        Mon,  4 Apr 2022 00:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=RarzftxdpCxIAw940HWfOtAep6
        foJaPrcti0gCF7XynAoHLA1/KJs1t8nUAoGu36GNJnu0RuTQWDrLCHb0HzI9eI+MDk2CnLZPFtxEK
        WrwXlMyvds036q+aWPcgSVSsR9S0089jXngZVL+hZZmBnNvpc5bsbAxN45VxON/PE8XtXP2vsqkSI
        eQiRXsaKAg16Y8CG81czZysCuDZbqQ5wZXM6hy8BkxgUtJ0wDCjNJddfS5ZUloAaGJQzYh7fDut2M
        tov8lCVeU+Q4xc0/DPO/a1X4p/QyawmcVW7viAds/a/yQVfK5UFuT/vLkpAcbGOsSUIDdEwhjh3LQ
        91bmKe4w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbHMR-00DfEX-6f; Mon, 04 Apr 2022 07:42:51 +0000
Date:   Mon, 4 Apr 2022 00:42:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 5/8] powerpc: add asm/stat.h to UAPI compile-test coverage
Message-ID: <Ykqhe/KDaY9lc7qW@infradead.org>
References: <20220404061948.2111820-1-masahiroy@kernel.org>
 <20220404061948.2111820-6-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404061948.2111820-6-masahiroy@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
