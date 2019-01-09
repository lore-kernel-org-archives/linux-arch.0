Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40109 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbfAISkl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Jan 2019 13:40:41 -0500
Received: by mail-lf1-f65.google.com with SMTP id v5so6416450lfe.7
        for <linux-arch@vger.kernel.org>; Wed, 09 Jan 2019 10:40:39 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id w12sm13866041lfe.80.2019.01.09.10.40.37
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 10:40:37 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id u89-v6so7400411lje.1
        for <linux-arch@vger.kernel.org>; Wed, 09 Jan 2019 10:40:37 -0800 (PST)
MIME-Version: 1.0
References: <1547045397-24388-1-git-send-email-guoren@kernel.org>
 <20190109180501.12290.85607.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
 <20190109182955.GC30131@pure.paranoia.local>
In-Reply-To: <20190109182955.GC30131@pure.paranoia.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 9 Jan 2019 10:40:20 -0800
Message-ID: <CAHk-=wi-4DfZDM2xE2qDnj0acEfgfW5wPWxcps-V5XD8TNAw5w@mail.gmail.com>
Subject: Re: [GIT PULL] csky fixup for linux-5.0-rc1
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: pr-tracker-bot@kernel.org, Guo Ren <guoren@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20190109184020.tlCTSCu7nFOBOtCHstRPdZit4lf-HmR7zh26Tazqp3Y@z>

On Wed, Jan 9, 2019 at 10:30 AM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> On Wed, Jan 09, 2019 at 06:05:01PM +0000, pr-tracker-bot@kernel.org wrote:
> > The pull request you sent on Wed,  9 Jan 2019 22:49:57 +0800:
> >
> > > (unable to parse the git remote)
>
> I just committed a fix for this. We weren't expecting URLs without ://
> in them.

Side note: I do wish people would use the proper _public_ access.
Maybe the pr-tracker-bot might even send the person who did a pull
request a (private) notice that there is something odd when that isn't
the case?

Pull requests shouldn't use the ssh address. Yes, it may be where you
_push_ things to, and yes, I can pull from it too (since I have ssh
access to both github and kernel.org), but it's still not the proper
"public-facing" repository address. Not everybody can use those
addresses.

When I remember, I actually end up editing these things up by hand as
I do the pull, because I want the git history to show the publicly
accessible tree. I don't always remember (but I did for the csky
case).

[ In fact, for the ssh://gitolite.kernel.org case, the fixup is
automatic in my git hooks, but for github I have to do it manually ]

               Linus
