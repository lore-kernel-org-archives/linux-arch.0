Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4774FC00140
	for <linux-arch@archiver.kernel.org>; Fri,  5 Aug 2022 17:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238133AbiHERmd (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 5 Aug 2022 13:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241586AbiHERmb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Aug 2022 13:42:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96690F590;
        Fri,  5 Aug 2022 10:42:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FACFB82990;
        Fri,  5 Aug 2022 17:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED046C43140;
        Fri,  5 Aug 2022 17:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659721348;
        bh=dSVWoW3MstJHngFlG333N133CVdlxOx7L6Rqcj/Fva4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Cx8PjIqEBbdyFmc3SAaSlsoUV2v93Zvd7lwNf8ovgxQ/EcXYUHrUtdd1rl2vL2EQ0
         4UJeISec2rlHeY3TjcJQ/GmYUpQdNs5rDIDVnqSGnBjBCLv5FAcbPYqyT+ZGqYJf0B
         Dei+2UYwioynRrtIaG8YkPCt0IRpbDsqRQkP55GbwkLgPFXYVx4QQLBBqJoaUAHPGI
         8KSf8WfVNuzfNNvgiyOIYCj1HLWsd5oHVXcjn+8v2wNYgJ/vhPIV0U4tE7VxsySq1u
         2NemtYtWaSdIQzPqi0QdkSyBpcqRtJEE8HPG+XFgpQhzY+m64rSRxh0b04JVuP5eKa
         RinTFfGtOW0rg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE0CBC43140;
        Fri,  5 Aug 2022 17:42:27 +0000 (UTC)
Subject: Re: [GIT PULL] asm-generic: updates for 6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a2jgQcLaDXX6eOTNrU0RJ2O625e75LBMy6v2ABP0cdoww@mail.gmail.com>
References: <CAK8P3a2jgQcLaDXX6eOTNrU0RJ2O625e75LBMy6v2ABP0cdoww@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <CAK8P3a2jgQcLaDXX6eOTNrU0RJ2O625e75LBMy6v2ABP0cdoww@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.0
X-PR-Tracked-Commit-Id: 6f05e014b96c8846cdc39acdf10bbdbafb9c78a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3bd6e5854bf9bb5436d6b533e206561839e3b284
Message-Id: <165972134790.14838.9190012685058273910.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Aug 2022 17:42:27 +0000
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The pull request you sent on Fri, 5 Aug 2022 12:25:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-6.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3bd6e5854bf9bb5436d6b533e206561839e3b284

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
