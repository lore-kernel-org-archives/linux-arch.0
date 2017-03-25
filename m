From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Splat during resume
Date: Sat, 25 Mar 2017 15:05:41 -0700
Message-ID: <CA+55aFz+23dAey7FnSF3pRNSydEZEe59RUmhO_a=dqZdGm-sEg@mail.gmail.com>
References: <20170325185855.4itsyevunczus7sc@pd.tnic> <20170325214615.eqgmkwbkyldt7wwl@pd.tnic>
 <20170325215012.v5vywew7pfi3qk5f@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:36289 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751042AbdCYWFn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 25 Mar 2017 18:05:43 -0400
In-Reply-To: <20170325215012.v5vywew7pfi3qk5f@pd.tnic>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>, Dave Hansen <dave.hansen@intel.com>, Denys Vlasenko <dvlasenk@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Michal Hocko <mhocko@suse.com>, Peter Zijlstra <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, x86-ml <x86@kernel.org>

I think this is the same as the kexec issue that also hit -tip.

It's *probably* fixed by the final series to actually enable 5-level
paging (which I don't think is in -tip yet), but even if that is the
case this is obviously a nasty bisectability problem.

You migth want to verify, though. The second batch starts here:

  https://marc.info/?l=linux-mm&m=148977696117208&w=2

Hmm?

In the meantime, this is currently -tip only, so I will stack back
from this thread unless you can reproduce it in mainline too.

               Linus

On Sat, Mar 25, 2017 at 2:50 PM, Borislav Petkov <bp@alien8.de> wrote:
>
> So I see rIP pointing to ident_pmd_init() and the stack trace has
> load_image_and_restore() so if I try to connect the dots, I get:
>
> load_image_and_restore
> |-> hibernation_restore
>  |-> resume_target_kernel
>   |-> swsusp_arch_resume
>    |-> set_up_temporary_mappings
>     |-> kernel_ident_mapping_init
>      |-> ... ident_pmd_init
>
> I'll let you folks make sense of what's going on.
>
> Thanks.
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.
