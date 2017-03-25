From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: Splat during resume
Date: Sun, 26 Mar 2017 01:01:03 +0300
Message-ID: <20170325220103.owhygrrrlsnk55fj@node.shutemov.name>
References: <20170325185855.4itsyevunczus7sc@pd.tnic>
 <20170325214615.eqgmkwbkyldt7wwl@pd.tnic>
 <20170325215012.v5vywew7pfi3qk5f@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20170325215012.v5vywew7pfi3qk5f@pd.tnic>
Sender: owner-linux-mm@kvack.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>, Dave Hansen <dave.hansen@intel.com>, Denys Vlasenko <dvlasenk@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86-ml <x86@kernel.org>
List-Id: linux-arch.vger.kernel.org

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

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
