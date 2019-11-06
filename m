From: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 00/10] Improvements for random.h/archrandom.h
Date: Wed,  6 Nov 2019 15:12:58 +0100
Message-ID: <20191106141308.30535-1-rth@twiddle.net>
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
To: linux-crypto@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, herbert@gondor.apana.org.au, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

During patch review for an addition of archrandom.h for arm64, it was
suggeted that the arch_random_get_* functions should be marked __must_check.
Which does sound like a good idea, since the by-reference integer output
may be uninitialized when the boolean result is false.

In addition, it turns out that arch_has_random() and arch_has_random_seed()
are not used, and not easy to support for arm64.  Rather than cobble
something together that would not be testable, remove the interfaces
against some future accidental use.

In addition, I noticed a few other minor inconsistencies between the
different architectures, e.g. powerpc isn't using bool.

Change since v1:
  * Remove arch_has_random, arch_has_random_seed.


r~


Richard Henderson (10):
  x86: Remove arch_has_random, arch_has_random_seed
  powerpc: Remove arch_has_random, arch_has_random_seed
  s390: Remove arch_has_random, arch_has_random_seed
  linux/random.h: Remove arch_has_random, arch_has_random_seed
  linux/random.h: Use false with bool
  linux/random.h: Mark CONFIG_ARCH_RANDOM functions __must_check
  x86: Mark archrandom.h functions __must_check
  powerpc: Use bool in archrandom.h
  powerpc: Mark archrandom.h functions __must_check
  s390x: Mark archrandom.h functions __must_check

 arch/powerpc/include/asm/archrandom.h | 27 +++++++++-----------------
 arch/s390/include/asm/archrandom.h    | 20 ++++---------------
 arch/x86/include/asm/archrandom.h     | 28 ++++++++++++---------------
 include/linux/random.h                | 24 ++++++++---------------
 4 files changed, 33 insertions(+), 66 deletions(-)

-- 
2.17.1
