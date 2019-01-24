From: Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH] riscv: fixup max_low_pfn with PFN_DOWN.
Date: Thu, 24 Jan 2019 10:31:57 +0800
Message-ID: <20190124023157.GA22934@guoren-Inspiron-7460>
References: <20190116010738.GA4817@guoren-Inspiron-7460>
 <mhng-7c486840-63d3-4645-84ff-8c89660fc552@palmer-si-x1c4>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <mhng-7c486840-63d3-4645-84ff-8c89660fc552@palmer-si-x1c4>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: Palmer Dabbelt <palmer@sifive.com>
Cc: linux-arch@vger.kernel.org, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org, mao_han@c-sky.com, Christoph Hellwig <hch@infradead.org>, ren_guo@c-sky.com, linux-riscv@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Wed, Jan 23, 2019 at 06:00:35PM -0800, Palmer Dabbelt wrote:
> On Tue, 15 Jan 2019 17:07:38 PST (-0800), guoren@kernel.org wrote:
> >Hi Christoph,
> >
> >I use PFN_DOWN() every where as possible and seems it's a habit
> >problem. So let risc-v maintainer to choose "PFN_DOW()" or
> >">> PAGE_SHIFT".
> >
> >Also the same with "end_of_DRAM & max_low_pfn".
> 
> PFN_DOWN makes sense to me, as that's what we're trying to do here (round a
> physical address down to page frame number).  Am a I misunderstanding
> something?
>
No, you got it :)

Best Regards
 Guo Ren
