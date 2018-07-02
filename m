From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V2 07/19] csky: MMU and page table management
Date: Mon, 2 Jul 2018 06:29:15 -0700
Message-ID: <20180702132915.GA6578@infradead.org>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <d07f919cb41ebb500c2e6f6defa6ea5760c22dc5.1530465326.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d07f919cb41ebb500c2e6f6defa6ea5760c22dc5.1530465326.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

This commit is missing an explanation.

For the dma-mapping code please use the generic kernel/dma/noncoherent.c
code instead of duplicating it.
