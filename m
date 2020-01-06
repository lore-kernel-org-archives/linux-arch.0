From: Alan Kao <alankao@andestech.com>
Subject: Re: [PATCH 2/2] riscv: Add vector ISA support
Date: Mon, 6 Jan 2020 10:45:16 +0800
Message-ID: <20200106024515.GA1021@andestech.com>
References: <20200105025215.2522-1-guoren@kernel.org>
 <20200105025215.2522-2-guoren@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200105025215.2522-2-guoren@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: guoren@kernel.org
Cc: linux-arch@vger.kernel.org, aou@eecs.berkeley.edu, Guo Ren <ren_guo@c-sky.com>, arnd@arndb.de, atish.patra@wdc.com, Anup.Patel@wdc.com, linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, vincent.chen@sifive.com, palmer@dabbelt.com, zong.li@sifive.com, paul.walmsley@sifive.com, greentime.hu@sifive.com, linux-riscv@lists.infradead.org, bmeng.cn@gmail.com
List-Id: linux-arch.vger.kernel.org

Hi Guo,

On Sun, Jan 05, 2020 at 10:52:15AM +0800, guoren@kernel.org wrote:
> From: Guo Ren <ren_guo@c-sky.com>
> 
> The implementation follow the RISC-V "V" Vector Extension draft v0.8 with
> 128bit-vlen and it's based on linux-5.5-rc4.
> 

According to https://lkml.org/lkml/2019/11/22/2169, in which Paul has stated
that "we plan to only accept patches for new modules or extensions that have
been frozen or ratified by the RISC-V Foundation."

Is v0.8 ratified enough for now?
