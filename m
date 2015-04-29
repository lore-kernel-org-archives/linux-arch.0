From: David Howells <dhowells@redhat.com>
Subject: [RFC][PATCH 00/13] Convert bitop funcs to bool return type and
 propagate to various callers/users
Date: Wed, 29 Apr 2015 20:21:33 +0100
Message-ID: <20150429192133.24909.43184.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


Attached are a bunch of patches that convert bitop functions that return a
boolean value (eg. test_and_set_bit()) to return a bool type rather than an
integer.  This is then propagated to a number of callers and users of these
functions.

The patches can also be found here:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=bool-experimental

Note that this only touches the x86 arch and only for my configuration.  I
haven't tried any other arches as yet nor other configurations.

This allows the compiler to make slightly better optimisations in some cases,
though functions that used to return a non-zero/zero integer as true/false now
get slightly bigger as they have to return one/zero instead (typically a
matter of 3 bytes or so on x86_64).  Quite a few functions, however, get
smaller but in most cases, because the altered functions are inline, and
because if() converts the value to bool anyway, there is no change.

Further, with gcc-5, warnings are given about using an unwrapped '!' operator
on the LHS of a comparison expression.  Note that these warnings aren't given
if the thing on the RHS is a bool.

Yet further, it permits "!!test_bit()" constructs to be converted to
"test_bit()" as the "!!" becomes redundant.

On my test kernel which has a bunch of drivers built in sufficient to boot my
test box, a reduction in .text size of 256 bytes is seen.  Below is a table
detailing the changes in size of individual function objects:

	warthog>../compare-elf.pl build/vmlinux.old build/vmlinux
	build/vmlinux.old has 65065 symbols
	build/vmlinux has 65065 symbols
	ELF 1 ADDR       ELF 2 ADDR       SIZE2 dSIZ NAME
	================ ================ ===== ==== ================
	ffffffff81006305 ffffffff81006305    24   +5 default_check_phys_apicid
	ffffffff81029070 ffffffff81029074   265   -5 perf_ibs_stop
	ffffffff8102ec75 ffffffff8102ec75    15   -2 default_apic_id_valid
	ffffffff8102ecaa ffffffff8102eca8    20   +3 default_check_apicid_used
	ffffffff81032008 ffffffff81032009    15   -2 default_apic_id_valid
	ffffffff810320ed ffffffff810320ec    45   +5 flat_apic_id_registered
	ffffffff81035be3 ffffffff81035be7   279   -6 kern_addr_valid
	ffffffff810360f9 ffffffff810360f7   330  -17 dump_pagetable
	ffffffff810362e6 ffffffff810362d3    50  -11 spurious_fault_check
	ffffffff81036323 ffffffff81036305   301  -16 spurious_fault
	ffffffff810365f3 ffffffff810365c5   821  -20 no_context
	ffffffff81037f2e ffffffff81037eec   343   -5 unmap_pmd_range
	ffffffff810385ad ffffffff81038566   189  -10 lookup_address_in_pgd
	ffffffff8103b126 ffffffff8103b0d5    24   -6 ptep_set_access_flags
	ffffffff8103b144 ffffffff8103b0ed    24   -3 ptep_test_and_clear_young
	ffffffff8103b1b8 ffffffff8103b15e   110   -3 pud_set_huge
	ffffffff8103b229 ffffffff8103b1cc   110   -3 pmd_set_huge
	ffffffff8103b29a ffffffff8103b23a    35   -3 pud_clear_huge
	ffffffff8103b2c0 ffffffff8103b25d    22  -16 pmd_clear_huge
	ffffffff8103b586 ffffffff8103b513   374  -10 gup_pud_range
	ffffffff810452b1 ffffffff81045231    23   +5 test_taint
	ffffffff81075009 ffffffff81074f8e  1936   +5 select_task_rq_fair
	ffffffff81090f33 ffffffff81090ebd    47   +5 memory_bm_test_bit
	ffffffff810b36f2 ffffffff810b3681    28   +3 tick_is_broadcast_device
	ffffffff810b38f1 ffffffff810b3883    30   +5 tick_check_broadcast_expi
	ffffffff810b3a33 ffffffff810b39ca   244   +2 tick_device_uses_broadcas
	ffffffff810b3d2c ffffffff810b3cc5    16   -2 tick_broadcast_oneshot_ac
	ffffffff810cde6c ffffffff810cde03   536  +10 __cpuset_node_allowed
	ffffffff81109c5a ffffffff81109bfb  1362  -16 generic_file_read_iter
	ffffffff81111e1e ffffffff81111daf   349   -3 __test_set_page_writeback
	ffffffff8111207a ffffffff81112008    94   -3 set_page_dirty
	ffffffff81112128 ffffffff811120b3   181   -3 clear_page_dirty_for_io
	ffffffff811127f6 ffffffff8111277e   209   -3 __set_page_dirty_nobuffer
	ffffffff8111421b ffffffff811141a0    30   -3 __set_page_dirty_no_write
	ffffffff8111423c ffffffff811141be   405   -6 test_clear_page_writeback
	ffffffff81119e57 ffffffff81119dd3  2605   -7 shrink_page_list
	ffffffff8112aa62 ffffffff8112a9d7   706  -23 follow_page_mask
	ffffffff8112ca3a ffffffff8112c998  1383  -24 unmap_single_vma
	ffffffff8112d17c ffffffff8112d0c2  1151   +1 do_wp_page
	ffffffff8112ea0e ffffffff8112e955  3453   -1 handle_mm_fault
	ffffffff811303a4 ffffffff811302ea   563   -2 munlock_vma_pages_range
	ffffffff811321ab ffffffff811320ef   138   +6 vma_wants_writenotify
	ffffffff81133f59 ffffffff81133ea3  1091  -11 change_protection
	ffffffff811343a7 ffffffff811342e6   445   -1 mprotect_fixup
	ffffffff81135bb5 ffffffff81135af3   674  -24 try_to_unmap_one
	ffffffff81136b0c ffffffff81136a32   256   -3 page_referenced
	ffffffff8114026d ffffffff81140190   364  +12 queue_pages_pte_range
	ffffffff81183d5b ffffffff81183c8a   159  -19 __set_page_dirty_buffers
	ffffffff811abf09 ffffffff811abe25   331  -15 gather_pte_stats
	ffffffff811ac063 ffffffff811abf70   456  -13 smaps_pte_range
	ffffffff811c5e3e ffffffff811c5d3e   476   +9 ext3_orphan_get
	ffffffff811e0645 ffffffff811e054e   490   +9 ext4_orphan_get
	ffffffff811fce65 ffffffff811fcd77   479   -9 ext4_commit_super
	ffffffff8122689d ffffffff812267a6   177   -3 __journal_refile_buffer
	ffffffff8122a315 ffffffff8122a21b   208   +2 journal_cancel_revoke
	ffffffff8122fdad ffffffff8122fcb5   176   -3 __jbd2_journal_refile_buf
	ffffffff812340cc ffffffff81233fd1   210   +3 jbd2_journal_cancel_revok
	ffffffff812dbe40 ffffffff812dbd48    22   +3 radix_tree_tagged
	ffffffff812e48f9 ffffffff812e47f9    75   -6 __bitmap_equal
	ffffffff812e497b ffffffff812e4875    81   -2 __bitmap_and
	ffffffff812e4a1c ffffffff812e4914    87   -2 __bitmap_andnot
	ffffffff812e4a75 ffffffff812e496b    77   -6 __bitmap_intersects
	ffffffff812e4ac8 ffffffff812e49b8    80   -6 __bitmap_subset
	ffffffff8142eb56 ffffffff8142ea36  1171   -5 input_handle_event
	ffffffff8142f05a ffffffff8142ef35   386   -2 input_inject_event
	ffffffff814bfc55 ffffffff814bfb35   343   -3 flow_cache_flush
	ffffffff814ce9cf ffffffff814ce8ac   374   +3 netlink_has_listeners
	ffffffff814cf076 ffffffff814cef56    77   +5 netlink_update_socket_mc

As can be seen, most of the size changes are negative indicating the function
ended up smaller.  After changing the return values of the bitops functions, I
attacked things that appeared in this list, trying to make them smaller.

The script that generated the above table is:

	#!/usr/bin/perl -w
	#
	# Compare the layout of ELF files
	#
	use strict;
	no warnings 'portable';  # Support for 64-bit ints required

	die "Format: compare-elf.pl <file1> <file2>\n" unless ($#ARGV == 1);

	###############################################################################
	#
	# Use readelf to scan a file; load the data into an array and sort it.
	#
	###############################################################################
	sub read_elf($$) {
	    my ($file, $array) = @_;

	    @{$array} = ();

	    open FD, "readelf -s $file|" || die "$file";
	    while (<FD>) {
		chomp;
		next if ($_ eq "");
		next if (/^\s+Num:/);
		next if (/^Symbol table/);
		$_ =~ s/^ +//;

		my @bits = split(/\s+/, $_);
		die "Odd line ", $#bits, ": '$_'\n" unless ($#bits >= 6);

		my ($num, $value, $size, $type, $bind, $vis, $section, $name) = @bits;

		if ($size =~ /^0x/) {
		    $size = hex($size);
		} else {
		    $size = int($size);
		}
		next if ($type eq "FILE");
		next if ($type eq "SECTION");
		push @{$array}, [ hex($value), $size, $type, $name ];
	    }
	}

	my @sysmap1;
	my @sysmap2;

	read_elf($ARGV[0], \@sysmap1);
	read_elf($ARGV[1], \@sysmap2);

	@sysmap1 = sort { $a->[0] <=> $b->[0] } @sysmap1;
	@sysmap2 = sort { $a->[0] <=> $b->[0] } @sysmap2;

	print $ARGV[0], " has ", $#sysmap1 + 1, " symbols\n";
	print $ARGV[1], " has ", $#sysmap2 + 1, " symbols\n";

	my $i1 = 0;
	my $i2 = 0;
	my $offset = 0;

	print("ELF 1 ADDR       ELF 2 ADDR       SIZE2 dSIZ NAME\n");
	print("================ ================ ===== ==== ================\n");
	while ($i1 <= $#sysmap1) {
	    my $this1 = $sysmap1[$i1++];
	    my $this2 = $sysmap2[$i2++];

	    if ($this1->[1] != $this2->[1]) {
		printf("%016x %016x %5d %+4d %s\n",
		       $this1->[0],
		       $this2->[0],
		       $this2->[1],
		       $this2->[1] - $this1->[1],
		       $this1->[3]);
	    }
	}


David
---
David Howells (13):
      Make the x86 bitops like test_bit() return bool
      Make bitmap functions that return boolean values return a bool type
      Make generic bitops return bool
      Make cpumask functions that return boolean values return bool
      Make nodemask functions that return a boolean value return bool
      Make a bunch of mm funcs return bool when they're returning a boolean value
      Make some apic functions return bool when returning a boolean value
      Make tick functions that return a boolean value return bool
      input: Use bool and don't use !! on test_bit
      Use bool with jbd2_journal_cancel_revoke()
      test_taint() should return bool
      netlink: Use bool when returning boolean values
      Make xfrm functions that return a boolean value return bool


 arch/x86/include/asm/apic.h                |   22 +++---
 arch/x86/include/asm/bitops.h              |   28 ++++---
 arch/x86/include/asm/pgtable.h             |  110 ++++++++++++++--------------
 arch/x86/include/asm/rmwcc.h               |    4 +
 arch/x86/kernel/apic/apic_flat_64.c        |    2 -
 arch/x86/kernel/apic/apic_noop.c           |    2 -
 arch/x86/kernel/setup.c                    |    2 -
 arch/x86/mm/pgtable.c                      |   62 ++++++++--------
 drivers/hid/hid-input.c                    |    4 +
 drivers/input/input.c                      |   12 ++-
 drivers/staging/lustre/lustre/llite/rw26.c |    2 -
 fs/afs/internal.h                          |    2 -
 fs/afs/write.c                             |    2 -
 fs/buffer.c                                |    4 +
 fs/ceph/addr.c                             |    6 +-
 fs/ext3/inode.c                            |    2 -
 fs/ext4/inode.c                            |    2 -
 fs/gfs2/aops.c                             |    4 +
 fs/jbd2/revoke.c                           |   10 +--
 fs/libfs.c                                 |    4 +
 include/asm-generic/bitops/ext2-atomic.h   |    4 +
 include/asm-generic/bitops/le.h            |   10 +--
 include/asm-generic/pgtable.h              |   32 ++++----
 include/linux/bitmap.h                     |   30 ++++----
 include/linux/buffer_head.h                |    8 +-
 include/linux/clockchips.h                 |    6 +-
 include/linux/cpumask.h                    |   12 ++-
 include/linux/fs.h                         |    4 +
 include/linux/hugetlb.h                    |   16 ++--
 include/linux/hugetlb_inline.h             |    6 +-
 include/linux/jbd2.h                       |    2 -
 include/linux/kernel.h                     |    2 -
 include/linux/mm.h                         |   14 ++--
 include/linux/netfilter/nfnetlink.h        |    2 -
 include/linux/netlink.h                    |    2 -
 include/linux/nodemask.h                   |   16 ++--
 include/linux/page-flags.h                 |   28 ++++---
 include/linux/radix-tree.h                 |    2 -
 include/linux/suspend.h                    |    2 -
 include/linux/swap.h                       |    2 -
 include/net/xfrm.h                         |    8 +-
 kernel/panic.c                             |    2 -
 kernel/power/snapshot.c                    |    8 +-
 kernel/time/tick-broadcast.c               |   16 ++--
 kernel/time/tick-internal.h                |    6 +-
 lib/bitmap.c                               |   32 ++++----
 lib/radix-tree.c                           |    4 +
 mm/mmap.c                                  |   16 ++--
 mm/page-writeback.c                        |   44 ++++++-----
 mm/page_io.c                               |    2 -
 net/netfilter/nfnetlink.c                  |    2 -
 net/netlink/af_netlink.c                   |   21 +++--
 52 files changed, 324 insertions(+), 323 deletions(-)
