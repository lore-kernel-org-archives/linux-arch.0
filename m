Return-Path: <SRS0=yLSb=7E=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730600AbgEVRgD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 May 2020 13:36:03 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC37C08C5C0
        for <linux-arch@vger.kernel.org>; Fri, 22 May 2020 10:36:03 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x18so3546538pll.6
        for <linux-arch@vger.kernel.org>; Fri, 22 May 2020 10:36:03 -0700 (PDT)
Date: Fri, 22 May 2020 10:36:00 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH 5/5] selftest/x86: Add CET quick test
Message-ID: <202005221034.59F5DF75@keescook>
References: <20200521211720.20236-1-yu-cheng.yu@intel.com>
 <20200521211720.20236-6-yu-cheng.yu@intel.com>
 <20200522092848.GJ325280@hirez.programming.kicks-ass.net>
 <202005221020.B578B8C6@keescook>
 <20200522172711.GA317569@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522172711.GA317569@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, Weijiang Yang <weijiang.yang@intel.com>
Message-ID: <20200522173600.-h08dy8fPxYpuvW5xMPhEuLwjqwP46eJKgt7f92nvAY@z>

On Fri, May 22, 2020 at 07:27:11PM +0200, Peter Zijlstra wrote:
> On Fri, May 22, 2020 at 10:22:51AM -0700, Kees Cook wrote:
> 
> > But yes, I think getting a copy of asm.h would be nice here. I don't
> > think the WRITE_ONCE() is needed in this particular case. Hmm.
> 
> Paranoia on my end because I had no clue wth he wanted with his -O0
> magic gunk.

Heh, yes, which is why I asked for many more comments. ;) I *think* it
was entirely to control the stack (and ssp) behavior (i.e. don't inline,
don't elide unused stack variables, etc).

-- 
Kees Cook
