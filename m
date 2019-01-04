From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH 2/2] xtensa: generate uapi header and syscall table header files
Date: Fri, 4 Jan 2019 11:45:27 +0530
Message-ID: <CALxhOnjyHri6rmAs+toXYBb2toniFV7AYhoBR+-fOhOk1=Uh9w@mail.gmail.com>
References: <1546442912-20818-1-git-send-email-firoz.khan@linaro.org>
 <1546442912-20818-3-git-send-email-firoz.khan@linaro.org> <CAMo8Bf+qK=k33boeNOeL69sLC3e-M07QK9ErhYm-byuQ2UnVnw@mail.gmail.com>
 <CALxhOnhgAEeEFhL2fgjDSCBMJo7dF5jiuGKCXjWYjMJmHefMgA@mail.gmail.com> <CAMo8BfJi-CLHHy1CWGZ_KhP2ddZxxHM+CafkjJRd=cC35aNF8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMo8BfJi-CLHHy1CWGZ_KhP2ddZxxHM+CafkjJRd=cC35aNF8g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris@zankel.net>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-xtensa@linux-xtensa.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, LKML <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

Hi Max,

On Fri, 4 Jan 2019 at 11:29, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> On Thu, Jan 3, 2019 at 9:13 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> > On Fri, 4 Jan 2019 at 04:14, Max Filippov <jcmvbkbc@gmail.com> wrote:
> >
> > This build rule is unused now as I was tried to implement
> > something else. Hopefully I'll remove the the above change
> > in my v2.
>
> Then maybe there's a way to move all these macros to a common
> makefile, as they seem to be fairly generic?


Good idea! Sure, I'll look into it.

Thanks
Firoz
