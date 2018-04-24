From: Christoph Hellwig <hch@lst.de>
Subject: dma-debug cleanups, including removing the arch hook
Date: Tue, 24 Apr 2018 16:02:32 +0200
Message-ID: <20180424140235.9125-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, Vincent Chen <deanbo422@gmail.com>, linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, nios2-dev@lists.rocketboards.org, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Hi all,

this series has a few dma-debug cleanups, most notably removing the need
for architectures to explicitly initialize dma-debug.
