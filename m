From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 3/5] asm-generic/tlb: stub out p4d_free_tlb() if nop4d ...
Date: Tue, 15 Oct 2019 14:47:02 -0700
Message-ID: <CAHk-=wg470=r9YPMLyJdgr-aLvHSnDOFwFx=Y=_HPAW-aqyFRg@mail.gmail.com>
References: <20191015191926.9281-1-vgupta@synopsys.com> <20191015191926.9281-4-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191015191926.9281-4-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Linux-MM <linux-mm@kvack.org>, linux-snps-arc@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Oct 15, 2019 at 12:19 PM Vineet Gupta
<Vineet.Gupta1@synopsys.com> wrote:
>
> This came up when removing __ARCH_HAS_5LEVEL_HACK for ARC as code bloat
> from this routine not required in a 2-level paging setup

Similarly acked,

          Linus
