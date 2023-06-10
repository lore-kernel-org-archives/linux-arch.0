Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81495C7EE43
	for <linux-arch@archiver.kernel.org>; Sat, 10 Jun 2023 06:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjFJG0R (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sat, 10 Jun 2023 02:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjFJG0P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 10 Jun 2023 02:26:15 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21C63AB3;
        Fri,  9 Jun 2023 23:26:14 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 15DFC68BEB; Sat, 10 Jun 2023 08:26:12 +0200 (CEST)
Date:   Sat, 10 Jun 2023 08:26:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@lst.de, rppt@kernel.org, willy@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@ACULAB.COM, shorne@gmail.com,
        deller@gmx.de
Subject: Re: [PATCH v6 15/19] mm/ioremap: Consider IOREMAP space in generic
 ioremap
Message-ID: <20230610062611.GD1776@lst.de>
References: <20230609075528.9390-1-bhe@redhat.com> <20230609075528.9390-16-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609075528.9390-16-bhe@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
