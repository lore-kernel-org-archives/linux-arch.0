Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE73A271456;
	Wed, 25 Feb 2026 02:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771987642; cv=none; b=oBQqtUB4EuPdIvM5p10cHG8ZAocQGm/GRQPVz8CVTGJ6njQqL2HFNTLe/385DyajCv94frvY31rc0vCKFuAM01Dmlk4sajcvRL9CW6fjH6wlHy02DzhAAYwEQWQqITfOAdzImFkU867xEhzP2IlTTJBTCNxcFUFVdIUtJJq5b1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771987642; c=relaxed/simple;
	bh=vnPzHx0X/qaS6meC3nBcsauKU3RBIOk3biR3/9t4ODk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ukMJDBqXgcZAg0EaN+cIV/AfSzvFdpkI45OAT/rI2DMWdtzYMbEWPM58wICT9zddytow40j9RG7+bJ/WMbBD1UNjnc+zu0W3+hHmjSNMivx0AgI7vJ3mkaisCJfP0Wb+cbpeuWX/OXFX68Va5O0M8cfBPzLzrLdUjdX/Ytn7+8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=stDtDriJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="stDtDriJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAEBC116D0;
	Wed, 25 Feb 2026 02:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771987642;
	bh=vnPzHx0X/qaS6meC3nBcsauKU3RBIOk3biR3/9t4ODk=;
	h=From:To:Cc:Subject:Date:From;
	b=stDtDriJGui+0odZNwqsvA76+vpX+4SHYSS9OG+eD1s99Tg/Y42wjUOBagzvtdA4v
	 69WWme479xenxH1MNW/u8YA+T6HnB1yHV2cV+g6ybyYAo451OPJh/Ys8+1DPNySX1K
	 d4zce//Y8CmiRcCel8Q6I14Bbuj/cGX/dK4Sad3xfUiLLWdL25n1+86EOgWBOwNAvO
	 UXlSXjma3TYYxewIRf0sTfI4THijJHVSXgPczPQ0m9uw0lJDZZXzLCaPm7ov6Yf8ii
	 OrnjSr6yEhzp0qIhos/IgbLOBlUZlZ0LtOh3nyBtUgb6PZielmZ+as4EJ7uwQYMDl2
	 CZ2qF7Nn4Emdg==
From: Kees Cook <kees@kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Jingwei Wang <wangjingwei@iscas.ac.cn>,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] vdso/datapage: Define vdso data pointers as arrays
Date: Tue, 24 Feb 2026 18:47:20 -0800
Message-Id: <20260225024716.work.043-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5715; i=kees@kernel.org; h=from:subject:message-id; bh=vnPzHx0X/qaS6meC3nBcsauKU3RBIOk3biR3/9t4ODk=; b=owGbwMvMwCVmps19z/KJym7G02pJDJnzknZsuJb2USV14adTcQcCL30xvpOZcWfjhS/xfQ0iz 34HN5370lHKwiDGxSArpsgSZOce5+Lxtj3cfa4izBxWJpAhDFycAjCR3esYGS4o3/n2va/9ybWP /9cw/pPazPRPdnujnVb0LlVH+XZpc32Gf+ZTbkmweLeuSlCT8y8pa9Cy2LphcufXtfat/0K4NQ0 6OAE=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The vdso_u_time_data, vdso_u_rng_data, and vdso_u_arch_data arrays
are seen by GCC as single instances (due to their declarations in
include/vdso/datapage.h). When the vdso data pointers are dereferenced
with an offset, GCC thinks there is an access beyond the returned single
instance. These are actually arrays constructed at link time, so declare
them as such.

Silence the warning seen with -Warray-bounds:

In file included from ../include/linux/export.h:5,
                 from ../include/linux/linkage.h:7,
                 from ../arch/x86/include/asm/cache.h:5,
                 from ../include/vdso/cache.h:5,
                 from ../include/linux/cache.h:6,
                 from ../include/linux/time.h:5,
                 from ../arch/x86/entry/vdso/vclock_gettime.c:11:
In function 'vdso_read_begin',
    inlined from 'do_coarse_timens' at ../arch/x86/entry/vdso/../../../../lib/vdso/gettimeofday.c:204:9,
    inlined from 'do_coarse' at ../arch/x86/entry/vdso/../../../../lib/vdso/gettimeofday.c:233:12,
    inlined from '__cvdso_clock_gettime_common' at ../arch/x86/entry/vdso/../../../../lib/vdso/gettimeofday.c:305:10,
    inlined from '__cvdso_clock_gettime_data.constprop' at ../arch/x86/entry/vdso/../../../../lib/vdso/gettimeofday.c:322:7:
../include/asm-generic/rwonce.h:44:26: error: array subscript 1024 is outside array bounds of 'struct vdso_time_data[1]' [-Werror=array-bounds=]
...
../include/vdso/helpers.h:14:32: note: in expansion of macro 'READ_ONCE'
   14 |         while (unlikely((seq = READ_ONCE(vc->seq)) & 1))
      |                                ^~~~~~~~~

Reachable via:

static __always_inline const struct vdso_time_data *__arch_get_vdso_u_time_data(void)
{
        return &vdso_u_time_data;
}
...
        return __cvdso_clock_gettime_data(__arch_get_vdso_u_time_data(), clock, ts);
...
__cvdso_clock_gettime_common(const struct vdso_time_data *vd, ...)
...
	const struct vdso_clock *vc = vd->clock_data;
...
	if (likely(msk & VDSO_HRES))
		vc = &vc[CS_HRES_COARSE];
...
	while (unlikely((seq = READ_ONCE(vc->seq)) & 1))

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: <linux-arch@vger.kernel.org>
---
 include/asm-generic/vdso/vsyscall.h | 4 ++--
 include/vdso/datapage.h             | 6 +++---
 arch/loongarch/vdso/vgetcpu.c       | 2 +-
 arch/riscv/kernel/vdso/hwprobe.c    | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/vsyscall.h
index 5c6d9799f4e7..743056f804ed 100644
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -7,14 +7,14 @@
 #ifndef __arch_get_vdso_u_time_data
 static __always_inline const struct vdso_time_data *__arch_get_vdso_u_time_data(void)
 {
-	return &vdso_u_time_data;
+	return vdso_u_time_data;
 }
 #endif
 
 #ifndef __arch_get_vdso_u_rng_data
 static __always_inline const struct vdso_rng_data *__arch_get_vdso_u_rng_data(void)
 {
-	return &vdso_u_rng_data;
+	return vdso_u_rng_data;
 }
 #endif
 
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 23c39b96190f..8c3408c8b126 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -164,9 +164,9 @@ struct vdso_rng_data {
  * With the hidden visibility, the compiler simply generates a PC-relative
  * relocation, and this is what we need.
  */
-extern struct vdso_time_data vdso_u_time_data __attribute__((visibility("hidden")));
-extern struct vdso_rng_data vdso_u_rng_data __attribute__((visibility("hidden")));
-extern struct vdso_arch_data vdso_u_arch_data __attribute__((visibility("hidden")));
+extern struct vdso_time_data vdso_u_time_data[] __attribute__((visibility("hidden")));
+extern struct vdso_rng_data vdso_u_rng_data[] __attribute__((visibility("hidden")));
+extern struct vdso_arch_data vdso_u_arch_data[] __attribute__((visibility("hidden")));
 
 extern struct vdso_time_data *vdso_k_time_data;
 extern struct vdso_rng_data *vdso_k_rng_data;
diff --git a/arch/loongarch/vdso/vgetcpu.c b/arch/loongarch/vdso/vgetcpu.c
index 73af49242ecd..d09f9d860bf0 100644
--- a/arch/loongarch/vdso/vgetcpu.c
+++ b/arch/loongarch/vdso/vgetcpu.c
@@ -39,7 +39,7 @@ int __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache *un
 		*cpu = cpu_id;
 
 	if (node)
-		*node = vdso_u_arch_data.pdata[cpu_id].node;
+		*node = vdso_u_arch_data->pdata[cpu_id].node;
 
 	return 0;
 }
diff --git a/arch/riscv/kernel/vdso/hwprobe.c b/arch/riscv/kernel/vdso/hwprobe.c
index 8f45500d0a6e..fc2ab4e6a9ab 100644
--- a/arch/riscv/kernel/vdso/hwprobe.c
+++ b/arch/riscv/kernel/vdso/hwprobe.c
@@ -16,7 +16,7 @@ static int riscv_vdso_get_values(struct riscv_hwprobe *pairs, size_t pair_count,
 				 size_t cpusetsize, unsigned long *cpus,
 				 unsigned int flags)
 {
-	const struct vdso_arch_data *avd = &vdso_u_arch_data;
+	const struct vdso_arch_data *avd = vdso_u_arch_data;
 	bool all_cpus = !cpusetsize && !cpus;
 	struct riscv_hwprobe *p = pairs;
 	struct riscv_hwprobe *end = pairs + pair_count;
@@ -50,7 +50,7 @@ static int riscv_vdso_get_cpus(struct riscv_hwprobe *pairs, size_t pair_count,
 			       size_t cpusetsize, unsigned long *cpus,
 			       unsigned int flags)
 {
-	const struct vdso_arch_data *avd = &vdso_u_arch_data;
+	const struct vdso_arch_data *avd = vdso_u_arch_data;
 	struct riscv_hwprobe *p = pairs;
 	struct riscv_hwprobe *end = pairs + pair_count;
 	unsigned char *c = (unsigned char *)cpus;
-- 
2.34.1

