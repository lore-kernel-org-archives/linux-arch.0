Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 22 Mar 2005 22:41:17 +0000
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Double free of initramfs
Message-ID: <20050322224117.GH31706@linux-mips.org>
References: <20050316184932.GB16712@linux-mips.org> <20050321182146.32a20ebf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050321182146.32a20ebf.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
List-ID: <linux-arch.vger.kernel.org>

On Mon, Mar 21, 2005 at 06:21:46PM -0800, Andrew Morton wrote:

> > It seems all 25 linker scripts in the current bk tree are suffering from
> > this.  Which mean with CONFIG_BLK_DEV_INITRD enabled first free_initrd_mem
> > may be called to free the initram disk and just a little later
> > free_initmem will try to free the entire range again, so either the
> > linker scripts would need fixing or free_initrd_mem has become obsolete.
> > 
> 
> Hard call.  I'd be 51% inclined to change the linker scripts so that the
> freeing of the initram disk happens explicitly, rather than having it
> magically hidden inside the main initmem segment.
> 
> Any objections from anyone?
> 
> (cc'ed Adrian, who might be interested in raising a patch ;))

I've cooked that already.  Let me check if I can dig it up from here - I'm
supposed to be on vacation ;-)

  Ralf
