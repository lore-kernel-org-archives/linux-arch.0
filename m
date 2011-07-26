From: Yinghai Lu <yhlu.kernel@gmail.com>
Subject: Re: [PATCHSET tip:x86/memblock] memblock: Kill early_node_map[]
Date: Tue, 26 Jul 2011 14:14:28 -0700
Message-ID: <CAE9FiQX0i2UwO9fSntwSEMUWiO6KdzbQth8Bf+_9OnKXntasKQ@mail.gmail.com>
References: <1311694534-5161-1-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43832 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753819Ab1GZVO3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 26 Jul 2011 17:14:29 -0400
In-Reply-To: <1311694534-5161-1-git-send-email-tj@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>
Cc: benh@kernel.crashing.org, tony.luck@intel.com, ralf@linux-mips.org, schwidefsky@de.ibm.com, liqin.chen@sunplusct.com, lethal@linux-sh.org, davem@davemloft.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com

On Tue, Jul 26, 2011 at 8:35 AM, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> This patchset builds on the previous "memblock, x86: Allow node info
> in memblock and remove x86 specific memblock code" patchset, which no=
w
> is in tip:x86/memblock. =A0This patchset updates memblock so that it'=
s
> easier to use, converts all archs which use early_node_map[] to use
> memblock instead, and kills early_node_map[].
>
> Bootmem allocator is still looming there but this ensures a unified
> way forward where memblock is the universal early memory management
> mechanism. =A0This cleans up the entanglement between memblock and
> early_node_map[] in the backend but API visible to archs is still a
> bit confusing and can use some cleanup and documentation once things
> settle down a bit.
>
> x86, powerpc and sparc are boot tested in several different
> configurations. =A0On x86 allmod/noconfigs are compile tested. =A0On =
all
> other archs except for score, defconfig + some variations are compile
> tested.
>
> This does touch a lot of archs but except for x86 and powerpc the
> changes are mostly trivial and as bulk of the changes involve updates
> to generic memblock code, it would be great if these can be routed
> through single tree (tip:x86/memblock).
>
> David, Ben, Paul, patches 0015-0017 are identical sans some offsets t=
o
> the previously posted versions.
>
> =A00001-memblock-Make-memblock_overlaps_region-static.patch
> =A00002-memblock-Make-memblock_-add-remove-free-reserve-retu.patch
> =A00003-memblock-Use-memblock_reserve-in-memblock-internal-f.patch
> =A00004-memblock-Add-__memblock_dump_all.patch
> =A00005-memblock-Kill-sentinel-entries-at-the-end-of-static-.patch
> =A00006-memblock-Kill-memblock_init.patch
> =A00007-memblock-Separate-out-memblock_isolate_range-from-me.patch
> =A00008-memblock-Reimplement-__memblock_remove-using-membloc.patch
> =A00009-memblock-Make-memblock-functions-handle-overflowing-.patch
> =A00010-memblock-Reimplement-memblock_enforce_memory_limit-u.patch
> =A00011-powerpc-Cleanup-memblock-usage.patch
> =A00012-memblock-Track-total-size-of-regions-automatically.patch
> =A00013-memblock-s-memblock_analyze-memblock_allow_resize-an.patch
> =A00014-memblock-Implement-memblock_add_node.patch
> =A00015-powerpc-Use-HAVE_MEMBLOCK_NODE_MAP.patch
> =A00016-sparc-Use-HAVE_MEMBLOCK_NODE_MAP.patch
> =A00017-SuperH-Use-HAVE_MEMBLOCK_NODE_MAP.patch
> =A00018-ia64-Use-HAVE_MEMBLOCK_NODE_MAP.patch
> =A00019-mips-Use-HAVE_MEMBLOCK_NODE_MAP.patch
> =A00020-s390-Use-HAVE_MEMBLOCK_NODE_MAP.patch
> =A00021-score-Use-HAVE_MEMBLOCK_NODE_MAP.patch
> =A00022-memblock-Kill-early_node_map.patch
> =A00023-memblock-Reimplement-memblock-allocation-using-rever.patch
>
> 0001-0014 clean up and improve generic memblock code (powerpc update
> is to allow updates to generic code) so that it's easier for archs.
> e.g. memblock_init/analyze() are no longer necessary.
>
> 0015-0017 convert archs which were using memblock + early_node_map[]
> to use MEMBLOCK_HAVE_NODE_MAP.
>
> 0018-0021 convert archs which were using only early_node_map[] to
> MEMBLOCK_HAVE_NODE_MAP.
>
> 0022 kills now unused early_node_map[].
>
> 0023 reimplements memblock allocator in sane way, which is possible
> with early_node_map[] gone.
>
> This patchset is available in the following git branch.
>
> =A0git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git memblock
>

it passes test with my x86 64bits setups.

looks like tip/master does not include tip/x86/memblock and tip/x86/mm =
yet.

So tip/x86/memblock, tip/x86/mm will not get into 3.1?
