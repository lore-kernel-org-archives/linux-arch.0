From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: c6x linker issue on linux-next-20160808 + some linker table work
Date: Thu, 11 Aug 2016 07:56:27 +0200
Message-ID: <20160811055627.GT3296@wotan.suse.de>
References: <CAB=NE6Xqah+dnk68v3+de=CrHOxHvAqK7G=UX_hoCAmvA9zo5g@mail.gmail.com>
 <741c0f4d-bd9c-f28a-12d1-64bb483c6998@roeck-us.net>
 <1470762240.3551.42.camel@redhat.com>
 <20160809184023.GD3296@wotan.suse.de>
 <1470793827.3551.77.camel@redhat.com>
 <CAB=NE6XbxvpdsXecPLbh9krsKRvwKcwEzcve4XorpPetU3Xk6Q@mail.gmail.com>
 <1470798247.3551.94.camel@redhat.com>
 <20160810213018.GS3296@wotan.suse.de>
 <1470870249.3551.100.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50520 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780AbcHKF4a (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 11 Aug 2016 01:56:30 -0400
Content-Disposition: inline
In-Reply-To: <1470870249.3551.100.camel@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Aurelien Jacquiot <a-jacquiot@ti.com>, Josh Poimboeuf <jpoimboe@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, "H. Peter Anvin" <hpa@zytor.com>

On Wed, Aug 10, 2016 at 07:04:09PM -0400, Mark Salter wrote:
> On Wed, 2016-08-10 at 23:30 +0200, Luis R. Rodriguez wrote:
> > On Tue, Aug 09, 2016 at 11:04:07PM -0400, Mark Salter wrote:
> > > 
> > > On Tue, 2016-08-09 at 19:09 -0700, Luis R. Rodriguez wrote:
> > > > 
> > > > On Aug 9, 2016 6:50 PM, "Mark Salter" <msalter@redhat.com> wrote:
> > > > > 
> > > > > 
> > > > > On Tue, 2016-08-09 at 20:40 +0200, Luis R. Rodriguez wrote:
> > > > > > 
> > > > > > On Tue, Aug 09, 2016 at 01:04:00PM -0400, Mark Salter wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > On Tue, 2016-08-09 at 06:37 -0700, Guenter Roeck wrote:
> > > > > > > > 
> > > > > > > > 
> > > > > > > > On 08/09/2016 01:11 AM, Luis R. Rodriguez wrote:
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > Mark, Aurelien,
> > > > > > > > > 
> > > > > > > > > I've run into a linker (ld) issue caused by the linker table work I've
> > > > > > > > > been working on [0]. I looked into this and for the life of me, I
> > > > > > > > > cannot comprehend what the problem is, so was hoping you folks might
> > > > > > > > > be able to chime in.
> > > > > > > > > 
> > > > > > > > For reference, the error is
> > > > > > > > 
> > > > > > > > c6x-elf-ld: drivers/built-in.o: SB-relative relocation but __c6xabi_DSBT_BASE not defined
> > > > > > > > c6x-elf-ld: drivers/built-in.o: SB-relative relocation but __c6xabi_DSBT_BASE not defined
> > > > > > > DSBT is a reference to the no-MMU userspace ABI used by c6x. The kernel shouldn't
> > > > > > > be referencing DSBT base. The -mno-dsbt gcc flag should prevent it.
> > > > > > I see -mno-dsbt on arch/c6x/Makefile already -- however at link time this is
> > > > > > an issue if linker tables are used it seems. Do you have any other recommendation?
> > > > > > 
> > > > > > I will note that it would seem that even i386 and x86-64 compiler/binutils seem
> > > > > > to have relocation issues on older compiler/binutils, for instance:
> > > > > I see the problem with gcc 6 as well.
> > > > > 
> > > > > So there appears to be some toolchain issues at play here. We build the kernel with two
> > > > > c6x-specific options: -mno-dsbt and -msdata=none. I already mentioned dsbt. The sdata
> > > > > option may be one of:
> > > > > 
> > > > > -msdata=default
> > > > >      Put small global and static data in the .neardata section, which is pointed to by
> > > > >      register B14. Put small uninitialized global and static data in the .bss section,
> > > > >      which is adjacent to the .neardata section. Put small read-only data into the 
> > > > >      .rodata section. The corresponding sections used for large pieces of data are
> > > > >      .fardata, .far and .const.
> > > > > 
> > > > > -msdata=all
> > > > >     Put all data, not just small objects, into the sections reserved for small data,
> > > > >     and use addressing relative to the B14 register to access them.
> > > > > 
> > > > > -msdata=none
> > > > >     Make no use of the sections reserved for small data, and use absolute addresses
> > > > >     to access all data. Put all initialized global and static data in the .fardata
> > > > >     section, and all uninitialized data in the .far section. Put all constant data
> > > > >     into the .const section.
> > > > > 
> > > > > 
> > > > > Both small data and DSBT make use of base register + 15-bit offset to access data
> > > > > and thus the SB-relative reloc in the above error message.
> > > > > 
> > > > > I think that gcc sees the .rodata section from DEFINE_LINKTABLE_RO() for builtin_fw
> > > > > and thinks it needs an SB-relative reloc. When the linker sees that reloc, it thinks
> > > > > it needs the dsbt base register and thus the error. Interestingly, weak data is
> > > > > never put in the small data section so if gcc sees that data is weak, it doesn't
> > > > > check the section name to see if it is a small data section. So SB-relative only
> > > > > gets used for builtin_fw__end, but not the weak builtin_fw even though they both
> > > > > are in the .rodata section.
> > > > > 
> > > > > I suspect gcc should avoid being fooled by .rodata if -msdata=none is used.
> > > > > Regardless, I think this could all be avoided if the RO tables used .const
> > > > > instead of .rodata for c6x.
> > > > Thanks for the thorough analysis, would you be OK for c6x to use .const for all read only linker tables or section ranges ?
> > > > I had not added #ifndef around the core-sections.h main ELF definitons but could add one as its needed. In this case perhals that is needed and fine by
> > > > you
> > > > for SECTION_RODATA.
> > > > We can also override any of the core section setter helpers for archs but in this case based on what you say it seems this is needed. Unless of course
> > > > just
> > > > -msdata=none is fine and that's not yet used and you prefer that.
> > > >   Luis
> > > We're already using -msdata=none for kernel builds. From the gcc docs, one would think
> > > all const data goes into .const with -msdata=none, but the kernel forces a lot of weak
> > > const kallsyms data ,rodata so c6x vmlinux.lds still needs to have a .rodata section. I
> > > think we need to use .const for the c6x read-only linker tables and keep .rodata for
> > > RO_DATA_SECTION in vmlinux.lds.h.
> > OK thanks I've found a clean solution minimal solution to this as follows. This now
> > builds fine. Is this a fine work around for now ?
> 
> Almost. You also need:
> 
> diff --git a/include/linux/tables.h b/include/linux/tables.h
> index a39ab03..3fa8d4d 100644
> --- a/include/linux/tables.h
> +++ b/include/linux/tables.h
> @@ -325,7 +325,7 @@
>               __attribute__((used,                                      \
>                              weak,                                      \
>                              __aligned__(LINUX_SECTION_ALIGNMENT(name)),\
> -                            section(SECTION_TBL(SECTION_RODATA,        \
> +                            section(SECTION_TBL(SECTION_TBL_RO,        \
>                                                  name, level))))
>  
>  /**
> 
> Otherwise, start and end RO table markers end up in different sections.

I thought that was not needed as weak attributes already force it to go to
.const ? Anyway I've added this as well. Thanks!

  Luis
