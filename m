Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB12C74A5B
	for <linux-arch@archiver.kernel.org>; Sun, 26 Mar 2023 22:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjCZWDe (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sun, 26 Mar 2023 18:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjCZWDc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Mar 2023 18:03:32 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDD4210A;
        Sun, 26 Mar 2023 15:03:26 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0839968B05; Mon, 27 Mar 2023 00:03:22 +0200 (CEST)
Date:   Mon, 27 Mar 2023 00:03:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, palmer@rivosinc.com, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, esyr@redhat.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3] uapi: Fixup strace compile error
Message-ID: <20230326220321.GA18023@lst.de>
References: <20230324073630.161034-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324073630.161034-1-guoren@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
