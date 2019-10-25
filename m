From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 1/2] asm-generic: Make msi.h a mandatory include/asm header
Date: Fri, 25 Oct 2019 08:12:14 +0200
Message-ID: <33e46e4b-cfe4-db2f-02e1-0164327bcecc@xilinx.com>
References: <cover.1571911976.git.michal.simek@xilinx.com>
 <a021f232968cfffe3f2d838da47214c6bbdeeedb.1571911976.git.michal.simek@xilinx.com>
 <CAK7LNAQvZr48zXkyhii6E-wckYfakhh9gVD=DoBOt++TtPFEaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAK7LNAQvZr48zXkyhii6E-wckYfakhh9gVD=DoBOt++TtPFEaw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Simek <michal.simek@xilinx.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Eric Biggers <ebiggers@google.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Palmer Dabbelt <palmer@sifive.com>, linux-mips@vger.kernel.org, Paul Mackerras <paulus@samba.org>, longman@redhat.com, sparclinux <sparclinux@vger.kernel.org>, linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, Michael Ellerman <mpe@ellerman.id.au>, Jackie Liu <liuyun01@kylinos.cn>, Russell King <linux@armlinux.org.uk>, Christoph Hellwig <hch@infradead.org>, Firoz Khan <firoz.khan@linaro.org>, Wesley Terpstra <wesley@sifive.com>, James Hogan <jhogan@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, Albert Ou <aou@eecs.berkele>
List-Id: linux-arch.vger.kernel.org

On 24. 10. 19 16:44, Masahiro Yamada wrote:
> On Thu, Oct 24, 2019 at 7:13 PM Michal Simek <michal.simek@xilinx.com> wrote:
>>
>> msi.h is generic for all architectures expect of x86 which has own version.
> 
> Maybe a typo?  "except"

unfortunately yes.

> 
> 
> Anyway, the code looks good to me.
> 
> Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>

I have sent v2.
Who should be taking these patches?

Thanks,
Michal
