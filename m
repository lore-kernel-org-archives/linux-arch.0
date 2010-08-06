From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: Re: [PATCH 2/4] module linker script: coalesce function and data sections
Date: Fri, 6 Aug 2010 04:18:06 +0200
Message-ID: <201008060418.06363.vda.linux@googlemail.com>
References: <1280360876-2571-1-git-send-email-vda.linux@googlemail.com> <1280360876-2571-3-git-send-email-vda.linux@googlemail.com> <4C581DEE.8080205@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <4C581DEE.8080205@suse.cz>
Content-Disposition: inline
Sender: linux-parisc-owner@vger.kernel.org
To: Michal Marek <mmarek@suse.cz>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, linux-arch@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Tim Abbott <tabbott@ksplice.com>, Tim Bird <tim.bird@am.sony.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Matt Fleming <matt@console-pimps.org>, Arnd Bergmann <arnd@arndb.de>, Anders Kaseorg <andersk@mit.edu>, Andi Kleen <andi@firstfloor.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-arch.vger.kernel.org

On Tuesday 03 August 2010 15:47, Michal Marek wrote:
> On 29.7.2010 01:47, Denys Vlasenko wrote:
> >  SECTIONS {
> > +
> > +	/* Coalesce sections produced by gcc -ffunction-sections */
> > +	.text   0 : AT(0) { *(.text .text.[A-Za-z0-9_$^]*) }
> > +
> > +	/* Coalesce sections produced by gcc -fdata-sections */
> > +	.rodata 0 : AT(0) { *(.rodata .rodata.[A-Za-z0-9_$^]*) }
> > +	.data   0 : AT(0) { *(.data .data.[A-Za-z0-9_$^]*) }
> > +	.bss    0 : AT(0) { *(.bss .bss.[A-Za-z0-9_$^]*) }
> > +
> >  	/DISCARD/ : { *(.discard) }
> >  }
> 
> I'm now getting
> 
> ld:/home/mmarek/linux-2.6/scripts/module-common.lds:23: ignoring invalid
> character `^' in script
> ld:/home/mmarek/linux-2.6/scripts/module-common.lds:26: ignoring invalid
> character `^' in script
> ld:/home/mmarek/linux-2.6/scripts/module-common.lds:27: ignoring invalid
> character `^' in script
> ld:/home/mmarek/linux-2.6/scripts/module-common.lds:28: ignoring invalid
> character `^' in script
> 
> when linking modules and a similar warning when linking vmlinux (caused
> by the next patch in series). I tried writing the carets as \^, but that
> doesn't help at all...

Yep, I can confirm it. The binutils fix to allow caret might be trivial,
and will allow us to use much better pattern: [^.]*

I created a Fedora bug for it:

https://bugzilla.redhat.com/show_bug.cgi?id=621742

So far, please remove these three patches from kbuild tree.

(I see that modpost patch is in Linus tree. Thanks!)

-- 
vda
