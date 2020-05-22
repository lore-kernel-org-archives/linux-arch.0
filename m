Return-Path: <SRS0=yLSb=7E=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:13909 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbgEVSIx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 May 2020 14:08:53 -0400
Message-ID: <02d825344b39891cf9c084edce44db168cce45fe.camel@intel.com>
Subject: Re: [RFC PATCH 5/5] selftest/x86: Add CET quick test
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date: Fri, 22 May 2020 11:07:49 -0700
In-Reply-To: <202005221034.59F5DF75@keescook>
References: <20200521211720.20236-1-yu-cheng.yu@intel.com>
         <20200521211720.20236-6-yu-cheng.yu@intel.com>
         <20200522092848.GJ325280@hirez.programming.kicks-ass.net>
         <202005221020.B578B8C6@keescook>
         <20200522172711.GA317569@hirez.programming.kicks-ass.net>
         <202005221034.59F5DF75@keescook>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, Weijiang Yang <weijiang.yang@intel.com>
Message-ID: <20200522180749.yYR8OhYkxZF1SxcqMSU92fwcFXZC3i0H0SaAqLmc7zs@z>

On Fri, 2020-05-22 at 10:36 -0700, Kees Cook wrote:
> On Fri, May 22, 2020 at 07:27:11PM +0200, Peter Zijlstra wrote:
> > On Fri, May 22, 2020 at 10:22:51AM -0700, Kees Cook wrote:
> > 
> > > But yes, I think getting a copy of asm.h would be nice here. I don't
> > > think the WRITE_ONCE() is needed in this particular case. Hmm.
> > 
> > Paranoia on my end because I had no clue wth he wanted with his -O0
> > magic gunk.
> 
> Heh, yes, which is why I asked for many more comments. ;) I *think* it
> was entirely to control the stack (and ssp) behavior (i.e. don't inline,
> don't elide unused stack variables, etc).

Yes, that was the reason.

Yu-cheng
