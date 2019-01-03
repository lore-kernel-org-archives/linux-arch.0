From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH 0/2] microblaze: Unify the system call scripts
Date: Thu, 3 Jan 2019 18:39:53 +0530
Message-ID: <CALxhOnhxyz03xvwXXUoZ8Gk=NrgdHU5CVoEXMFh77R4saWJyPg@mail.gmail.com>
References: <1546441924-20262-1-git-send-email-firoz.khan@linaro.org> <86b91768-2a3d-eb58-c9a5-641be473f301@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <86b91768-2a3d-eb58-c9a5-641be473f301@monstr.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <monstr@monstr.eu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

Hi Michal,

On Thu, 3 Jan 2019 at 18:00, Michal Simek <monstr@monstr.eu> wrote:
> >  arch/microblaze/kernel/syscall_table.S        |  2 +-
> >  arch/microblaze/kernel/syscalls/Makefile      | 11 ++++++--
> >  arch/microblaze/kernel/syscalls/syscallhdr.sh | 36 ---------------------------
> >  arch/microblaze/kernel/syscalls/syscalltbl.sh | 32 ------------------------
> >  4 files changed, 10 insertions(+), 71 deletions(-)
> >  delete mode 100644 arch/microblaze/kernel/syscalls/syscallhdr.sh
> >  delete mode 100644 arch/microblaze/kernel/syscalls/syscalltbl.sh
> >
>
> Looks good. Will keep this in my queue till depending patch is applied.

Thanks for the feedback. As Geert shared few feedback while m68k review,
Hopefully, I may have to include those changes here also.


Firoz
