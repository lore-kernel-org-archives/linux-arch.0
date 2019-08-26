From: Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH V2] csky: Fixup 610 vipt cache flush mechanism
Date: Mon, 26 Aug 2019 14:54:26 +0800
Message-ID: <CAJF2gTS6myiYmPqMLhSxHJd3tL1rmy+K9Kj42cYq9HLxSMPWCg@mail.gmail.com>
References: <1566443122-17540-1-git-send-email-guoren@kernel.org> <20190826063818.GA29871@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190826063818.GA29871@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-csky@vger.kernel.org, douzhk@nationalchip.com, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

Thx Christoph,

On Mon, Aug 26, 2019 at 2:38 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Aug 22, 2019 at 11:05:22AM +0800, guoren@kernel.org wrote:
> > From: Guo Ren <ren_guo@c-sky.com>
> >
> > 610 has vipt aliasing issue, so we need to finish the cache flush
> > apis mentioned in cachetlb.rst to avoid data corruption.
> >
> > Here is the list of modified apis in the patch:
>
> Looks sensible to me, although I can't really verify the details.
> You might also want to Cc linux-mm.

I'll re-send it to linux-mm.

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
