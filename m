Return-Path: <SRS0=cy2k=32=vger.kernel.org=linux-doc-owner@kernel.org>
Message-ID: <b0e7e487d1bf92bf19df2ecf199b90c76d9097dd.camel@intel.com>
Subject: Re: [RFC PATCH v9 01/27] Documentation/x86: Add CET description
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date: Thu, 06 Feb 2020 12:17:30 -0800
In-Reply-To: <af5ee976-3b57-4afe-6304-fcab8de45c77@infradead.org>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
         <20200205181935.3712-2-yu-cheng.yu@intel.com>
         <af5ee976-3b57-4afe-6304-fcab8de45c77@infradead.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-doc-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200206201730.RAg0MDK4ACcj5iXYjkp8knX4dQcp-OhpVKxl_cYRrUE@z>

On Wed, 2020-02-05 at 16:16 -0800, Randy Dunlap wrote:
> Hi,
> 
> I have a few comments and a question (please see inline below).
> 
> 
> On 2/5/20 10:19 AM, Yu-cheng Yu wrote:
[...]
> > +arch_prctl(ARCH_X86_CET_LOCK)
> > +    Lock in CET feature.
> 
> which feature?

Both SHSTK and IBT are locked.  They cannot be turned off afterwards.

I will check things you pointed out.

Thanks,
Yu-cheng
