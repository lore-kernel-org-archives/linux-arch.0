From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v10 00/26] Control-flow Enforcement: Shadow Stack
Date: Thu, 21 May 2020 10:15:56 -0500
Message-ID: <20200521151556.pojijpmuc2rdd7ko@treble>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200429220732.31602-1-yu-cheng.yu@intel.com>
Sender: linux-doc-owner@vger.kernel.org
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Apr 29, 2020 at 03:07:06PM -0700, Yu-cheng Yu wrote:
> Control-flow Enforcement (CET) is a new Intel processor feature that blocks
> return/jump-oriented programming attacks.  Details can be found in "Intel
> 64 and IA-32 Architectures Software Developer's Manual" [1].
> 
> This series depends on the XSAVES supervisor state series that was split
> out and submitted earlier [2].
> 
> I have gone through previous comments, and hope all concerns have been
> resolved now.  Please inform me if anything is overlooked.
> 
> Changes in v10:

Hi Yu-cheng,

Do you have a git branch with the latest Shadow Stack and IBT branches
applied?  I tried to apply IBT v9 on top of this, but I guess the SS
code has changed since then and it didn't apply cleanly.

-- 
Josh
