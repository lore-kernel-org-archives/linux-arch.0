Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59232 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729455AbfFRQFt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 Jun 2019 12:05:49 -0400
From: Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH v7 22/27] binfmt_elf: Extract .note.gnu.property from an ELF file
References: <87lfy9cq04.fsf@oldenburg2.str.redhat.com>
        <20190611114109.GN28398@e103592.cambridge.arm.com>
        <031bc55d8dcdcf4f031e6ff27c33fd52c61d33a5.camel@intel.com>
        <20190612093238.GQ28398@e103592.cambridge.arm.com>
        <87imt4jwpt.fsf@oldenburg2.str.redhat.com>
        <alpine.DEB.2.21.1906171418220.1854@nanos.tec.linutronix.de>
        <20190618091248.GB2790@e103592.cambridge.arm.com>
        <20190618124122.GH3419@hirez.programming.kicks-ass.net>
        <87ef3r9i2j.fsf@oldenburg2.str.redhat.com>
        <20190618125512.GJ3419@hirez.programming.kicks-ass.net>
        <20190618133223.GD2790@e103592.cambridge.arm.com>
        <d54fe81be77b9edd8578a6d208c72cd7c0b8c1dd.camel@intel.com>
        <87pnna7v1d.fsf@oldenburg2.str.redhat.com>
        <1ca57aaae8a2121731f2dcb1a137b92eed39a0d2.camel@intel.com>
Date: Tue, 18 Jun 2019 18:05:24 +0200
In-Reply-To: <1ca57aaae8a2121731f2dcb1a137b92eed39a0d2.camel@intel.com>
        (Yu-cheng Yu's message of "Tue, 18 Jun 2019 08:53:29 -0700")
Message-ID: <87blyu7ubf.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Dave Martin <Dave.Martin@arm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Message-ID: <20190618160524.6h7mnG_3DJwAU_mXFp3jqekxKALChNUO_bONnl1vF1Y@z>

* Yu-cheng Yu:

>> I assumed that it would also parse the main executable and make
>> adjustments based on that.
>
> Yes, Linux also looks at the main executable's header, but not its
> NT_GNU_PROPERTY_TYPE_0 if there is a loader.
>
>> 
>> ld.so can certainly provide whatever the kernel needs.  We need to tweak
>> the existing loader anyway.
>> 
>> No valid statically-linked binaries exist today, so this is not a
>> consideration at this point.
>
> So from kernel, we look at only PT_GNU_PROPERTY?

If you don't parse notes/segments in the executable for CET, then yes.
We can put PT_GNU_PROPERTY into the loader.

Thanks,
Florian
