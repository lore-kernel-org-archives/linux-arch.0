From: Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH v2 0/2] Introduce common code for risc-v sparsemem support
Date: Wed, 14 Nov 2018 10:06:24 -0800 (PST)
Message-ID: <mhng-dfc065e5-80c6-4a9d-b95b-95170df42969@palmer-si-x1c4>
References: <20181107205433.3875-1-logang@deltatee.com>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181107205433.3875-1-logang@deltatee.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mm@kvack.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, sbates@raithlin.com, aou@eecs.berkeley.edu, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>, logang@deltatee.com
List-Id: linux-arch.vger.kernel.org

On Wed, 07 Nov 2018 12:54:31 PST (-0800), logang@deltatee.com wrote:
> These are the first two common patches in my series to introduce
> sparsemem support to RISC-V. The full series was posted last cycle
> here [1] and the latest version can be found here [2].
>
> As recommended by Palmer, I'd like to get the changes to common code
> merged and then I will pursue the cleanups in the individual arches (arm,
> arm64, and sh) as well as add the new feature to riscv.
>
> I would suggest we merge these two patches through Andrew's mm tree.

I haven't seen any review on this.  It looks fine to me, but I'm not qualified 
to review it as I don't really know anything about core MM stuff -- and I 
certainly don't feel comfortable taking this through my tree.

I've To'd linux-mm, hopefully it just got lost in the shuffle during the merge 
window.
