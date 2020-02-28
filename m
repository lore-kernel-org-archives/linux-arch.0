From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [RFC PATCH v9 01/27] Documentation/x86: Add CET description
Date: Fri, 28 Feb 2020 07:55:33 -0800
Message-ID: <e35cc25c4ba1dcb4154276b1e2731891a3c600ec.camel@intel.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
         <20200205181935.3712-2-yu-cheng.yu@intel.com>
         <202002251159.939AA6A@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <202002251159.939AA6A@keescook>
Sender: linux-doc-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel
List-Id: linux-arch.vger.kernel.org

On Tue, 2020-02-25 at 12:02 -0800, Kees Cook wrote:
> On Wed, Feb 05, 2020 at 10:19:09AM -0800, Yu-cheng Yu wrote:
> > Explain no_cet_shstk/no_cet_ibt kernel parameters, and introduce a new
> > document on Control-flow Enforcement Technology (CET).
> > 
> > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> I'm not a huge fan of the boot param names, but I can't suggest anything
> better. ;) I love the extensive docs!
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks for reviewing!

Yu-cheng
