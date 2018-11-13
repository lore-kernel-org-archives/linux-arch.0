From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v2 0/3] xtensa: system call table generation support
Date: Tue, 13 Nov 2018 15:53:09 -0800
Message-ID: <CAMo8BfLt0NuQOTP6MBbRdOpK0_fWwtvfZArwVhwW1SZyzH4mbQ@mail.gmail.com>
References: <1542104370-22831-1-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542104370-22831-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038@lists.linaro.org, LKML <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, marcin.juszkiewicz@linaro.org
List-Id: linux-arch.vger.kernel.org

Hi Firoz,

On Tue, Nov 13, 2018 at 2:19 AM Firoz Khan <firoz.khan@linaro.org> wrote:
[...]
> Firoz Khan (3):
>   xtensa: add __NR_syscalls along with __NR_syscall_count
>   xtensa: add system call table generation support
>   xtensa: generate uapi header and syscall table header files

What's your plan for submission of this series? Are you going to
submit it with other similar series in a common tree, or shall I take
it into the xtensa tree?

-- 
Thanks.
-- Max
