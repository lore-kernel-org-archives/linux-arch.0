Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:50035 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbcEWP5K (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 23 May 2016 11:57:10 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 0/2] kbuild: Remove stale asm-generic wrappers
Date: Mon, 23 May 2016 17:55:02 +0200
Message-ID: <6113470.ejZJVBYpBf@wuerfel>
In-Reply-To: <1463991681-3531-1-git-send-email-james.hogan@imgtec.com>
References: <1463991681-3531-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-mips@linux-mips.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Michal Marek <mmarek@suse.com>, Jonathan Corbet <corbet@lwn.net>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>, Florian Fainelli <f.fainelli@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org
Message-ID: <20160523155502.ed9vE2rqEEfKUawTE9JU6nEZh5RwIav9NDJ0z3spkrg@z>

On Monday, May 23, 2016 9:21:19 AM CEST James Hogan wrote:
> This patchset attempts to fix kbuild to automatically remove stale
> asm-generic wrappers, i.e. when files are removed from generic-y and
> added directly into arch/*/include/uapi/asm/, but where the existing
> wrapper in arch/*/include/generated/asm/ continues to be used.
> 
> MIPS was recently burned by this in v4.3 (see patch 2), with continuing
> reports of build failures when people upgrade their trees, which go away
> after arch/mips/include/generated is removed (or reportedly make
> mrproper/distclean). It is particularly irritating during bisection.

Nice series!

Acked-by: Arnd Bergmann <arnd@arndb.de>

There are a number of files that we leave behind after a make clean,
and I also wondered if we could remove some more of them, but I couldn't
easily figure out which of them were left intentionally.

The asm-generic wrappers certainly are not there for a good reason,
and it's good to see them gone.

	Arnd
