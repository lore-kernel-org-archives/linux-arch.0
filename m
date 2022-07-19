Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E30C433EF
	for <linux-arch@archiver.kernel.org>; Tue, 19 Jul 2022 15:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbiGSPQc (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 19 Jul 2022 11:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbiGSPQb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jul 2022 11:16:31 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A4E251;
        Tue, 19 Jul 2022 08:16:30 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 22AF068AFE; Tue, 19 Jul 2022 17:16:27 +0200 (CEST)
Date:   Tue, 19 Jul 2022 17:16:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH] tools: Fixed MIPS builds due to struct flock
 re-definition
Message-ID: <20220719151626.GA22030@lst.de>
References: <20220715185551.3951955-1-f.fainelli@gmail.com> <CAK8P3a3cuTknZaLZCFGwZtMfbd1qAFWEtXMcvVHsXoJn8EUCOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3cuTknZaLZCFGwZtMfbd1qAFWEtXMcvVHsXoJn8EUCOg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 19, 2022 at 09:42:23AM +0200, Arnd Bergmann wrote:
> I think the correct fix to address the problem in both versions and
> get them back into sync would be something like the patch below.
> I have done zero testing on it though.
> 
> Christoph and Florian, any other suggestions?

Fine with me.  I still think these whole tools/ copy of headers are just
broken.  Userspace code must use system headers and not try to include
two slightly out of sync versions of the same header in obsfucated ways.
