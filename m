From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: USE_ELF_CORE_DUMP?
Date: Sun, 26 Apr 2009 11:21:03 +0200
Message-ID: <20090426092103.GB8207@lst.de>
References: <20090423183331.GA19899@lst.de> <49F16786.7010401@petalogix.com>
Reply-To: microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <49F16786.7010401-g5w7nrANp4BDPfheJLI6IQ@public.gmane.org>
Sender: owner-microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org
To: Michal Simek <michal.simek-g5w7nrANp4BDPfheJLI6IQ@public.gmane.org>
Cc: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, microblaze-uclinux-rVRm/Wmeqae7NGdpmJTKYQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Apr 24, 2009 at 09:17:26AM +0200, Michal Simek wrote:
> Christoph Hellwig wrote:
> > Currently all architectures but microblaze unconditionally define
> > USE_ELF_CORE_DUMP.  The microblaze ommision seems like an error to
> > me, so can we just kill this ifdef and make sure we are the same
> > everywhere?
> >   
> Where did you find it?
> I haven't seen in in mainline (noMMU kernel). It is in my MMU patches
> which I want to send for review soon.

USE_ELF_CORE_DUMP is defined in arch/x86/include/*/elf.h (or sometimes
elf_{32,64}.h) on all architectures but microblaze.

> For noMMU I use CONFIG_BINFMT_FLAT (binfmt_flat.c) where I don't need
> USE_ELF_CORE_DUMP
> For MMU I use CONFIG_BINFMT_ELF (binfmt_elf.c) where USE_ELF_CORE_DUMP
> make sense to me.

USE_ELF_CORE_DUMP only comes into play if CONFIG_ELF_CORE is set, so in
the mmu example above.  These two are in fact always checked together,
so not setting USE_ELF_CORE_DUMP is an obscure way to disable elf core
dumps despite CONFIG_ELF_CORE being set.
