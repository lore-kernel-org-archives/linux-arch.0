From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [GIT PULL] kbuild changes for v4.9-rc1
Date: Mon, 17 Oct 2016 17:59:51 +1100
Message-ID: <20161017175951.31d8f4b7@roar.ozlabs.ibm.com>
References: <20161017065131.GA27863@angband.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20161017065131.GA27863@angband.pl>
Sender: linux-kbuild-owner@vger.kernel.org
To: Adam Borowski <kilobyte@angband.pl>
Cc: Omar Sandoval <osandov@osandov.com>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, adobriyan@gmail.com, sfr@canb.auug.org.au, viro@zeniv.linux.org.uk, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, 17 Oct 2016 08:51:31 +0200
Adam Borowski <kilobyte@angband.pl> wrote:

> On Mon, Oct 17, 2016 at 02:57:09PM +1100, Nicholas Piggin wrote:
> > On Sat, 15 Oct 2016 17:22:05 -0700 Omar Sandoval <osandov@osandov.com> wrote:  
> > > On Fri, Oct 14, 2016 at 10:12:46PM +0200, Michal Marek wrote:  
> > > > please pull these kbuild changes for v4.9-rc1:
> > > > 
> > > > - EXPORT_SYMBOL for asm source by Al Viro. This does bring a regression,
> > > >   because genksyms no longer generates checksums for these symbols
> > > >   (CONFIG_MODVERSIONS). Nick Piggin is working on a patch to fix this.
> > > >   Plus, we are talking about functions like strcpy(), which rarely
> > > >   change prototypes.    
> > > 
> > > So this has broken all module loading for me. I get the following dmesg
> > > spew:
> > > ...
> > > [    4.586914] scsi_mod: no symbol version for memset
> > > [    4.587920] scsi_mod: Unknown symbol memset (err -22)
> > > [    4.588443] scsi_mod: no symbol version for ___preempt_schedule
> > > [    4.589026] scsi_mod: Unknown symbol ___preempt_schedule (err -22)
> > > ...
> > > 
> > > Reverting 784d5699eddc ("x86: move exports to actual definitions") fixes
> > > it for me. This is with GCC 6.2.1, binutils 2.27, attached config.  
> > 
> > Thanks for the report. Could you try this patch and see if it helps?  
> [patch snipped]
> 
> Omar probably won't wake up in quite a while, so I've tested the patch.
> Alas, doesn't help.  Similar spew (for the few modules I don't have =y),
> while reverting 784d5699eddc fixes it for me too.
> 
> Debian sid toolchain: gcc 6.2.0-6, binutils 2.27-8, config at
> https://angband.pl/tmp/config-4.9.0-rc1-debug+.gz

Forgot to engage my brain before posting.

Architectures will need to have an include/asm/asm-prototypes.h that
defines or #include<>s C-style prototypes for exported asm functions.
We can do an asm-generic version for the common ones like memset so
there's not a lot of pointless duplication there.

Care to do a patch for x86?

Thanks,
Nick
