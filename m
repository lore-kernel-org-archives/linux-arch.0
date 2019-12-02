Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gentwo.org ([3.19.106.255]:46878 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727927AbfLBTmW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 2 Dec 2019 14:42:22 -0500
Date: Mon, 2 Dec 2019 19:42:21 +0000 (UTC)
From: Christopher Lameter <cl@linux.com>
Subject: Re: [PATCH] fix __percpu annotation in asm-generic
In-Reply-To: <20191202190718.GA18019@dennisz-mbp>
Message-ID: <alpine.DEB.2.21.1912021939320.2675@www.lameter.com>
References: <20191126200619.63348-1-luc.vanoostenryck@gmail.com> <alpine.DEB.2.21.1911271553560.16980@www.lameter.com> <20191127175350.GA52308@dennisz-mbp.dhcp.thefacebook.com> <20191127225432.ttwxm3hxtg5utfaz@ltop.local> <alpine.DEB.2.21.1911291808530.1365@www.lameter.com>
 <20191130000037.zsendu5pk7p75xqf@ltop.local> <20191202190718.GA18019@dennisz-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dennis Zhou <dennis@kernel.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Ben Dooks <ben.dooks@codethink.co.uk>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20191202194221.DUfMHEYTmiXWJRPpHB5wY0ul01N5he6AEukGdGdheys@z>

On Mon, 2 Dec 2019, Dennis Zhou wrote:

> I think typeof_cast_kernel() or typeof_force_kernel() are reasonable
> names. I kind of like the idea of cast/force over strip because we're
> really still moving address spaces even if it is moving it back.

I vote for typeof_cast_kernel()...

percpu addresses are more like an alias.... or more precisely an offset to
a base pointer (that already belongs to a certain "address space") and we
use the notion of a distinctly different "address space" in the linker to
categorize these references.
