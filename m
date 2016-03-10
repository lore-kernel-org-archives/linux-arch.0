From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arc: use little endian accesses
Date: Thu, 10 Mar 2016 08:45:30 +0100
Message-ID: <201603100845.30602.arnd@arndb.de>
References: <1457544064-16167-1-git-send-email-ltrimas@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075F4E8EDF9@us01wembx1.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075F4E8EDF9@us01wembx1.internal.synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Lada Trimasova <Lada.Trimasova@synopsys.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Noam Camus <noamc@ezchip.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Thursday 10 March 2016, Vineet Gupta wrote:
> On Wednesday 09 March 2016 10:51 PM, Lada Trimasova wrote:
> > Memory access primitives should use cpu_to_le16, cpu_to_le32, le16_to_cpu
> > and le32_to_cpu because it is not really guaranteed that drivers handles
> > any ordering themselves.
> 
> That is the driver issue. readxx as API simply returns data in native endianness.
> We've had EZChip running big endian and so far and they didn't need this change.

Most drivers using readl() or readl_relaxed() expect those to perform byte
swaps on big-endian architectures, as the registers tend to be fixed endian,
so the change seems reasonable.

It depends a little bit on how endian mode is implemented in the CPU: do you
follow the normal model of swapping byte order in the load/store instructions
of the CPU when running big-endian, or is the CPU always running little-endian
but the bus addresses get mangled on byte accesses to give the illusion
of a big-endian system?

	Arnd
