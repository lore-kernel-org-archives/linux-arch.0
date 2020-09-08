Return-Path: <SRS0=vPgs=CR=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB1DC43461
	for <linux-arch@archiver.kernel.org>; Tue,  8 Sep 2020 06:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 561AE2078B
	for <linux-arch@archiver.kernel.org>; Tue,  8 Sep 2020 06:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgIHGQ6 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 8 Sep 2020 02:16:58 -0400
Received: from verein.lst.de ([213.95.11.211]:51470 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728775AbgIHGQ6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Sep 2020 02:16:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 77E6B68AFE; Tue,  8 Sep 2020 08:16:55 +0200 (CEST)
Date:   Tue, 8 Sep 2020 08:16:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Russell King <rmk@arm.linux.org.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        stable@vger.kernel.org, Mikael Pettersson <mikpe@it.uu.se>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] ARM: oabi-compat: add epoll_pwait handler
Message-ID: <20200908061655.GC13930@lst.de>
References: <20200907153701.2981205-1-arnd@arndb.de> <20200907153701.2981205-4-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907153701.2981205-4-arnd@arndb.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> +SYSCALL_DEFINE4(oabi_epoll_wait, int, epfd, struct oabi_epoll_event __user *, events,
> +		int, maxevents, int, timeout)

> +SYSCALL_DEFINE6(oabi_epoll_pwait, int, epfd, struct oabi_epoll_event __user *, events,
> +		int, maxevents, int, timeout, const sigset_t __user *, sigmask,
> +		size_t, sigsetsize)

More pointlessly long lines..

Otherwise this looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
