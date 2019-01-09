From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [GIT PULL] csky fixup for linux-5.0-rc1
Date: Wed, 9 Jan 2019 15:05:21 -0500
Message-ID: <20190109200521.GE30131@pure.paranoia.local>
References: <1547045397-24388-1-git-send-email-guoren@kernel.org>
 <20190109180501.12290.85607.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
 <20190109182955.GC30131@pure.paranoia.local>
 <CAHk-=wi-4DfZDM2xE2qDnj0acEfgfW5wPWxcps-V5XD8TNAw5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHk-=wi-4DfZDM2xE2qDnj0acEfgfW5wPWxcps-V5XD8TNAw5w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: pr-tracker-bot@kernel.org, Guo Ren <guoren@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Jan 09, 2019 at 10:40:20AM -0800, Linus Torvalds wrote:
> Side note: I do wish people would use the proper _public_ access.

I'm wondering if this largely happens due to people's insteadOf rules.
We've established that git-request-pull will quietly substitute URLs in
the emails it generates if a matching insteadOf rule is found. I started
a discussion related to this on the git list, but it veered a bit
sideways:

https://public-inbox.org/git/20181115182826.GB25806@pure.paranoia.local/T/#u

> Maybe the pr-tracker-bot might even send the person who did a pull
> request a (private) notice that there is something odd when that isn't
> the case?

I'm not sure that would be very effective. Folks tend to ignore bots,
and with this one we're specifically recommending "add it to your ignore
list if you don't want notifications." I think an email from you for
such (rare) cases would be a better way to indicate that something in
the pull request needs to be changed.

-K
