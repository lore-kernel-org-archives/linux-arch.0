From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 6/8] asm-generic: pgalloc: provide generic pgd_free()
Date: Mon, 29 Jun 2020 17:42:28 +0200
Message-ID: <CAMuHMdWP07XqvgrXjCG+n5FssH3BwdDEWA4fD9TQgvVy93uMhQ@mail.gmail.com>
References: <20200627143453.31835-1-rppt@kernel.org>
 <20200627143453.31835-7-rppt@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
In-Reply-To: <20200627143453.31835-7-rppt@kernel.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, Max Filippov <jcmvbkbc@gmail.com>, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>, linux-csky@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>, Linux-Arch <linux-arch@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, Mike Rapoport <rppt@linux.ibm.com>, Abdul Haleem <abdhalee@linux.vnet.ibm.com>, arcml <linux-snps-arc@lists.infradead.org>, "open list:TENSILICA XTENSA PORT (xtensa)" <linux-xtensa@linux-xtensa.org>, Arnd Bergmann <arnd@arndb.de>, linux-s390 <linux-s390@vger.kernel.org>, linux-um <linux-um@lis>
List-Id: linux-arch.vger.kernel.org

On Sat, Jun 27, 2020 at 4:36 PM Mike Rapoport <rppt@kernel.org> wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> Most architectures define pgd_free() as a wrapper for free_page().
>
> Provide a generic version in asm-generic/pgalloc.h and enable its use for
> most architectures.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

For the m68k part:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
