Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from tartarus.angband.pl ([89.206.35.136]:35974 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932710AbcJQKie (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Oct 2016 06:38:34 -0400
Date: Mon, 17 Oct 2016 12:01:30 +0200
From: Adam Borowski <kilobyte@angband.pl>
Subject: Re: [GIT PULL] kbuild changes for v4.9-rc1
Message-ID: <20161017100130.GA16013@angband.pl>
References: <20161017065131.GA27863@angband.pl>
 <20161017175951.31d8f4b7@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161017175951.31d8f4b7@roar.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Omar Sandoval <osandov@osandov.com>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, adobriyan@gmail.com, sfr@canb.auug.org.au, viro@zeniv.linux.org.uk, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20161017100130.PqpeKP1gGXRO66D8f5jwP9tNnQO-j_fIaIkbIeqIFGg@z>

On Mon, Oct 17, 2016 at 05:59:51PM +1100, Nicholas Piggin wrote:
> On Mon, 17 Oct 2016 08:51:31 +0200
> Adam Borowski <kilobyte@angband.pl> wrote:
> > On Mon, Oct 17, 2016 at 02:57:09PM +1100, Nicholas Piggin wrote:
> > > On Sat, 15 Oct 2016 17:22:05 -0700 Omar Sandoval <osandov@osandov.com> wrote:  
> > > > So this has broken all module loading for me. I get the following dmesg
> > > > spew:
> > > > ...
> > > > [    4.586914] scsi_mod: no symbol version for memset
> > > > [    4.587920] scsi_mod: Unknown symbol memset (err -22)
> > > > [    4.588443] scsi_mod: no symbol version for ___preempt_schedule
> > > > [    4.589026] scsi_mod: Unknown symbol ___preempt_schedule (err -22)
> > > > ...
> > > > 
> > > > Reverting 784d5699eddc ("x86: move exports to actual definitions") fixes
> > > > it for me. This is with GCC 6.2.1, binutils 2.27, attached config.  
> > > 
> > > Thanks for the report. Could you try this patch and see if it helps?  
> > [patch snipped]
> > 
> > Omar probably won't wake up in quite a while, so I've tested the patch.
> > Alas, doesn't help.  Similar spew (for the few modules I don't have =y),
> > while reverting 784d5699eddc fixes it for me too.
> 
> Forgot to engage my brain before posting.
> 
> Architectures will need to have an include/asm/asm-prototypes.h that
> defines or #include<>s C-style prototypes for exported asm functions.
> We can do an asm-generic version for the common ones like memset so
> there's not a lot of pointless duplication there.
> 
> Care to do a patch for x86?

Sure, did so.  With the prototypes added, your patch works!
Tested on a handful of modules, and one out-of-tree (virtualbox).
I didn't try a 32-bit build.

Note that powerpc already has an include/asm/asm-prototypes.h which might or
might not be what you want.  It doesn't have memset and co, for example.

Anyway, here's my stab at x86:
