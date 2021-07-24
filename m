Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B16C4338F
	for <linux-arch@archiver.kernel.org>; Sat, 24 Jul 2021 17:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE92660C51
	for <linux-arch@archiver.kernel.org>; Sat, 24 Jul 2021 17:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhGXQZQ (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sat, 24 Jul 2021 12:25:16 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:49996 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhGXQZP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 24 Jul 2021 12:25:15 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m7L1d-003aTX-9q; Sat, 24 Jul 2021 17:01:21 +0000
Date:   Sat, 24 Jul 2021 17:01:21 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, b.a.t.m.a.n@lists.open-mesh.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic: avoid sparse {get,put}_unaligned warning
Message-ID: <YPxHYW/HPI/LLMXx@zeniv-ca.linux.org.uk>
References: <20210724162429.394792-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210724162429.394792-1-sven@narfation.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jul 24, 2021 at 06:24:29PM +0200, Sven Eckelmann wrote:

> The special attribute force must be used in such statements when the cast
> is known to be safe to avoid these warnings.

	How about container_of(ptr, typeof(*__pptr), x) instead of a cast?
Would be easier to follow...
