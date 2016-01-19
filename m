From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH v2 0/2] kbuild: Remove stale asm-generic wrappers
Date: Tue, 19 Jan 2016 13:37:48 +0000
Message-ID: <1453210670-12596-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mips-bounce@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Michal Marek <mmarek@suse.com>
Cc: linux-kernel@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, James Hogan <james.hogan@imgtec.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-kbuild@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-arch.vger.kernel.org

This patchset attempts to fix kbuild to automatically remove stale
asm-generic wrappers, i.e. when files are removed from generic-y and
added directly into arch/*/include/uapi/asm/, but where the existing
wrapper in arch/*/include/generated/asm/ continues to be used.

MIPS was recently burned by this in v4.3 (see patch 2), with continuing
reports of build failures when people upgrade their trees, which go away
after arch/mips/include/generated is removed (or reportedly make
mrproper/distclean). It is particularly irritating during bisection.

Changes in v2:
- New patch 1 to add tracking of generated headers that aren't generic-y
  wrappers, via generated-y, particularly for x86 (thanks to kbuild test
  robot).
- Rewrite a bit, drawing inspiration from Makefile.headersinst.
- Exclude genhdr-y and generated-y (thanks to kbuild test robot).

James Hogan (2):
  kbuild, x86: Track generated headers with generated-y
  kbuild: Remove stale asm-generic wrappers

 Documentation/kbuild/makefiles.txt | 14 ++++++++++++++
 arch/x86/include/asm/Kbuild        |  6 ++++++
 scripts/Makefile.asm-generic       | 17 ++++++++++++++++-
 3 files changed, 36 insertions(+), 1 deletion(-)

Cc: Michal Marek <mmarek@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: linux-kbuild@vger.kernel.org
Cc: x86@kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mips@linux-mips.org
-- 
2.4.10
