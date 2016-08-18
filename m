From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 3/6] kbuild: add arch specific post-link pass
Date: Thu, 18 Aug 2016 10:17:11 +1000
Message-ID: <20160818101711.0e6b27c6@roar.ozlabs.ibm.com>
References: <1470910580-18458-1-git-send-email-npiggin@gmail.com>
	<1470910580-18458-4-git-send-email-npiggin@gmail.com>
	<57B2DBA1.6090304@suse.com>
	<20160817144322.4067391f@roar.ozlabs.ibm.com>
	<20160817095632.GA5187@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33958 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797AbcHRARZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Aug 2016 20:17:25 -0400
In-Reply-To: <20160817095632.GA5187@ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Michal Marek <mmarek@suse.com>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>

On Wed, 17 Aug 2016 11:56:33 +0200
Sam Ravnborg <sam@ravnborg.org> wrote:

> > diff --git a/Makefile b/Makefile
> > index 1d26fdb..20d3bfd 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -954,8 +954,14 @@ include/generated/autoksyms.h: FORCE
> >        cmd_link-vmlinux = $(CONFIG_SHELL) $< $(LD) $(LDFLAGS) $(LDFLAGS_vmlinux)
> >  quiet_cmd_link-vmlinux = LINK    $@
> >  
> > +# Optional arch pass after final link
> > +ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
> > +      cmd_postlink-vmlinux = \
> > +          $(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
> > +
> >  vmlinux: scripts/link-vmlinux.sh vmlinux_prereq $(vmlinux-deps) FORCE
> >  	+$(call if_changed,link-vmlinux)
> > +	+$(call if_changed,postlink-vmlinux)
> >  
> >  # Build samples along the rest of the kernel
> >  ifdef CONFIG_SAMPLES
> > @@ -1279,6 +1285,7 @@ $(clean-dirs):
> >  
> >  vmlinuxclean:
> >  	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/link-vmlinux.sh clean
> > +	$(Q)$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) clean)
> >  
> >  clean: archclean vmlinuxclean
> >    
> Another option would be to embed the logic in the link-vmlinux shell script.
> It is much simpler for normal humans to read and understand shell scripts,
> and it would be simpler too.

I did that in the previous patch. I struggle with Makefiles too, but
considering that we need the same recipe for modules, I thought just
doing it the same for both was a bit nicer. But I really can go either
way on it so whatever maintainers prefer I can respin.

Thanks,
Nick
