From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v2 1/3] xtensa: add __NR_syscalls along with __NR_syscall_count
Date: Tue, 13 Nov 2018 15:49:29 -0800
Message-ID: <CAMo8BfJGWgJrsg858nwO_845HQOSMNm4AxEqjEjVsSMZMG1Gzw@mail.gmail.com>
References: <1542104370-22831-1-git-send-email-firoz.khan@linaro.org> <1542104370-22831-2-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542104370-22831-2-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038@lists.linaro.org, LKML <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, marcin.juszkiewicz@linaro.org
List-Id: linux-arch.vger.kernel.org

Hi Firoz,

I have one more question:

On Tue, Nov 13, 2018 at 2:20 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> The 2nd option will be the recommended one. For that, I
> added the __NR_syscalls macro in uapi/asm/unistd.h along
> with __NR_syscall_count asm/unistd.h. The macro __NR_sys-
> calls also added for making the name convention same across
> all architecture. While __NR_syscalls isn't strictly part
> of the uapi, having it as part of the generated header to
> simplifies the implementation. We also need to enclose
> this macro with #ifdef __KERNEL__ to avoid side effects.

Looking at the include/uapi/asm-generic/unistd.h I see that
__NR_syscalls is not guarded by the #ifdef __KERNEL__,
why should it be guarded for xtensa?

If we remove __NR_syscall_count from the uapi header I'd
suggest dropping it completely and switching its two current
users to __NR_syscalls.

-- 
Thanks.
-- Max
