Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54006 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752303AbdARLdl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 18 Jan 2017 06:33:41 -0500
Date: Wed, 18 Jan 2017 12:29:51 +0100
From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v7 02/14] xtensa: skip adding literal when SORT() is used
Message-ID: <20170118112951.62drjsk264rhe5lj@pd.tnic>
References: <20170109145833.11502-1-mcgrof@kernel.org>
 <20170115211057.17167-1-mcgrof@kernel.org>
 <20170115211057.17167-3-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170115211057.17167-3-mcgrof@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: hpa@zytor.com, acme@redhat.com, tglx@linutronix.de, mingo@redhat.com, jpoimboe@redhat.com, npiggin@gmail.com, mhiramat@kernel.org, masami.hiramatsu.pt@hitachi.com, jbaron@akamai.com, heiko.carstens@de.ibm.com, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, realmz6@gmail.com, dalias@libc.org, linux@arm.linux.org.uk, x86@kernel.org, luto@amacapital.net, keescook@chromium.org, linux@roeck-us.net, torvalds@linux-foundation.org, gregkh@linuxfoundation.org, rusty@rustcorp.com.au, gnomes@lxorguk.ukuu.org.uk, alan@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, ming.lei@canonical.com, linux-arch@vger.kernel.org, benh@kernel.crashing.org, pebolle@tiscali.nl, fontana@sharpeleven.org, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, andrew.cooper3@citrix.com, andriy.shevchenko@linux.intel.com, paul.gortmaker@windriver.com, xen-devel@lists.xensource.com, ak@linux.intel.com, pali.rohar@gmail.com, dvhart@infradead.org, platform-driver-x86@vger.kernel.org, mmarek@suse.com, linux@rasmusvillemoes.dk, jkosina@suse.cz, korea.drzix@gmail.com, linux-kbuild@vger.kernel.org, tony.luck@intel.com, akpm@linux-foundation.org, linux-ia64@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, rostedt@goodmis.org, jani.nikula@intel.com, mchehab@osg.samsung.com, markus.heiser@darmarit.de, jolsa@kernel.org, msalter@redhat.com, chris@zankel.net, jcmvbkbc@gmail.com, linux-xtensa@linux-xtensa.org, adrian.hunter@intel.com, dsahern@gmail.com, namhyung@kernel.org, wangnan0@huawei.com, dmitry.torokhov@gmail.com, joro@8bytes.org, paulus@samba.org, mpe@ellerman.id.au, James.Bottomley@HansenPartnership.com
Message-ID: <20170118112951.jDUnxel6XmL3mlytR1o7EWOzQW2ODt1D2bQSitfUTe4@z>

On Sun, Jan 15, 2017 at 01:10:45PM -0800, Luis R. Rodriguez wrote:
> When SORT(foo.*) is used the current sed replacements add
> SORT(foo.literal foo.*), this breaks linking. Avoid adding
> literals for SORT globs, if needed, these need to be added
> manually.

Please rewrite this commit message by breaking into separate sentences,
adding punctuation, etc.

Also, "the current sed replacements add" sounds really strange and makes
me wonder what do you mean. What are "sed replacements"? I think you
mean the "sed regex adds" from looking at the diff.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
