From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 0/7] use struct pt_regs based syscall calling for x86-64
Date: Fri, 30 Mar 2018 13:48:08 +0200
Message-ID: <20180330114808.GA10671@light.dominikbrodowski.net>
References: <20180330093720.6780-1-linux@dominikbrodowski.net>
 <20180330101602.ongosnigfmdmgayb@gmail.com>
 <20180330104649.GB12688@light.dominikbrodowski.net>
 <20180330110354.cnrtmjkk77hhbekt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180330110354.cnrtmjkk77hhbekt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Mar 30, 2018 at 01:03:54PM +0200, Ingo Molnar wrote:
> 
> * Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> 
> > > > The whole series is available at
> > > > 
> > > >         https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git syscalls-WIP
> > > 
> > > BTW., I'd like all these bits to go through the x86 tree.
> > > 
> > > What is the expected merge route of the generic preparatory bits?
> > 
> > My current plan is to push the 109 patch bomb to remove in-kernel calls to syscalls
> > directly to Linus once v4.16 is released.
> 
> Are there any (textual and semantic) conflicts with the latest -next?
> 
> Also, to what extent were these 109 patches tested in -next?

These 109 patches are equivalent to the syscalls tree in linux-next. Most of
these patches habe been in there for quite a while (the last major batch went
in on March 22; other patches are in there since March 14th).

Conflicts existend with asm-generic and metag (which contain remvoal of some
architectures; I have solved that issue by not caring about those archs any
more); trivial conflicts exist since very few days with the vfs and sparc
trees.

Thanks,
	Dominik
