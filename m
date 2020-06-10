Return-Path: <SRS0=wbd0=7X=lists.infradead.org=linux-riscv-bounces+rppt=kernel.org@kernel.org>
Date: Wed, 10 Jun 2020 17:48:11 +0200
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Possible duplicate page fault accounting on some archs after commit
 4064b9827063
Message-ID: <20200610174811.44b94525@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+rppt=kernel.org@lists.infradead.org
To: Peter Xu <peterx@redhat.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrea Arcangeli <aarcange@redhat.com>, linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org, Nick Hu <nickhu@andestech.com>, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-um@lists.infradead.org, linux-mips@vger.kernel.org, Ley Foon Tan <ley.foon.tan@intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200610154811.Qp13J0YWKdZaQ8FsM7MDth1NWg1SEF7vwU8X2G12_Iw@z>

Hi,

Some architectures have their page fault accounting code inside the fault
retry loop, and rely on only going through that code once. Before commit
4064b9827063 ("mm: allow VM_FAULT_RETRY for multiple times"), that was
ensured by testing for and clearing FAULT_FLAG_ALLOW_RETRY.

That commit had to remove the clearing of FAULT_FLAG_ALLOW_RETRY for all
architectures, and introduced a subtle change to page fault accounting
logic in the affected archs. It is now possible to go through the retry
loop multiple times, and the affected archs would then account multiple
page faults instead of just one.

This was found by coincidence in s390 code, and a quick check showed that
there are quite a lot of other architectures that seem to be affected in a
similar way. I'm preparing a fix for s390, by moving the accounting behind
the retry loop, similar to x86. It is not completely straight-forward, so
I leave the fix for other archs to the respective maintainers.

Added the lists for possibly affected archs on cc, but no guarantee for
completeness.

Regards,
Gerald
