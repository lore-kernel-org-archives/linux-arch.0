Return-Path: <SRS0=4CXV=BR=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F79C433E0
	for <linux-arch@archiver.kernel.org>; Fri,  7 Aug 2020 17:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF9BE22CAE
	for <linux-arch@archiver.kernel.org>; Fri,  7 Aug 2020 17:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596822492;
	bh=nOrxrRd9XLj7d9qhiFQO1na9S+72lXEfOphlfrRBGLk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ilA9mojM8lslsmpr6kKeSH+dIwvjPjyPpmEBzqHJ/4B+0wxNUTdasMGFHqdnPNkJd
	 JNCt47m35lQzvM4Upmlz68baBcZLWm9rynRLfSq3QOdxae8yILjIhhKo8Fl1mPU5XZ
	 Jh8lswzQCKhEopf2DhSYRuoQ3+oBp4BbaQvl/4Bc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgHGRsL (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:48:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbgHGRsL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 7 Aug 2020 13:48:11 -0400
Subject: Re: [git pull] regset work
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596822491;
        bh=nOrxrRd9XLj7d9qhiFQO1na9S+72lXEfOphlfrRBGLk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CzAtYhgMuUeit9UTxVQLwYcV2ld6+I4M1x0fuO2LCYs1U3Y6CxJ2OPEjQMXQG4h1b
         RtXuGBBW+Y8ZDJhz+3P3h6bMilY+kBKcHSNp1eqCIBjA0g6zIlWK1RvyXzKRd21GU9
         ZklRpbxa+CLJ6G7L10gQ7Ch88vxhqEg+XxKElnrw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200806141044.GP1236603@ZenIV.linux.org.uk>
References: <20200806141044.GP1236603@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200806141044.GP1236603@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.regset
X-PR-Tracked-Commit-Id: ce327e1c54119179066d6f3573a28001febc9265
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 19b39c38abf68591edbd698740d410c37ee075cc
Message-Id: <159682249108.18750.2732125873851448328.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Aug 2020 17:48:11 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Thu, 6 Aug 2020 15:10:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.regset

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/19b39c38abf68591edbd698740d410c37ee075cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
