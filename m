Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E716C43334
	for <linux-arch@archiver.kernel.org>; Tue, 19 Jul 2022 04:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbiGSEao (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 19 Jul 2022 00:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbiGSEam (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jul 2022 00:30:42 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9652627;
        Mon, 18 Jul 2022 21:30:42 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DB27F68AA6; Tue, 19 Jul 2022 06:30:37 +0200 (CEST)
Date:   Tue, 19 Jul 2022 06:30:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, hch@lst.de, nathan@kernel.org,
        naresh.kamboju@linaro.org, linux-mips@vger.kernel.org,
        linux-arch@vger.kernel.org, heiko@sntech.de,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH] tools: Fixed MIPS builds due to struct flock
 re-definition
Message-ID: <20220719043037.GA26372@lst.de>
References: <20220715185551.3951955-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715185551.3951955-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

(although userspace including two copies of fcntl.h is really broken).
