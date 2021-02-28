Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EC6C433DB
	for <linux-arch@archiver.kernel.org>; Sun, 28 Feb 2021 20:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F361164E62
	for <linux-arch@archiver.kernel.org>; Sun, 28 Feb 2021 20:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhB1UO4 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sun, 28 Feb 2021 15:14:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:56744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231264AbhB1UOq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 28 Feb 2021 15:14:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4F7BC64E62;
        Sun, 28 Feb 2021 20:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614543246;
        bh=ifvnJfxXmGrftMuOMoc+1CmH7A81MmPX4MVcE/CKjlM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DeW/JWe9K845MI6ceKft3tz0LNH9zElN7evA8ifEE5ZLOkqs6e6KlpnB0YaQM7eHQ
         UcObNf8m2ygytVC28z7/UWnMAfoB7rw2K1cMNcf0S2DXxV8bf2IBAiPP2NG8p01rEF
         wvJHznEeWp1DzZhWP9cVSdwCvRScE1dmGxQchuD13fJc+Y3wv2m4Jypjl5CYzCQa9o
         lNyJNN80kowpQJCCJtvaVmaIGzT0HDcZG9s10mzNfn0MyFwhZCviH1ICizAgwkwg9m
         DnJC7oRegGrQGLGF+0dHEkeTz31XtEBePBmUj9fcS8tcRfQcIW/Sf4itFaQ+upHO9W
         fJM4FVxBW0Yrg==
Subject: Re: [GIT PULL] csky changes for v5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210228034300.1090149-1-guoren@kernel.org>
References: <20210228034300.1090149-1-guoren@kernel.org>
X-PR-Tracked-List-Id: <linux-csky.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210228034300.1090149-1-guoren@kernel.org>
X-PR-Tracked-Remote: https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.12-rc1
X-PR-Tracked-Commit-Id: 6607aa6f6b68fc9b5955755f1b1be125cf2a9d03
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd278456d4ca0e6b3d5e10ace4566524baa144eb
Message-Id: <161454324620.2182.2972358139345966200.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Feb 2021 20:14:06 +0000
To:     guoren@kernel.org
Cc:     torvalds@linux-foundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Sun, 28 Feb 2021 11:43:00 +0800:

> https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd278456d4ca0e6b3d5e10ace4566524baa144eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
