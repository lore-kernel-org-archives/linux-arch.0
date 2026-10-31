Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.42.203.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793452201;
	b=wMqgQtHMFCgmR9z8bistCTymPuBsd5+i1KcFuLJWEqe3yRnf/SfS99g0fE1mpzzjLkDD
	 4oWygsgBwS5uUDUBkFxLFrzyFpVy36YkHsrrDc7+qQPHNAA0fhPrTf8HmFQc3l1JAjeNh
	 xLAfv6VoLeRrf/zBW4EDFWL5F1nve+mWRDw5OobImWkODVcrk7mzp7TEPswgdfzCPbhTW
	 qDxpmcaYwSm2DplPyeFmA6ettIH91+2TRMC374eHS+rYUbtq/lhN8GYqVUbgdpTdha7nR
	 BYbdO146nduj7apkyWOea+tKFf0U8W78IdHDdKUWgX8tN2uNXmgqxuXF5TAg4We7y3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793452201;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=qpRQyl+F0iyCWogSrvS1H906Iwx+X1/j+/wJASJUclQ=;
	b=u9uwzvQGYD/D733R/GZ06y5lDFciGq50YqiW87qmR8KUPaFxpkI+5BgxN/A5iseW+65c
	 pjWAhRwpIAOBFvs9DFRJZ4JZ3alIze4963AT94D973bED/KfP/LeGRjFL+duEb8Ls4OJH
	 C4AOFTMZ7BsfFG5eQoa/Q8csmYkbR6DZrP6yENyIyjTswNBsHScUlfvOFZPhVn06rl0+2
	 UrHSAF1MmHNyP50APVrAAMhzKIX9SFSD+j3cJs6hcdwF3PNLaKKeIu9rUAoXdKW8dUNKR
	 WaYaBLMASMXgadlNi2Yzx4Sesi6lkebgOG/FHw+uYfw1/OeeWwsfv4Np+uWcSK78FZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=njInuDVE;
	arc=none smtp.remote-ip=52.42.203.116
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CF8606A31A;
	Sat, 31 Oct 2026 13:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10CF8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=njInuDVE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1793452201; x=1824988201;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qpRQyl+F0iyCWogSrvS1H906Iwx+X1/j+/wJASJUclQ=;
  b=njInuDVEda+lcVa35YS8nSSsra2aAQm8GRxZ8F9+Rv99/EAg8nMQ5aBC
   T2LRDbw///U/kIJwyGD95M2dmOiR03O7BpBGkrTWU/ZOaPXMYLjXJVQ/s
   3jzqEKZoTZ1iXBzDnqJfuqSYw3YGtfZGDmk0U+LAeOeOzE+V5/VDZf25W
   Sw64NESf8kCsJk4N67sCYDDCf3YIayMWXmWhDR3XHNr41IMwjFU7lkVnL
   a7tEivaJ2jRds8imizf+PT2y8WikW9J6zmiezR5zUC+PCs5ZB8b5+9BNL
   97vzPFBdgXYfQBBR5EqLeh7TGN0coZUrQKcvA3Bj9rBsNjAOXDu8iOsBT
   g==;
X-CSE-ConnectionGUID: yl+j7SMISFCmSqa074HKsQ==
X-CSE-MsgGUID: EkYm3CWrQUC8iV6hmcVX0Q==
X-IronPort-AV: E=Sophos;i="6.27,188,1787011200"; 
   d="scan'208";a="32781343"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 13:10:00 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:18493]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.238:2525] with esmtp (Farcaster)
 id f6314dd5-b68f-40bd-afa9-ac54f6d9e237; Sat, 31 Oct 2026 13:10:00 +0000 (UTC)
X-Farcaster-Flow-ID: f6314dd5-b68f-40bd-afa9-ac54f6d9e237
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sat, 31 Oct 2026 13:10:00 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Sat, 31 Oct 2026 13:09:59 +0000
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
Subject: [PATCH bpf-next 00/13] bpf: keep the vmlinux BTF compressed until first use (CONFIG_DEBUG_INFO_BTF_LAZY) to save ~6 MB memory
Date: Sat, 31 Oct 2026 13:09:46 +0000
Message-ID: <20261031130959.23472-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
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
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

This series follows the feedback on the previous posting, "[PATCH
bpf-next v4 00/12] bpf: make the vmlinux BTF an on-demand loadable
module (CONFIG_DEBUG_INFO_BTF=m) to save ~5.4 MB memory":
https://lore.kernel.org/bpf/20261001225214.12351-1-wanjay@amazon.com/

Based on and tested against bpf-next commit 7101b10cf281 ("Merge branch
'bpf-add-syscall-common-attrs-support-for-xdp-link_create'"), plus
commit fb2b27d214c3 ("bpf: Propagate btf_add_type() errors in
btf_check_all_metas()") from the bpf tree, which a first use that runs
out of memory relies on.

This series adds CONFIG_DEBUG_INFO_BTF_LAZY.  With it, the kernel image
keeps the vmlinux BTF zstd-compressed, and the kernel decompresses and
parses it the first time something needs it, instead of at boot.  On a
system that never uses BTF this saves ~6 MB of memory with a
distribution config; the first user waits ~15 ms once, and from then
on everything is as without the option.  The option is off by default.

The option is currently available on x86 and arm64 only.  On several
other architectures the boot image is a stripped ELF copy of vmlinux,
which would carry the 5-7 MB of uncompressed BTF that the kernel never
uses; they can follow once their boot images drop it.

It replaces the CONFIG_DEBUG_INFO_BTF=m series [1]: compression is the
approach Ihor proposed there and prototyped [2], Alexei preferred it
[3], and Ihor agreed to this series taking it to submission [4].

Problem
-------

The vmlinux BTF is 5-7 MB of read-only data in every kernel built with
CONFIG_DEBUG_INFO_BTF=y, and the kernel parses it at boot whether or
not anything on the system uses it.  A distribution ships one kernel
build to all its users, so it cannot turn BTF off for the ones who do
not need it without taking it away from the ones who do: CO-RE,
fentry/fexit, kfuncs, struct_ops, sched_ext and BPF LSM all depend on
it.

Approach
--------

Nothing is removed, only deferred, and nothing waits for user space:
whoever needs the BTF first decompresses and parses it synchronously,
so every caller of bpf_get_btf_vmlinux() still gets the BTF or an
error.  The work is in finding the first users and in what has to wait
for them:

 - Who needs it (patches 1-3).  bpf_check() fetched the BTF for every
   program; now it is fetched where kernel types enter a program, and
   program context types are matched by name, so the socket filters
   and cgroup programs systemd loads at boot do not parse it.  Neither
   can an unprivileged bpffs mount with delegate options.

 - Where it must not be parsed (patches 7, 8).  The CO-RE candidate
   lookup and the tracefs btf_ids file fetch it before taking their
   mutex.  The trace readers print BTF-typed arguments under the trace
   locks while the tracer records; tracing now parses the BTF when such
   output is enabled, and the printers never parse it.

 - Boot-time registrations (patches 4, 6, 10).  kfunc sets and
   struct_ops registered by initcalls are queued and replayed by the
   task that parses the BTF, before it publishes it.  A first use that
   runs out of memory, e.g. because its task is being killed, is undone
   and left to the next one.

 - Module BTF (patches 5, 11).  Module BTF is split BTF on top of the
   vmlinux BTF.  Modules that load before the first use keep their BTF
   unparsed and serve it in sysfs; it is parsed together with the
   vmlinux BTF.

Systems that use BTF end up with the same memory as today: the
compressed copy is freed once it is decompressed.  What still parses
the BTF at boot: BPF LSM programs (systemd loads one when "bpf" is in
the LSM list), the iterators of CONFIG_BPF_PRELOAD (at the first bpffs
mount, which systemd does at boot), and modules with distilled base
BTF.

Patches 1-8 prepare and are small changes on their own; their
changelogs say what, if anything, changes without the option.  Patch 9
adds the option and keeps the BTF compressed; 10 and 11 defer the
registrations and module BTF; 12 keeps two selftests working without
__start_BTF; 13 documents the option.

Patches 1, 3, 4, 7 and 8 are Ihor's, adapted to the current tree.
Patches 2, 5, 9, 10 and 11 are co-developed with him: 9 reworks his
compression patch, and 2, 5, 10 and 11 combine his rework with parts
of the =m series.

Testing
-------

Tested with a distribution config, the option on against off, with
module BTF.  A kprobe event on btf_parse_vmlinux() shows when the BTF
gets parsed, without needing BTF itself:

  # cd /sys/kernel/tracing
  # echo 'p:parse btf_parse_vmlinux' >> kprobe_events
  # echo 1 > events/kprobes/parse/enable
  # grep btf_vmlinux /proc/vmallocinfo
      -> only btf_vmlinux_keep_zst: the compressed copy, ~1.4 MB.
  # ls -la /sys/kernel/btf/vmlinux
      -> the full size, ~5.5 MB, although nothing is decompressed yet.
  # modprobe ext4; ls /sys/kernel/btf
      -> ext4 and its dependencies are there right away, although
         their BTF is only kept, not parsed.
  # cat /sys/kernel/btf/vmlinux > /dev/null
  # grep btf_vmlinux /proc/vmallocinfo
      -> btf_vmlinux_data: the decompressed copy, ~5.5 MB; the
         compressed copy is freed.
  # grep parse kprobe_profile
      -> parse 0: reading the file did not parse the BTF.
  # bpftool btf list
      -> vmlinux, ext4 and its dependencies get BTF ids, and
         kprobe_profile counts one parse.

Results:

 - Without a BTF user, MemTotal is 5.4-6.7 MB higher with the option,
   slab ~2 MB lower, and the compressed copy takes ~1.4 MB of vmalloc:
   ~6-7 MB more free memory.  After the first use the decompressed copy
   takes ~5.5 MB of vmalloc, and slab is as with the option off.
   The ~5.4 MB quoted for the =m series [1] counted MemTotal alone,
   i.e. the size of .BTF.  The figure here also counts the ~2 MB that
   parsing the BTF at boot allocates (=m saved that too), minus the
   ~1.4 MB compressed copy.
 - The first use takes ~15 ms: ~7 ms to decompress, ~6 ms to parse,
   ~1 ms for the kept module BTF and the queued registrations.
 - Each of these, as the first user on a fresh boot, parses the BTF
   and works: kfunc calls, a struct_ops map, a kptr to task_struct,
   ksyms and map_ptr access, bpf_snprintf_btf(), BPF_BTF_GET_NEXT_ID,
   kprobe events with BTF arguments, func-args, funcgraph-args and
   funcgraph-retval, a tracepoint's btf_ids file, a bpffs mount with
   delegate option names, loading a module with distilled base BTF,
   and four program loads at once.  Modules loaded before have their
   BTF, and the kfuncs they registered from init, in place after it;
   modules removed before leave nothing behind.
 - These do not parse it: socket filters (also failing ones, and ones
   with func_info and an extension of them), a light skeleton loader,
   CO-RE relocations done by libbpf, the programs systemd loads at
   boot, stat(), read() and mmap() of /sys/kernel/btf/vmlinux, reading
   a module's BTF file, BPF_BTF_GET_NEXT_ID without CAP_SYS_ADMIN, and
   an unprivileged map_ptr access or attach_btf_id.
 - A module with broken BTF loads, loses its BTF at the first use and
   stays loaded.
 - Lockdep, kmemleak and KASAN kernels run the same cases cleanly.  A
   fault injection sweep fails each of the 750 allocations of a first
   use in turn, one per boot; each failure leaves nothing published,
   and the next use completes.
 - With systemd as init, its BPF LSM program parses the BTF at boot
   when "bpf" is in the LSM list; without it, and without
   CONFIG_BPF_PRELOAD, nothing does.
 - Every patch builds with and without BTF.  Neither the x86
   compressed image nor the arm64 Image carries the uncompressed BTF.

[1] https://lore.kernel.org/bpf/20261001225214.12351-1-wanjay@amazon.com/
[2] https://lore.kernel.org/bpf/44315425-c505-46fe-8379-f19d78ff3abb@linux.dev/
[3] https://lore.kernel.org/bpf/DLUZVHOLSN1B.115EUX4KJBEA3@gmail.com/
[4] https://lore.kernel.org/bpf/7844ef03-d9b2-4a10-8f14-1b498ada9043@linux.dev/

Ihor Solodrai (5):
  bpf: match program context types by name without vmlinux BTF
  bpf: check CAP_SYS_ADMIN before looking up bpffs delegation names
  bpf: move bpf_get_btf_vmlinux() to btf.c
  bpf: parse the vmlinux BTF before taking cand_cache_mutex
  tracing: parse the vmlinux BTF when BTF-typed output is enabled

Jay Wang (8):
  bpf: fetch the vmlinux BTF where kernel types enter a program
  bpf: let btf_parse_module() adopt the caller's copy of the module BTF
  bpf: look up the struct_ops common value type in the given BTF
  bpf: keep the vmlinux BTF zstd-compressed in the kernel image
  bpf: defer kfunc and struct_ops registrations until first BTF use
  bpf: keep module BTF until the vmlinux BTF is parsed
  selftests/bpf: keep ksyms and linked_vars working without __start_BTF
  Documentation/bpf: describe CONFIG_DEBUG_INFO_BTF_LAZY

 Documentation/bpf/btf.rst                     |  30 +
 arch/x86/boot/compressed/Makefile             |   2 +-
 include/asm-generic/vmlinux.lds.h             |  24 +-
 include/linux/bpf.h                           |   1 +
 include/linux/btf.h                           |   5 +
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/bpf_struct_ops.c                   |   4 +-
 kernel/bpf/btf.c                              | 636 +++++++++++++++---
 kernel/bpf/inode.c                            |  11 +-
 kernel/bpf/syscall.c                          |  12 +-
 kernel/bpf/sysfs_btf.c                        | 167 ++++-
 kernel/bpf/verifier.c                         | 115 ++--
 kernel/trace/bpf_trace.c                      |   3 +-
 kernel/trace/trace_btf.c                      |  32 +
 kernel/trace/trace_btf.h                      |   3 +
 kernel/trace/trace_events.c                   |   4 +
 kernel/trace/trace_functions.c                |   4 +
 kernel/trace/trace_functions_graph.c          |  15 +-
 kernel/trace/trace_output.c                   |   3 +
 lib/Kconfig.debug                             |  24 +
 scripts/gen-btf.sh                            |  25 +-
 .../testing/selftests/bpf/prog_tests/ksyms.c  |   8 +-
 .../selftests/bpf/progs/linked_vars2.c        |   4 +-
 .../testing/selftests/bpf/progs/test_ksyms.c  |   5 +-
 24 files changed, 951 insertions(+), 188 deletions(-)


base-commit: 7101b10cf281f629ac58c99697ca6f6d082b99a7
prerequisite-patch-id: 7f71e8747677477d27e903f08839dcecfd176ade
-- 
2.47.3

