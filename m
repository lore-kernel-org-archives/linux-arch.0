From: Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH v9 00/27] Control-flow Enforcement: Shadow Stack
Date: Tue, 25 Feb 2020 13:31:27 -0800
Message-ID: <202002251330.7CD5EEFA2@keescook>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200205181935.3712-1-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel
List-Id: linux-arch.vger.kernel.org

On Wed, Feb 05, 2020 at 10:19:08AM -0800, Yu-cheng Yu wrote:
> Control-flow Enforcement (CET) is a new Intel processor feature that blocks
> return/jump-oriented programming attacks.  Details can be found in "Intel
> 64 and IA-32 Architectures Software Developer's Manual" [1].

At v9, this probably isn't RFC any more. :)

As mentioned in another patch, I'd really like to see some self tests
for this feature. It's relatively complex...

-- 
Kees Cook
