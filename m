From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [RFC v2 2/7] tables.h: add linker table support
Date: Wed, 24 Feb 2016 01:54:58 +0100
Message-ID: <20160224005458.GK25240@wotan.suse.de>
References: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
 <1455889559-9428-3-git-send-email-mcgrof@kernel.org>
 <56C77A53.6060708@zytor.com>
 <20160219214856.GX25240@wotan.suse.de>
 <CAB=NE6W8H=Sc+1gCBfua8A=qW09CrJxTpCm4Ag_qDrj_Lr6LKw@mail.gmail.com>
 <56CCE9B6.4080000@zytor.com>
 <CAB=NE6WtZtyy3xhG170id3pVGfVpgWdYhODxEi+gYRNor-GSzw@mail.gmail.com>
 <56CCF41F.8080507@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45673 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751949AbcBXAzF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Feb 2016 19:55:05 -0500
Content-Disposition: inline
In-Reply-To: <56CCF41F.8080507@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Rusty Russell <rusty@rustcorp.com.au>, David Vrabel <david.vrabel@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Michael Brown <mcb30@ipxe.org>, Juergen Gross <jgross@suse.com>, Ming Lei <ming.lei@canonical.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, jbaron@akamai.com, ananth@in.ibm.com, anil.s.keshavamurthy@intel.com, David Miller <davem@davemloft.net>, Masami Hiramatsu <masami.hiram>

On Tue, Feb 23, 2016 at 04:06:55PM -0800, H. Peter Anvin wrote:
> On 02/23/2016 03:36 PM, Luis R. Rodriguez wrote:
> > 
> >> 4. the only useful operator on a range is "is address X inside this
> >>    range"; this operator is likely *not* useful for a table, since
                                                     ^^^^^^^^^^^^
> >>    if you have to ever invoke it you are probably doing something very
> >>    wrong.
> > 
> > kprobe uses it :P
> > 
> 
> Could you explain how?

Sorry I misread this as "unless you are a table", kprobes has two
ranges, one is a table (blacklist) and the other just a range
(for kprobes); only kprobes uses "address inside this range",
as reflected below. So I agree with you.

index d10ab6b9b5e0..d816c659f358 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1328,8 +1328,7 @@ out:
 bool __weak arch_within_kprobe_blacklist(unsigned long addr)
 {
        /* The __kprobes marked functions and entry code must not be probed */
-       return addr >= (unsigned long)__kprobes_text_start &&
-              addr < (unsigned long)__kprobes_text_end;
+       return LINKTABLE_ADDR_WITHIN(kprobes, addr);
 }
 
 bool within_kprobe_blacklist(unsigned long addr)
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index d10ab6b9b5e0..d816c659f358 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1328,8 +1328,7 @@ out:
 bool __weak arch_within_kprobe_blacklist(unsigned long addr)
 {
        /* The __kprobes marked functions and entry code must not be probed */
-       return addr >= (unsigned long)__kprobes_text_start &&
-              addr < (unsigned long)__kprobes_text_end;
+       return LINKTABLE_ADDR_WITHIN(kprobes, addr);
 }
 
What about rebranding general section primitives under section.h

#define DECLARE_SECTION_TEXT_TYPE(type, name)                              \       
         extern const type name[], name##__end[];

#define DECLARE_SECTION_TEXT(name)                              \       
	DECLARE_SECTION_TEXT_TYPE(char, name)

Then tables.h would use the TYPE version:

#define DECLARE_LINKTABLE_TEXT(type, name)                              \       
         DECLARE_SECTION_TEXT_TYPE(type, name)

Since I've been making _TEXT the implicit type for section names(SECTION_INIT
is .init.text) the above could just be DECLARE_SECTION_TYPE() and DECLARE_SECTION()
for text if we prefer.

  Luis
