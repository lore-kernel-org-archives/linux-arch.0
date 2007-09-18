Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3568 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751456AbXIVGpI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 22 Sep 2007 02:45:08 -0400
Date: Tue, 18 Sep 2007 17:21:08 +0000
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch 7/7] Add documentation for extended crashkernel syntax
Message-ID: <20070918172108.GD5966@ucw.cz>
References: <20070913161428.343951643@strauss.suse.de> <20070913161430.686458007@strauss.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070913161430.686458007@strauss.suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Hi!

> This adds the documentation for the extended crashkernel syntax into
> Documentation/kdump/kdump.txt.

Should you also update kernel-parameters.txt?

> +For example:
> +
> +    crashkernel=512M-2G:64M,2G-:128M
> +
> +This would mean:
> +
> +    1) if the RAM is smaller than 512M, then don't reserve anything
> +       (this is the "rescue" case)
> +    2) if the RAM size is between 512M and 2G, then reserve 64M
> +    3) if the RAM size is larger than 2G, then reserve 128M

Why is this useful? I mean... if 64M is enough to save a dump, why use
128M? ...or does the required size somehow scale with memory in
machine? (pagetables?)
						Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
