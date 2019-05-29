Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34143 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfE2XA0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2019 19:00:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id c14so194812pfi.1
        for <linux-arch@vger.kernel.org>; Wed, 29 May 2019 16:00:26 -0700 (PDT)
Date: Wed, 29 May 2019 16:00:23 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] elf: align AT_RANDOM bytes
Message-ID: <201905291559.87E96F79@keescook>
References: <20190529213708.GA10729@avx2>
 <20190529152020.c9d0ed1c6194328f751fe0f9@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529152020.c9d0ed1c6194328f751fe0f9@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20190529230023.TSqRZK62pK3MMrKD7lBBo7ZJ79EjeQp45KC5IyDbK6Q@z>

On Wed, May 29, 2019 at 03:20:20PM -0700, Andrew Morton wrote:
> On Thu, 30 May 2019 00:37:08 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > AT_RANDOM content is always misaligned on x86_64:
> > 
> > 	$ LD_SHOW_AUXV=1 /bin/true | grep AT_RANDOM
> > 	AT_RANDOM:       0x7fff02101019
> > 
> > glibc copies first few bytes for stack protector stuff, aligned
> > access should be slightly faster.
> 
> I just don't understand the implications of this.  Is there
> (badly-behaved) userspace out there which makes assumptions about the
> current alignment?
> 
> How much faster, anyway?  How frequently is the AT_RANDOM record
> accessed?
> 
> I often have questions such as these about your performance/space
> tweaks :(.  Please try to address them as a matter of course when
> preparing changelogs?
> 
> And let's Cc Kees, who wrote the thing.
> 
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -144,11 +144,15 @@ static int padzero(unsigned long elf_bss)
> >  #define STACK_ALLOC(sp, len) ({ \
> >  	elf_addr_t __user *old_sp = (elf_addr_t __user *)sp; sp += len; \
> >  	old_sp; })
> > +#define STACK_ALIGN(sp, align)	\
> > +	((typeof(sp))(((unsigned long)sp + (int)align - 1) & ~((int)align - 1)))
> 
> I suspect plain old ALIGN() could be used here.
> 
> >  #else
> >  #define STACK_ADD(sp, items) ((elf_addr_t __user *)(sp) - (items))
> >  #define STACK_ROUND(sp, items) \
> >  	(((unsigned long) (sp - items)) &~ 15UL)
> >  #define STACK_ALLOC(sp, len) ({ sp -= len ; sp; })
> > +#define STACK_ALIGN(sp, align)	\
> > +	((typeof(sp))((unsigned long)sp & ~((int)align - 1)))
> 
> And maybe there's a helper which does this, dunno.
> 
> >  #endif
> >  
> >  #ifndef ELF_BASE_PLATFORM
> > @@ -217,6 +221,12 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
> >  			return -EFAULT;
> >  	}
> >  
> > +	/*
> > +	 * glibc copies first bytes for stack protector purposes
> > +	 * which are misaligned on x86_64 because strlen("x86_64") + 1 == 7.
> > +	 */
> > +	p = STACK_ALIGN(p, sizeof(long));
> > +

I have no objection to eating some bytes here. Though perhaps things could just
be reordered to leave all the aligned things together and put all the
strings later?

-Kees

> >  	/*
> >  	 * Generate 16 random bytes for userspace PRNG seeding.
> >  	 */
> 

-- 
Kees Cook
