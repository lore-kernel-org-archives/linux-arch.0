From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH/RFC] m68k: Add -ffreestanding to KBUILD_CFLAGS
Date: Wed, 10 Apr 2013 19:48:59 +0200
Message-ID: <20130410174859.GE16732@two.firstfloor.org>
References: <1365585879-5321-1-git-send-email-geert@linux-m68k.org>
 <51653C5D.4060408@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51653C5D.4060408@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Marek <mmarek@suse.cz>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>
List-Id: linux-arch.vger.kernel.org

> My understanding is, that with -fnobuiltin, the compiler is not allowed
> to make assumptions about functions if it does not see their definition,
> even if they resemble standard functions. E.g. on x86_64, strlen() is
> out-of-line, so gcc would have to assume, that strcmp() has side
> effects. How about just naming the m68k inline function 'strlen'?

You should always supply an out of line fallback version with 
the standard name. The easiest way is to define the right
define so that lib/string.c does it.

-Andi
