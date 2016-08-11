From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: c6x linker issue on linux-next-20160808 + some linker table work
Date: Thu, 11 Aug 2016 10:56:59 -0700
Message-ID: <CAB=NE6Xte8v4KngiyHALwgUSzpvs4oUFL-5=3dUu1q=_H1kUrQ@mail.gmail.com>
References: <741c0f4d-bd9c-f28a-12d1-64bb483c6998@roeck-us.net>
 <1470762240.3551.42.camel@redhat.com> <20160809184023.GD3296@wotan.suse.de>
 <1470793827.3551.77.camel@redhat.com> <CAB=NE6XbxvpdsXecPLbh9krsKRvwKcwEzcve4XorpPetU3Xk6Q@mail.gmail.com>
 <1470798247.3551.94.camel@redhat.com> <20160810213018.GS3296@wotan.suse.de>
 <1470870249.3551.100.camel@redhat.com> <20160811055627.GT3296@wotan.suse.de>
 <1470915162.3551.107.camel@redhat.com> <20160811155926.GX3296@wotan.suse.de> <1470935674.3551.118.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470935674.3551.118.camel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Aurelien Jacquiot <a-jacquiot@ti.com>, Josh Poimboeuf <jpoimboe@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Aug 11, 2016 at 10:14 AM, Mark Salter <msalter@redhat.com> wrote:
> On Thu, 2016-08-11 at 17:59 +0200, Luis R. Rodriguez wrote:
>> On Thu, Aug 11, 2016 at 07:32:42AM -0400, Mark Salter wrote:
>> >
>> > On Thu, 2016-08-11 at 07:56 +0200, Luis R. Rodriguez wrote:
>> > >
>> > > On Wed, Aug 10, 2016 at 07:04:09PM -0400, Mark Salter wrote:
>> > > >
>> > > >
>> > > > On Wed, 2016-08-10 at 23:30 +0200, Luis R. Rodriguez wrote:
>> > > > >
>> > > > > OK thanks I've found a clean solution minimal solution to this as follows. This now
>> > > > > builds fine. Is this a fine work around for now ?
>> > > > Almost. You also need:
>> > > >
>> > > > diff --git a/include/linux/tables.h b/include/linux/tables.h
>> > > > index a39ab03..3fa8d4d 100644
>> > > > --- a/include/linux/tables.h
>> > > > +++ b/include/linux/tables.h
>> > > > @@ -325,7 +325,7 @@
>> > > >               __attribute__((used,                                      \
>> > > >                              weak,                                      \
>> > > >                              __aligned__(LINUX_SECTION_ALIGNMENT(name)),\
>> > > > -                            section(SECTION_TBL(SECTION_RODATA,        \
>> > > > +                            section(SECTION_TBL(SECTION_TBL_RO,        \
>> > > >                                                  name, level))))
>> > > >
>> > > >  /**
>> > > >
>> > > > Otherwise, start and end RO table markers end up in different sections.
>> > > I thought that was not needed as weak attributes already force it to go to
>> > > .const ? Anyway I've added this as well. Thanks!
>> > The section attribute forced both variables into .rodata but the weak
>> > attribute prevented accesses from using the SB-relative reloc. The
>> > non-weak variable is the one that led to the link error.
>> I ask as set_section_tbl_type() was not patched for instance, so firmware/Makefile
>> still uses SECTION_RODATA, and it compiles and links fine. Should that also be
>> using then SECTION_TBL_RO ? Or do we only need this for the C constructors ?
>>
>>   Luis
>
> Yuck. You need SECTION_TBL_RO and s/.rodata/.const/ in that Makefile.

OK as I suspected then... So what I will have to do is add into
asm-generic/tables.h a special section_tbl_ro_type() / push_*() for RO
tables, so that then they all use  SECTION_TBL_RO.

> C6X doesn't support any of the devices with firmware, so I just added:

I figured, but this will be more important as more linker RO tables
become prevalent so better we get this right now.

> fw-shipped-y += ti_3410.fw
>
> to firmware/Makefile for testing.
>
> Leaving in .rodata and SECTION_RODATA, I got:
>
> % readelf --syms vmlinux | grep -e _fw_ -e builtin_fw
>   8445: e01d4000     0 NOTYPE  LOCAL  DEFAULT    7 _fw_ti_3410_fw_bin
>   8446: e01d75c5     0 NOTYPE  LOCAL  DEFAULT    7 _fw_end
>   8447: e020a7cc     0 NOTYPE  LOCAL  DEFAULT    7 _fw_ti_3410_fw_name
>  11063: e023d688     0 OBJECT  GLOBAL DEFAULT   13 builtin_fw__end
>  15867: e023d688     0 OBJECT  WEAK   DEFAULT   13 builtin_fw
>
> From the above addresses, the _fw symbols are in .rodata and the builtin_fw symbols
> are in .const.
>
> Changing the Makefile to use .rodata and SECTION_TBL_RO, I see:
>
>   8445: e0239688     0 NOTYPE  LOCAL  DEFAULT   13 _fw_ti_3410_fw_bin
>   8446: e023cc4d     0 NOTYPE  LOCAL  DEFAULT   13 _fw_end
>   8447: e023cc50     0 NOTYPE  LOCAL  DEFAULT   13 _fw_ti_3410_fw_name
>  11063: e0239688     0 OBJECT  GLOBAL DEFAULT   13 builtin_fw__end
>  15867: e0239688     0 OBJECT  WEAK   DEFAULT   13 builtin_fw
>
> which has everything in .const as it should be. But still builtin_fw and
> builtin_fw__end are at same address which seems wrong.

The address order seems odd, I've seen something similar but it works,
you can add debugging code to fw_get_builtin_firmware() in
drivers/base/firmware_class.c to debug while iterating, and/or also
use LINUX_SECTION_SIZE(builtin_fw) to verify the size.

  Luis
