From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v7 0/2] arm64 tagged address ABI
Date: Wed,  7 Aug 2019 16:53:19 +0100
Message-ID: <20190807155321.9648-1-catalin.marinas@arm.com>
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
To: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, Szabolcs Nagy <szabolcs.nagy@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Hansen <dave.hansen@intel.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>
List-Id: linux-arch.vger.kernel.org

Hi,

Thanks for the feedback so far. This is an updated series documenting
the AArch64 Tagged Address ABI as implemented by these patches:

http://lkml.kernel.org/r/cover.1563904656.git.andreyknvl@google.com

Version 6 of the documentation series is available here:

http://lkml.kernel.org/r/20190725135044.24381-1-vincenzo.frascino@arm.com

Changes in v7:

- Dropped the MAP_PRIVATE requirements for tagged pointers for both
  anonymous and file mappings. One reason is that we can't enforce such
  restriction anyway. The other reason is that a future series
  implementing support for the hardware MTE will detect
  incompatibilities of the new PROT_MTE flag with various mmap()
  options.

- As a consequence of the above, I removed Szabolcs ack as I'm not sure
  he's ok with the change.

- Clarified the sysctl and prctl() interaction and reordered the
  descriptions.

- Reworded the prctl(PR_SET_MM) restrictions.

- Removed the description of the tag preservation from the first patch
  as it didn't really make sense (the syscall ABI has always preserved
  all registers other than x0 on return to user).

- s/ARM64/AArch64/ for consistency with the tagged-pointers.rst
  document.

- Other minor rewordings.

Vincenzo Frascino (2):
  arm64: Define Documentation/arm64/tagged-address-abi.rst
  arm64: Relax Documentation/arm64/tagged-pointers.rst

 Documentation/arm64/tagged-address-abi.rst | 151 +++++++++++++++++++++
 Documentation/arm64/tagged-pointers.rst    |  23 +++-
 2 files changed, 167 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/arm64/tagged-address-abi.rst
