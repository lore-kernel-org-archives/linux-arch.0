From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v2 4/5] mips: add system call table generation support
Date: Mon, 19 Nov 2018 22:35:25 +0000
Message-ID: <20181119223524.gsvjkf5v24ic7ilj@pburton-laptop>
References: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org>
 <1542262461-29024-5-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542262461-29024-5-git-send-email-firoz.khan@linaro.org>
Content-Language: en-US
Content-ID: <A2E211591DB73D41806327B2F9F1BA57@namprd22.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, "y2038@lists.linaro.org" <y2038@lists.linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>, "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

Hi Firoz,

On Thu, Nov 15, 2018 at 11:44:20AM +0530, Firoz Khan wrote:
> diff --git a/arch/mips/kernel/syscalls/Makefile b/arch/mips/kernel/syscal=
ls/Makefile
> new file mode 100644
> index 0000000..dc6bbb1
> --- /dev/null
> +++ b/arch/mips/kernel/syscalls/Makefile
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: GPL-2.0
> +kapi :=3D arch/$(SRCARCH)/include/generated/asm
> +uapi :=3D arch/$(SRCARCH)/include/generated/uapi/asm
> +
> +_dummy :=3D $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')	\
> +	  $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
> +
> +syscallo32 :=3D $(srctree)/$(src)/syscall_o32.tbl
> +syscall64 :=3D $(srctree)/$(src)/syscall_64.tbl
> +syscalln32 :=3D $(srctree)/$(src)/syscall_n32.tbl
> +syshdr :=3D $(srctree)/$(src)/syscallhdr.sh
> +systbl :=3D $(srctree)/$(src)/syscalltbl.sh

Could we go with 'n64' instead of just '64'?

When we get nanoMIPS support we'll be introducing the p32 ABI, and
there's a reasonable chance that the equivalent p64 ABI may come along
in the future. Using 'n64' now would avoid confusion in that case where
we may have 2 different 64-bit ABIs.

Thanks,
    Paul
