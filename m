From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [RFC PATCH v9 18/27] x86/cet/shstk: Introduce WRUSS instruction
Date: Thu, 05 Mar 2020 10:39:08 -0800
Message-ID: <5dcc9da2caff92a9af16846cbe1f168f61368c51.camel@intel.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
         <20200205181935.3712-19-yu-cheng.yu@intel.com>
         <202002251309.E238DFEEB4@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <202002251309.E238DFEEB4@keescook>
Sender: linux-doc-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel
List-Id: linux-arch.vger.kernel.org

On Tue, 2020-02-25 at 13:10 -0800, Kees Cook wrote:
> On Wed, Feb 05, 2020 at 10:19:26AM -0800, Yu-cheng Yu wrote:
> > WRUSS is a new kernel-mode instruction but writes directly to user Shadow
> > Stack (SHSTK) memory.  This is used to construct a return address on SHSTK
> > for the signal handler.
> > 
> > This instruction can fault if the user SHSTK is not valid SHSTK memory.
> > In that case, the kernel does a fixup.
> 
> Since these functions aren't used in this patch, should this get merged
> with patch 19?

Yes, I can do that.

Yu-cheng
