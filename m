Return-Path: <wli@holomorphy.com>
Received: from holomorphy.com ([207.189.100.168]:61603 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264062AbUDVONV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Apr 2004 10:13:21 -0400
Date: Thu, 22 Apr 2004 07:13:05 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [Patch] SMP call function cleanup
Message-ID: <20040422141305.GX743@holomorphy.com>
References: <1082636511.1332.34.camel@halo> <20040422123318.GX22027@krispykreme> <1082642408.1332.56.camel@halo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082642408.1332.56.camel@halo>
To: Jan Glauber <glauber@gmx.de>
Cc: Anton Blanchard <anton@samba.org>, Linux Architecture List <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2004-04-22 at 14:33, Anton Blanchard wrote:
>> We noticed this too. Rusty created on_one_cpu below and had a generic
>> (but costly) implementation so architectures could switch across when they
>> wanted.

On Thu, Apr 22, 2004 at 04:00:08PM +0200, Jan Glauber wrote:
> Hm, why can't you just do a:
> for_each_cpu_mask(cpu, mask)
>         send_IPI_single(cpu)

I think they're concerned about API minimality. I just debunked or
whatever both of the feature requests I had for it on my end after
doublechecking on IRC, so there isn't a known immediate need for it.


-- wli
