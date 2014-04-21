Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39418 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753489AbaDUUqg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 21 Apr 2014 16:46:36 -0400
Date: Mon, 21 Apr 2014 22:46:34 +0200
From: Pavel Machek <pavel@denx.de>
Subject: Re: [PATCH 16/28] nios2: System calls handling
Message-ID: <20140421204634.GA22181@amd.pavel.ucw.cz>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
 <1397824031-4892-13-git-send-email-lftan@altera.com>
 <20140419160947.GA27776@amd.pavel.ucw.cz>
 <CAFiDJ5-e=vRLxyKuzSQO0vg4HBHessv3xE9SdCQ9zFOqYOreZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFiDJ5-e=vRLxyKuzSQO0vg4HBHessv3xE9SdCQ9zFOqYOreZg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, cltang@codesourcery.com, mtk.manpages@gmail.com
Message-ID: <20140421204634.4qeRZ4TuE8Pi5rUPj-ZHvcr44BRBXUomoQLudciG8p0@z>

Hi!

> > Also... explanation why you need this syscall while other
> > architectures live happily without it would be nice.
> This syscall exist in nios2 port since old days and some users already
> used it for sometimes.
> Like mentioned by Greet, 12 our of 28 architectures provide such a syscall.

Would it make sense to create common code for this syscall?

> >> +/* sys_cacheflush -- flush the processor cache. */
> >> +asmlinkage int sys_cacheflush(unsigned long addr, unsigned long len,
> >> +                             unsigned int op)
> >> +{
> >> +     struct vm_area_struct *vma;
> >> +
> >> +     if (len == 0)
> >> +             return 0;
> >
> > op is being ignored? You should remove it... or if (op) return -EINVAL
> > if you want future extensions.
> Yes, op argument is being ignored. Okay, will add the return -EINVAL
> if op is non-zero.

Thanks!
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
