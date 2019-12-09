From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: RFC: kill off ioremap_nocache
Date: Mon, 9 Dec 2019 10:48:20 -0800
Message-ID: <CAADWXX9zEBT-NPCwE09D+6=8iCZ+kCmdyXoGrTKhnmYn82XEJQ@mail.gmail.com>
References: <20191209135823.28465-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191209135823.28465-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-mips <linux-mips@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Dec 9, 2019 at 5:58 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Let me know what you think and if this is something acceptable for
> just after -rc1.

How many conflicts will this result in generally? I like it, but I'd
like to have some idea of whether it ends up being one of those
"really painful churn" things?

A couple of conflicts isn't an issue - they'll be trivial to fix. It's
the "this causes fifty silly conflicts" that I worry about, partly
because it then makes submaintainers inevitably do the wrong thing (ie
"I foresee an excessive amount of 'git rebase' rants next release").

Also, it looks like Google doesn't want this to happen. This whole
series was marked as spam for me.I'm not sure why, I don't see
anything odd that would trigger it, and DKIM and SPF both passed.
Maybe it's you, maybe it's Google, and maybe it's the infradead SRS
thing.

               Linus
