Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266905AbUIOGXf@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:35475 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266901AbUIOGXe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Sep 2004 02:23:34 -0400
Date: Wed, 15 Sep 2004 08:23:24 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: waitid fallout
Message-ID: <20040915062324.GA27164@wotan.suse.de>
References: <20040915033903.GA904@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915033903.GA904@twiddle.net>
To: Richard Henderson <rth@twiddle.net>
Cc: roland@redhat.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Sep 14, 2004 at 08:39:03PM -0700, Richard Henderson wrote:
> Is an *entire* struct rusage required in siginfo_t for sigchld?
> 
> It's much bigger than the 24 (!) words of padding we had reserved
> for expansion in siginfo_t.
> 
> Which means that the size of siginfo_t changed, which means that
> any existing "sigwaitinfo ({ SIGCHLD }, &info)" will now corrupt
> user memory.  Perhaps we think no one does this, but we should
> at least be aware of the ABI change.

Oops. I think this broke x86-64 too.

I don't want to change the signal ABI at all there and would prefer
if this change was reverted.

Thanks,
-Andi
