From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/3] eldie generated code for folded p4d/pud
Date: Thu, 10 Oct 2019 09:29:52 +0200
Message-ID: <20191010072952.GM2311@hirez.programming.kicks-ass.net>
References: <20191009222658.961-1-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20191009222658.961-1-vgupta@synopsys.com>
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
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, linux-kernel@vger.kernel.org, Nick Piggin <npiggin@gmail.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, linux-snps-arc@lists.infradead.org, Will Deacon <will@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Oct 09, 2019 at 03:26:55PM -0700, Vineet Gupta wrote:
> Hi,
> 
> This series elides extraneous generate code for folded p4d/pud.
> This came up when trying to remove __ARCH_USE_5LEVEL_HACK from ARC port.
> The code saving are not a while lot, but still worthwhile IMHO.
> 
> bloat-o-meter2 vmlinux-A-baseline vmlinux-E-elide-p?d_clear_bad
> add/remove: 0/2 grow/shrink: 0/1 up/down: 0/-146 (-146)
> function                                     old     new   delta
> p4d_clear_bad                                  2       -      -2
> pud_clear_bad                                 20       -     -20
> free_pgd_range                               546     422    -124
> Total: Before=4137148, After=4137002, chg -1.000000%
> 

Works for me, thanks!
