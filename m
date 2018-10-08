From: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v3 5/6] parisc: wire up rseq system call
Date: Mon, 8 Oct 2018 07:36:14 +0200
Message-ID: <feb53cb6-e20b-42c3-5b53-8b310c772545@gmx.de>
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
 <1538975801-13735-6-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538975801-13735-6-git-send-email-firoz.khan@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>, linux-parisc@vger.kernel.org, "James E . J . Bottomley" <jejb@parisc-linux.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org
List-Id: linux-arch.vger.kernel.org

On 08.10.2018 07:16, Firoz Khan wrote:
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> ---
>  arch/parisc/kernel/syscalls/syscall.tbl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
> index 4e85293..4334bb7 100644
> --- a/arch/parisc/kernel/syscalls/syscall.tbl
> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
> @@ -349,4 +349,5 @@
>  347     common  preadv2                         sys_preadv2                     compat_sys_preadv2
>  348     common  pwritev2                        sys_pwritev2                    compat_sys_pwritev2
>  349     common  statx                           sys_statx
> -350	common  io_pgetevents			sys_io_pgetevents		compat_sys_io_pgetevents
> \ No newline at end of file
> +350	common  io_pgetevents			sys_io_pgetevents		compat_sys_io_pgetevents
> +351	common	rseq				sys_rseq			compat_sys_rseq

You can't add the rseq syscall for parisc yet.
It needs additional code in the kernel for parisc which hasn't been tested yet.
See my initial untested patch at https://patchwork.kernel.org/patch/10495209/

Helge
