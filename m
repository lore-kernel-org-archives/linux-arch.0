Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33521 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753994AbcHYF5H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Aug 2016 01:57:07 -0400
Date: Thu, 25 Aug 2016 12:06:33 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 04/16] generic-sections: add section core helpers
Message-ID: <20160825120633.057b2f6f@roar.ozlabs.ibm.com>
In-Reply-To: <20160824201253.GS3296@wotan.suse.de>
References: <1471642454-5679-1-git-send-email-mcgrof@kernel.org>
        <1471642454-5679-5-git-send-email-mcgrof@kernel.org>
        <20160823112633.7d482e62@roar.ozlabs.ibm.com>
        <20160823173306.GA3296@wotan.suse.de>
        <20160824135141.2c8f06ec@roar.ozlabs.ibm.com>
        <20160824201253.GS3296@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, jpoimboe@redhat.com, bp@alien8.de, linux@arm.linux.org.uk, mhiramat@kernel.org, masami.hiramatsu.pt@hitachi.com, jbaron@akamai.com, heiko.carstens@de.ibm.com, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, realmz6@gmail.com, x86@kernel.org, luto@amacapital.net, keescook@chromium.org, torvalds@linux-foundation.org, gregkh@linuxfoundation.org, rusty@rustcorp.com.au, gnomes@lxorguk.ukuu.org.uk, alan@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, ming.lei@canonical.com, linux-arch@vger.kernel.org, benh@kernel.crashing.org, ananth@in.ibm.com, pebolle@tiscali.nl, fontana@sharpeleven.org, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, andrew.cooper3@citrix.com, andriy.shevchenko@linux.intel.com, paul.gortmaker@windriver.com, xen-devel@lists.xensource.com, ak@linux.intel.com, pali.rohar@gmail.com, dvhart@infradead.org, platform-driver-x86@vger.kernel.org, mmarek@suse.com, linux@rasmusvillemoes.dk, jkosina@suse.cz, korea.drzix@gmail.com, linux-kbuild@vger.kernel.org, tony.luck@intel.com, akpm@linux-foundation.org, linux-ia64@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, rostedt@goodmis.org, jani.nikula@intel.com, mchehab@osg.samsung.com, markus.heiser@darmarit.de, acme@redhat.com, jolsa@kernel.org, msalter@redhat.com, chris@zankel.net, jcmvbkbc@gmail.com, linux-xtensa@linux-xtensa.org, paulus@samba.org, mpe@ellerman.id.au, James.Bottomley@HansenPartnership.com
Message-ID: <20160825020633.fIIepdmnAVgszN69XCXugH3FzuRwqT2VcasrvmJJzfA@z>

On Wed, 24 Aug 2016 22:12:53 +0200
"Luis R. Rodriguez" <mcgrof@kernel.org> wrote:

> On Wed, Aug 24, 2016 at 01:51:41PM +1000, Nicholas Piggin wrote:
> > On Tue, 23 Aug 2016 19:33:06 +0200
> > "Luis R. Rodriguez" <mcgrof@kernel.org> wrote:
> >   
> > > On Tue, Aug 23, 2016 at 11:26:33AM +1000, Nicholas Piggin wrote:  
> > > > On Fri, 19 Aug 2016 14:34:02 -0700
> > > > mcgrof@kernel.org wrote:    
> > > > > +/**
> > > > > + * DOC: Standard ELF section use in Linux
> > > > > + *
> > > > > + * Linux makes use of the standard ELF sections, this sections documents
> > > > > + * these.
> > > > > + */
> > > > > +
> > > > > +/**
> > > > > + * DOC: SECTION_RODATA
> > > > > + *
> > > > > + * Macro name for code which must be protected from write access, read only
> > > > > + * data.
> > > > > + */
> > > > > +#define SECTION_RODATA			.rodata    
> > > > 
> > > > These, for example. The exact name of the section is important in linker
> > > > scripts and asm, so I can't see the benefit of hiding it. I could be
> > > > missing the bigger picture.    
> > > 
> > > There's two goals by using a macro for these core names. One is to allow us
> > > to easily aggregate documentation in central place for each, the second is
> > > to then provide more easily grep'able helpers so we can use them when devising
> > > extensions or using them in extensions which further customize the sections
> > > in the kernel.  
> 
> Just thought of more more justification I had forgotten. I cover it below.
> 
> > Documentation is good, but not necessary to have the extra name indirection.  
> 
> Fair point.
> 
> > Sections tend (not always, but it would be nice if they did) to follow the
> > .name convention, which makes them reasonably easy to grep for.  
> 
> git grep .text  doesn't work but that is typically expected...
> git grep \.text doesn't work as expected
> 
> Ah finally:
> 
> git grep "\.text" seems to work. But WTF.

This is simply how grep works though.


> But:
> 
> git grep SECTION_TEXT works as expected immediately.
> 
> I guess its a matter of perspective.
> 
> > They are also
> > the names you'll be grepping for when you look at disassembly.  
> 
> Sure but if you're grepping asm, you very likely know what to look for.

After you have gone through the extra layer of naming indirection
to work out what it is. I'm still not sold on the name indirection
and hiding wildcards. Not just for asm grepping, but I don't think
it's a negative thing for devs working on the linker to know what
actual section names and commands are being used, as much as possible.


> > > > > +/**
> > > > > + * DOC: SECTION_TEXT
> > > > > + *
> > > > > + * Macro name used to annotate code (functions) used during regular
> > > > > + * kernel run time. This is combined with `SECTION_RODATA`, only this
> > > > > + * section also allows for execution.
> > > > > + *
> > > > > + */
> > > > > +#define SECTION_TEXT			.text    
> > > > 
> > > > I can't see how these comments are right. .rodata doesn't seem like it
> > > > should be combined with .text, and is not currently on powerpc. I think
> > > > it's for data, not code.    
> > > 
> > > On x86 and powerpc .rodata follows .text.  
> > 
> > But follows is not the same as combined.  
> 
> True and as I confirmed below, on PowerPC this is certainly not true.

OK.


> > And together with the comment that RODATA is for code (which is wrong, it's data),  
> 
> Where did I have that? If you refer to the above SECTION_TEXT documentation, it
> refers to SECTION_TEXT being for code, but the goal was to highlight that
> SECTION_TEXT is for execution, while SECTION_RODATA was for data. This
> certainly can use some love though, thanks, will just drop the SECTION_RODATA
> reference *or* properly explain the whole thing below.

+/**
+ * DOC: SECTION_RODATA
+ *
+ * Macro name for code which must be protected from write access, read only
+ * data.
+ */
+#define SECTION_RODATA			.rodata

This together with the "combined with .text" part confused me.


> > it make it seem like it is actually combined.  
> 
> Will fix to ensure this is understood in proper context.

Thanks.



> > > Its not intended to grab .text but rather its for helpers that provide customizations
> > > based on a core section as base, in this case given your example it would be used by
> > > section ranges and linker tables for .text. Both section ranges and linker tables
> > > use postfix .something for their customizations. The SECTION_ALL() macro then is
> > > a helper for customizations on a core section.  
> > 
> > Right, it's just that .text.* is *immediately* obvious. SECTION_ALL() is not.  
> 
> Which is why I was suggesting perhaps an alternative name.
> 
> > > If the name is misleading would SECTION_CORE_ALL() be better with some documentation
> > > explaining this and the above goal ?  
> > 
> > I don't know... not to be glib, but .section.* would be better and not require
> > documentation.  
> 
> Well consider the issues below for a second... and keep in mind with linker
> tables we are about to open the prospect to add more things into the kernel's
> sections more easily than before.
> 
> > CORE does not really add anything as far as I can see. Other types of .text including
> > ones which are automatically generated by the compiler, for better or worse, are
> > .text.x sections too.  
> 
> Actually, sorry, in this case SECTION_ALL() *was* intended for things that are
> not linker tables or section ranges, instead this was for globs that want to
> use the new section macro names, so we only use this for:
> *(SECTION_ALL(SECTION_RODATA)) at this time.  It would seem we just did not
> have .text.* and friends (other section names documented here). So this is
> more of a reaction to provide a way to use a glob for section names if they
> have a macro name.
> 
> The idea was to add helpers to do the globbing more easily.
> 
> The glob for sections now documented   is SECTION_ALL()
> The glob that is range specific        is SECTION_RNG_ALL()
> The glob that is linker table specific is SECTION_TBL_ALL()

I still don't see this is better than

.text*
.text.*
.text.range.*
.text.table.*
etc.



> 
> The only one needing SECTION_ALL() it turns out was .rodata:
> 
> -               *(.rodata) *(.rodata.*)                                 \
> +               *(SECTION_RODATA) *(SECTION_ALL(SECTION_RODATA))        \
> 
> > I would like to see more standardisation of naming convention -- some sections start
> > with .., some start with no dots, some use . to separate logical "subsections", others
> > use underscores or something else.  
> 
> Agreed... Actually while at it -- anyone happen to know why the two dot thing
> started creeping up?

I'm not sure, but I suspect it may have been due to . not being a valid C
symbol name. I'm not saying it's always the wrong thing to do, but I think
copy&paste and lack of documentation has left the naming conventions in
need of some love.

The section names themselves of course can and should have some greppable
distinguishing conventions -- we don't need macro name for that.


> > I just don't see it would be a problem to simply use the raw names and linker
> > wildcards for it.  
> 
> A concern here is more abuse over this if we now expose APIs to users to
> more easily customize sections. So let's review what the chances are.
> 
> $ git grep DEFINE_SECTION_RANGE| egrep -v "tools|include|Document"
> kernel/kprobes.c:DEFINE_SECTION_RANGE(kprobes, SECTION_TEXT);
> 
> These require the actual desired section specified. Do we want
> to just hide that ? Or are we OK in assuming users willing to use
> proper names here?

For me, DEFINE_SECTION_RANGE(kprobes, .text) would be fine.


> > BTW, I'm not trying to bikeshed :) This doesn't affect the value of your
> > patch at all, it was just an offhand thing I saw.  
> 
> Just saying, if you say its ugly please help me with a different name then.

Sure, but point taken it's more productive to discuss fundamentals
first. Let's consider exact details afterward.


> > It's fine, I don't mind too much. I think asm-generic/asm.h should be
> > fine for generic asm'isms though. Or assembler.h to match compiler.h.  
> 
> I'd like address this in asm.h but I would hope we can do this as a secondary
> step, given the length of this patch set already. Thoughts ?

It's not a big deal, so whatever suits you. Some of the bugfixes and
cleanups could be pushed through various arch and other maintainers
first too, which would make the core series look more managable and
touch fewer parts.


> > Well but your macros are not linker sections. They are "Linux sections", which
> > appear to give you a start and end symbol name, but does not direct the linker
> > to create a specific output section.  
> 
> You're right the above can use some love to help explain this better.
> 
> How about:
> 
> At the top just use "Linux sections helpers"
> 
> Then:
> 
> /**
>  * DOC: Introduction
>  *
>  * We document below a dedicated set of helpers used in Linux to make sections
>  * defined in the Linux linker script accessible in C code in a generic form and 
>  * and provide certain attributes about them.
>  */
> 
> > I just can't work out what exactly is a
> > "custom Linux section", and what DECLARE_LINUX_SECTION(), for example, actaully
> > gives you.  
> 
> Its a way to replace the:
> 
> extern char foo[], foo__end[];
> 
> So this provides a generalized form to use declarations used in C code to make
> the linker script start and end symbols from esctions accessible in C code. Since
> DEFINE_SECTION_RANGE() and DEFINE_LINKTABLE() macros use this, then the
> DECLARE_LINUX_SECTION() is only needed if you need access to these symbols in C
> code outside of the one that is defining and mainly in charge of managing the
> section. We provide DECLARE_*() helpers for section ranges and linker tables
> though so those can be used instead to help annotate the type of a custom
> section they are.

Oh, that makes more sense. The SECTION stuff and custom sections was
confusing me. I would prefer just to drop all the LINUX_SECTION naming
and make it match the functionality you're using. For example:

+DEFINE_LINKTABLE(struct jump_entry, __jump_table);
+
 /* mutex to protect coming/going of the the jump_label table */
 static DEFINE_MUTEX(jump_label_mutex);
 
@@ -274,8 +277,6 @@ static void __jump_label_update(struct static_key *key,
 
 void __init jump_label_init(void)
 {
-	struct jump_entry *iter_start = __start___jump_table;
-	struct jump_entry *iter_stop = __stop___jump_table;
 	struct static_key *key = NULL;
 	struct jump_entry *iter;
 
@@ -292,9 +293,10 @@ void __init jump_label_init(void)
 		return;
 
 	jump_label_lock();
-	jump_label_sort_entries(iter_start, iter_stop);
+	jump_label_sort_entries(LINUX_SECTION_START(__jump_table),
+				LINUX_SECTION_END(__jump_table));

Now I think this is a fine abstraction to have. I think it would look
even cleaner if you had:

LINKTABLE_START(__jump_table)
LINKTABLE_END(__jump_table)

Then do we need to even have the LINUX_SECTION middle man at all?

Thanks,
Nick
