Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 21 Mar 2005 18:21:46 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: Re: Double free of initramfs
Message-Id: <20050321182146.32a20ebf.akpm@osdl.org>
In-Reply-To: <20050316184932.GB16712@linux-mips.org>
References: <20050316184932.GB16712@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-arch@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
List-ID: <linux-arch.vger.kernel.org>

Ralf Baechle <ralf@linux-mips.org> wrote:
>
> In all linker scripts we currently have something like this:
> 
>   __init_begin = .;
>  ...
>    . = ALIGN(4096);
>   __initramfs_start = .;
>   .init.ramfs : { *(.init.ramfs) }
>   __initramfs_end = .;
>   ...
>   __init_end = .;
> 
> It seems all 25 linker scripts in the current bk tree are suffering from
> this.  Which mean with CONFIG_BLK_DEV_INITRD enabled first free_initrd_mem
> may be called to free the initram disk and just a little later
> free_initmem will try to free the entire range again, so either the
> linker scripts would need fixing or free_initrd_mem has become obsolete.
> 

Hard call.  I'd be 51% inclined to change the linker scripts so that the
freeing of the initram disk happens explicitly, rather than having it
magically hidden inside the main initmem segment.

Any objections from anyone?

(cc'ed Adrian, who might be interested in raising a patch ;))
