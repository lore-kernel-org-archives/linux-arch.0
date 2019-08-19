From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 08/26] m68k: simplify ioremap_nocache
Date: Mon, 19 Aug 2019 11:18:46 +0200
Message-ID: <20190819091846.GA27890@lst.de>
References: <20190817073253.27819-1-hch@lst.de> <20190817073253.27819-9-hch@lst.de> <CAMuHMdWyXGjokWi7tn9JHCTz9YMb_vHn6XKeE7KzH5n-54Sy0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWyXGjokWi7tn9JHCTz9YMb_vHn6XKeE7KzH5n-54Sy0A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>, Michal Simek <monstr@monstr.eu>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, the arch/x86 maintainers <x86@kernel.org>, alpha <linux-alpha@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-mips@vger.kernel.org, nios2-dev@lists.rocketboards.org, Openrisc <openrisc@lists.librecores.org>, Parisc List <linux-parisc@vger.kernel.org>, linux-riscv@lists.infradead.orglinux-s390 <linux>
List-Id: linux-arch.vger.kernel.org

On Mon, Aug 19, 2019 at 10:56:02AM +0200, Geert Uytterhoeven wrote:
> BTW, shouldn't we get rid of the sole user of ioremap_uc(), too?
> Seems to make a difference on x86 only, where it is "strongly uncached"
> (whatever that may mean ;-)

Yes, we probably should.  However that actually seems worth a discussion
so I wanted to defer it until after this already huge series.

Another thing we can do after this series is to kill of ioremap_nocache.
