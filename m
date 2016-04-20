Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:57880 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754213AbcDTNkg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 20 Apr 2016 09:40:36 -0400
Date: Wed, 20 Apr 2016 15:40:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 10/11] x86, rwsem: provide __down_write_killable
Message-ID: <20160420134019.GX3448@twins.programming.kicks-ass.net>
References: <1460041951-22347-1-git-send-email-mhocko@kernel.org>
 <1460041951-22347-11-git-send-email-mhocko@kernel.org>
 <20160413090829.GB29579@gmail.com>
 <20160413091625.GF14351@dhcp22.suse.cz>
 <20160413091943.GA17858@gmail.com>
 <20160413102731.GA29896@gmail.com>
 <20160413124943.GH14351@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160413124943.GH14351@dhcp22.suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, "David S. Miller" <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Message-ID: <20160420134019.Wz078O3hiAcUPjFe6bGQcmreg2jUv-JzNnDGFbeGTIo@z>

On Wed, Apr 13, 2016 at 02:49:43PM +0200, Michal Hocko wrote:
> On Wed 13-04-16 12:27:31, Ingo Molnar wrote:
> > 
> > * Ingo Molnar <mingo@kernel.org> wrote:
> > 
> > > I'm testing your patches today, if they are otherwise OK [...]
> > 
> > got this build failure:
> > 
> >   ./arch/x86/include/asm/rwsem.h:106:2: error: ‘asm’ operand has impossible constraints
> 
> Hmm, I have no idea why 64b didn't have problem with the asm but 32b
> complains. Anyway, the following makes both happy. I have checked the
> generated code for 64b and it hasn't changed after the patch. 32b also
> seems to be generating a proper code. My gcc asm()-foo is rather weak so
> I would feel better if somebody double checked after me.

I completely blow at this gcc-asm constraints thing too :/

In any case, Ingo will you look after the rest of these patches, or do
you want me to pick up the remaining bits?
