From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V9 11/21] csky: Atomic operations
Date: Thu, 18 Oct 2018 10:40:50 +0800
Message-ID: <20181018024049.GB13314@guoren-Inspiron-7460>
References: <cover.1539655731.git.ren_guo@c-sky.com>
 <efb6c9bb87f68c6f579ef497096086413effa5c2.1539655732.git.ren_guo@c-sky.com>
 <CAK8P3a2x_ECC0bjYGUHm5mO9KrWviyWg8xVWNqXkSeNmpjdDxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a2x_ECC0bjYGUHm5mO9KrWviyWg8xVWNqXkSeNmpjdDxA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, David Miller <davem@davemloft.net>, gregkh <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com, andrea.parri@amarulasolutions.com
List-Id: linux-arch.vger.kernel.org

On Wed, Oct 17, 2018 at 05:17:05PM +0200, Arnd Bergmann wrote:
> On Tue, Oct 16, 2018 at 5:02 AM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > This patch adds atomic, cmpxchg, spinlock files.
> >
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> 
> I'd wait for Peter to give his final Ack here.
Yes, Peter help a lot to improve the patch.

Best Regards
 Guo Ren
