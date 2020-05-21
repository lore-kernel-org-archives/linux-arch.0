From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [RFC PATCH 4/5] selftest/x86: Fix sysret_rip with ENDBR
Date: Thu, 21 May 2020 15:59:23 -0700
Message-ID: <35ce10628df75494569e5cf5bb6a3c537ff30cf2.camel@intel.com>
References: <20200521211720.20236-1-yu-cheng.yu@intel.com>
         <20200521211720.20236-5-yu-cheng.yu@intel.com>
         <878shlt1jw.fsf@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <878shlt1jw.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg
List-Id: linux-arch.vger.kernel.org

On Thu, 2020-05-21 at 23:34 +0200, Thomas Gleixner wrote:
> Yu-cheng Yu <yu-cheng.yu@intel.com> writes:
> 
> > Insert endbr64 to assembly code of sysret_rip.
> 
> This changelog explains what the patch does, but not the WHY. It also
> lacks any information why this is harmless for !CET enabled systems.
> 
> > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> > ---
> 
> Please consult Dave Hansen about the void between your Signed-off-by
> and the '---' line.
> 
> Thanks,
> 
>         tglx

Thanks!  I will work on it.

Yu-cheng
