Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:58160 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750953AbZGAFAb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 1 Jul 2009 01:00:31 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] reduce export symbol CRC table size on 64-bit archs
Date: Wed, 1 Jul 2009 14:30:28 +0930
References: <4A4A18780200007800008345@vpn.id2.novell.com>
In-Reply-To: <4A4A18780200007800008345@vpn.id2.novell.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-ID: <200907011430.29524.rusty@rustcorp.com.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jan Beulich <JBeulich@novell.com>
Cc: Ingo Molnar <mingo@elte.hu>, tony.luck@intel.com, Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Message-ID: <20090701050028.KzYZL2iWhaLqk72PWAidVntOamJQacV2FO35doJTR1g@z>

On Tue, 30 Jun 2009 09:21:52 pm Jan Beulich wrote:
> Since these CRCs are really only 32-bit quantities, there's no need to
> store them in 64-bit slots. Since, however, gcc doesn't allow
> respective initializations, asm() constructs get used to create the CRC
> tables (and its for that reason that the patch only makes x86-64 and
> ia64 utilize that functionality, as I can't verify this doesn't break
> in some subtle way elsewhere).

Hmm, can we change the build system to just link this in as a normal table, 
rather than use linker tricks?

Then genksyms would just spit out a C file we could compile and link into final 
vmlinux.

Thanks,
Rusty.
