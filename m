Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:54644 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751054AbdCYVuf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 25 Mar 2017 17:50:35 -0400
Date: Sat, 25 Mar 2017 22:50:12 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: Splat during resume
Message-ID: <20170325215012.v5vywew7pfi3qk5f@pd.tnic>
References: <20170325185855.4itsyevunczus7sc@pd.tnic>
 <20170325214615.eqgmkwbkyldt7wwl@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170325214615.eqgmkwbkyldt7wwl@pd.tnic>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>, Dave Hansen <dave.hansen@intel.com>, Denys Vlasenko <dvlasenk@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86-ml <x86@kernel.org>
Message-ID: <20170325215012.Cd7xSwPvo-GperQKegiGIF3V2H5-kruPPjf3oNOVfkI@z>

On Sat, Mar 25, 2017 at 10:46:15PM +0100, Borislav Petkov wrote:
> On Sat, Mar 25, 2017 at 07:58:55PM +0100, Borislav Petkov wrote:
> > Hey Rafael,
> > 
> > have you seen this already (partial splat photo attached)? Happens
> > during resume from s2d. Judging by the timestamps, this looks like the
> > resume kernel before we switch to the original, boot one but I could be
> > mistaken.
> > 
> > This is -rc3+tip/master.
> > 
> > I can't catch a full splat because this is a laptop and it doesn't have
> > serial. netconsole is helping me for shit so we'd need some guess work.
> > 
> > So I'm open to suggestions.
> > 
> > Please don't say "bisect" yet ;-)))
> 
> No need, I found it. Reverting
> 
>   ea3b5e60ce80 ("x86/mm/ident_map: Add 5-level paging support")
> 
> makes the machine suspend and resume just fine again. Lemme add people to CC.

So I see rIP pointing to ident_pmd_init() and the stack trace has
load_image_and_restore() so if I try to connect the dots, I get:

load_image_and_restore
|-> hibernation_restore
 |-> resume_target_kernel
  |-> swsusp_arch_resume
   |-> set_up_temporary_mappings
    |-> kernel_ident_mapping_init
     |-> ... ident_pmd_init

I'll let you folks make sense of what's going on.

Thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
