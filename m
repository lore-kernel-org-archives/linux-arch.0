From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V5 00/15] entry, x86, kvm: Generic entry/exit functionality
 for host and guest
Date: Wed, 22 Jul 2020 23:59:54 +0200
Message-ID: <20200722215954.464281930@linutronix.de>
Content-Transfer-Encoding: 8-bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>, Sean Christopherson <sean.j.christopherson@intel.com>
List-Id: linux-arch.vger.kernel.org

This is the 5th version of generic entry/exit functionality for host and
guest.

The 4th version is available here:

    https://lore.kernel.org/r/20200721105706.030914876@linutronix.de

Changes vs. V4:

  - Add the missing instrumentation prevetions to the entry Makefile (Kees)
  - Rename exit_to_guest to xfer_to_guest (Sean)

The patches depend on:

    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/entry

The lot is also available from git:

    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/entry

Thanks,

	tglx
