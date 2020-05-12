Return-Path: <SRS0=WvJP=62=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:19892 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726031AbgELXU3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 May 2020 19:20:29 -0400
Message-ID: <5cc163ff9058d1b27778e5f0a016c88a3b1a1598.camel@intel.com>
Subject: Re: [PATCH v10 01/26] Documentation/x86: Add CET description
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date: Tue, 12 May 2020 16:20:32 -0700
In-Reply-To: <dd5b9bab31ecf247a0b4890e22bfbb486ff52001.camel@intel.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
         <20200429220732.31602-2-yu-cheng.yu@intel.com>
         <b5197a8d-5d8b-e1f7-68d4-58d80261904c@intel.com>
         <dd5b9bab31ecf247a0b4890e22bfbb486ff52001.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, Weijiang Yang <weijiang.yang@intel.com>
Message-ID: <20200512232032.6Uc0btw4AOETeQYiBm-ksI-ZUs0adBUrTupsvMPB-is@z>

On Wed, 2020-04-29 at 16:02 -0700, Yu-cheng Yu wrote:
> On Wed, 2020-04-29 at 15:53 -0700, Dave Hansen wrote:
> > On 4/29/20 3:07 PM, Yu-cheng Yu wrote:
> > > +Note:
> > > +  There is no CET-enabling arch_prctl function.  By design, CET is enabled
> > > +  automatically if the binary and the system can support it.
> > 
> > I think Andy and I danced around this last time.  Let me try to say it
> > more explicitly.
> > 
> > I want CET kernel enabling to able to be disconnected from the on-disk
> > binary.  I want a binary compiled with CET to be able to disable it, and
> > I want a binary not compiled with CET to be able to enable it.  I want
> > different threads in a process to be able to each have different CET status.
> 
> The kernel patches we have now can be modified to support this model.  If after
> discussion this is favorable, I will modify code accordingly.

To turn on/off and to lock CET are application-level decisions.  The kernel does
not prevent any of those.  Should there be a need to provide an arch_prctl() to
turn on CET, it can be added without any conflict to this series.

> > Which JITs was this tested with?  I think as a bare minimum we need to
> > know that this design can accommodate _a_ modern JIT.  It would be
> > horrible if the browser javascript engines couldn't use this design, for
> > instance.
> 
> JIT work is still in progress.  When that is available I will test it.

I found CET has been enabled in LLVM JIT, Mesa JIT as well as sljit which is
used by jit.  So the current model works with JIT.

Yu-cheng
