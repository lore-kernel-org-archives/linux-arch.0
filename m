Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:48236 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRM5A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Jun 2019 08:57:00 -0400
Date: Tue, 18 Jun 2019 14:55:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v7 22/27] binfmt_elf: Extract .note.gnu.property from an
 ELF file
Message-ID: <20190618125512.GJ3419@hirez.programming.kicks-ass.net>
References: <94b9c55b3b874825fda485af40ab2a6bc3dad171.camel@intel.com>
 <87lfy9cq04.fsf@oldenburg2.str.redhat.com>
 <20190611114109.GN28398@e103592.cambridge.arm.com>
 <031bc55d8dcdcf4f031e6ff27c33fd52c61d33a5.camel@intel.com>
 <20190612093238.GQ28398@e103592.cambridge.arm.com>
 <87imt4jwpt.fsf@oldenburg2.str.redhat.com>
 <alpine.DEB.2.21.1906171418220.1854@nanos.tec.linutronix.de>
 <20190618091248.GB2790@e103592.cambridge.arm.com>
 <20190618124122.GH3419@hirez.programming.kicks-ass.net>
 <87ef3r9i2j.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ef3r9i2j.fsf@oldenburg2.str.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: Dave Martin <Dave.Martin@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Message-ID: <20190618125512.UTFUEzKj4yQyUg1FN5U8g64kAGoHgI21UTaHSun1Byk@z>

On Tue, Jun 18, 2019 at 02:47:00PM +0200, Florian Weimer wrote:
> * Peter Zijlstra:
> 
> > I'm not sure I read Thomas' comment like that. In my reading keeping the
> > PT_NOTE fallback is exactly one of those 'fly workarounds'. By not
> > supporting PT_NOTE only the 'fine' people already shit^Hpping this out
> > of tree are affected, and we don't have to care about them at all.
> 
> Just to be clear here: There was an ABI document that required PT_NOTE
> parsing.

URGH.

> The Linux kernel does *not* define the x86-64 ABI, it only
> implements it.  The authoritative source should be the ABI document.
>
> In this particularly case, so far anyone implementing this ABI extension
> tried to provide value by changing it, sometimes successfully.  Which
> makes me wonder why we even bother to mainatain ABI documentation.  The
> kernel is just very late to the party.

How can the kernel be late to the party if all of this is spinning
wheels without kernel support?
