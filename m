From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V9 00/21] C-SKY(csky) Linux Kernel Port
Date: Wed, 17 Oct 2018 17:58:46 +0200
Message-ID: <CAK8P3a25W5rE093QsmC539d+s038Wv9PmV8Xa76LQzDLk3E8Wg@mail.gmail.com>
References: <cover.1539655731.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1539655731.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, David Miller <davem@davemloft.net>, gregkh <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
List-Id: linux-arch.vger.kernel.org

On Tue, Oct 16, 2018 at 4:58 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> This is the 9th version patchset to add the Linux kernel port for
> C-SKY(csky) based on linux-4.19-rc3.
>
> There are only a few changes between V8 patchset. Hope it could be
> merged into linux-4.20 and I'm very grateful for any help.

I've gone through the entire series once more and saw no show-stoppers.
The last patch looked like it introduced a bug, but with that one dropped,
I'm happy for the architecture to get merged, unless anyone else
has any last-minute concerns. (Alternatively, explain why I'm wrong
and the code works correctly, of course).

I'd appreciate having someone else take another look at the signal
handling code, the atomics, and the DT bindings and provide another
Ack for those.

The remaining open question is about the 32-bit time_t interfaces.
With 4.20, I did not manage to get the required system calls in place
for using 64-bit time_t in a new architecture, so you will at least
start out using 32-bit time_t and likely have to keep supporting
that going forward, unless we decide to break the ABI here later
on .This is something we normally don't do, but we might make
an exception here, under the assumption that there are no
existing users with the ABI. We can debate that once we get there.

       Arnd
