From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH v1 0/4] xtensa: system call table generation support
Date: Tue, 6 Nov 2018 12:30:03 -0800
Message-ID: <20181106203003.q7kqlwm5hcnxmu6t@octofox.metropolis>
References: <1541080581-4072-1-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1541080581-4072-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org
List-Id: linux-arch.vger.kernel.org

On Thu, Nov 01, 2018 at 07:26:17PM +0530, Firoz Khan wrote:
> The purpose of this patch series is, we can easily
> add/modify/delete system call table support by cha-
> nging entry in syscall.tbl file instead of manually
> changing many files. The other goal is to unify the 
> system call table generation support implementation 
> across all the architectures. 
 
Do I understand it right that you're also planning to unify scripts
and makefile snippets used to generate headers, as they're not
architecture-specific?

> Firoz Khan (4):
>   xtensa: move SYS_XTENSA_* macros to non uapi header
>   xtensa: add __NR_syscalls along with __NR_syscall_count
>   xtensa: add system call table generation support
>   xtensa: generate uapi header and syscall table header files

Other than the two notes that I've posted to the individual patches
this series looks good to me.

-- 
Thanks.
-- Max
