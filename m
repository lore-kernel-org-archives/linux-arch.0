From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/5] kbuild: thin archives use P option to ar
Date: Mon, 19 Jun 2017 16:52:40 +1000
Message-ID: <20170619165240.0d2b6e73@roar.ozlabs.ibm.com>
References: <20170609052417.561-1-npiggin@gmail.com>
        <20170609052417.561-3-npiggin@gmail.com>
        <CAK7LNATkm0hKB+yBKHFBEpV2nycp5DyJMvUe7vATLOwN2fLb1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <CAK7LNATkm0hKB+yBKHFBEpV2nycp5DyJMvUe7vATLOwN2fLb1g@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-arch.vger.kernel.org

On Mon, 19 Jun 2017 15:17:39 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> Hi Nicholas,
> 
> 
> 2017-06-09 14:24 GMT+09:00 Nicholas Piggin <npiggin@gmail.com>:
> > The P option makes ar do full path name matching and can prevent ar
> > from discarding files with duplicate names in some cases of creating
> > thin archives from thin archives. The sh architecture in particular
> > loses some object files from its kernel/cpu/sh*/ directories without
> > this option.  
> 
> After playing around with thin archives, I agree this is the right
> thing to do.
> 
> Currently, sh is the only architecture that has this kind of issue
> (arch/sh/kernel/cpu/fpu.c  vs  arch/sh/kernel/cpu/sh*/fpu.c),
> but this could happen in any architecture, I think.
> 
> 
> BTW, I see one more instance in archive_builtin() in scripts/link-vmlinux.sh.
> 
> We have no source file at the top directory, so it will work
> with/without "P" for the top-level built-in.o
> 
> Either way seems OK to me.

Oh, we should probably add the P there for consistency. I can't see
any downside to it. Can you fold in the fix?

> > This could be a bug in binutils ar, but the P option should not cause
> > any negative effects so it is safe to use to work around tihs with.  
> 
> 
> Is "tihs" a typo?

Yes. Should be "this".

Thanks,
Nick
