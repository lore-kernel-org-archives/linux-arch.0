Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34765 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbdCYW3b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 25 Mar 2017 18:29:31 -0400
Received: by mail-wr0-f194.google.com with SMTP id w43so427811wrb.1
        for <linux-arch@vger.kernel.org>; Sat, 25 Mar 2017 15:28:33 -0700 (PDT)
Date: Sun, 26 Mar 2017 01:01:03 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: Splat during resume
Message-ID: <20170325220103.owhygrrrlsnk55fj@node.shutemov.name>
References: <20170325185855.4itsyevunczus7sc@pd.tnic>
 <20170325214615.eqgmkwbkyldt7wwl@pd.tnic>
 <20170325215012.v5vywew7pfi3qk5f@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170325215012.v5vywew7pfi3qk5f@pd.tnic>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>, Dave Hansen <dave.hansen@intel.com>, Denys Vlasenko <dvlasenk@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86-ml <x86@kernel.org>
Message-ID: <20170325220103.xAF9DA-m7r8ltLbqJUTOfxELu0htUQDmaXJcrODjoDY@z>

On Sat, Mar 25, 2017 at 10:50:12PM +0100, Borislav Petkov wrote:
> > No need, I found it. Reverting
> > 
> >   ea3b5e60ce80 ("x86/mm/ident_map: Add 5-level paging support")
> > 
> > makes the machine suspend and resume just fine again. Lemme add people to CC.
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

Sorry for this. See

http://lkml.kernel.org/r/20170324120458.nw3fwpmdptjtj5qb@node.shutemov.name

-- 
 Kirill A. Shutemov
