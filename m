Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from barikada.upol.cz ([158.194.242.200]:58986 "EHLO
	barikada.upol.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547AbXIIWms (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 9 Sep 2007 18:42:48 -0400
Date: Mon, 10 Sep 2007 00:45:52 +0200
Subject: CPP includes ([PATCH 3/4] ia64: fix sn to add include files using EXTRA_CFLAGS)
Message-ID: <20070909224552.GF475@flower.upol.cz>
References: <20070909180254.GA20086@uranus.ravnborg.org> <20070909180623.GD20086@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070909180623.GD20086@uranus.ravnborg.org>
From: Oleg Verych <olecom@flower.upol.cz>
Sender: linux-arch-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux arch <linux-arch@vger.kernel.org>, Andi Kleen <ak@suse.de>, kbuild devel <kbuild-devel@lists.sourceforge.net>, Tony Luck <tony.luck@intel.com>
List-ID: <linux-arch.vger.kernel.org>

On Sun, Sep 09, 2007 at 08:06:23PM +0200, Sam Ravnborg wrote:
> Changing the global CPPFLAGS is not the recommended way
> to add additional include dirs.
> Changed to use EXTRA_CFLAGS.

Maybe same magic can be applied to Rusty's "../../../" in i386
asm-offsets? Noone seems to use cpp's features much.

BTW, asm-values[0] are just don't needed any more?

[0] http://marc.info/?l=linux-kernel&s=asm-values
____
