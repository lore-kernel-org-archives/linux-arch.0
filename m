Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33406 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751175AbcHTE5b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 Aug 2016 00:57:31 -0400
Received: by mail-pf0-f194.google.com with SMTP id i6so2455625pfe.0
        for <linux-arch@vger.kernel.org>; Fri, 19 Aug 2016 21:57:30 -0700 (PDT)
Subject: Re: [PATCH v1 0/7] tools: add linker table userspace sandbox
References: <1471642454-5679-1-git-send-email-mcgrof@kernel.org>
 <1471642875-5957-1-git-send-email-mcgrof@kernel.org>
From: Rob Landley <rob@landley.net>
Message-ID: <ef5f6b3f-1b00-d33f-4ce1-81e03f4f2f10@landley.net>
Date: Fri, 19 Aug 2016 23:57:18 -0500
MIME-Version: 1.0
In-Reply-To: <1471642875-5957-1-git-send-email-mcgrof@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mcgrof@kernel.org, acme@redhat.com, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, jpoimboe@redhat.com, bp@alien8.de, linux@arm.linux.org.uk, mhiramat@kernel.org, masami.hiramatsu.pt@hitachi.com, jbaron@akamai.com, heiko.carstens@de.ibm.com, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, realmz6@gmail.com
Cc: x86@kernel.org, luto@amacapital.net, keescook@chromium.org, torvalds@linux-foundation.org, gregkh@linuxfoundation.org, rusty@rustcorp.com.au, gnomes@lxorguk.ukuu.org.uk, alan@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, ming.lei@canonical.com, linux-arch@vger.kernel.org, benh@kernel.crashing.org, ananth@in.ibm.com, pebolle@tiscali.nl, fontana@sharpeleven.org, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, andrew.cooper3@citrix.com, andriy.shevchenko@linux.intel.com, paul.gortmaker@windriver.com, xen-devel@lists.xensource.com, ak@linux.intel.com, pali.rohar@gmail.com, dvhart@infradead.org, platform-driver-x86@vger.kernel.org, mmarek@suse.com, linux@rasmusvillemoes.dk, jkosina@suse.cz, korea.drzix@gmail.com, linux-kbuild@vger.kernel.org, tony.luck@intel.com, akpm@linux-foundation.org, linux-ia64@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, rostedt@goodmis.org, jani.nikula@intel.com, mchehab@osg.samsung.com, markus.heiser@darmarit.de, jolsa@kernel.org, msalter@redhat.com, chris@zankel.net, jcmvbkbc@gmail.com, linux-xtensa@linux-xtensa.org, paulus@samba.org, mpe@ellerman.id.au, James.Bottomley@HansenPartnership.com
Message-ID: <20160820045718.-Ng63NBtS8O1XlkMYJ9E_q9em8RQlUSF3IkmijmJJbE@z>

On 08/19/2016 04:41 PM, mcgrof@kernel.org wrote:
> Please let me know if there are any issue or questions.

Only that this has been the majority of the traffic on the linux-sh
mailing list for over a month and I'm still not sure why anyone should care.

I have no idea what problem it solves, despite reading a couple dozen
messages in the thread, and the most recent two 0/x intro messages. Its
purpose seems to be ensuring that lld.llvm.org has more work to do if it
ever wants to build the kernel without binutils?

I also am not certain why every revision of it is cc'd to linux-sh. Is
it generic linker infrastructure change, or is it something that affects
this architecture specifically? As far as I can tell nothing in this
most recent 7-patch series touches arch/sh at all, you just cc'd our
list because you think the work you're doing is _important_, not that
it's specifically relevant to us.

Rob
