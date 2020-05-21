Return-Path: <SRS0=Ax4L=7D=kvack.org=owner-linux-mm@kernel.org>
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 4/5] selftest/x86: Fix sysret_rip with ENDBR
In-Reply-To: <20200521211720.20236-5-yu-cheng.yu@intel.com>
References: <20200521211720.20236-1-yu-cheng.yu@intel.com> <20200521211720.20236-5-yu-cheng.yu@intel.com>
Date: Thu, 21 May 2020 23:34:27 +0200
Message-ID: <878shlt1jw.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linux-mm@kvack.org
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, Weijiang Yang <weijiang.yang@intel.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200521213427.O2VsC5zS5nX-P6gs6ZB0pO76pSFmC0ljMJHyuvIMHH4@z>

Yu-cheng Yu <yu-cheng.yu@intel.com> writes:

> Insert endbr64 to assembly code of sysret_rip.

This changelog explains what the patch does, but not the WHY. It also
lacks any information why this is harmless for !CET enabled systems.

> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---

Please consult Dave Hansen about the void between your Signed-off-by
and the '---' line.

Thanks,

        tglx
