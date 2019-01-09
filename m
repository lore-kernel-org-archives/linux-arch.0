From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [GIT PULL] csky fixup for linux-5.0-rc1
Date: Wed, 9 Jan 2019 13:29:55 -0500
Message-ID: <20190109182955.GC30131@pure.paranoia.local>
References: <1547045397-24388-1-git-send-email-guoren@kernel.org>
 <20190109180501.12290.85607.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190109180501.12290.85607.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pr-tracker-bot@kernel.org
Cc: guoren@kernel.org, torvalds@linux-foundation.org, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Jan 09, 2019 at 06:05:01PM +0000, pr-tracker-bot@kernel.org wrote:
> The pull request you sent on Wed,  9 Jan 2019 22:49:57 +0800:
> 
> > (unable to parse the git remote)

I just committed a fix for this. We weren't expecting URLs without ://
in them.

-K
