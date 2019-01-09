Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f195.google.com ([209.85.166.195]:36682 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfAISaB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Jan 2019 13:30:01 -0500
Received: by mail-it1-f195.google.com with SMTP id c9so12460824itj.1
        for <linux-arch@vger.kernel.org>; Wed, 09 Jan 2019 10:30:00 -0800 (PST)
Date: Wed, 9 Jan 2019 13:29:55 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [GIT PULL] csky fixup for linux-5.0-rc1
Message-ID: <20190109182955.GC30131@pure.paranoia.local>
References: <1547045397-24388-1-git-send-email-guoren@kernel.org>
 <20190109180501.12290.85607.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190109180501.12290.85607.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: pr-tracker-bot@kernel.org
Cc: guoren@kernel.org, torvalds@linux-foundation.org, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20190109182955.ur2H6T1rECmhPf7j-hH2L1xg6I_lX-Kqec-IPQlxRXE@z>

On Wed, Jan 09, 2019 at 06:05:01PM +0000, pr-tracker-bot@kernel.org wrote:
> The pull request you sent on Wed,  9 Jan 2019 22:49:57 +0800:
> 
> > (unable to parse the git remote)

I just committed a fix for this. We weren't expecting URLs without ://
in them.

-K
