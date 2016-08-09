From: Mark Salter <msalter@redhat.com>
Subject: Re: c6x linker issue on linux-next-20160808 + some linker table work
Date: Tue, 09 Aug 2016 14:45:25 -0400
Message-ID: <1470768325.3551.45.camel@redhat.com>
References: <CAB=NE6Xqah+dnk68v3+de=CrHOxHvAqK7G=UX_hoCAmvA9zo5g@mail.gmail.com>
	 <741c0f4d-bd9c-f28a-12d1-64bb483c6998@roeck-us.net>
	 <1470762240.3551.42.camel@redhat.com> <20160809184023.GD3296@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160809184023.GD3296@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Aurelien Jacquiot <a-jacquiot@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@redhat.com>
List-Id: linux-arch.vger.kernel.org

On Tue, 2016-08-09 at 20:40 +0200, Luis R. Rodriguez wrote:
> On Tue, Aug 09, 2016 at 01:04:00PM -0400, Mark Salter wrote:
> > 
> > On Tue, 2016-08-09 at 06:37 -0700, Guenter Roeck wrote:
> > > 
> > > On 08/09/2016 01:11 AM, Luis R. Rodriguez wrote:
> > > > 
> > > > 
> > > > Mark, Aurelien,
> > > > 
> > > > I've run into a linker (ld) issue caused by the linker table work I've
> > > > been working on [0]. I looked into this and for the life of me, I
> > > > cannot comprehend what the problem is, so was hoping you folks might
> > > > be able to chime in.
> > > > 
> > > For reference, the error is
> > > 
> > > c6x-elf-ld: drivers/built-in.o: SB-relative relocation but __c6xabi_DSBT_BASE not defined
> > > c6x-elf-ld: drivers/built-in.o: SB-relative relocation but __c6xabi_DSBT_BASE not defined
> > DSBT is a reference to the no-MMU userspace ABI used by c6x. The kernel shouldn't
> > be referencing DSBT base. The -mno-dsbt gcc flag should prevent it.
> I see -mno-dsbt on arch/c6x/Makefile already -- however at link time this is
> an issue if linker tables are used it seems. Do you have any other recommendation?
> 

I'm looking at it now...

> I will note that it would seem that even i386 and x86-64 compiler/binutils seem
> to have relocation issues on older compiler/binutils, for instance:
> 
> gcc-4.7.2
> binutils-2.22 
> 
> Yields:
> 
> x86_64:allyesconfig || x86_64:allmodconfig
> Invalid absolute R_X86_64_64 relocation: __per_cpu_load 
> 
> i386:defconfig
> Invalid absolute R_386_32 relocation: __vvar_page
> 
> This issue on x86 is not observed as so far as of gcc 5.2.1
> and binutils-2.26.1.
> 
> hpa -- if you can think of a work around for this for older compilers/linkers
> let me know... unless we are OK to increase the requirements for x86.
> 
>   Luis
