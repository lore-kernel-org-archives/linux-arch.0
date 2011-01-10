From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCHv1 01/12] unicore32 core architecture: build
	infrastructure
Date: Mon, 10 Jan 2011 13:34:45 +0100
Message-ID: <20110110123445.GA13069@merkur.ravnborg.org>
References: <00c601cba463$69533750$3bf9a5f0$@mprc.pku.edu.cn> <20110106075553.GC15914@linux-sh.org> <023601cbaef7$850f2af0$8f2d80d0$@mprc.pku.edu.cn> <20110108072053.GA10552@merkur.ravnborg.org> <023c01cbaf24$85a99cc0$90fcd640$@mprc.pku.edu.cn> <20110108114826.GA7915@merkur.ravnborg.org> <002201cbb0bf$a20e9d60$e62bd820$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pfepb.post.tele.dk ([195.41.46.236]:40977 "EHLO
	pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626Ab1AJMer (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jan 2011 07:34:47 -0500
Content-Disposition: inline
In-Reply-To: <002201cbb0bf$a20e9d60$e62bd820$@mprc.pku.edu.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
Cc: 'Paul Mundt' <lethal@linux-sh.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

> Because TEXT_OFFSET is not changed in different machines or in configuration time,
> I move it into mach-spec memory.h and rename it KERNEL_IMAGE_START.
Good!

	Sam
