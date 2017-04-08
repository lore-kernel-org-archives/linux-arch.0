From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [RFC] why do we still keep __{get,put}_user_unaligned()?
Date: Sat, 8 Apr 2017 07:21:16 +0100
Message-ID: <20170408062115.GZ29622@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:38654 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751724AbdDHGVR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Apr 2017 02:21:17 -0400
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

	Right now we have no users of __get_user_unaligned() outside of
arch/* and only 4 users of __put_user_unaligned() outside of arch/*.

	All 4 are in compat_sys_getdents64().  For storing
->d_ino and ->d_off in
struct linux_dirent64 {
        u64             d_ino;
        s64             d_off;
        unsigned short  d_reclen;
        unsigned char   d_type;
        char            d_name[0];
};
in case 32bit userland has weaker alignment requirements for that thing
and passes us a pointer that would've been aligned for 32bit, but not
for 64bit ABI.  Which architecture would that be, though?

	arm, mips, powerpc, sparc and s390 have that thing 64bit-aligned
in 32bit ABI (both of them in case of mips).  And since native getdents()
does *not* maintain more than that when padding an entry, we'd better have
put_user() of 64bit values work for any 64bit-aligned pointer.  I hadn't
checked actual cross-compile for tile, but judging by their compat.h they
are not suffering from that kind of braindamage either.

	x86 does, indeed, have weaker alignment in 32bit ABI.  It also
has __put_user_unaligned defined as __put_user.

	Is there any reason to keep those around?  As it is, the only places
that need those are m68k and arm binfmt-flat, and these boil down to "can this
CPU flavour do unaligned access?", with "use __get_user/__put_user" and
"use __copy_from_user/__copy_to_user" as outcomes.  Nothing more fancy...
