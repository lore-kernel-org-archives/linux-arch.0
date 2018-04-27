From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v3 0/7] kprobes: Fix %p in kprobes
Date: Fri, 27 Apr 2018 15:39:38 +0900
Message-ID: <152481117776.22588.1210388093668905564.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, Jon Medhurst <tixy@linaro.org>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Richter <tmricht@linux.ibm.com>, akpm@linux-foundation.org, acme@kernel.org, rostedt@goodmis.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, stable@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi,

This 3rd version of the series which fixes %p uses in kprobes.
Some by replacing with %pS, some by replacing with %px but
masking with kallsyms_show_value().

I've read the thread about %pK and if I understand correctly
we shouldn't print kernel addresses. However, kprobes debugfs
interface can not stop to show the actual probe address because
it should be compared with addresses in kallsyms for debugging.
So, it depends on that kallsyms_show_value() allows to show
address to user, because if it returns true, anyway that user
can dump /proc/kallsyms.
Other error messages are replaced it with %pS or just removed.

This series also including some fixes for arch ports too.

Changes in this version;
 - [2/7]: Updated for the latest linus tree.
 - [4/7][5/7]: Do not use %px.

Thank you,

---

Masami Hiramatsu (7):
      kprobes: Make blacklist root user read only
      kprobes: Show blacklist addresses as same as kallsyms does
      kprobes: Show address of kprobes if kallsyms does
      kprobes: Replace %p with other pointer types
      kprobes/x86: Fix %p uses in error messages
      kprobes/arm: Fix %p uses in error messages
      kprobes/arm64: Fix %p uses in error messages


 arch/arm/probes/kprobes/core.c      |   10 ++++---
 arch/arm/probes/kprobes/test-core.c |    1 -
 arch/arm64/kernel/probes/kprobes.c  |    4 +--
 arch/x86/kernel/kprobes/core.c      |   12 +++------
 kernel/kprobes.c                    |   48 ++++++++++++++++++++++-------------
 5 files changed, 41 insertions(+), 34 deletions(-)
