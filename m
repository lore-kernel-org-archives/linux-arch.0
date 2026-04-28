Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DC13F54D9;
	Tue, 28 Apr 2026 07:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360842; cv=none; b=khtGB3QalFRO+K3+1ZLITOPfjfgc+zsbP3MkhDOho++tzVbEZ3q7mJmaR/HBHlOzB6KsOXbAXuucN8oysPLUxplUyP+8NaxxPEiX8nHMRPZDEjATqzhNGRS3cvDruyDJM9DybpfHVyvm39+QQWiYDTZMXaBH2HPGQPwbThgxk+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360842; c=relaxed/simple;
	bh=7BQIk5pvORGUkLbKpjnxkQ4oY6i8zRO5e45MEUEzEQc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LbLCSYDBSWfJorz+1MT4iTdZw3AGyWv38X5egFAiRatLwTo1S1+dPtTJa6jklTh6qkUfM/WQugVitR+cjf11TifrRisbgIzxV9E4zkPXZXHqzHP2VeFJ/MjqI3ZmDN75dm3g9g9krOkgIXSS96fxXopmhoPXpfbSC4CXRoLtzsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxrOm5X_Bp2KgEAA--.14158S3;
	Tue, 28 Apr 2026 15:20:26 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxjcK3X_BpkWV2AA--.26183S2;
	Tue, 28 Apr 2026 15:20:24 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] Move thread_info into task_struct for LoongArch
Date: Tue, 28 Apr 2026 15:20:18 +0800
Message-ID: <20260428072021.7289-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxjcK3X_BpkWV2AA--.26183S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7AF45uw1xArWkZFy7Kr1fXwc_yoW8Jw4rpF
	9rZrnxJr4rGr93Arnxt34Durn8Jw1xKw1ag3ZIy348CF42vF1UXr1kGrykXFyDtayrtrW0
	qF1rGwn0gF1UJacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UWHqcUUUUU=

This is still an RFC, based on 7.1-rc1. I will perform more tests locally.
Looking forward to more review comments and test results.

Tiezhu Yang (3):
  LoongArch: Implement CONFIG_THREAD_INFO_IN_TASK
  LoongArch: BPF: Inline bpf_get_current_task{_btf}() helpers
  LoongArch: BPF: Inline bpf_get_smp_processor_id() helper

 arch/loongarch/Kconfig                   |  1 +
 arch/loongarch/include/asm/current.h     | 22 ++++++++++++
 arch/loongarch/include/asm/processor.h   | 44 +++---------------------
 arch/loongarch/include/asm/ptrace.h      |  6 ----
 arch/loongarch/include/asm/smp.h         |  3 +-
 arch/loongarch/include/asm/stackframe.h  |  9 +++--
 arch/loongarch/include/asm/switch_to.h   | 15 ++++++--
 arch/loongarch/include/asm/thread_info.h | 13 +------
 arch/loongarch/kernel/asm-offsets.c      |  7 ++--
 arch/loongarch/kernel/entry.S            |  7 ++--
 arch/loongarch/kernel/head.S             | 18 ++++++----
 arch/loongarch/kernel/process.c          |  6 ++++
 arch/loongarch/kernel/relocate.c         |  2 +-
 arch/loongarch/kernel/setup.c            |  3 ++
 arch/loongarch/kernel/smp.c              |  8 +++--
 arch/loongarch/kernel/switch.S           |  9 ++---
 arch/loongarch/net/bpf_jit.c             | 26 ++++++++++++++
 17 files changed, 115 insertions(+), 84 deletions(-)
 create mode 100644 arch/loongarch/include/asm/current.h

-- 
2.42.0

