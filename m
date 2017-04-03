From: James Morse <james.morse@arm.com>
Subject: Re: [RFC][CFT][PATCHSET v1] uaccess unification
Date: Mon, 03 Apr 2017 17:27:21 +0100
Message-ID: <58E277E9.8080404@arm.com>
References: <20170329055706.GH29622@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33330 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753585AbdDCQ1r (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 3 Apr 2017 12:27:47 -0400
In-Reply-To: <20170329055706.GH29622@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Richard Henderson <rth@twiddle.net>, Russell King <linux@armlinux.org.uk>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Steven Miao <realmz6@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Mark Salter <msalter@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>, Helge Deller <deller@gmx.de>, Martin Schwidefsky <sc>

On 29/03/17 06:57, Al Viro wrote:
> The series lives in git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git
> in #work.uaccess.  It's based at 4.11-rc1.  Infrastructure is in
> #uaccess.stem, then it splits into per-architecture branches (uaccess.<arch>),

> Comments, review, testing, replacement patches, etc. are very welcome.

For the two "arm64: " patches:
Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
