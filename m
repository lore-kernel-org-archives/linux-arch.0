Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:32836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727286AbeHaUO3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 31 Aug 2018 16:14:29 -0400
Date: Fri, 31 Aug 2018 17:06:30 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH RFC LKMM 7/7] EXP tools/memory-model: Add .cfg and .cat
 files for s390
Message-ID: <20180831160630.GF30626@arm.com>
References: <20180829211018.GA19646@linux.vnet.ibm.com>
 <20180829211053.20531-7-paulmck@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829211053.20531-7-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com
Message-ID: <20180831160630.3Gkdd7jO9H5GBrz8JRFsXnqfjXWVeFA3X46heQHtdJw@z>

Hi Paul,

On Wed, Aug 29, 2018 at 02:10:53PM -0700, Paul E. McKenney wrote:
> This commit adds s390.cat and s390.cfg files to allow users to check
> litmus tests for s390-specific code.  Note that this change only enables
> herd7 checking of C-language litmus tests.  Larger changes are required
> to enable the litmus7 and klitmus7 tools to check litmus tests on real
> hardare.
> 
> Suggested-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Suggested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> [ paulmck: Add fixes suggested by Alan Stern. ]
> ---
>  tools/memory-model/s390.cat | 18 ++++++++++++++++++
>  tools/memory-model/s390.cfg | 21 +++++++++++++++++++++
>  2 files changed, 39 insertions(+)
>  create mode 100644 tools/memory-model/s390.cat
>  create mode 100644 tools/memory-model/s390.cfg

As I said before, I'd *much* prefer this to be part of the upstream
herdtools7 repository. It's not really anything to do with the Linux
kernel, so I don't think it belongs in the source tree.

Cheers,

Will
