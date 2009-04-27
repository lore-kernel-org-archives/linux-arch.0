Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:56357 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755055AbZD0OlF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 Apr 2009 10:41:05 -0400
Subject: [RFC 00/17] asm-generic ABI files for microblaze
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 27 Apr 2009 16:40:43 +0200
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-ID: <200904271640.44445.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: john.williams@petalogix.com, monstr@monstr.eu, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, liqin.chen@sunplusct.com, Sam Ravnborg <sam@ravnborg.org>, Remis Lima Baima <remis.developer@googlemail.com>
Message-ID: <20090427144043.6NR5kSibzY5KwfyhmZx_hAL4FpOgrtAwY2aDjbG5dEk@z>

This is my attempt to do a generic system call ABI for
all new architectures, including a port for microblaze,
which has recently been merged into 2.6.30. The next
architecture that is about to get merged will be score,
so it would be good if they can move to the same ABI.

Please review the files and (in case of microblaze
and score maintainers) test them on your architecture.

The one part I'm not yet completely happy with is signal
handling, I had to massage the microblaze code quite a
bit to get the old-style siginfo out of it, which may
not yet work.

Sam also mentioned that it might be good to consistently
use the __u32 and similar types everywhere in asm-generic
exported headers, which I might be doing as a next step
(including the existing files).

Special thanks to Remis Baima, who has done some significant
work cleaning up my patches.

	Arnd <><
