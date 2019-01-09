From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] csky fixup for linux-5.0-rc1
Date: Wed, 9 Jan 2019 10:40:20 -0800
Message-ID: <CAHk-=wi-4DfZDM2xE2qDnj0acEfgfW5wPWxcps-V5XD8TNAw5w@mail.gmail.com>
References: <1547045397-24388-1-git-send-email-guoren@kernel.org>
 <20190109180501.12290.85607.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
 <20190109182955.GC30131@pure.paranoia.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109182955.GC30131@pure.paranoia.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: pr-tracker-bot@kernel.org, Guo Ren <guoren@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

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
