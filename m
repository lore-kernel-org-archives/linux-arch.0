Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33BDC432BE
	for <linux-arch@archiver.kernel.org>; Fri, 23 Jul 2021 12:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86C5D60ED7
	for <linux-arch@archiver.kernel.org>; Fri, 23 Jul 2021 12:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbhGWMCG (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 23 Jul 2021 08:02:06 -0400
Received: from verein.lst.de ([213.95.11.211]:38400 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234601AbhGWMCF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Jul 2021 08:02:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6F22D67373; Fri, 23 Jul 2021 14:42:37 +0200 (CEST)
Date:   Fri, 23 Jul 2021 14:42:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>, kbuild-all@lists.01.org
Subject: Re: [PATCH v3 6/9] microblaze: use generic strncpy/strnlen
 from_user
Message-ID: <20210723124237.GA25198@lst.de>
References: <20210722124814.778059-7-arnd@kernel.org> <202107230453.Cz16fInO-lkp@intel.com> <CAK8P3a22AEb+Sn6ZXPnMt4WykwjizNv3O6fXOtMjD4egA257VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a22AEb+Sn6ZXPnMt4WykwjizNv3O6fXOtMjD4egA257VA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 23, 2021 at 02:36:15PM +0200, Arnd Bergmann wrote:
> I had to add a user_addr_max() definition here, which unfortunately
> will also conflict
> with the get_fs() removal if Christoph plans to have that merged
> through the microblaze
> tree.

I don't have any patches to remove set_fs for microblaze so far.
