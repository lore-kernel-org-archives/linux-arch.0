From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v10 26/26] x86/cet/shstk: Add arch_prctl functions for
 shadow stack
Date: Fri, 22 May 2020 10:17:43 -0700
Message-ID: <c9c9314374c7db0bf9b6e39670855afe5b0d4014.camel@intel.com>
References: <20200429220732.31602-1-yu-cheng.yu@intel.com>
         <20200429220732.31602-27-yu-cheng.yu@intel.com>
         <202005211528.A12B4AD@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <202005211528.A12B4AD@keescook>
Sender: linux-doc-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel
List-Id: linux-arch.vger.kernel.org

On Thu, 2020-05-21 at 15:42 -0700, Kees Cook wrote:
> On Wed, Apr 29, 2020 at 03:07:32PM -0700, Yu-cheng Yu wrote:
[...]
> > +
> > +int prctl_cet(int option, u64 arg2)
> > +{
> > +	struct cet_status *cet;
> > +
> > +	if (!IS_ENABLED(CONFIG_X86_INTEL_CET))
> > +		return -EINVAL;
> 
> Using -EINVAL here means userspace can't tell the difference between an
> old kernel and a kernel not built with CONFIG_X86_INTEL_CET. Perhaps
> -ENOTSUPP?

Looked into this.  The kernel and GLIBC are not in sync.  So maybe we still use
EINVAL here?

Yu-cheng



In kernel:
----------

#define EOPNOTSUPP	95
#define ENOTSUPP 	524

In GLIBC:
---------

printf("ENOTSUP=%d\n", ENOTSUP);
printf("EOPNOTSUPP=%d\n", EOPNOTSUPP);
printf("%s=524\n", strerror(524));
 
ENOTSUP=95
EOPNOTSUPP=95
Unknown error 524=524
