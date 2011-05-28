From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] ns: Wire up the setns system call for 2.6.40-rc1 or whatever
Date: Sat, 28 May 2011 10:55:55 -0700
Message-ID: <BANLkTi=-DHpvAm_9J9y+rOxB25e=4kCjYA@mail.gmail.com>
References: <m1lixr4kz8.fsf@fess.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <m1lixr4kz8.fsf@fess.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Daniel Lezcano <dlezcano@fr.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Fri, May 27, 2011 at 7:28 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> 32bit and 64bit on x86 are tested and working. =A0The rest I have loo=
ked
> at closely and I can't find any problems.

So I really don't think this was even worth it. I applied the patch,
but I think that you should just have done the architecture you
tested, and left it to arch maintainers to add it as they will.

That's how we tend to do this, and it works. It also avoids surprises
when people then invariably end up having clashes due to system calls
being added. Even in just the 15 hours since you sent the email, I had
merged more code from ARM, and the patch no longer applied to my tree.
It's trivial to fix up, so that's not the problem, but the problem is
with different people adding system calls resulting in re-numbering.

In other words, it's simply better to strive to have *one* entity in
charge of picking the system call number, rather than do it like this.
Ergo: leave it to architecture maintainers to minimize the issue of
system call renumbering.

                        Linus
