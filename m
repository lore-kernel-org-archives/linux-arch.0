From: Fangrui Song <maskray@google.com>
Subject: Re: [PATCH v2 1/3] vmlinux.lds.h: Add .gnu.version* to DISCARDS
Date: Mon, 22 Jun 2020 15:00:43 -0700
Message-ID: <20200622220043.6j3vl6v7udmk2ppp@google.com>
References: <20200622205341.2987797-1-keescook@chromium.org>
 <20200622205341.2987797-2-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200622205341.2987797-2-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 2020-06-22, Kees Cook wrote:
>For vmlinux linking, no architecture uses the .gnu.version* section,
>so remove it via the common DISCARDS macro in preparation for adding
>--orphan-handling=warn more widely.
>
>Signed-off-by: Kees Cook <keescook@chromium.org>
>---
> include/asm-generic/vmlinux.lds.h | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>index db600ef218d7..6fbe9ed10cdb 100644
>--- a/include/asm-generic/vmlinux.lds.h
>+++ b/include/asm-generic/vmlinux.lds.h
>@@ -934,6 +934,7 @@
> 	*(.discard)							\
> 	*(.discard.*)							\
> 	*(.modinfo)							\
>+	*(.gnu.version*)						\
> 	}
>
> /**
>-- 
>2.25.1

I wonder what lead to .gnu.version{,_d,_r} sections in the kernel.

tools/lib/bpf/libbpf_internal.h uses `.symver` directive and
-Wl,--version-script, which may lead to .gnu.version{,_d}, but this only
applies to the userspace libbpf.so

libperf.so has a similar -Wl,--version-script.

Linking vmlinux does not appear to use any symbol versioning.
