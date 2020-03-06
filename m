Return-Path: <SRS0=ZCnS=4X=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:1470 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgCFTCL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Mar 2020 14:02:11 -0500
Subject: Re: [RFC PATCH v9 05/27] x86/cet/shstk: Add Kconfig option for
 user-mode Shadow Stack protection
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-6-yu-cheng.yu@intel.com>
 <d4dabb84-5636-2657-c45e-795f3f2dcbbc@intel.com>
 <070d9d78981f0aad2baf740233e8dfc32ecd29d7.camel@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <d4e09cf8-4237-d168-7e46-929f2b536332@intel.com>
Date: Fri, 6 Mar 2020 11:02:08 -0800
MIME-Version: 1.0
In-Reply-To: <070d9d78981f0aad2baf740233e8dfc32ecd29d7.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Message-ID: <20200306190208.lGgL12cEydKSzJJtkVLWIUPU_L10u65QuvpnIh4hzYE@z>

On 3/6/20 10:37 AM, Yu-cheng Yu wrote:
> We used to do this for CET instructions, but after adding kernel-mode
> instructions and inserting ENDBR's, the code becomes cluttered.  I also
> found an earlier discussion on the ENDBR:
> 
> https://lore.kernel.org/lkml/CALCETrVRH8LeYoo7V1VBPqg4WS0Enxtizt=T7dPvgoeWfJrdzA@mail.gmail.com/
> 
> It makes sense to let the user know early on that the system cannot support
> CET and cannot build a CET-enabled kernel.
> 
> One thing we can do is to disable CET in Kconfig and not in kernel
> build, which I will do in the next version.

I'll go on the record and say I think we should allow building
CET-enabled kernels on old toolchains.  We need it for build test
coverage.  We can spit out a warning, but we need to allow building it.

Andy L, do you have any heartburn with that?
