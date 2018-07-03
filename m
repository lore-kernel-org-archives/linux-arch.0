From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 0/3] arm, arm64,
 microblaze: add endianness options to LDFLAGS instead of LD
Date: Tue,  3 Jul 2018 10:21:58 +0900
Message-ID: <1530580921-23340-1-git-send-email-yamada.masahiro@socionext.com>
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
To: Michal Simek <monstr@monstr.eu>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linux-arch <linux-arch@vger.kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, Russell King <linux@armlinux.org.uk>
List-Id: linux-arch.vger.kernel.org


We are able to evaluate compiler / toolchain capability in the
Kconfig phase.
(If you do not know the background of this work, please read
 the commit log of 316d55d55f49eca442e4fd948f5fa92bab0c8312)

To achieve this, 'CC', 'LD', etc. must be passed to Kconfig.

arch/*/Makefile should not tweak such environment variables
depending on CONFIG options - this would cause circular dependency.
  - We want to pass $(LD) from Makefile to Kconfig
  - CONFIG_CPU_BIG_ENDIAN is defined by Kconfig, then given
    back to Makefile

Nicholas already fixed this issue for PowerPC in commit 1421dc6d48296a.

I need to fix arm, arm64, microblaze as well
before I start moving linker option tests to Kconfig from Makefile.

arch maintainers:
Please pick up a proper patch for your tree.



Masahiro Yamada (3):
  ARM: add endianness option to LDFLAGS instead of LD
  arm64: add endianness option to LDFLAGS instead of LD
  microblaze: add endianness options to LDFLAGS instead of LD

 arch/arm/Makefile        | 4 ++--
 arch/arm64/Makefile      | 6 ++----
 arch/microblaze/Makefile | 4 ++--
 3 files changed, 6 insertions(+), 8 deletions(-)

-- 
2.7.4
