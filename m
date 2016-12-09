From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [RFC, PATCHv1 15/28] x86: detect 5-level paging support
Date: Fri, 9 Dec 2016 18:32:33 +0300
Message-ID: <20161209153233.GA8932@node.shutemov.name>
References: <20161208162150.148763-1-kirill.shutemov@linux.intel.com>
 <20161208162150.148763-17-kirill.shutemov@linux.intel.com>
 <20161208200505.c6xiy56oufg6d24m@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wj0-f193.google.com ([209.85.210.193]:34305 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753971AbcLIPch (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Dec 2016 10:32:37 -0500
Received: by mail-wj0-f193.google.com with SMTP id xy5so2936719wjc.1
        for <linux-arch@vger.kernel.org>; Fri, 09 Dec 2016 07:32:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161208200505.c6xiy56oufg6d24m@pd.tnic>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On Thu, Dec 08, 2016 at 09:05:05PM +0100, Borislav Petkov wrote:
> On Thu, Dec 08, 2016 at 07:21:37PM +0300, Kirill A. Shutemov wrote:
> > 5-level paging support is required from hardware when compiled with
> > CONFIG_X86_5LEVEL=y. We may implement runtime switch support later.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> ...
> 
> > diff --git a/arch/x86/boot/cpuflags.c b/arch/x86/boot/cpuflags.c
> > index 6687ab953257..26e9a287805f 100644
> > --- a/arch/x86/boot/cpuflags.c
> > +++ b/arch/x86/boot/cpuflags.c
> > @@ -80,6 +80,17 @@ static inline void cpuid(u32 id, u32 *a, u32 *b, u32 *c, u32 *d)
> >  	);
> >  }
> >  
> > +static inline void cpuid_count(u32 id, u32 count,
> > +		u32 *a, u32 *b, u32 *c, u32 *d)
> > +{
> > +	asm volatile(".ifnc %%ebx,%3 ; movl  %%ebx,%3 ; .endif	\n\t"
> > +		     "cpuid					\n\t"
> > +		     ".ifnc %%ebx,%3 ; xchgl %%ebx,%3 ; .endif	\n\t"
> > +		    : "=a" (*a), "=c" (*c), "=d" (*d), EBX_REG (*b)
> > +		    : "a" (id), "c" (count)
> > +	);
> > +}
> 
> Pls make those like cpuid() and cpuid_count() in
> arch/x86/include/asm/processor.h, which explicitly assign ecx and then
> call the underlying helper.
> 
> The cpuid() in cpuflags.c doesn't zero ecx which, if we have to be
> pedantic, it should do. It calls CPUID now with the ptr value of its 4th
> on 64-bit and 3rd arg on 32-bit, respectively, IINM.

Something like this?

diff --git a/arch/x86/boot/cpuflags.c b/arch/x86/boot/cpuflags.c
index 6687ab953257..366aad972025 100644
--- a/arch/x86/boot/cpuflags.c
+++ b/arch/x86/boot/cpuflags.c
@@ -70,16 +70,22 @@ int has_eflag(unsigned long mask)
 # define EBX_REG "=b"
 #endif

-static inline void cpuid(u32 id, u32 *a, u32 *b, u32 *c, u32 *d)
+static inline void cpuid_count(u32 id, u32 count,
+               u32 *a, u32 *b, u32 *c, u32 *d)
 {
+       *a = id;
+       *c = count;
+
        asm volatile(".ifnc %%ebx,%3 ; movl  %%ebx,%3 ; .endif  \n\t"
                     "cpuid                                     \n\t"
                     ".ifnc %%ebx,%3 ; xchgl %%ebx,%3 ; .endif  \n\t"
                    : "=a" (*a), "=c" (*c), "=d" (*d), EBX_REG (*b)
-                   : "a" (id)
+                   : "a" (id), "c" (count)
        );
 }

+#define cpuid(id, a, b, c, d) cpuid_count(id, 0, a, b, c, d)
+
 void get_cpuflags(void)
 {
        u32 max_intel_level, max_amd_level;
-- 
 Kirill A. Shutemov
