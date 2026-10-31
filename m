Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.42.203.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793452340;
	b=r0vKi4WVKyom3rdhgK+vGZZXPFNDpNvbjvuTFz1NRGt+i1fui9sDsEawnMMhgySXHVmg
	 bMEzyLHenlQigKGjhdJ4oZ2jo2ICpZ7UHXcRIrwb4kBquR0/WiHV9YIMSl1Wtp+o5wZgL
	 q4A4Sp705CkxwZYF/tO9FJD/8+mEZfQtSw5zk+qhHIC3Py1jhdiInhwTk8FhUEz/RwF/q
	 djF96ATV5xQK/StEa3yJzXZccvfWZpKuJudNiEV/RugSeV0Ci3uV+ASDtRuZcHptN9A6p
	 maJ8q84/b//kz1ExwUE0/UHzMHk4PkcKPzt8V24U+905PlqlCmvl4sm6s17FiDv2qnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793452340;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=sPwFncXFZYt429eDYcsZYoVbrXtolcdAoZY8cqt3DJ0=;
	b=HL8jh9C7/Odwbcno2UQveAt5U7n3L5EVo+57aRy7gIKUy+rC3t5hKTNhaprIBXD5M0IU
	 ohQYtm9a30bKadd9maMYc7mdvEvFU664vNaAiGyywIHx7m+H4h+fhrgW1cfN1m2O+WsSU
	 bcOLH8MRq4kurSNthAgvwV3EV6lLATEkkCfVH1IFYFZMQWxg4JyQOHtoCOAkZr+0YiXea
	 R7NQCM06qHAbzYpoqO2lyw/BlUN8JdRk1m2u9y3i0ED1FlL17ondCPHCVyh00UP2LiiNx
	 kl+fAKAFN6qHdw3o8N7gMn3ZSicJsblc8l+R0Q6RmkxQ9sT+5hPJlVUYu9nNw8kE4JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=Cy5wOTBS;
	arc=none smtp.remote-ip=52.42.203.116
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39519606A31A;
	Sat, 31 Oct 2026 13:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39519606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=Cy5wOTBS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793452340; x=1824988340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sPwFncXFZYt429eDYcsZYoVbrXtolcdAoZY8cqt3DJ0=;
  b=Cy5wOTBSsQDSndR/NYVK5mYtU34n7qxiv2uGLngJi5/2/EZYoXZrg9qi
   dIPnkjHV0akmTs60yLoeEt7qTQsHMWo0FGxvQTeocevRFYoi5IFu0TDqy
   J8+dMHyLmzv0mO6YtBEcE5ZnxmHPZuWktAYDNfT44u1sx8vo546QcPtWS
   iE2iS0rsuWmbMdJt3aQH2BuytXP58VmQrNdDJPk9RPu+r+itvj4p9lV2m
   WMVNjifKIw9BzULz0A30jROmZ89EUTwwEWWOBBrWSXwCew78hUWhImdEO
   eVj0PXjj8eZHJuBa0MUDZGI0+DefwUQFivGFWMnE5X/v05sPyCdUlkyeL
   A==;
X-CSE-ConnectionGUID: 7/p+FJHQRRWKGWvdXA/b0w==
X-CSE-MsgGUID: 8WgVVBEzTgWOXPaiMdZC/g==
X-IronPort-AV: E=Sophos;i="6.27,188,1787011200"; 
   d="scan'208";a="32781475"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 13:12:20 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:18621]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.238:2525] with esmtp (Farcaster)
 id b9e2cf49-def2-4ba4-87a3-26380d899b99; Sat, 31 Oct 2026 13:12:19 +0000 (UTC)
X-Farcaster-Flow-ID: b9e2cf49-def2-4ba4-87a3-26380d899b99
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sat, 31 Oct 2026 13:12:19 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sat, 31 Oct 2026 13:12:19 +0000
From: Jay Wang <wanjay@amazon.com>
To: <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	"Eduard Zingerman" <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi
	<memxor@gmail.com>
CC: Ihor Solodrai <ihor.solodrai@linux.dev>, Alan Maguire
	<almagui@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song
	<yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Steven Rostedt
	<rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>,
	<linux-trace-kernel@vger.kernel.org>, Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>, <linux-kbuild@vger.kernel.org>, "Arnd
 Bergmann" <arnd@arndb.de>, <linux-arch@vger.kernel.org>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Hazem Mohamed
 Abuelfotoh" <abuehaze@amazon.com>, Bjoern Doebel <doebel@amazon.de>, "Martin
 Pohlack" <mpohlack@amazon.de>, <jay.wang.upstream@gmail.com>
Subject: [PATCH bpf-next 09/13] bpf: keep the vmlinux BTF zstd-compressed in the kernel image
Date: Sat, 31 Oct 2026 13:09:55 +0000
Message-ID: <20261031130959.23472-10-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261031130959.23472-1-wanjay@amazon.com>
References: <20261031130959.23472-1-wanjay@amazon.com>
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
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The vmlinux BTF is 5-7 MB of read-only data in every kernel built with
CONFIG_DEBUG_INFO_BTF=y, resident whether or not anything on the system
ever uses BTF.  Add CONFIG_DEBUG_INFO_BTF_LAZY to keep it compressed
with zstd in the image instead, at about a quarter of the size, and
decompress it in the kernel when it is first needed.  This is the
transport half of the option; the next two patches defer the
parsing.

kbuild: gen_btf_o() in scripts/gen-btf.sh compresses the final
${ELF}.BTF with zstd -19 and adds it as a second section, .init.BTF.zst,
of the same .btf.o, so neither an extra link pass nor a size
reservation is needed.  .BTF stays in the vmlinux ELF file as a
non-alloc section: pahole --btf_base, resolve_btfids for modules,
bpftool and libbpf's on-disk fallback find it by name and keep working
unchanged, and so do out-of-tree module builds.  The linker script
puts .init.BTF.zst in INIT_DATA, bounded by __start_BTF_zst and
__stop_BTF_zst, and .BTF in ELF_DETAILS at address 0.  The BTF macro
is renamed RO_BTF, because the token BTF in ".BTF 0 : { ... }" would
otherwise be macro-expanded.  x86 strips .BTF from the ELF it puts in
the compressed boot image, and arm64 makes its Image with objcopy
-O binary, which drops non-alloc sections.  The option is limited to
these two architectures for now: several others build their boot
image from a stripped ELF copy of vmlinux, which keeps non-alloc
sections and would carry the uncompressed BTF.  The inline BTF
(CONFIG_DEBUG_INFO_BTF_INLINE) is left as it is: built in, .BTF.inline
stays in the image; as a module it is not in memory anyway.

kernel: btf_vmlinux_data() returns the raw BTF.  With the option it
decompresses the blob once, under a leaf mutex, into vmalloc_user()
memory that is never freed; the size comes from the zstd frame header,
so /sys/kernel/btf/vmlinux gets its size without decompressing.  A
late_initcall_sync copies the blob out of init memory before that is
freed, unless it is decompressed by then, and the copy is freed after
decompression, so a system that uses BTF ends up with the same
footprint as today.  The copy uses vmalloc(): kvmemdup() of the
~1.4 MB blob would get a 2 MB kmalloc_large() allocation.  If the copy
fails, the BTF is unavailable for the rest of the boot: that is logged
once, and later fetches fail with -ENOMEM right away instead of
allocating the raw buffer for nothing each time.  A blob that does not
decompress is logged once and dropped, and fetches fail with -EINVAL
from then on.  btf_parse_vmlinux() and the read and mmap handlers of
/sys/kernel/btf/vmlinux use btf_vmlinux_data(); mmap of the
decompressed copy uses remap_vmalloc_range().  Without the option
btf_vmlinux_data() returns __start_BTF, and the sysfs file keeps its
current handlers.

btf_vmlinux_data() lives in sysfs_btf.c, which is now built whenever
CONFIG_DEBUG_INFO_BTF is enabled, with the sysfs file itself still
under CONFIG_SYSFS: btf_parse_vmlinux() needs the data without sysfs
too, and with the option the blob has to be copied out of init memory
either way.

Reading /sys/kernel/btf/vmlinux decompresses but never parses, and
only vmalloc and zstd run under btf_vmlinux_data_lock, so the sysfs
mmap path (mmap_lock -> kernfs -> btf_vmlinux_data_lock) cannot form
a cycle with module or cand_cache locks.

On its own this patch only changes where the bytes come from: initcall
kfunc registrations still parse the vmlinux BTF at boot.

Measured with a distribution config: the raw .BTF is 5.47 MB on x86_64
and 5.57 MB on arm64, and 1.44 and 1.46 MB with zstd -19.  xz -9e would
save another 0.17 MB but decodes about 6 times slower (72 vs 12 ms in
user space).  Decompression in the kernel takes ~7 ms on x86_64.

Trade-offs: the compressed blob stays resident on systems that never
use BTF (~1.4 MB), so with the next two patches they save about 80% of
what the BTF costs rather than all of it (~6 of ~7.5 MB, the raw BTF
plus what parsing it allocates); the x86 bzImage on disk is ~0.3 MB
smaller; building needs the zstd tool; __start_BTF/__stop_BTF do not
exist with the option (the ksyms and linked_vars selftests use them; a
later patch adapts them).

Co-developed-by: Ihor Solodrai <ihor.solodrai@linux.dev>
TODO-NEEDS-IHOR: Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 arch/x86/boot/compressed/Makefile |   2 +-
 include/asm-generic/vmlinux.lds.h |  24 ++++-
 include/linux/btf.h               |   5 +
 kernel/bpf/Makefile               |   2 +-
 kernel/bpf/btf.c                  |  13 ++-
 kernel/bpf/sysfs_btf.c            | 167 +++++++++++++++++++++++++++++-
 lib/Kconfig.debug                 |  16 +++
 scripts/gen-btf.sh                |  25 +++--
 8 files changed, 232 insertions(+), 22 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 680ad803cba7..58d05262dec8 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -116,7 +116,7 @@ endif
 $(obj)/vmlinux: $(vmlinux-objs-y) $(vmlinux-libs-y) FORCE
 	$(call if_changed,ld)
 
-OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
+OBJCOPYFLAGS_vmlinux.bin :=  -R .comment $(if $(CONFIG_DEBUG_INFO_BTF_LAZY),-R .BTF) -S
 $(obj)/vmlinux.bin: vmlinux FORCE
 	$(call if_changed,objcopy)
 
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 3eb732942d69..7358aedab95c 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -553,7 +553,7 @@
 									\
 	RO_EXCEPTION_TABLE						\
 	NOTES								\
-	BTF								\
+	RO_BTF								\
 									\
 	. = ALIGN((align));						\
 	__end_rodata = .;
@@ -704,12 +704,24 @@
 #define BTF_INLINE_LINK
 #endif
 
-#ifdef CONFIG_DEBUG_INFO_BTF
-#define BTF								\
+#ifdef CONFIG_DEBUG_INFO_BTF_LAZY
+/* compressed BTF in init data (see sysfs_btf.c), raw BTF not loaded */
+#define BTF_LOADED
+#define BTF_ZST		. = ALIGN(8); BOUNDED_SECTION_BY(.init.BTF.zst, _BTF_zst)
+#define BTF_RAW		.BTF 0 : { *(.BTF) }
+#else
+#define BTF_LOADED							\
 	. = ALIGN(PAGE_SIZE);						\
 	.BTF : AT(ADDR(.BTF) - LOAD_OFFSET) {				\
 		BOUNDED_SECTION_BY(.BTF, _BTF)				\
-	}								\
+	}
+#define BTF_ZST
+#define BTF_RAW
+#endif
+
+#ifdef CONFIG_DEBUG_INFO_BTF
+#define RO_BTF								\
+	BTF_LOADED							\
 	BTF_INLINE							\
 	BTF_INLINE_LINK						\
 	. = ALIGN(PAGE_SIZE);						\
@@ -717,7 +729,7 @@
 		*(.BTF_ids)						\
 	}
 #else
-#define BTF
+#define RO_BTF
 #endif
 
 /*
@@ -748,6 +760,7 @@
 	KERNEL_CTORS()							\
 	MCOUNT_REC()							\
 	*(.init.rodata .init.rodata.*)					\
+	BTF_ZST								\
 	FTRACE_EVENTS()							\
 	TRACE_SYSCALLS()						\
 	KPROBE_BLACKLIST()						\
@@ -880,6 +893,7 @@
 /* Required sections not related to debugging. */
 #define ELF_DETAILS							\
 		.comment 0 : { *(.comment) }				\
+		BTF_RAW							\
 		.symtab 0 : { *(.symtab) }				\
 		.strtab 0 : { *(.strtab) }				\
 		.shstrtab 0 : { *(.shstrtab) }				\
diff --git a/include/linux/btf.h b/include/linux/btf.h
index b66e20a18c54..b6d5a7f59852 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -617,6 +617,11 @@ __u32 *btf_field_iter_next(struct btf_field_iter *it);
 const char *btf_name_by_offset(const struct btf *btf, u32 offset);
 const char *btf_str_by_offset(const struct btf *btf, u32 offset);
 struct btf *btf_parse_vmlinux(void);
+#ifdef CONFIG_DEBUG_INFO_BTF
+void *btf_vmlinux_data(u32 *size);
+#else
+static inline void *btf_vmlinux_data(u32 *size) { return ERR_PTR(-ENOENT); }
+#endif
 struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog);
 u32 *btf_kfunc_flags(const struct btf *btf, u32 kfunc_btf_id, const struct bpf_prog *prog);
 int btf_kfunc_check_flag(const struct btf *btf, u32 kfunc_btf_id, u32 flag);
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 269810b128c4..4f500927cec8 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -40,8 +40,8 @@ obj-$(CONFIG_CGROUP_BPF) += cgroup.o
 ifeq ($(CONFIG_INET),y)
 obj-$(CONFIG_BPF_SYSCALL) += reuseport_array.o
 endif
-ifeq ($(CONFIG_SYSFS),y)
 obj-$(CONFIG_DEBUG_INFO_BTF) += sysfs_btf.o
+ifeq ($(CONFIG_SYSFS),y)
 obj-$(CONFIG_DEBUG_INFO_BTF_INLINE) += btf_vmlinux_inline.o
 endif
 ifeq ($(CONFIG_BPF_JIT),y)
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 70adc52f5d7c..a7bb780743fb 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1901,7 +1901,8 @@ static void btf_free(struct btf *btf)
 	kvfree(btf->resolved_sizes);
 	kvfree(btf->resolved_ids);
 	/* vmlinux does not allocate btf->data, it simply points it at
-	 * __start_BTF.
+	 * __start_BTF, or at the decompressed copy with
+	 * CONFIG_DEBUG_INFO_BTF_LAZY, which is never freed either.
 	 */
 	if (!btf_is_vmlinux(btf))
 		kvfree(btf->data);
@@ -6523,8 +6524,6 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr,
 	return ERR_PTR(err);
 }
 
-extern char __start_BTF[];
-extern char __stop_BTF[];
 extern struct btf *btf_vmlinux;
 
 #define BPF_MAP_TYPE(_id, _ops)
@@ -6900,15 +6899,21 @@ struct btf *btf_parse_vmlinux(void)
 	struct btf_verifier_env *env = NULL;
 	struct bpf_verifier_log *log;
 	struct btf *btf;
+	void *data;
+	u32 size;
 	int err;
 
+	data = btf_vmlinux_data(&size);
+	if (IS_ERR(data))
+		return ERR_CAST(data);
+
 	env = kzalloc_obj(*env, GFP_KERNEL | __GFP_NOWARN);
 	if (!env)
 		return ERR_PTR(-ENOMEM);
 
 	log = &env->log;
 	log->level = BPF_LOG_KERNEL;
-	btf = btf_parse_base(env, "vmlinux", __start_BTF, __stop_BTF - __start_BTF);
+	btf = btf_parse_base(env, "vmlinux", data, size);
 	if (IS_ERR(btf))
 		goto err_out;
 
diff --git a/kernel/bpf/sysfs_btf.c b/kernel/bpf/sysfs_btf.c
index 556fe92c3649..015cd8221154 100644
--- a/kernel/bpf/sysfs_btf.c
+++ b/kernel/bpf/sysfs_btf.c
@@ -12,11 +12,126 @@
 #include <linux/vmalloc.h>
 #include <linux/io.h>
 #include <linux/btf.h>
+#include <linux/zstd.h>
 
+#ifdef CONFIG_DEBUG_INFO_BTF_LAZY
+/* See scripts/gen-btf.sh, gen_btf_o() for details */
+extern char __start_BTF_zst[];
+extern char __stop_BTF_zst[];
+
+static DEFINE_MUTEX(btf_vmlinux_data_lock);
+static void *btf_vmlinux_raw;
+static u32 btf_vmlinux_raw_size;
+static bool btf_vmlinux_broken;
+/* Compressed BTF: init data until btf_vmlinux_keep_zst(), freed once decompressed */
+static void *btf_zst = __start_BTF_zst;
+
+static u32 btf_vmlinux_size(void)
+{
+	zstd_frame_header hdr;
+
+	guard(mutex)(&btf_vmlinux_data_lock);
+	if (!btf_vmlinux_raw_size && btf_zst &&
+	    !zstd_get_frame_header(&hdr, btf_zst, __stop_BTF_zst - __start_BTF_zst) &&
+	    hdr.frameContentSize < U32_MAX)
+		btf_vmlinux_raw_size = hdr.frameContentSize;
+	return btf_vmlinux_raw_size;
+}
+
+static void btf_vmlinux_drop_zst(void)
+{
+	if (btf_zst != __start_BTF_zst)
+		vfree(btf_zst);
+	btf_zst = NULL;
+}
+
+/*
+ * The raw vmlinux BTF, decompressed on first use and never freed, or
+ * ERR_PTR(-ENOMEM) if that cannot be done (now: memory; for good: no copy of
+ * the compressed BTF), or ERR_PTR(-EINVAL) if it is broken.
+ */
+void *btf_vmlinux_data(u32 *size)
+{
+	size_t ret, ws_size = zstd_dctx_workspace_bound();
+	void *raw, *ws;
+
+	/* Pairs with smp_store_release() below */
+	raw = smp_load_acquire(&btf_vmlinux_raw);
+	if (raw) {
+		*size = btf_vmlinux_raw_size;
+		return raw;
+	}
+
+	*size = btf_vmlinux_size();
+	guard(mutex)(&btf_vmlinux_data_lock);
+	if (btf_vmlinux_raw)
+		return btf_vmlinux_raw;
+	if (!btf_zst)
+		return ERR_PTR(btf_vmlinux_broken ? -EINVAL : -ENOMEM);
+	if (!*size) {
+		pr_err("BTF: no size in the compressed vmlinux BTF\n");
+		btf_vmlinux_broken = true;
+		btf_vmlinux_drop_zst();
+		return ERR_PTR(-EINVAL);
+	}
+	/* vmalloc_user(): btf_sysfs_vmlinux_mmap() maps it to user space */
+	raw = vmalloc_user(*size);
+	ws = kvmalloc(ws_size, GFP_KERNEL);
+	if (raw && ws) {
+		ret = zstd_decompress_dctx(zstd_init_dctx(ws, ws_size), raw, *size,
+					   btf_zst, __stop_BTF_zst - __start_BTF_zst);
+		if (!zstd_is_error(ret) && ret == *size) {
+			/* Pairs with smp_load_acquire() above */
+			smp_store_release(&btf_vmlinux_raw, raw);
+		} else {
+			pr_err("BTF: cannot decompress the vmlinux BTF: %s\n",
+			       zstd_is_error(ret) ? zstd_get_error_name(ret) : "size mismatch");
+			btf_vmlinux_broken = true;
+		}
+		btf_vmlinux_drop_zst();
+	}
+	kvfree(ws);
+	if (btf_vmlinux_raw)
+		return btf_vmlinux_raw;
+	vfree(raw);
+	return ERR_PTR(btf_vmlinux_broken ? -EINVAL : -ENOMEM);
+}
+
+/* Keep a copy of the compressed BTF before init memory is freed */
+static int __init btf_vmlinux_keep_zst(void)
+{
+	size_t size = __stop_BTF_zst - __start_BTF_zst;
+
+	guard(mutex)(&btf_vmlinux_data_lock);
+	if (btf_zst) {
+		/* vmalloc(): kmalloc() would round up to a power of 2 */
+		btf_zst = vmalloc(size);
+		if (btf_zst)
+			memcpy(btf_zst, __start_BTF_zst, size);
+		else
+			pr_err("BTF: out of memory, vmlinux BTF unavailable\n");
+	}
+	return 0;
+}
+late_initcall_sync(btf_vmlinux_keep_zst);
+#else
 /* See scripts/link-vmlinux.sh, gen_btf() func for details */
 extern char __start_BTF[];
 extern char __stop_BTF[];
 
+static u32 btf_vmlinux_size(void)
+{
+	return __stop_BTF - __start_BTF;
+}
+
+void *btf_vmlinux_data(u32 *size)
+{
+	*size = btf_vmlinux_size();
+	return __start_BTF;
+}
+#endif
+
+#ifdef CONFIG_SYSFS
 static int btf_sysfs_mmap_check(void *data, size_t size, struct vm_area_struct *vma)
 {
 	unsigned long pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
@@ -61,10 +176,49 @@ static int btf_sysfs_mmap_image(struct file *filp, struct kobject *kobj,
 	return remap_pfn_range(vma, vma->vm_start, pfn, vm_size, vma->vm_page_prot);
 }
 
+#ifdef CONFIG_DEBUG_INFO_BTF_LAZY
+/* Reading or mapping the file decompresses the BTF but does not parse it */
+static int btf_sysfs_vmlinux_mmap(struct file *filp, struct kobject *kobj,
+				  const struct bin_attribute *attr,
+				  struct vm_area_struct *vma)
+{
+	void *data;
+	u32 size;
+	int err;
+
+	data = btf_vmlinux_data(&size);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	err = btf_sysfs_mmap_check(data, attr->size, vma);
+	if (err)
+		return err;
+
+	return remap_vmalloc_range(vma, data, 0);
+}
+
+static ssize_t btf_sysfs_vmlinux_read(struct file *filp, struct kobject *kobj,
+				      const struct bin_attribute *attr, char *buf,
+				      loff_t off, size_t count)
+{
+	void *data;
+	u32 size;
+
+	data = btf_vmlinux_data(&size);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	return memory_read_from_buffer(buf, count, &off, data, size);
+}
+#else
+#define btf_sysfs_vmlinux_read	sysfs_bin_attr_simple_read
+#define btf_sysfs_vmlinux_mmap	btf_sysfs_mmap_image
+#endif
+
 static struct bin_attribute bin_attr_btf_vmlinux __ro_after_init = {
 	.attr = { .name = "vmlinux", .mode = 0444, },
-	.read = sysfs_bin_attr_simple_read,
-	.mmap = btf_sysfs_mmap_image,
+	.read = btf_sysfs_vmlinux_read,
+	.mmap = btf_sysfs_vmlinux_mmap,
 };
 
 struct kobject *btf_kobj;
@@ -180,8 +334,12 @@ void sysfs_btf_remove(struct bin_attribute *attr)
 
 static int __init btf_vmlinux_init(void)
 {
-	bin_attr_btf_vmlinux.private = __start_BTF;
-	bin_attr_btf_vmlinux.size = __stop_BTF - __start_BTF;
+	u32 size;
+
+	/* with CONFIG_DEBUG_INFO_BTF_LAZY the read and mmap handlers get it */
+	if (!IS_ENABLED(CONFIG_DEBUG_INFO_BTF_LAZY))
+		bin_attr_btf_vmlinux.private = btf_vmlinux_data(&size);
+	bin_attr_btf_vmlinux.size = btf_vmlinux_size();
 
 	if (bin_attr_btf_vmlinux.size == 0)
 		return 0;
@@ -194,3 +352,4 @@ static int __init btf_vmlinux_init(void)
 }
 
 subsys_initcall(btf_vmlinux_init);
+#endif /* CONFIG_SYSFS */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2d22638ec13a..700c4f67bdd8 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -408,6 +408,22 @@ config DEBUG_INFO_BTF
 	  Turning this on requires pahole v1.22 or later, which will convert
 	  DWARF type info into equivalent deduplicated BTF type info.
 
+config DEBUG_INFO_BTF_LAZY
+	bool "Compress vmlinux BTF and parse it on first use"
+	depends on DEBUG_INFO_BTF
+	depends on X86 || ARM64
+	select ZSTD_DECOMPRESS
+	help
+	  Keep the vmlinux BTF zstd-compressed in the kernel image, at about
+	  a quarter of its size, and decompress and parse it the first time
+	  something needs it instead of at boot.  Systems that never use BTF
+	  then keep only the compressed copy in memory, which saves about 80%
+	  of what the BTF costs; the first user pays a few tens of
+	  milliseconds once.  The vmlinux file keeps the uncompressed BTF as
+	  a non-loaded section for tools.  Building needs the zstd tool.
+
+	  If unsure, say N.
+
 config PAHOLE_HAS_BTF_TAG
 	def_bool PAHOLE_VERSION >= 123
 	depends on CC_IS_CLANG
diff --git a/scripts/gen-btf.sh b/scripts/gen-btf.sh
index b17f1189298a..c490b0630612 100755
--- a/scripts/gen-btf.sh
+++ b/scripts/gen-btf.sh
@@ -86,13 +86,24 @@ gen_btf_o()
 	btf_data=${ELF_FILE}.btf.o
 
 	# Create ${btf_data} which contains just BTF sections but no symbols. Add
-	# SHF_ALLOC because .BTF will be part of the vmlinux image. --strip-all
-	# deletes all symbols including __start_BTF and __stop_BTF, which will
-	# be redefined in the linker script.
+	# SHF_ALLOC to the sections that will be part of the vmlinux image.
+	# --strip-all deletes all symbols including __start_BTF and __stop_BTF,
+	# which will be redefined in the linker script.
 	echo "" | ${CC} ${CLANG_FLAGS} ${KBUILD_CPPFLAGS} ${KBUILD_CFLAGS} -fno-lto -c -x c -o ${btf_data} -
-	${OBJCOPY} --add-section .BTF=${ELF_FILE}.BTF \
-		--set-section-flags .BTF=alloc,readonly ${btf_data}
-	ONLY_SEC="--only-section=.BTF"
+	if is_enabled CONFIG_DEBUG_INFO_BTF_LAZY; then
+		# The image gets compressed BTF as init data, .BTF stays in
+		# the ELF file for tools.
+		${ZSTD} -q -f -19 ${ELF_FILE}.BTF -o ${ELF_FILE}.BTF.zst
+		${OBJCOPY} --add-section .BTF=${ELF_FILE}.BTF \
+			--set-section-flags .BTF=readonly \
+			--add-section .init.BTF.zst=${ELF_FILE}.BTF.zst \
+			--set-section-flags .init.BTF.zst=alloc,readonly ${btf_data}
+		ONLY_SEC="--only-section=.BTF --only-section=.init.BTF.zst"
+	else
+		${OBJCOPY} --add-section .BTF=${ELF_FILE}.BTF \
+			--set-section-flags .BTF=alloc,readonly ${btf_data}
+		ONLY_SEC="--only-section=.BTF"
+	fi
 	btf_inline=${ELF_FILE}.BTF.inline
 	if [ "${BTF_INLINE}" = "m" ]; then
 		if [ -f "${btf_inline}" ]; then
@@ -145,7 +156,7 @@ embed_btf_data()
 cleanup()
 {
 	rm -f "${ELF_FILE}.BTF.1"
-	rm -f "${ELF_FILE}.BTF"
+	rm -f "${ELF_FILE}.BTF" "${ELF_FILE}.BTF.zst"
 	rm -f "${ELF_FILE}.BTF.inline"
 	rm -f "${ELF_FILE}.BTF.inline.link"
 	if [ "${BTFGEN_MODE}" = "module" ]; then
-- 
2.47.3

