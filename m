From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [RFC PATCH 2/5] selftest/x86: Enable CET for selftests/x86
Date: Thu, 21 May 2020 15:58:11 -0700
Message-ID: <b97aeac13967cfad5d6a962d29a87215c77996e8.camel@intel.com>
References: <20200521211720.20236-1-yu-cheng.yu@intel.com>
         <20200521211720.20236-3-yu-cheng.yu@intel.com>
         <202005211544.26CD475832@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <202005211544.26CD475832@keescook>
Sender: linux-doc-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel
List-Id: linux-arch.vger.kernel.org

On Thu, 2020-05-21 at 15:44 -0700, Kees Cook wrote:
> On Thu, May 21, 2020 at 02:17:17PM -0700, Yu-cheng Yu wrote:
> > To build CET-enabled applications, GCC needs to support '-fcf-protection'.
> > Update x86 selftest makefile to detect and enable CET for x86 selftest
> > applications.
> > 
> > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!  I will fix issues you pointed out in the series.

Yu-cheng
