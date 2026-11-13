Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575962;
	b=eHui5KQGgV1tIAaGNcrXcRg6ylbgIOClylZDTUlUM8zXjHPWm1WiqaVSAM7eNE1p6YO+
	 K5A9UwBXzabt1jCKJEResPjaPZ25tmzYhDobKKQB/VmbAgxf/1chlBDMaTa5oLi4efuUW
	 IytiyECssUB1VYxBQqsPHmux0neJQvL8iRmX1o0ThmcSHHbMwUZ6rx85hInBvSBQd+XnG
	 6n5EqQiZpMq7/xoH23oKec27+ALshtxZGYv9H0iUcoUXEgbfVhVb1st7Wosj5L8Kzr8Wn
	 AXXUrjghPDCme/ribAQXMcLBvc1dXtL6wI7OCoFiYReJcht7MbGOYj9waKuOVkm0UeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575962;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WHY+8I3fXBrwECRQRQwc27pmPFAuQe8kSc5abxVwo8A=;
	b=zbPsNKohDGWaeV2VVYBrOV6M2jL3QENgUhiT1xH5kSEwZx4UUEDALdTYWozzW+6qjmo0
	 zHa10fODtg+1CB65EdpXQqv+bkwWh2aya0GquCaSQ/DU85uRSAppt9rOT3DN7aHYZ4uoT
	 BDdeXU5HDIDX5bCHYsJ6JuxlGMRfZ0Xx96ZxfB/Pe6GsiCZAc3G9DJtJWhXRy/NGRPPQb
	 UZUYoddXpkgrlG8s7i4Ow4G3l2DZcCIU54ibL2uArG8vSWYSmR6kMT3O9vgbPIdwR0V7u
	 +UT0r/OQ/sg4WOYkWd7nlqKZMqf8JSwxIFM4+d23n1gTjHmnj+DKHYRhCHej/0NOLLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=bDJyICoo;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CFE606B570;
	Fri, 13 Nov 2026 13:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06CFE606B570
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=bDJyICoo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794575952;
	bh=WHY+8I3fXBrwECRQRQwc27pmPFAuQe8kSc5abxVwo8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bDJyICooaKcDSek4/A4H+S+weKzQTQDleKQPO4COpfpcZOVV1ac9mO5nbp/hmwrV/
	 AQVk1PDb7U7fYHLenbjMC3xnAy+P3hSG5uUwUDSNq70We787UQx/ZaMiBNmRdwf7mw
	 VkZP66ATHNuO4m1MAB/whXO+4dOyg6pZ5NBUeexxKGMewN3gWdzbZ2XZqhthTNWHaX
	 kvWZ0bwRDCRd0Ll2L/8NqJziOZdv2kNu/7CkgPzI1mpqFslGSd03KSZDYdmxYBqorq
	 O9yAOCDKLLf1y6q155foRI21EXgT7N8THnQxxlukXlnQmMSf+y5BerbQYVD2ztJLX1
	 TIrv4ikp/QPeQ==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jQyX00WW2zQ2n;
	Fri, 13 Nov 2026 08:19:12 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Michal Clapinski <mclapinski@google.com>,
	Andrei Vagin <avagin@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Aniket Gattani <aniketgattani@google.com>,
	linux-kselftest@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Gellermann <christian.gellermann@codasip.com>,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	John David Anglin <dave.anglin@bell.net>,
	linux-parisc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Guo Ren <guoren@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-csky@vger.kernel.org,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	linux-openrisc@vger.kernel.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	linux-arch@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Andy Lutomirski <luto@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Boqun Feng <boqun@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	lkmm@lists.linux.dev,
	bpf@vger.kernel.org,
	Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH 14/16] MAINTAINERS: Add the membarrier selftests to MEMBARRIER SUPPORT
Date: Fri, 13 Nov 2026 08:19:01 -0500
Message-Id: <20261113131903.157186-15-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261113131903.157186-1-mathieu.desnoyers@efficios.com>
References: <20261113131903.157186-1-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MEMBARRIER SUPPORT entry does not list the membarrier selftests.
get_maintainer.pl does not report the membarrier maintainers for a
change to these tests.

Add tools/testing/selftests/membarrier/ to the entry.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 222b7fc2c3aa..2ee220ccc5e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17435,6 +17435,7 @@ F:	arch/*/include/asm/membarrier.h
 F:	arch/*/include/asm/sync_core.h
 F:	include/uapi/linux/membarrier.h
 F:	kernel/sched/membarrier.c
+F:	tools/testing/selftests/membarrier/
 
 MEMBLOCK AND MEMORY MANAGEMENT INITIALIZATION
 M:	Mike Rapoport <rppt@kernel.org>
-- 
2.47.3

