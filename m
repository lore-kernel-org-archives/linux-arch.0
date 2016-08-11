From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: c6x linker issue on linux-next-20160808 + some linker table work
Date: Thu, 11 Aug 2016 17:59:26 +0200
Message-ID: <20160811155926.GX3296@wotan.suse.de>
References: <741c0f4d-bd9c-f28a-12d1-64bb483c6998@roeck-us.net>
 <1470762240.3551.42.camel@redhat.com>
 <20160809184023.GD3296@wotan.suse.de>
 <1470793827.3551.77.camel@redhat.com>
 <CAB=NE6XbxvpdsXecPLbh9krsKRvwKcwEzcve4XorpPetU3Xk6Q@mail.gmail.com>
 <1470798247.3551.94.camel@redhat.com>
 <20160810213018.GS3296@wotan.suse.de>
 <1470870249.3551.100.camel@redhat.com>
 <20160811055627.GT3296@wotan.suse.de>
 <1470915162.3551.107.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46892 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932267AbcHKP72 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 11 Aug 2016 11:59:28 -0400
Content-Disposition: inline
In-Reply-To: <1470915162.3551.107.camel@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Aurelien Jacquiot <a-jacquiot@ti.com>, Josh Poimboeuf <jpoimboe@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, "H. Peter Anvin" <hpa@zytor.com>

On Thu, Aug 11, 2016 at 07:32:42AM -0400, Mark Salter wrote:
> On Thu, 2016-08-11 at 07:56 +0200, Luis R. Rodriguez wrote:
> > On Wed, Aug 10, 2016 at 07:04:09PM -0400, Mark Salter wrote:
> > > 
> > > On Wed, 2016-08-10 at 23:30 +0200, Luis R. Rodriguez wrote:
> > > > OK thanks I've found a clean solution minimal solution to this as follows. This now
> > > > builds fine. Is this a fine work around for now ?
> > > Almost. You also need:
> > > 
> > > diff --git a/include/linux/tables.h b/include/linux/tables.h
> > > index a39ab03..3fa8d4d 100644
> > > --- a/include/linux/tables.h
> > > +++ b/include/linux/tables.h
> > > @@ -325,7 +325,7 @@
> > >               __attribute__((used,                                      \
> > >                              weak,                                      \
> > >                              __aligned__(LINUX_SECTION_ALIGNMENT(name)),\
> > > -                            section(SECTION_TBL(SECTION_RODATA,        \
> > > +                            section(SECTION_TBL(SECTION_TBL_RO,        \
> > >                                                  name, level))))
> > >  
> > >  /**
> > > 
> > > Otherwise, start and end RO table markers end up in different sections.
> > I thought that was not needed as weak attributes already force it to go to
> > .const ? Anyway I've added this as well. Thanks!
> 
> The section attribute forced both variables into .rodata but the weak
> attribute prevented accesses from using the SB-relative reloc. The
> non-weak variable is the one that led to the link error.

I ask as set_section_tbl_type() was not patched for instance, so firmware/Makefile
still uses SECTION_RODATA, and it compiles and links fine. Should that also be
using then SECTION_TBL_RO ? Or do we only need this for the C constructors ?

  Luis
