From: Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH 1/2] riscv: Fixup obvious bug for fp-regs reset
Date: Fri, 10 Jan 2020 17:30:45 -0800 (PST)
Message-ID: <alpine.DEB.2.21.9999.2001101730140.38813@viisi.sifive.com>
References: <20200105025215.2522-1-guoren@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200105025215.2522-1-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: guoren@kernel.org
Cc: palmer@dabbelt.com, aou@eecs.berkeley.edu, Anup.Patel@wdc.com, vincent.chen@sifive.com, zong.li@sifive.com, greentime.hu@sifive.com, bmeng.cn@gmail.com, atish.patra@wdc.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

On Sun, 5 Jan 2020, guoren@kernel.org wrote:

> From: Guo Ren <ren_guo@c-sky.com>
> 
> CSR_MISA is defined in Privileged Architectures' spec: 3.1.1 Machine
> ISA Register misa. Every bit:1 indicate a feature, so we should beqz
> reset_done when there is no F/D bit in csr_msia register.
> 
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>

Thanks Guo Ren, queued for v5.5-rc.


- Paul
