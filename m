Return-Path: <SRS0=ejdr=3A=lists.infradead.org=linux-riscv-bounces+rppt=kernel.org@kernel.org>
Date: Fri, 10 Jan 2020 17:30:45 -0800 (PST)
From: Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH 1/2] riscv: Fixup obvious bug for fp-regs reset
In-Reply-To: <20200105025215.2522-1-guoren@kernel.org>
Message-ID: <alpine.DEB.2.21.9999.2001101730140.38813@viisi.sifive.com>
References: <20200105025215.2522-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+rppt=kernel.org@lists.infradead.org
To: guoren@kernel.org
Cc: linux-arch@vger.kernel.org, aou@eecs.berkeley.edu, Guo Ren <ren_guo@c-sky.com>, arnd@arndb.de, atish.patra@wdc.com, Anup.Patel@wdc.com, linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, vincent.chen@sifive.com, palmer@dabbelt.com, zong.li@sifive.com, greentime.hu@sifive.com, linux-riscv@lists.infradead.org, bmeng.cn@gmail.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200111013045.ift7Z6YVM8RYp1DN8pouRfEVwSTDpYrmVZc-FQWiu4w@z>

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
