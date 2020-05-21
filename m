Return-Path: <SRS0=V28G=7D=vger.kernel.org=linux-doc-owner@kernel.org>
Message-ID: <a1e7c71c72de517a288e6273ba0c18dac2e937bc.camel@intel.com>
Subject: Re: [PATCH v10 00/26] Control-flow Enforcement: Shadow Stack
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date: Thu, 21 May 2020 08:57:57 -0700
In-Reply-To: <20200521151556.pojijpmuc2rdd7ko@treble>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
         <20200521151556.pojijpmuc2rdd7ko@treble>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-doc-owner@vger.kernel.org
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, Weijiang Yang <weijiang.yang@intel.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200521155757.0dRJpyPq37zuC_FLDAaxVLeZnk1gIZUf_fVQFXcBq2I@z>

On Thu, 2020-05-21 at 10:15 -0500, Josh Poimboeuf wrote:
> On Wed, Apr 29, 2020 at 03:07:06PM -0700, Yu-cheng Yu wrote:
> > Control-flow Enforcement (CET) is a new Intel processor feature that blocks
> > return/jump-oriented programming attacks.  Details can be found in "Intel
> > 64 and IA-32 Architectures Software Developer's Manual" [1].
> > 
> > This series depends on the XSAVES supervisor state series that was split
> > out and submitted earlier [2].
> > 
> > I have gone through previous comments, and hope all concerns have been
> > resolved now.  Please inform me if anything is overlooked.
> > 
> > Changes in v10:
> 
> Hi Yu-cheng,
> 
> Do you have a git branch with the latest Shadow Stack and IBT branches
> applied?  I tried to apply IBT v9 on top of this, but I guess the SS
> code has changed since then and it didn't apply cleanly.

It is here:

https://github.com/yyu168/linux_cet/commits/cet

Yu-cheng
