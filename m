From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] C-SKY(csky) Port for Linux 4.20
Date: Sun, 28 Oct 2018 14:11:30 -0700
Message-ID: <CAHk-=whHhzsdgbVwRFB8oGVwnfN551HPQjtvuodf+W5dNHtjuA@mail.gmail.com>
References: <1540613318-23877-1-git-send-email-ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540613318-23877-1-git-send-email-ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ren_guo@c-sky.com
Cc: Arnd Bergmann <arnd@arndb.de>, marc.zyngier@arm.com, Peter Zijlstra <peterz@infradead.org>, robh@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, c-sky_gcc_upstream@c-sky.com, guoren1983@gmail.com
List-Id: linux-arch.vger.kernel.org

Arnd,
 I was kind of hoping/expecting to get an explicit ack for this from
you, since it's a new architecture.

Good to merge?

              Linus

On Fri, Oct 26, 2018 at 9:08 PM Guo Ren <ren_guo@c-sky.com> wrote:
>
> This tag contains the Linux port for C-SKY(csky) based on linux-4.19
> Release, which has been through 10 rounds of review on mailing list.
>
> We almost got the Acked-by/Reviewed-by of all patches except "Process
> management and Signal", but all've been tested.
