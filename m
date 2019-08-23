From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v10 0/1] arm64 tagged address ABI
Date: Fri, 23 Aug 2019 17:37:16 +0100
Message-ID: <20190823163717.19569-1-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, Szabolcs Nagy <szabolcs.nagy@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Dave Hansen <dave.hansen@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>, Dave P Martin <Dave.Martin@arm.com>
List-Id: linux-arch.vger.kernel.org

Hi,

Minor update to the arm64 tagged address ABI documentation since v9,
posted here:

http://lkml.kernel.org/r/20190821164730.47450-1-catalin.marinas@arm.com

The mmap/mremap/... patch (1/3) has been queued in the -mm tree and
removed from this series. The tagged-address-abi.rst patch (2/3) has
been queued in the arm64 for-next/core tree. There is only one patch
left in this series (keeping the cover letter for consistency).

Changes in v10:

- Remove the tag preservation paragraph since the new ABI does not
  change the behaviour we already have. The only difference is that now
  the kernel can access tagged addresses (e.g. delivering a signal on a
  tagged alternate stack).

Vincenzo Frascino (1):
  arm64: Relax Documentation/arm64/tagged-pointers.rst

 Documentation/arm64/tagged-pointers.rst | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)
