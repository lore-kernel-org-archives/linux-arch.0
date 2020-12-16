Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB4BC2BBCF
	for <linux-arch@archiver.kernel.org>; Wed, 16 Dec 2020 08:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06F14233ED
	for <linux-arch@archiver.kernel.org>; Wed, 16 Dec 2020 08:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgLPIW4 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 16 Dec 2020 03:22:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:40502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgLPIW4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 16 Dec 2020 03:22:56 -0500
Subject: Re: [GIT PULL 3/3] asm-generic: cross-architecture timer cleanup
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608106935;
        bh=dOZSwTSoB7DvAVz/0P0/ZJPrImXxnouKmXjgIulb75M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Aeo7bV3jxuAyK4skZzc4nIab8HewmsKgMRbprvTQPiSfbB34yoNgrqyZQG940eBD/
         Q+uoeUWQfoahdSGvmEPblGi74uZj+0ZbZoZVmsD1VurGk4+BS/L910xYKju45a5cem
         SI4iEnGhvvzXqPldrQArQ090s2Z3R2KTKt5nikxFkZwTeGZ1kwgN/WISjENO/E6P6h
         cm+Ydu9s3k+FUnhutIRJ0vBe/hC6cKXH4QNGek7u4Jy+HyqKyLaWqLRDPx5k6VHhZF
         ktfguVbdmUbcL7AsWKwViciu9+7Db+Nng0cBZCLw/UBUWBlh8fQ6B1NFDKEHwQNR1d
         RBNfVTf6RSNkQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a1epGkg=-YzHZtZTe074XFTVfgBemaNiHZUt_0Y7NJNtA@mail.gmail.com>
References: <CAK8P3a0b0u9NQ1unjQfwBJovahQYNgNj1ROLGR+TzZWKnzQgzQ@mail.gmail.com> <CAK8P3a1epGkg=-YzHZtZTe074XFTVfgBemaNiHZUt_0Y7NJNtA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a1epGkg=-YzHZtZTe074XFTVfgBemaNiHZUt_0Y7NJNtA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-timers-5.11
X-PR-Tracked-Commit-Id: 0774a6ed294b963dc76df2d8342ab86d030759ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7a932e5702886e872a545d64605c06a51ee17973
Message-Id: <160810693583.6147.4615376164114324442.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 08:22:15 +0000
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Tue, 15 Dec 2020 16:46:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-timers-5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7a932e5702886e872a545d64605c06a51ee17973

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
