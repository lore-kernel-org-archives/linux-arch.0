From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 35/38] unicore32: clean-up uapi Kbuild file
Date: Tue, 15 Jul 2014 13:07:30 +0200
Message-ID: <20140715110730.GA3690@ravnborg.org>
References: <20140714150609.GA28358@ravnborg.org>
 <1405350546-28467-1-git-send-email-sam@ravnborg.org>
 <1405350546-28467-35-git-send-email-sam@ravnborg.org>
 <53C50840.2020204@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from asavdk4.altibox.net ([109.247.116.15]:34747 "EHLO
	asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758450AbaGOLHr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jul 2014 07:07:47 -0400
Content-Disposition: inline
In-Reply-To: <53C50840.2020204@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: Arnd Bergmann <arnd@arndb.de>, lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, kvm <kvm@vger.kernel.org>

Hi James.

> > +# Wapper from asm-generic
> >  generic-y += kvm_para.h
> > 
> 
> You dropped the generic-y += kvm_para.h for arm64 & c6x, but not for
> unicore, avr32 & ia64 patch, which seems a bit inconsistent. Was there
> some reason behind that?
I was fooling around with kvm_para.h and in both cases dropping
them was wrong.

kvm_para.h shows the current nightmare when you want to add a header
file that for most architectures has a generic implementation, but
in a few cases have a dedicated implementation.
This is the same point that Arnd raises.

I will fix it up so kvm_para.h is again specified for arm64 + c6x.
And then will address the whole mess later if I manage to come up
with something that is acceptable (simple enough).

Thanks for the review!

	Sam
