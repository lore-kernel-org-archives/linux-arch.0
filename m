Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr680100.outbound.protection.outlook.com ([40.107.68.100]:25922
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726210AbfCAWQX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 1 Mar 2019 17:16:23 -0500
From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH 10/20] mips/mmiowb: Add unconditional mmiowb() to
 arch_spin_unlock()
Date: Fri, 1 Mar 2019 22:16:18 +0000
Message-ID: <20190301221616.uhpjjepmxjmahkjt@pburton-laptop>
References: <20190301140348.25175-1-will.deacon@arm.com>
 <20190301140348.25175-11-will.deacon@arm.com>
In-Reply-To: <20190301140348.25175-11-will.deacon@arm.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A3010C6AF45DBF439F24B8ACCA3A9798@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
Message-ID: <20190301221618.KZn5ZeIjxhhSVS1vRD-n4NCZtShT5TATqve2XCPtDug@z>

Hi Will,

On Fri, Mar 01, 2019 at 02:03:38PM +0000, Will Deacon wrote:
> The mmiowb() macro is horribly difficult to use and drivers will continue
> to work most of the time if they omit a call when it is required.
>=20
> Rather than rely on driver authors getting this right, push mmiowb() into
> arch_spin_unlock() for mips. If this is deemed to be a performance issue,
> a subsequent optimisation could make use of ARCH_HAS_MMIOWB to elide
> the barrier in cases where no I/O writes were performed inside the
> critical section.
>=20
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Cleaning up our I/O functions has been on my to-do list for a while, so
I'll aim to get to that soon & get the calls to mmiowb_set_pending() in
place as part of it so that we can look at that optimization & drop the
custom queued_spin_unlock().

Meanwhile this looks sane & I don't want to hold it up so:

    Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul
