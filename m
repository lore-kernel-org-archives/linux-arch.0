From: Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v2 1/2] asm-generic: Make dma-contiguous.h a mandatory
 include/asm header
Date: Fri, 17 Jan 2020 12:41:31 -0800 (PST)
Message-ID: <alpine.DEB.2.21.9999.2001171241070.98477@viisi.sifive.com>
References: <cover.1579248206.git.michal.simek@xilinx.com> <0274919c5e3b134df19d943f99cb7e84e5135ccd.1579248206.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-mips-owner@vger.kernel.org>
In-Reply-To: <0274919c5e3b134df19d943f99cb7e84e5135ccd.1579248206.git.michal.simek@xilinx.com>
Sender: linux-mips-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com, Christoph Hellwig <hch@lst.de>, Christoph Hellwig <hch@infradead.org>, Paul Burton <paulburton@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, linux-mips@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Catalin Marinas <catalin.marinas@arm.com>, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, x86@kernel.org, Guo Ren <guoren@kernel.org>, Kate Stewart <kstewart@linuxfoundation.org>, Wesley Terpstra <wesley@sifive.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ralf Baechle <ralf@linux-mips.org>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, "H. Peter Anvin" <hpa@zytor.>
List-Id: linux-arch.vger.kernel.org

On Fri, 17 Jan 2020, Michal Simek wrote:

> dma-continuguous.h is generic for all architectures except arm32 which has
> its own version.
> 
> Similar change was done for msi.h by commit a1b39bae16a6
> ("asm-generic: Make msi.h a mandatory include/asm header")
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Acked-by: Paul Walmsley <paul.walmsley@sifive.com> # for arch/riscv


- Paul
