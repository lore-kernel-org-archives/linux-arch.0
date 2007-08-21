Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:40011 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755662AbXHUSYR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 21 Aug 2007 14:24:17 -0400
Date: Tue, 21 Aug 2007 11:25:05 -0700
From: Chris Wedgwood <cw@f00f.org>
Subject: Re: RFC: drop support for gcc < 4.0
Message-ID: <20070821182505.GA20968@puku.stupidest.org>
References: <20070821132038.GA22254@ff.dom.local> <20070821093103.3c097d4a.randy.dunlap@oracle.com> <20070821173550.GC30705@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070821173550.GC30705@stusta.de>
Sender: linux-arch-owner@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Jarek Poplawski <jarkao2@o2.pl>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Aug 21, 2007 at 07:35:50PM +0200, Adrian Bunk wrote:

> Are there any architectures still requiring a gcc < 4.0 ?

Yes, sadly in some places (embedded) there are people with older
compiler who want newer kernels.
