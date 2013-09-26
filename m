From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 1/4] asm-generic: cmpxchg: implement dummy
 cmpxchg64_relaxed operation
Date: Thu, 26 Sep 2013 08:34:04 -0700
Message-ID: <CA+55aFzCiOxpgdJagSVdsBYEU66zBSBXZpnU5-jvQpAX6T7SiA@mail.gmail.com>
References: <1380208411-31403-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1380208411-31403-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tony Luck <tony.luck@intel.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 26, 2013 at 8:13 AM, Will Deacon <will.deacon@arm.com> wrote:
>
> This patch implements a dummy implementation for asm-generic, falling
> back to the usual cmpxchg64 code.

I don't like the "let's add dummy operations for everybody who doesn't
care" when it is this specialized.

I'd much rather just add a single

   #ifndef cmpxchg64_relaxed
   # define cmpxchg64_relaxed cmpxchg64
   #endif

to the LOCKREF code, and then ARM (and others) can define it as they wish.

And *if* anybody else ever realizes that they want this outside of the
lockref code, let's look at doing that then. Right now I don't know of
any users, and I'd be leery of people using this willy-nilly, because
very few people really understand memory ordering.

               Linus
