From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 0/8] kprobes: Fix %p in kprobes
Date: Thu, 25 Jan 2018 14:26:31 +0900
Message-ID: <151685799071.3099.10383062804474021403.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, Jon Medhurst <tixy@linaro.org>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Hi,

This series fixes %p uses in kprobes. Some by replacing
with %pS, some by replacing with %px but masking with
kallsyms_show_value().

I've read the thread about %pK and if I understand correctly
we shouldn't print kernel addresses. However, kprobes debugfs
interface can not stop to show the actual probe address because
it should be compared with addresses in kallsyms for debugging.
So, it depends on that kallsyms_show_value() allows to show
address to user, because if it returns true, anyway that user
can dump /proc/kallsyms.

Other error messages are replaced it with %pS, and one critical
function uses %px which is called right before BUG().

Also, I tried to fix this issue on each arch port. I searched
it by

 # find arch/* | grep -e 'kprobe.*c' | xargs grep -w %p

And fixed all %p uses in those files.

Thank you,

---

Masami Hiramatsu (8):
      kprobes: Show blacklist addresses as same as kallsyms does
      kprobes: Show address of kprobes if kallsyms does
      kprobes: Replace %p with other pointer types
      kprobes/x86: Fix %p uses in error messages
      kprobes/arm: Fix %p uses in error messages
      kprobes/arm64: Fix %p uses in error messages
      kprobes/MN10300: Fix %p uses in error messages
      kprobes/s390: Fix %p uses in error messages


 arch/arm/probes/kprobes/core.c      |   10 ++++----
 arch/arm/probes/kprobes/test-core.c |    1 -
 arch/arm64/kernel/probes/kprobes.c  |    4 ++-
 arch/mn10300/kernel/kprobes.c       |    6 +++--
 arch/s390/kernel/kprobes.c          |    2 +-
 arch/x86/kernel/kprobes/core.c      |   12 +++-------
 kernel/kprobes.c                    |   42 ++++++++++++++++++++++-------------
 7 files changed, 41 insertions(+), 36 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
