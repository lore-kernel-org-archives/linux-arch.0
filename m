From: Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH 3/3] riscv/signal: Fixup additional syscall restarting
Date: Thu, 25 Apr 2019 11:11:19 -0700 (PDT)
Message-ID: <mhng-e56eb5bc-3336-4e0e-897f-be508b1c5f4a@palmer-si-x1e>
References: <20190410065304.GA2942@infradead.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190410065304.GA2942@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: guoren@kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, ren_guo@c-sky.com
List-Id: linux-arch.vger.kernel.org

On Tue, 09 Apr 2019 23:53:04 PDT (-0700), Christoph Hellwig wrote:
> Looks good,
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks!  I've pulled just this patch into my for-next, as I'm assuming the
c-sky patches will go in seperately.  Given that it's been on the list for a
while I think it's a good candidate for rc7, so unless anyone says something or
testing causes a problem I'll send it up tomorrow.
