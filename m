From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from asm
Date: Fri, 25 Nov 2016 10:00:46 -0800
Message-ID: <CA+55aFwXqv6uYmW0kC=c+yyumO_T0CJrz6m+MQCQX6bR5gRBQw@mail.gmail.com>
References: <20161123205338.GA12050@angband.pl> <20161123210256.31501-1-kilobyte@angband.pl>
 <20161124044028.GA12704@gmail.com> <20161124162051.5e336127@roar.ozlabs.ibm.com>
 <20161124060050.GA788@gmail.com> <20161124182026.34e6570b@roar.ozlabs.ibm.com>
 <20161124073639.GA12728@kroah.com> <20161124185322.1e2a492c@roar.ozlabs.ibm.com>
 <20161124095622.GA14390@kroah.com> <20161124213152.30d8d27a@roar.ozlabs.ibm.com>
 <20161124152410.GC30905@kroah.com> <20161125114018.12421474@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20161125114018.12421474@roar.ozlabs.ibm.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Adam Borowski <kilobyte@angband.pl>, Michal Marek <mmarek@suse.com>, Philip Muller <philm@manjaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-arch <linux-arch@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Nov 24, 2016 at 4:40 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
>>
>> Yes, manual "marking" is never going to be a viable solution.
>
> I guess it really depends on how exactly you want to use it. For distros
> that do stable ABI but rarely may have to break something for security
> reasons, it should work and give exact control.

No. Because nobody else will care, so unless it's like a single symbol
or something, it will just be a maintenance nightmare.

> What else do people *actually* use it for? Preventing mismatched modules
> when .git version is not attached and release version of the kernel has
> not been bumped. Is that it?

It used to be very useful for avoiding loading stale modules and then
wasting days on debugging something that wasn't the case when you had
forgotten to do "make modules_install". Change some subtle internal
ABI issue (add/remove a parameter, whatever) and it would really help.

These days, for me, LOCALVERSION_AUTO and module signing are what I
personally tend to use.

The modversions stuff may just be too painful to bother with. Very few
people probably use it, and the ones that do likely don't have any
overriding reason why.

So I'd personally be ok with just saying "let's disable it for now",
and see if anybody even notices and cares, and then has a good enough
explanation of why. It's entirely possible that most users are "I
enabled it ten years ago, I didn't even realize it was still in my
defconfig".

                    Linus
