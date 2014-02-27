From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 5/5] bug: Make BUG() call unreachable()
Date: Thu, 27 Feb 2014 20:19:47 +0100
Message-ID: <201402272019.47554.arnd@arndb.de>
References: <469b5dc113cb468232291527642f8dc47663e945.1393385236.git.josh@joshtriplett.org> <201402261429.06553.arnd@arndb.de> <20140226145806.GA24150@thin>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.24]:58688 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbaB0TTv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 27 Feb 2014 14:19:51 -0500
In-Reply-To: <20140226145806.GA24150@thin>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Josh Triplett <josh@joshtriplett.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 26 February 2014, Josh Triplett wrote:
> This doesn't seem any different than compiling out assert() at runtime
> in a userspace program, given how the kernel uses BUG() and BUG_ON().
> I'd argue that adding unreachable() doesn't seem like it makes the
> current implementation of BUG() any worse; either way if you reach it
> you have a problem.

I think it's better to get a warning about undefined behavior than
to suppress that warning.

	Arnd
