From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 3/7] seccomp: Allow arch code to provide seccomp_data
Date: Fri, 18 Jul 2014 15:16:37 -0700
Message-ID: <CAGXu5jLsnSujJdZmA=nzHw1_K3eYhSiUEnntJ3S2hCZ8DFVYpg@mail.gmail.com>
References: <cover.1405717901.git.luto@amacapital.net>
	<ce65e0e8be18ae8fab437899db44ca41c912b506.1405717901.git.luto@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-security-module-owner@vger.kernel.org>
In-Reply-To: <ce65e0e8be18ae8fab437899db44ca41c912b506.1405717901.git.luto@amacapital.net>
Sender: linux-security-module-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Will Drewry <wad@chromium.org>, Oleg Nesterov <oleg@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-arch <linux-arch@vger.kernel.org>, linux-security-module <linux-security-module@vger.kernel.org>, Alexei Starovoitov <ast@plumgrid.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Jul 18, 2014 at 2:18 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> populate_seccomp_data is expensive: it works by inspecting
> task_pt_regs and various other bits to piece together all the
> information, and it's does so in multiple partially redundant steps.
>
> Arch-specific code in the syscall entry path can do much better.
>
> Admittedly this adds a bit of additional room for error, but the
> speedup should be worth it.

I still think we should gain either a note in the
HAVE_ARCH_SECCOMP_FILTER help text in arch/Kconfig, or possibly a new
section in Documentation/prctl/seccomp.txt (or similar) on how do
implement filter support for an architecture, that mentions the
arch-supplied seccomp_data and how two-phase can be done.

-Kees

-- 
Kees Cook
Chrome OS Security
