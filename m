Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE594C43334
	for <linux-arch@archiver.kernel.org>; Mon, 13 Jun 2022 18:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbiFMSXM (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245090AbiFMSWv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jun 2022 14:22:51 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED504AE2A;
        Mon, 13 Jun 2022 07:29:52 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F264868AA6; Mon, 13 Jun 2022 16:29:47 +0200 (CEST)
Date:   Mon, 13 Jun 2022 16:29:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     guoren@kernel.org
Cc:     palmer@rivosinc.com, arnd@arndb.de, linux@roeck-us.net,
        palmer@dabbelt.com, heiko@sntech.de,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] uapi: Fixup strace compile error
Message-ID: <20220613142947.GA4110@lst.de>
References: <20220613013051.1741434-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613013051.1741434-1-guoren@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The change looks fine, but the commit log could use some work, please
move the notes from the back to the front and make them a standalone
commit log and just drop the rest.
