From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 0/4] LD_DEAD_CODE_DATA_ELIMINATION fixes and enabling for
 powerpc
Date: Wed,  9 May 2018 22:59:57 +1000
Message-ID: <20180509130001.24276-1-npiggin@gmail.com>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>, linux-kbuild@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

v2 changes only patch 4, updates the changelog with ppc32 numbers and
Tested-by tags, and also use TEXT_MAIN in the linker script as
Christophe suggested.

Thanks,
Nick

Nicholas Piggin (4):
  kbuild: Fix asm-generic/vmlinux.lds.h for
    LD_DEAD_CODE_DATA_ELIMINATION
  kbuild: LD_DEAD_CODE_DATA_ELIMINATION no
    -ffunction-sections/-fdata-sections for module build
  kbuild: Allow LD_DEAD_CODE_DATA_ELIMINATION to be selectable if
    enabled
  powerpc: Allow LD_DEAD_CODE_DATA_ELIMINATION to be selected

 Makefile                          |  4 +--
 arch/Kconfig                      | 15 ----------
 arch/powerpc/Kconfig              |  1 +
 arch/powerpc/kernel/vmlinux.lds.S | 22 +++++++-------
 include/asm-generic/vmlinux.lds.h | 49 ++++++++++++++++++-------------
 init/Kconfig                      | 27 +++++++++++++++++
 6 files changed, 70 insertions(+), 48 deletions(-)

-- 
2.17.0
