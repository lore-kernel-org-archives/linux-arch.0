Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88243D8138;
	Fri, 29 May 2026 16:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780072472; cv=none; b=ihmth+EtggOJcH1r4zK8l01B8bTjAHrEnZWG3MyG6KKZHKUaVhyHJW1NAyh3TF/adsv8dnaEdKRbnHkJVQG5HP8PyZOHGvBHWSBqQv2xEkuX8Svtri04YiRmQR7T922uw5+JNnEZVNdD5M3G6wX8NosFX2eRLExuyp3D+a2yrSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780072472; c=relaxed/simple;
	bh=AVbZc/+UkSgAclmhCaGTEh00NCIWkPQPGqJj8zKSTok=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=svCKcQPVE4g9psGAdvhmNWG5Swvk6uEp/Cy3HHoZqxfJGLyjhOuWlXXyTUDcmC8P7exxDlk6SUZUs2SIonxb26AJsMM/On0Nn3ADl0h7P+yXZ+e6f2YhUv8G7TLFCErvWSjf6JjxO+RG5MdrJnO6XqNbvCEF7DVQ+Rs5CbYWi+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=e87S0zdN; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="e87S0zdN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=1McyqRj83H79ogs7eXUcAZgD/w57LDM5QZuLbtwGDbc=; b=e87S0zdNoqHRgwFQcWbfeW8R14
	/sbQwyMFuqHub9mXJGaYqTgG9nRJYM5Ul4wfrMaqHM5ubkJ0irjLVzBNP0lRgif8aPvtBbMo0btMP
	zKTezGVkeTEb6+X9Al4si9xqsLA4jSDJpkJzYeQmqUPKocJw4O3ZZsk3If0AU2vr4vXE2fyohAlgY
	a2z1d06BZGy5UHm2dm9D4krmXMarC9yS0NX1dDUMSoEbMwganQcWUOgJ7eQmEimcgoe5WSFg/WbVF
	47anJeIOZLvND6vvQPtThSECQvACxORxWog6CbnaZSOkEO0tl0MbhjnOSrbhJXcLcsf9skFVpEx0S
	OTWtw8Wg==;
Received: from [179.118.191.12] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wT0A5-009wov-Sc; Fri, 29 May 2026 18:34:18 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v3 0/5] arm64: vdso: Implement
 __vdso_futex_robust_try_unlock()
Date: Fri, 29 May 2026 13:33:52 -0300
Message-Id: <20260529-tonyk-robust_arm-v3-0-a6f02684d4fe@igalia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23O0QrCIBQG4FcJrzPUuQld9R4R4dxxs9oMddIYe
 /d0ERR1+cN/vv/MyIMz4NF+MyMH0XhjhxSK7QapTg4tYNOkjBhhFeG0wsEO0xU7W48+nKXrccm
 1FqJhigNH6ezuQJvHSh5Pr+zH+gIqZCc3OuODddO6GWnuvXnxy0eKCSaFlBUHpjWVB9PKm5E7Z
 XuU/cg+BMb/CCwJTZ3eq7QomdJfwrIsT+838B0FAQAA
X-Change-ID: 20260416-tonyk-robust_arm-54ff77d2c4e4
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Carlos O'Donell <carlos@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Florian Weimer <fweimer@redhat.com>, Rich Felker <dalias@aerifal.cx>, 
 Torvald Riegel <triegel@redhat.com>, Darren Hart <dvhart@infradead.org>, 
 Ingo Molnar <mingo@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, 
 Arnd Bergmann <arnd@arndb.de>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
 Uros Bizjak <ubizjak@gmail.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, kernel-dev@igalia.com, 
 LKML <linux-kernel@vger.kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.15.2

Hi folks,

This is my take on implementing the new vDSO for unlocking a robust futex in
arm64. If you don't know what's that, Thomas wrote a good summary,
including the motivation for this work and the x86 implementation:

   https://lore.kernel.org/lkml/878qb89g7b.ffs@tglx/

This patchset depends on this series:

   https://lore.kernel.org/lkml/20260402151131.876492985@kernel.org/

The only part that I didn't figure out about this implementation is
something that I have removed from patch 01:

        /*
         * Avoid dereferencing current->mm if not returning from interrupt.
         * current->rseq.event is going to be used subsequently, so bringing the
         * cache line in is not a big deal.
         */
        if (!current->rseq.event.user_irq)
                return;

On arm64 _it seems_ that user_irq is never true. I had to remove this if
to make the code reach __futex_fixup_robust_unlock() and make the test work.

On x86, this is the callstack that sets user_irq to true:

	rseq_note_user_irq_entry
	irqentry_enter_from_user_mode
	exc_debug_user
	noist_exc_debug
	asm_exc_debug

So I'm not sure if there's something missing on arm64 and it should also hit 
irqentry_enter_from_user_mode(), or if we should look into other flag to check
if the task is returing from interrupt.

* Testing

This patchset works fine with the tests proposed at
https://lore.kernel.org/lkml/20260330120118.012924430@kernel.org/

In the series there's also a patch to adapt Sebastian's test to arm64, and it
worked:
https://lore.kernel.org/lkml/20260404093939.7XgeW_54@linutronix.de/

I also used gdb to manually check if the address is cleared when the kernel
interrupts the critical section.

Changes in v3:
 - Change asm to always use x2 to store *pop
 - Fix clang asm errors
 - Moved 32 bit entry point to vdso32/ and use littlearm asm
 - Adapted Sebastians test for arm
v2: https://patch.msgid.link/20260424-tonyk-robust_arm-v2-0-db4e46f752cf@igalia.com

Changes in v2:
 - s/CONFIG_COMPAT/CONFIG_COMPAT_VDSO (Thomas Weißschuh)
 - Fixed linker not finding the symbols (Thomas Weißschuh)
v1: https://patch.msgid.link/20260417-tonyk-robust_arm-v1-0-03aa64e2ff1a@igalia.com

---
André Almeida (5):
      arm64: vdso: Prepare for robust futex unlock support
      arm64: vdso: Implement __vdso_futex_robust_try_unlock()
      selftests: futex: Add support for aarch64 in robust_list_critical
      arm64: vdso32: Bring vdso32-offsets.h back
      arm64: vdso32: Implement __vdso_futex_robust_try_unlock()

 arch/arm64/Kconfig                                 |  1 +
 arch/arm64/Makefile                                |  2 +-
 arch/arm64/include/asm/futex_robust.h              | 20 +++++
 arch/arm64/include/asm/vdso.h                      |  3 +
 arch/arm64/kernel/vdso.c                           | 34 ++++++++
 arch/arm64/kernel/vdso/Makefile                    |  9 ++-
 arch/arm64/kernel/vdso/vdso.lds.S                  |  5 ++
 arch/arm64/kernel/vdso/vfutex.c                    | 34 ++++++++
 arch/arm64/kernel/vdso32/Makefile                  | 10 ++-
 arch/arm64/kernel/vdso32/vdso.lds.S                |  5 ++
 arch/arm64/kernel/vdso32/vfutex.c                  | 33 ++++++++
 arch/x86/entry/vdso/vma.c                          |  4 +-
 include/linux/futex.h                              | 13 +--
 include/vdso/futex.h                               |  1 +
 .../futex/functional/robust_list_critical.c        | 92 ++++++++++++++++++++--
 15 files changed, 245 insertions(+), 21 deletions(-)
---
base-commit: 78333d5371a5fe6f3eaec5e6e4c16d22fe386cbe
change-id: 20260416-tonyk-robust_arm-54ff77d2c4e4

Best regards,
--  
André Almeida <andrealmeid@igalia.com>

