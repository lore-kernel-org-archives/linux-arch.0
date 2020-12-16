Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE1DC2BBCA
	for <linux-arch@archiver.kernel.org>; Wed, 16 Dec 2020 08:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47B21233CF
	for <linux-arch@archiver.kernel.org>; Wed, 16 Dec 2020 08:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgLPIW4 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 16 Dec 2020 03:22:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:40478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgLPIWz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 16 Dec 2020 03:22:55 -0500
Subject: Re: [GIT PULL 1/3] cleanups for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608106935;
        bh=nKIXQ4AzObvFLuWrtdfnOvWCRRP9fbdlgbIb+HS4uEs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RWpoTeIV7TID5yHWVK20y0wE71ZYrUgevUZYdfyrMtG8NNd6MCQfFmAFA88gpCcBl
         tpBUuybj3AjiCWS6sfTuQCynNLCdO3TLkuklaFJUvzMhKQAb0vYxycGpWRY2VWVZID
         lJHqqh3Y98xRdPzL/CVkfCUHzLkrQPKE/n+kPAYfyksijZpDsx43hmC9T3qKOnopS6
         u+lROV7qP3ORPxWMJt8KLMNVpY0cl8dF17gDsVLN89Dry+1akydJMF6HYEd+LPfxKJ
         DFvWMxevV+gmTIaQDT1KrJSvvoFMM1vpQhKc6gLo8tTumzMfDn8H/GA7sVVctz8Ddp
         WPD99ItfKgraA==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a0b0u9NQ1unjQfwBJovahQYNgNj1ROLGR+TzZWKnzQgzQ@mail.gmail.com>
References: <CAK8P3a0b0u9NQ1unjQfwBJovahQYNgNj1ROLGR+TzZWKnzQgzQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a0b0u9NQ1unjQfwBJovahQYNgNj1ROLGR+TzZWKnzQgzQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-cleanup-5.11
X-PR-Tracked-Commit-Id: 8d0dd23c6c78d140ed2132f523592ddb4cea839f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2dc4957349a7a15f87ac2ea6367b129192769e1
Message-Id: <160810693499.6147.8944707749893935528.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 08:22:14 +0000
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Tue, 15 Dec 2020 16:44:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-cleanup-5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2dc4957349a7a15f87ac2ea6367b129192769e1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
