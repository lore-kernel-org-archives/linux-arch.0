Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:54371 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754786AbXHUUlI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Aug 2007 16:41:08 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1566230fkz
        for <linux-arch@vger.kernel.org>; Tue, 21 Aug 2007 13:41:06 -0700 (PDT)
Message-ID: <5d6222a80708211341s63f8c1eau922f018e66db49f4@mail.gmail.com>
Date: Tue, 21 Aug 2007 17:41:04 -0300
From: "Glauber de Oliveira Costa" <glommer@gmail.com>
Subject: Re: RFC: drop support for gcc < 4.0
In-Reply-To: <20070821182505.GA20968@puku.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070821132038.GA22254@ff.dom.local>
	 <20070821093103.3c097d4a.randy.dunlap@oracle.com>
	 <20070821173550.GC30705@stusta.de>
	 <20070821182505.GA20968@puku.stupidest.org>
Sender: linux-arch-owner@vger.kernel.org
To: Chris Wedgwood <cw@f00f.org>
Cc: Adrian Bunk <bunk@kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Jarek Poplawski <jarkao2@o2.pl>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mips@linux-mips.org
List-ID: <linux-arch.vger.kernel.org>

On 8/21/07, Chris Wedgwood <cw@f00f.org> wrote:
> On Tue, Aug 21, 2007 at 07:35:50PM +0200, Adrian Bunk wrote:
>
> > Are there any architectures still requiring a gcc < 4.0 ?
>
> Yes, sadly in some places (embedded) there are people with older
> compiler who want newer kernels.

Last time I tried a mips build, it would fail the compile unless I was
using _exactly_ 3.4.4 (I didn't tried older versions, but did try
3.4.6, for ex.). So I also think the 3.4 series will still have to be
around for a while.

-- 
Glauber de Oliveira Costa.
"Free as in Freedom"
http://glommer.net

"The less confident you are, the more serious you have to act."
