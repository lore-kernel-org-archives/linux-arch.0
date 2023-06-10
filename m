Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF7AC7EE2E
	for <linux-arch@archiver.kernel.org>; Sat, 10 Jun 2023 06:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjFJGYc (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sat, 10 Jun 2023 02:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjFJGYb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 10 Jun 2023 02:24:31 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BA13ABB;
        Fri,  9 Jun 2023 23:24:29 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9A72A68BEB; Sat, 10 Jun 2023 08:24:26 +0200 (CEST)
Date:   Sat, 10 Jun 2023 08:24:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@lst.de, rppt@kernel.org, willy@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        schnelle@linux.ibm.com, David.Laight@ACULAB.COM, shorne@gmail.com,
        deller@gmx.de
Subject: Re: [PATCH v6 04/19] mm/ioremap: Define generic_ioremap_prot() and
 generic_iounmap()
Message-ID: <20230610062426.GB1776@lst.de>
References: <20230609075528.9390-1-bhe@redhat.com> <20230609075528.9390-5-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609075528.9390-5-bhe@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
