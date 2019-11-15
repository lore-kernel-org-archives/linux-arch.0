Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33383 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfKOAi1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Nov 2019 19:38:27 -0500
Date: Fri, 15 Nov 2019 01:38:21 +0100
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v6 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20191115003821.raskzlj7hscz7vax@ltop.local>
References: <20191107174622.61718-4-alex.kogan@oracle.com>
 <201911110540.8p3UoQAR%lkp@intel.com>
 <58623E4A-973B-46CC-8FA8-29E68DB5EFF4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58623E4A-973B-46CC-8FA8-29E68DB5EFF4@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>
Cc: kbuild test robot <lkp@intel.com>, linux-sparse@vger.kernel.org, kbuild-all@lists.01.org, linux@armlinux.org.uk, Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20191115003821.WUa7Pt8T_eqwEopx4P7IGetXWCLtO5V56XHNywMgGUM@z>

On Thu, Nov 14, 2019 at 03:57:34PM -0500, Alex Kogan wrote:
> + linux-sparse mailing list
> 
> It seems like a bug in the way sparse handles “pure” functions that return
> a pointer.

Yes, it's a bug in sparse.
 
> The warnings can be eliminated by adding an explicit cast, e.g.:
> 
> 	node = (struct mcs_spinlock *)grab_mcs_node(node, idx);
> 
> but this seems wrong (unnecessary) to me.

Indeed, it would be wrong.

Thanks for analyzing and reporting this,
-- Luc 
