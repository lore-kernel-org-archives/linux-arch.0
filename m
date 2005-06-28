Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 28 Jun 2005 18:44:00 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: RFC: is_compat_task (Was: Re: input compat stuff)
Message-ID: <20050628164358.GQ8035@wotan.suse.de>
References: <20050628072710.GA29916@lst.de> <20050628181453.387e0fac.sfr@canb.auug.org.au> <20050628091704.GP4171@wotan.suse.de> <20050629020944.1af20657.sfr@canb.auug.org.au> <20050628161414.GP8035@wotan.suse.de> <20050629023455.5e2ef856.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050629023455.5e2ef856.sfr@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andi Kleen <ak@suse.de>, hch@lst.de, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> We still have the signal delivery problem - a 32 bit binary running on
> ppc64 needs the correct signal stack etc set up for it.  I guess most of
> the 64bit arches have the equivalent of
> 
>         if (test_thread_flag(TIF_32BIT))
>                 return do_signal32(oldset, regs);
> 
> in do_signal().

It's not a real problem. There are two use cases for this:
- A special 32bit in 64bit mode ABI. In this case the signal structures
can just be defined to have the necessary padding.
- A emulator like valgrind that executes a 32bit guest - in this
case the monitor can intercept the signal and handle it.
In both cases 64bit signals are fine.

-Andi
