From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Testing of function/data-sections on linux-2.6.35-rc4
Date: Mon, 26 Jul 2010 09:27:10 +0200
Message-ID: <20100726072710.GB10061@merkur.ravnborg.org>
References: <201007181703.17022.vda.linux@googlemail.com> <20100723202448.GB27054@merkur.ravnborg.org> <201007260329.09913.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201007260329.09913.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: Tim Abbott <tabbott@ksplice.com>, Tim Bird <tim.bird@am.sony.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-kernel@vger.kernel.org, Matt Fleming <matt@console-pimps.org>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Michal Marek <mmarek@suse.cz>, Parisc List <linux-parisc@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Jul 26, 2010 at 03:29:09AM +0200, Denys Vlasenko wrote:
> On Friday 23 July 2010 22:24, Sam Ravnborg wrote:
> > > * fix for kernel linker stripts: linux-2.6.35-rc4-fs.fix-kernel-linker-scripts.patch
> > >   It makes _all_ linker scripts -ffunction/data-sections safe via:
> > >   -       *(.data)
> > >   +       *(.data .data.*)
> > >   
> > 
> > This patch touches both the regular kernel linker scripts and the
> > boot linker scripts.
> > I would strongly prefer a split so you touched the boot linker
> > scripts in a separate patch.
> 
> No problem.
> 
> > In addition the patch handles more sections than
> > documented: rodata, bss, text.
> 
> Yes, that was assumed.
> 
> > The patch introduce the following syntax for input sections:
> > 
> >     *(.bss .bss.*)
> >
> > Where the kernel linker script would have one input
> > section per line.
> > Can we stick to the "layout" used in the kernel linker scripts?
> 
> Sure.
> 
> 
> > The patch in addition in several places changes linker
> > scripts that already uses the two-lines layout to a single line approach.
> > These "fixes" should be omitted.
> 
> Reverted.
> 
> > Why do we need *(.bss .bss.*)?
> > Does -fdata-sections introduce special .bss sectiosn too?
> 
> Yes, it does.
> 
> Please take a look at attached updated patches.
> 
> Signed-off-by: Denys Vlasenko <vda.linux@googlemail.com>

Looks better now - thanks.

With proper changelogs both patches has my:

Acked-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
