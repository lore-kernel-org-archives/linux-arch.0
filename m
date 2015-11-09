From: Octavian Purdila <octavian.purdila@intel.com>
Subject: Re: [RFC PATCH 00/28] Linux Kernel Library
Date: Mon, 9 Nov 2015 17:11:06 +0200
Message-ID: <CAE1zotLg++wrkSimnD3CNzQFUW02g8Gw7Lhj3Zqo79gEAbVOYA@mail.gmail.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
	<CAFLxGvzZozV0rDpY_VcQaFH+dx_+tHGyEy+22kgL=wdS5pSqCw@mail.gmail.com>
	<CAE1zot+hBnAds-T37JLv_6Sp2fRqwCbCv46_gA=E7D49gGd6cA@mail.gmail.com>
	<1670BE0E-C0E0-4D45-BF16-1FF60C298149@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1670BE0E-C0E0-4D45-BF16-1FF60C298149@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yalin wang <yalin.wang2010@gmail.com>
Cc: Richard Weinberger <richard.weinberger@gmail.com>, Linux-Arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Hajime Tazaki <thehajime@gmail.com>, "Richard W.M. Jones" <rjones@redhat.com>
List-Id: linux-arch.vger.kernel.org

On Sun, Nov 8, 2015 at 4:42 PM, yalin wang <yalin.wang2010@gmail.com> w=
rote:
>
> On Nov 4, 2015, at 07:06, Octavian Purdila <octavian.purdila@intel.co=
m>
> wrote:
>
> On Tue, Nov 3, 2015 at 11:40 PM, Richard Weinberger
> <richard.weinberger@gmail.com> wrote:
>
> Hi Richard,
>
> On Tue, Nov 3, 2015 at 9:20 PM, Octavian Purdila
> <octavian.purdila@intel.com> wrote:
>
> LKL (Linux Kernel Library) is aiming to allow reusing the Linux kerne=
l code
> as extensively as possible with minimal effort and reduced maintenanc=
e
> overhead.
>
> Examples of how LKL can be used are: creating userspace applications
> (running on Linux and other operating systems) that can read or write=
 Linux
> filesystems or can use the Linux networking stack, creating kernel dr=
ivers
> for other operating systems that can read Linux filesystems, bootload=
ers
> support for reading/writing Linux filesystems, etc.
>
> With LKL, the kernel code is compiled into an object file that can be
> directly linked by applications. The API offered by LKL is based on t=
he
> Linux system call interface.
>
> LKL is implemented as an architecture port in arch/lkl. It relies on =
host
> operations defined by the application or a host library (tools/lkl/li=
b).
>
> The latest LKL version can be found at git@github.com:lkl/linux.git
>
>
> Or more copy&paste friendly: https://github.com/lkl/linux.git
>
> FAQ
> =3D=3D=3D
>
> Q: How is LKL different from UML?
> A: UML provides a full OS environment (e.g. user/kernel separation, u=
ser
> processes) and also has requirements (a filesystem, processes, etc.) =
that
> makes it hard to use it for standalone applications. UML also relies
> heavily on Linux hosts. On the other hand LKL is designed to be linke=
d
> directly with the application and hence does not have user/kernel
> separation which makes it easier to use it in standalone applications=
=2E
>
>
> So, this is a "liblinux" where applications are directly linked
> against the kernel.
> IOW system calls are plain function calls into the kernel?
>
>
> More like "thread" calls. All system calls are executed in a dedicate
> (kernel) thread to avoid race conditions with the "interrupt" path.
>
> why not call sys_XXX()  function directly?
> since kernel have implement lots of spin_locks to avoid race with nor=
mal
> path
> in IRQ handle ,  isn=E2=80=99t  it ?
> for example, you timer IRQ can be simulated by SIGALARM signal,
> and the signal handler can check if IRQ is disabled ,
> if not , then continuing , otherwise , return directly ..
> it is not safe ?
>

Hi Yalin,

We need to have a proper Linux context in order to issue system calls
(e.g. current needs to point to a proper Linux kernel thread_struct).
We also want to let the Linux scheduler to select what kernel threads
run at a given time. Lets say that currently a ksoftirqd runs and the
application want to issue a system call. In this case we want to wait
for ksoftirqd to complete then run the system call.

The simplest way I found to do that is to have the system calls
execute from Linux kernel threads hence the need to queue the system
calls from the application thread to the Linux kernel system call
thread.

(BTW, we can have multiple system call threads if needed and the 2.6
implementation has that, but in order to simplify the review process I
decided to throw away that for the moment).

Thanks,
Tavi
