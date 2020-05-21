From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 4/5] selftest/x86: Fix sysret_rip with ENDBR
Date: Thu, 21 May 2020 23:34:27 +0200
Message-ID: <878shlt1jw.fsf@nanos.tec.linutronix.de>
References: <20200521211720.20236-1-yu-cheng.yu@intel.com> <20200521211720.20236-5-yu-cheng.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20200521211720.20236-5-yu-cheng.yu@intel.com>
Sender: linux-doc-owner@vger.kernel.org
To: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
List-Id: linux-arch.vger.kernel.org

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
